From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 13 Oct 2011 13:34:55 -0600
Subject: [PATCH] rtc: rtc-s3c: Add device tree support
In-Reply-To: <053801cc8803$43676230$ca362690$%kim@samsung.com>
References: <1315064959-16930-1-git-send-email-thomas.abraham@linaro.org>
	<CAJuYYwQdeD=DEFSBqTTJM_EQcc517LPDy4w-N+mbHdH8Eqh=Dg@mail.gmail.com>
	<053801cc8803$43676230$ca362690$%kim@samsung.com>
Message-ID: <20111013193455.GC18574@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 07:48:07PM +0900, Kukjin Kim wrote:
> Thomas Abraham wrote:
> > 
> > On 3 September 2011 21:19, Thomas Abraham <thomas.abraham@linaro.org>
> > wrote:
> > > Add device tree based discovery support for Samsung's rtc controller.
> > >
> > > Cc: Ben Dooks <ben-linux@fluff.org>
> > > Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> > > ---
> > > ?Documentation/devicetree/bindings/rtc/s3c-rtc.txt | ? 20
> > ++++++++++++++++++++
> > > ?drivers/rtc/rtc-s3c.c ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 21
> > ++++++++++++++++++++-
> > > ?2 files changed, 40 insertions(+), 1 deletions(-)
> > > ?create mode 100644 Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> > 
> > Ping. Any comments for this patch? If this looks fine, can this be
> > considered for 3.2 merge via the Samsung kernel tree.
> > 
> (Cc'ed Alessandro Zummo who is RTC Subsystem maintainer)
> 
> I'm ok with this, so if this can be got the ack from Grant and Alessandro,
> will take this.

Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> > >
> > > diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> > b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> > > new file mode 100644
> > > index 0000000..90ec45f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> > > @@ -0,0 +1,20 @@
> > > +* Samsung's S3C Real Time Clock controller
> > > +
> > > +Required properties:
> > > +- compatible: should be one of the following.
> > > + ? ?* "samsung,s3c2410-rtc" - for controllers compatible with s3c2410
> rtc.
> > > + ? ?* "samsung,s3c6410-rtc" - for controllers compatible with s3c6410
> rtc.
> > > +- reg: physical base address of the controller and length of memory
> mapped
> > > + ?region.
> > > +- interrupts: Two interrupt numbers to the cpu should be specified.
> First
> > > + ?interrupt number is the rtc alarm interupt and second interrupt
> number
> > > + ?is the rtc tick interrupt. The number of cells representing a
> interrupt
> > > + ?depends on the parent interrupt controller.
> > > +
> > > +Example:
> > > +
> > > + ? ? ? rtc at 10070000 {
> > > + ? ? ? ? ? ? ? compatible = "samsung,s3c6410-rtc";
> > > + ? ? ? ? ? ? ? reg = <0x10070000 0x100>;
> > > + ? ? ? ? ? ? ? interrupts = <44 0 45 0>;
> > > + ? ? ? };
> > > diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> > > index 4e7c04e..29f928c 100644
> > > --- a/drivers/rtc/rtc-s3c.c
> > > +++ b/drivers/rtc/rtc-s3c.c
> > > @@ -25,6 +25,7 @@
> > > ?#include <linux/clk.h>
> > > ?#include <linux/log2.h>
> > > ?#include <linux/slab.h>
> > > +#include <linux/of.h>
> > >
> > > ?#include <mach/hardware.h>
> > > ?#include <asm/uaccess.h>
> > > @@ -481,7 +482,13 @@ static int __devinit s3c_rtc_probe(struct
> > platform_device *pdev)
> > > ? ? ? ? ? ? ? ?goto err_nortc;
> > > ? ? ? ?}
> > >
> > > - ? ? ? s3c_rtc_cpu_type = platform_get_device_id(pdev)->driver_data;
> > > +#ifdef CONFIG_OF
> > > + ? ? ? if (pdev->dev.of_node)
> > > + ? ? ? ? ? ? ? s3c_rtc_cpu_type = of_device_is_compatible(pdev-
> > >dev.of_node,
> > > + ? ? ? ? ? ? ? ? ? ? ? "samsung,s3c6410-rtc") ? TYPE_S3C64XX :
> > TYPE_S3C2410;
> > > + ? ? ? else
> > > +#endif
> > > + ? ? ? ? ? ? ? s3c_rtc_cpu_type =
> platform_get_device_id(pdev)->driver_data;
> > >
> > > ? ? ? ?/* Check RTC Time */
> > >
> > > @@ -603,6 +610,17 @@ static int s3c_rtc_resume(struct platform_device
> *pdev)
> > > ?#define s3c_rtc_resume ?NULL
> > > ?#endif
> > >
> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id s3c_rtc_dt_match[] = {
> > > +       { .compatible = "samsung,s3c2410-rtc" },
>      ^^^^^^^
> > > +       { .compatible = "samsung,s3c6410-rtc" },
>      ^^^^^^^
> > > +       {},
>      ^^^^^^^
> should be Tab?
> 
> > > +};
> > > +MODULE_DEVICE_TABLE(of, s3c_rtc_dt_match);
> > > +#else
> > > +#define s3c_rtc_dt_match NULL
> > > +#endif
> > > +
> > > ?static struct platform_device_id s3c_rtc_driver_ids[] = {
> > > ? ? ? ?{
> > > ? ? ? ? ? ? ? ?.name ? ? ? ? ? = "s3c2410-rtc",
> > > @@ -625,6 +643,7 @@ static struct platform_driver s3c_rtc_driver = {
> > > ? ? ? ?.driver ? ? ? ? = {
> > > ? ? ? ? ? ? ? ?.name ? = "s3c-rtc",
> > > ? ? ? ? ? ? ? ?.owner ?= THIS_MODULE,
> > > +               .of_match_table = s3c_rtc_dt_match,
>      ^^^^^^^^^^^^^^^
> Same as above...
> 
> But I know, Thomas' original patch has no problem...probably when ping,
> happened above.
> 
> > > ? ? ? ?},
> > > ?};
> > >
> > > --
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
