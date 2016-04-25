From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 25 Apr 2016 12:04:55 +0100
Subject: [PATCHv2 0/6] efi: detect erroneous firmware IRQ manipulation
In-Reply-To: <20160425105153.GR2829@codeblueprint.co.uk>
References: <1461333083-15529-1-git-send-email-mark.rutland@arm.com>
 <CAKv+Gu8FGpZK4yDito2jKTbjuyE2jojj5tZhCa2qUwKdWL9+ng@mail.gmail.com>
 <20160424212241.GO2829@codeblueprint.co.uk>
 <20160425101527.GP2829@codeblueprint.co.uk>
 <CAKv+Gu8OfqdJp-VhC3o-tie4mRZXsF5ESKkZbsjnBHDY4xbXvQ@mail.gmail.com>
 <20160425102821.GQ2829@codeblueprint.co.uk>
 <20160425104009.GD25087@leverpostej>
 <20160425105153.GR2829@codeblueprint.co.uk>
Message-ID: <20160425110455.GF25087@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 11:51:53AM +0100, Matt Fleming wrote:
> On Mon, 25 Apr, at 11:40:09AM, Mark Rutland wrote:
> > 
> > It looks like irqs_disabled_flags() will do what you expect, and ignore
> > everything but the interrupt flag.
> > 
> > However, for ARM that will ignore the other exceptions we've seen FW
> > erroneously unmask (e.g. FIQ), which is unfortunate, as fiddling with
> > those is just as disastrous.
>  
> Bah, right.
> 
> > Would you be happy with an arch_efi_call_check_flags(before, after),
> > instead? That way we can make the flags we check arch-specific.
> 
> Could we just make the flag mask arch-specific instead of the call
> since the rest of efi_call_virt_check_flags() is good?

Yup, I meant that arch_efi_call_check_flags would only do the flag
comparison, only replacing the bit currently in the WARN_ON_ONCE().

> Something like this (uncompiled, untested, half-baked),
> 
> ---
> 
> diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
> index c38b1cfc26e2..057d00bee7d6 100644
> --- a/drivers/firmware/efi/runtime-wrappers.c
> +++ b/drivers/firmware/efi/runtime-wrappers.c
> @@ -25,9 +25,12 @@
>  static void efi_call_virt_check_flags(unsigned long flags, const char *call)
>  {
>  	unsigned long cur_flags;
> +	bool mismatch;
>  
>  	local_save_flags(cur_flags);
> -	if (!WARN_ON_ONCE(cur_flags != flags))
> +
> +	mismatch = (cur_flags ^ flags) & ARCH_EFI_IRQ_FLAGS_MASK;
> +	if (!WARN_ON_ONCE(mismatch))
>  		return;

This style also works for me.

Should I respin patch 6 as a series doing the above?

I assume that the first 5 patches are fine as-is.

Thanks,
Mark.
