From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 30 Jul 2015 15:01:44 +0100
Subject: [PATCH 1/2] efi: add 'offset' param to efi_low_alloc()
In-Reply-To: <1438164259-14470-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1438164259-14470-1-git-send-email-ard.biesheuvel@linaro.org>
 <1438164259-14470-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150730140144.GH2725@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Jul, at 12:04:18PM, Ard Biesheuvel wrote:
> In some cases, e.g., when allocating memory for the arm64 kernel,
> we need memory at a certain offset from an aligned boundary. So add
> an offset parameter to efi_low_alloc(), and update the existing
> callers to pass zero by default.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/efi-stub.c                   |  2 +-
>  arch/x86/boot/compressed/eboot.c               |  4 ++--
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 20 +++++++++++++++-----
>  include/linux/efi.h                            |  2 +-
>  4 files changed, 19 insertions(+), 9 deletions(-)
 
[...]

> @@ -269,10 +269,19 @@ efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
>  		 * checks pointers against NULL. Skip the first 8
>  		 * bytes so we start at a nice even number.
>  		 */
> -		if (start == 0x0)
> +		if (start + offset == 0x0)
>  			start += 8;
>  
> -		start = round_up(start, align);
> +		/*
> +		 * Check if the offset exceeds the misalignment of this region.
> +		 * In that case, we can round down instead of up, and the
> +		 * resulting start value will be correctly aligned and still
> +		 * point past the start of the region.
> +		 */
> +		if (offset >= (start & (align - 1)))
> +			start = round_down(start, align) + offset;
> +		else
> +			start = round_up(start, align) + offset;
>  		if ((start + size) > end)
>  			continue;

Aha, now I see what you mean. Thanks for doing this Ard, these are much
more polished than what I was expecting.

I'm gonna have to NAK this because it's just too much of a special case
to support directly in efi_low_alloc(), which I think was the exact
point that you made originally, and which I was too tired/dumb to
understand. Sorry.

In particular, the fact that you can use the offset argument to violate
the requested alignment seems like it would trip up most users. 

-- 
Matt Fleming, Intel Open Source Technology Center
