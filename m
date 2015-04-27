From: contact@paulk.fr (Paul Kocialkowski)
Date: Mon, 27 Apr 2015 16:42:27 +0200
Subject: [PATCH v3 2/2] arch: arm: Show the serial number from
 devicetree in cpuinfo
In-Reply-To: <CAL_JsqKkw7n5p1ZH345BeKkyU=GKDrhaLef__0ET7t90Cm0Eog@mail.gmail.com>
References: <1429351135-11842-1-git-send-email-contact@paulk.fr>
 <1429351135-11842-2-git-send-email-contact@paulk.fr>
 <CAL_JsqKkw7n5p1ZH345BeKkyU=GKDrhaLef__0ET7t90Cm0Eog@mail.gmail.com>
Message-ID: <1430145747.3081.5.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le lundi 27 avril 2015 ? 08:48 -0500, Rob Herring a ?crit :
> On Sat, Apr 18, 2015 at 4:58 AM, Paul Kocialkowski <contact@paulk.fr> wrote:
> > This grabs the serial number shown in cpuinfo from the serial-number devicetree
> > property in priority. When booting with ATAGs (and without device-tree), the
> > provided number is still shown instead.
> >
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> 
> One comment below, otherwise:
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> > ---
> >  arch/arm/include/asm/system_info.h |  1 +
> >  arch/arm/kernel/setup.c            | 27 +++++++++++++++++++++++++--
> >  2 files changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/system_info.h b/arch/arm/include/asm/system_info.h
> > index 720ea03..3860cbd40 100644
> > --- a/arch/arm/include/asm/system_info.h
> > +++ b/arch/arm/include/asm/system_info.h
> > @@ -17,6 +17,7 @@
> >
> >  /* information about the system we're running on */
> >  extern unsigned int system_rev;
> > +extern const char *system_serial;
> >  extern unsigned int system_serial_low;
> >  extern unsigned int system_serial_high;
> >  extern unsigned int mem_fclk_21285;
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index 1d60beb..349790f 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -93,6 +93,9 @@ unsigned int __atags_pointer __initdata;
> >  unsigned int system_rev;
> >  EXPORT_SYMBOL(system_rev);
> >
> > +const char *system_serial;
> > +EXPORT_SYMBOL(system_serial);
> > +
> >  unsigned int system_serial_low;
> >  EXPORT_SYMBOL(system_serial_low);
> >
> > @@ -821,8 +824,29 @@ arch_initcall(customize_machine);
> >
> >  static int __init init_machine_late(void)
> >  {
> > +#ifdef CONFIG_OF
> > +       struct device_node *root;
> > +       int ret;
> > +#endif
> > +
> >         if (machine_desc->init_late)
> >                 machine_desc->init_late();
> > +
> > +#ifdef CONFIG_OF
> 
> These ifdefs should not be necessary, but please double check.

Well, of_property_read_string is only defined when CONFIG_OF is set
(base.c is always built in drivers/of but the directory is only included
when CONFIG_OF is set).

Of course, on ARM, we now expect that it is the case, but it seems like
good practice to check for it, since it could theoretically be disabled.

This is also being done a few lines above in customize_machine.

> > +       root = of_find_node_by_path("/");
> > +       if (root) {
> > +               ret = of_property_read_string(root, "serial-number",
> > +                                             &system_serial);
> > +               if (ret)
> > +                       system_serial = NULL;
> > +       }
> > +#endif
> > +
> > +       if (!system_serial)
> > +               system_serial = kasprintf(GFP_KERNEL, "%08x%08x",
> > +                                         system_serial_high,
> > +                                         system_serial_low);
> > +
> >         return 0;
> >  }
> >  late_initcall(init_machine_late);
> > @@ -1091,8 +1115,7 @@ static int c_show(struct seq_file *m, void *v)
> >
> >         seq_printf(m, "Hardware\t: %s\n", machine_name);
> >         seq_printf(m, "Revision\t: %04x\n", system_rev);
> > -       seq_printf(m, "Serial\t\t: %08x%08x\n",
> > -                  system_serial_high, system_serial_low);
> > +       seq_printf(m, "Serial\t\t: %s\n", system_serial);
> >
> >         return 0;
> >  }
> > --
> > 1.9.1
> >

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150427/5dfe6591/attachment.sig>
