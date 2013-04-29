From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 29 Apr 2013 09:35:18 +0200
Subject: [PATCH] module: fix mutiple defined issue
In-Reply-To: <1367213521-26795-1-git-send-email-inki.dae@samsung.com>
References: <1367213521-26795-1-git-send-email-inki.dae@samsung.com>
Message-ID: <20130429073518.GZ15233@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 29, 2013 at 02:32:01PM +0900, Inki Dae wrote:
> This patch fixes mutiple defined issue to MODULE_DEVICE_TABLE
s/mutiple/multiple/, still this sentence doesn't sound right. What is
the error message you see?
 
> The issue could be induced when some framework which includes two
> more sub drivers, is built as one moudle because those sub drivers
s/moudle/module/

> could have their own MODULE_DEVICE_TABLE.
> 
> And 'struct of_device_id' isn't needed to be determined by type
> argument because the definition of 'of_device_id' should be fixed.
> So this patch makes 'of_devce_id' definition to be fixed and
> only its instance name to be defined by type.
include/linux/isapnp.h uses:
#define ISAPNP_CARD_TABLE(name) \
		MODULE_GENERIC_TABLE(isapnp_card, name)

and you changed the table's type with your patch. Ditto for all users of

	MODULE_DEVICE_TABLE(i2c, ...);
	MODULE_DEVICE_TABLE(acpi, ...);
	MODULE_DEVICE_TABLE(platform, ...);
	MODULE_DEVICE_TABLE(pci, ...);
	MODULE_DEVICE_TABLE(sdio, ...);

So I'm pretty sure your patch is wrong and I expect it makes most
defconfigs fail to compile.

Best regards
Uwe

> 
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> ---
>  include/linux/module.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 46f1ea0..ac5d79f 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -84,7 +84,7 @@ void trim_init_extable(struct module *m);
>  
>  #ifdef MODULE
>  #define MODULE_GENERIC_TABLE(gtype,name)			\
> -extern const struct gtype##_id __mod_##gtype##_table		\
> +extern const struct of_device_id __mod_##gtype##_table		\
>    __attribute__ ((unused, alias(__stringify(name))))
>  
>  #else  /* !MODULE */
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
