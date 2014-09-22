From: msalter@redhat.com (Mark Salter)
Date: Mon, 22 Sep 2014 12:33:29 -0400
Subject: [PATCH 7/7] efi_rtc: probe function error out in case no efi
 runtime enabled
In-Reply-To: <1408007953-15151-1-git-send-email-dyoung@redhat.com>
References: <1408007731-15081-1-git-send-email-dyoung@redhat.com>
 <1408007953-15151-1-git-send-email-dyoung@redhat.com>
Message-ID: <1411403609.25340.55.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-08-14 at 17:19 +0800, Dave Young wrote:
> efi rtc depends on efi runtime services, so if efi runtime services are not
> usable it should error out.
> 
> Without this patch rtc-efi will panic with 'noefi' boot

Is this still needed after commit da167ad7638759:

  rtc: ia64: allow other architectures to use EFI RTC

That should keep efi_rtc_probe from being called if runtime services
are not available.

> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  drivers/rtc/rtc-efi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> index c4c3843..ca2487b 100644
> --- a/drivers/rtc/rtc-efi.c
> +++ b/drivers/rtc/rtc-efi.c
> @@ -191,6 +191,9 @@ static int __init efi_rtc_probe(struct platform_device *dev)
>  {
>  	struct rtc_device *rtc;
>  
> +	if (!efi_enabled(EFI_RUNTIME_SERVICES))
> +		return -ENODEV;
> +
>  	rtc = devm_rtc_device_register(&dev->dev, "rtc-efi", &efi_rtc_ops,
>  					THIS_MODULE);
>  	if (IS_ERR(rtc))
