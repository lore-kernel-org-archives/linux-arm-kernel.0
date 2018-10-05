From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 5 Oct 2018 08:23:57 -0500
Subject: [PATCH v15 06/16] of/fdt: add helper functions for handling
 properties
In-Reply-To: <20181005030849.GK32578@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-7-takahiro.akashi@linaro.org>
 <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
 <20181005030849.GK32578@linaro.org>
Message-ID: <CAL_Jsq+wXU8PCyJhaTKE7ezZhiD0KARUFXVzQBk0ZptEEK7ubQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 4, 2018 at 10:07 PM AKASHI, Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Rob,
>
> # I haven't replied to this comment yet.
>
> On Fri, Sep 28, 2018 at 08:44:42AM -0500, Rob Herring wrote:
> > +David Gibson
> >
> > On Fri, Sep 28, 2018 at 1:48 AM AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > >
> > > These functions will be used later to handle kexec-specific properties
> > > in arm64's kexec_file implementation.
> > >
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Cc: devicetree at vger.kernel.org
> > > ---
> > >  drivers/of/fdt.c       | 56 ++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/of_fdt.h |  4 +++
> > >  2 files changed, 60 insertions(+)
> > >
> > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > index 800ad252cf9c..c65c31562ccb 100644
> > > --- a/drivers/of/fdt.c
> > > +++ b/drivers/of/fdt.c
> > > @@ -25,6 +25,7 @@
> > >  #include <linux/debugfs.h>
> > >  #include <linux/serial_core.h>
> > >  #include <linux/sysfs.h>
> > > +#include <linux/types.h>
> > >
> > >  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> > >  #include <asm/page.h>
> > > @@ -1323,3 +1324,58 @@ late_initcall(of_fdt_raw_init);
> > >  #endif
> > >
> > >  #endif /* CONFIG_OF_EARLY_FLATTREE */
> > > +
> > > +#define FDT_ALIGN(x, a)        (((x) + (a) - 1) & ~((a) - 1))
> > > +#define FDT_TAGALIGN(x)        (FDT_ALIGN((x), FDT_TAGSIZE))
> > > +
> > > +int fdt_prop_len(const char *prop_name, int len)
> > > +{
> > > +       return (strlen(prop_name) + 1) +
> > > +               sizeof(struct fdt_property) +
> > > +               FDT_TAGALIGN(len);
> >
> > Looks like you are using this to calculate how much space you need to
> > allocate in addition to the current DTB for a couple of new or
> > replaced properties. I'm not sure that this calculation is completely
> > accurate. And it is strange there doesn't seem to be any libfdt
> > function for this already. It would be simpler to just add some fixed
> > additional amount.
> >
> > Maybe David G has comments on this?
> >
> > > +}
> > > +
> >
> > The rest of this should go in drivers/of/fdt_address.c. Ultimately, it
> > should go into libfdt, but I'm fine with having it in the kernel for
> > now.
>
> I'd like to have this function in the kernel for now.
>
> > > +static void fill_property(void *buf, u64 val64, int cells)
> > > +{
> > > +       __be32 val32;
> > > +
> > > +       while (cells) {
> > > +               val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
> > > +               memcpy(buf, &val32, sizeof(val32));
> > > +               buf += sizeof(val32);
> >
> > This is kind of hard to read. I would copy u-boot's fdt_pack_reg function.
>
> Are you sure?
> I originally implemented this function in a similar way that fdt_pack_reg()
> was, but, you suggested, in your past comment[1], that we'd be better to
> have of_read_number()-like implementation.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/579118.html

Yeah, you're right. Plus, I'm not sure the u-boot one would work for
unaligned accesses with armv5 and earlier h/w.

My only comment then is I think you can drop the U32_MAX masking.

Rob
