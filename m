From: inki.dae@samsung.com (Inki Dae)
Date: Mon, 29 Apr 2013 16:56:10 +0900
Subject: [PATCH] module: fix mutiple defined issue
In-Reply-To: <20130429073518.GZ15233@pengutronix.de>
References: <1367213521-26795-1-git-send-email-inki.dae@samsung.com>
 <20130429073518.GZ15233@pengutronix.de>
Message-ID: <016501ce44af$03129c80$0937d580$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> owner at vger.kernel.org] On Behalf Of Uwe Kleine-Konig
> Sent: Monday, April 29, 2013 4:35 PM
> To: Inki Dae
> Cc: gregkh at linuxfoundation.org; linux-kernel at vger.kernel.org; dri-
> devel at lists.freedesktop.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] module: fix mutiple defined issue
> 
> On Mon, Apr 29, 2013 at 02:32:01PM +0900, Inki Dae wrote:
> > This patch fixes mutiple defined issue to MODULE_DEVICE_TABLE
> s/mutiple/multiple/, still this sentence doesn't sound right. What is
> the error message you see?
> 
> > The issue could be induced when some framework which includes two
> > more sub drivers, is built as one moudle because those sub drivers
> s/moudle/module/
> 
> > could have their own MODULE_DEVICE_TABLE.
> >
> > And 'struct of_device_id' isn't needed to be determined by type
> > argument because the definition of 'of_device_id' should be fixed.
> > So this patch makes 'of_devce_id' definition to be fixed and
> > only its instance name to be defined by type.
> include/linux/isapnp.h uses:
> #define ISAPNP_CARD_TABLE(name) \
> 		MODULE_GENERIC_TABLE(isapnp_card, name)
> 
> and you changed the table's type with your patch. Ditto for all users of
> 
> 	MODULE_DEVICE_TABLE(i2c, ...);
> 	MODULE_DEVICE_TABLE(acpi, ...);
> 	MODULE_DEVICE_TABLE(platform, ...);
> 	MODULE_DEVICE_TABLE(pci, ...);
> 	MODULE_DEVICE_TABLE(sdio, ...);
> 
> So I'm pretty sure your patch is wrong and I expect it makes most
> defconfigs fail to compile.
>

It might be my big mistake. Maybe xxx_device_id object was created device
tree internally. Right? Will check it out again. So please ignore it.

Thanks,
Inki Dae


> Best regards
> Uwe
> 
> >
> > Signed-off-by: Inki Dae <inki.dae@samsung.com>
> > ---
> >  include/linux/module.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 46f1ea0..ac5d79f 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -84,7 +84,7 @@ void trim_init_extable(struct module *m);
> >
> >  #ifdef MODULE
> >  #define MODULE_GENERIC_TABLE(gtype,name)			\
> > -extern const struct gtype##_id __mod_##gtype##_table		\
> > +extern const struct of_device_id __mod_##gtype##_table		\
> >    __attribute__ ((unused, alias(__stringify(name))))
> >
> >  #else  /* !MODULE */
> > --
> > 1.7.5.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
