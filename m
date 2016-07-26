From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 26 Jul 2016 11:36:42 +0200
Subject: [PATCH] usb: ehci-platform: switch over to shared reset
In-Reply-To: <1468927970-32240-1-git-send-email-yamada.masahiro@socionext.com>
References: <1468927970-32240-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <44a5bed2-3e58-1abb-f184-07c664c54a7b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

usb-next already has:

https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/drivers/usb/host/ehci-platform.c?h=usb-next&id=76d15c8fba655c9b2d60cf01834858f2c44483dc
https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/drivers/usb/host/ohci-platform.c?h=usb-next&id=62d9694a003dba585026df36c181e3ca930aeafc

Regards,

Hans



On 19-07-16 13:32, Masahiro Yamada wrote:
> The recent update in the reset subsystem requires all reset consumers
> to be explicit when requesting reset lines.  For detail, see the log
> of commit 3c35f6edc09b ("reset: Reorder inline reset_control_get*()
> wrappers").
>
> The devm_reset_control_get_optional() is deprecated, and falls into
> the _exclusive variant during the migration, but the reset control
> in this driver is apparently shared-tolerate.  Besides, this driver
> is for generic platforms, so actually should be able to work with a
> shared reset line.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  drivers/usb/host/ehci-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 1757ebb..2f5a16c 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -234,7 +234,7 @@ static int ehci_platform_probe(struct platform_device *dev)
>  		}
>  	}
>
> -	priv->rst = devm_reset_control_get_optional(&dev->dev, NULL);
> +	priv->rst = devm_reset_control_get_optional_shared(&dev->dev, NULL);
>  	if (IS_ERR(priv->rst)) {
>  		err = PTR_ERR(priv->rst);
>  		if (err == -EPROBE_DEFER)
>
