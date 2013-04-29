From: inki.dae@samsung.com (Inki Dae)
Date: Mon, 29 Apr 2013 19:06:23 +0900
Subject: [PATCH] module: fix mutiple defined issue
In-Reply-To: <20130429095138.GJ14496@n2100.arm.linux.org.uk>
References: <1367213521-26795-1-git-send-email-inki.dae@samsung.com>
 <20130429095138.GJ14496@n2100.arm.linux.org.uk>
Message-ID: <019801ce44c1$34326d60$9c974820$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> owner at vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Monday, April 29, 2013 6:52 PM
> To: Inki Dae
> Cc: gregkh at linuxfoundation.org; linux-kernel at vger.kernel.org; dri-
> devel at lists.freedesktop.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] module: fix mutiple defined issue
> 
> On Mon, Apr 29, 2013 at 02:32:01PM +0900, Inki Dae wrote:
> > This patch fixes mutiple defined issue to MODULE_DEVICE_TABLE
> >
> > The issue could be induced when some framework which includes two
> > more sub drivers, is built as one moudle because those sub drivers
> > could have their own MODULE_DEVICE_TABLE.
> >
> > And 'struct of_device_id' isn't needed to be determined by type
> > argument because the definition of 'of_device_id' should be fixed.
> > So this patch makes 'of_devce_id' definition to be fixed and
> > only its instance name to be defined by type.
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
> 
> This patch (a) looks wrong (why would a generic device table be limited
> to of_device_id when it could be ISAPNP or something else?) and (b) how
> does changing the type fix the "multiple defined issue" ?  (c) include
> the errors that you're fixing in the commit log.

There was my misunderstanding. So please ignore my patch. Some headers in
include/linux/ have some kind of device_id structure such as of_device_id,
platform_device_id, i2c_device_id, and so on. And these structures should be
used properly. This was my missing point.

Thanks,
Inki Dae


> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
