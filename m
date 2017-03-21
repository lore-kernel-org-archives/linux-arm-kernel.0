From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Mar 2017 11:58:05 +0000
Subject: [PATCH] efi/libstub: arm/arm64: make debug prints dependent on
 efi=debug
In-Reply-To: <1490043425-20118-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1490043425-20118-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170321115805.GC22188@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 08:57:05PM +0000, Ard Biesheuvel wrote:
> The EFI stub currently prints a number of diagnostic messages that do
> not carry a lot of information. Since these prints are not controlled
> by 'loglevel' or other command line parameters, and since they appear on
> the EFI framebuffer as well (if enabled), it would be nice if we could
> turn them off.
> 
> So let's only print them if 'efi=debug' is passed on the command line,
> or when CONFIG_DEBUG_EFI is set in the kernel build configuration.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/libstub/arm32-stub.c      |  2 ++
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 23 ++++++++++++++---------
>  drivers/firmware/efi/libstub/efistub.h         |  9 +++++++++
>  drivers/firmware/efi/libstub/secureboot.c      |  2 ++
>  include/linux/efi.h                            |  3 ---
>  5 files changed, 27 insertions(+), 12 deletions(-)

> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 71c4d0e3c4ed..5ed16e6e166f 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -24,6 +24,15 @@
>  #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
>  #endif
>  
> +extern int __pure debug_enabled(void);
> +
> +#define pr_efi(sys_table, msg)		do {				\
> +	if (debug_enabled()) efi_printk(sys_table, "EFI stub: "msg);	\
> +} while (0)

I was going to say that it's somewhat unfortunate to lose some of these
messages by default, but I guess this only adds one additional
round-trip when debugging a remote issue, and gives us the freedom to
add more comprehensive debug messages in future.

Is the idea is to make the EFI stub completely silent in the successful
case, or is the aim just to minimise the number of messages?

If it's only the latter, we could log a message regarding the existence
of efi=debug in the default case, which might help with bug reports.

No strong feelings from me.

Thanks,
Mark.
