From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Fri, 30 Jan 2015 15:14:14 +0100
Subject: [PATCH] ARM: /proc/cpuinfo: DT: Add support for Revision
In-Reply-To: <CAL_JsqKNq4mY9vwDBPGYLmSYpTnYqS4QvjkbMkD6LJpxDYoLAg@mail.gmail.com>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201501262009.45854@pali>
 <CAL_JsqKNq4mY9vwDBPGYLmSYpTnYqS4QvjkbMkD6LJpxDYoLAg@mail.gmail.com>
Message-ID: <201501301514.14884@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 26 January 2015 21:22:27 Rob Herring wrote:
> On Mon, Jan 26, 2015 at 1:09 PM, Pali Roh?r 
<pali.rohar@gmail.com> wrote:
> > Ok, here is patch which set Revision field (global variable
> > system_rev) in /proc/cpuinfo from DT revision property:
> > 
> > diff --git a/arch/arm/kernel/devtree.c
> > b/arch/arm/kernel/devtree.c index 11c54de..9946c1b 100644
> > --- a/arch/arm/kernel/devtree.c
> > +++ b/arch/arm/kernel/devtree.c
> > @@ -19,6 +19,7 @@
> > 
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/smp.h>
> > 
> > +#include <linux/libfdt_env.h>
> > 
> >  #include <asm/cputype.h>
> >  #include <asm/setup.h>
> > 
> > @@ -26,6 +27,7 @@
> > 
> >  #include <asm/smp_plat.h>
> >  #include <asm/mach/arch.h>
> >  #include <asm/mach-types.h>
> > 
> > +#include <asm/system_info.h>
> > 
> >  #ifdef CONFIG_SMP
> > 
> > @@ -204,6 +206,8 @@ static const void * __init
> > arch_get_next_mach(const char *const **match)
> > 
> >  const struct machine_desc * __init
> >  setup_machine_fdt(unsigned int dt_phys) {
> >  
> >         const struct machine_desc *mdesc, *mdesc_best =
> >         NULL;
> > 
> > +       unsigned long dt_root;
> > +       const u32 *prop;
> > 
> >  #ifdef CONFIG_ARCH_MULTIPLATFORM
> >  
> >         DT_MACHINE_START(GENERIC_DT, "Generic DT based
> >         system")
> > 
> > @@ -215,17 +219,16 @@ const struct machine_desc * __init
> > setup_machine_fdt(unsigned int dt_phys)
> > 
> >         if (!dt_phys ||
> >         !early_init_dt_verify(phys_to_virt(dt_phys)))
> >         
> >                 return NULL;
> > 
> > +       dt_root = of_get_flat_dt_root();
> > 
> >         mdesc = of_flat_dt_match_machine(mdesc_best,
> >         arch_get_next_mach);
> >         
> >         if (!mdesc) {
> >         
> >                 const char *prop;
> >                 int size;
> > 
> > -               unsigned long dt_root;
> > 
> >                 early_print("\nError:
> >                 unrecognized/unsupported "
> >                 
> >                             "device tree compatible list:\n[
> >                             ");
> > 
> > -               dt_root = of_get_flat_dt_root();
> > 
> >                 prop = of_get_flat_dt_prop(dt_root,
> >                 "compatible", &size); while (size > 0) {
> >                 
> >                         early_print("'%s' ", prop);
> > 
> > @@ -246,5 +249,10 @@ const struct machine_desc * __init
> > setup_machine_fdt(unsigned int dt_phys)
> > 
> >         /* Change machine number to match the mdesc we're
> >         using */ __machine_arch_type = mdesc->nr;
> > 
> > +       /* Set system revision from DT */
> > +       prop = of_get_flat_dt_prop(dt_root, "revision",
> > NULL); +       if (prop)
> > +               system_rev = fdt32_to_cpu(*prop);
> > +
> > 
> >         return mdesc;
> >  
> >  }
> > 
> > And here is patch which convert ATAG revision into DT
> > revision property and append it into DT in decompress code:
> > 
> > diff --git a/arch/arm/boot/compressed/atags_to_fdt.c
> > b/arch/arm/boot/compressed/atags_to_fdt.c index
> > 9448aa0..e7e1cc9 100644
> > --- a/arch/arm/boot/compressed/atags_to_fdt.c
> > +++ b/arch/arm/boot/compressed/atags_to_fdt.c
> > @@ -171,6 +171,8 @@ int atags_to_fdt(void *atag_list, void
> > *fdt, int total_space)
> > 
> >                                         cpu_to_fdt32(atag->u
> >                                         .mem.size);
> >                         
> >                         }
> > 
> > +               } else if (atag->hdr.tag == ATAG_REVISION) {
> > +                       setprop_cell(fdt, "/", "revision",
> > atag->u.revision.rev);
> > 
> >                 } else if (atag->hdr.tag == ATAG_INITRD2) {
> >                 
> >                         uint32_t initrd_start, initrd_size;
> >                         initrd_start = atag->u.initrd.start;
> > 
> > I tested it on DT booted Nokia N900 and it is working, in
> > /proc/cpuinfo is revision from ATAG.
> > 
> > I do not know which DT property to use for storing HW
> > Revision, so if "/revision" is not correct one, let me know
> > what to use instead. Also you can add my Signed-off-by for
> > both patches.
> 
> It is the correct property, but /revision in DT is a string.
> 
> You need to add your own sign-off.
> 
> Rob

Any documentation which says that /revision is string?

If it is really string, how to store ATAG_REVISON (number) to 
string? dec or hex?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150130/d560d228/attachment.sig>
