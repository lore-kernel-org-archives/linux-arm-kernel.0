From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Tue, 20 Jan 2015 15:46:27 +0000
Subject: [PATCH] efi: rtc-efi: mark UIE as unsupported
In-Reply-To: <1421152133-28506-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1421152133-28506-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150120154627.GZ12079@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jan, at 12:28:53PM, Ard Biesheuvel wrote:
> Tools like hwclock attempt to enable the RTC update interrupt (UIE) to
> maximize the accuracy of the reported time value. The EFI rtc does not
> have interrupt capability so this is a pointless exercise to begin with,
> but the generic RTC framework ends up issuing a SetWakeupTime() Runtime
> Services call before drawing that conclusion on its own.
> 
> Instead, we can mark UIE as unsupported at driver probe time. The net
> result is the same, but without the spurious SetWakeupTime() call.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/rtc/rtc-efi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> index b37b0c80bd5a..cb989cd00b14 100644
> --- a/drivers/rtc/rtc-efi.c
> +++ b/drivers/rtc/rtc-efi.c
> @@ -218,6 +218,7 @@ static int __init efi_rtc_probe(struct platform_device *dev)
>  	if (IS_ERR(rtc))
>  		return PTR_ERR(rtc);
>  
> +	rtc->uie_unsupported = 1;
>  	platform_set_drvdata(dev, rtc);
>  
>  	return 0;

Looks fine to me. Picked up in the EFI tree for v3.20. Thanks Ard.

-- 
Matt Fleming, Intel Open Source Technology Center
