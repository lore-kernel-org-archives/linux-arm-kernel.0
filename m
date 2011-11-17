From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Nov 2011 20:28:27 +0800
Subject: [PATCH 1/1] ARM: imx6q: move clock register map to
 machine_desc.map_io
In-Reply-To: <CAMPhdO89_hpk287CF3oYeaQK02RZ0ouOB_Bt2egDuJc3HA7s1g@mail.gmail.com>
References: <1321527269-26784-1-git-send-email-richard.zhao@linaro.org>
 <CAMPhdO89_hpk287CF3oYeaQK02RZ0ouOB_Bt2egDuJc3HA7s1g@mail.gmail.com>
Message-ID: <20111117122826.GJ14656@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 07:18:00PM +0800, Eric Miao wrote:
> On Thu, Nov 17, 2011 at 6:54 PM, Richard Zhao <richard.zhao@linaro.org> wrote:
> > map_io is the only place to call iotable_init.
> >
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---

Applied, thanks.

> > ?arch/arm/mach-imx/clock-imx6q.c ? ? ? ? | ? ?7 +++++--
> > ?arch/arm/mach-imx/mach-imx6q.c ? ? ? ? ?| ? ?1 +
> > ?arch/arm/plat-mxc/include/mach/common.h | ? ?1 +
> > ?3 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
> > index 613a1b9..d3b0a8e 100644
> > --- a/arch/arm/mach-imx/clock-imx6q.c
> > +++ b/arch/arm/mach-imx/clock-imx6q.c
> > @@ -1953,14 +1953,17 @@ static struct map_desc imx6q_clock_desc[] = {
> > ? ? ? ?imx_map_entry(MX6Q, ANATOP, MT_DEVICE),
> > ?};
> >
> > +void __init imx_clock_map_io(void)

The function name should be imx6q_clock_map_io(), as it's implemented
in clock-imx6q.c which should be all imx6q specific.  I have fixed it
up when applying.

> > +{
> > + ? ? ? iotable_init(imx6q_clock_desc, ARRAY_SIZE(imx6q_clock_desc));
> > +}
> > +
> > ?int __init mx6q_clocks_init(void)
> > ?{
> > ? ? ? ?struct device_node *np;
> > ? ? ? ?void __iomem *base;
> > ? ? ? ?int i, irq;
> >
> > - ? ? ? iotable_init(imx6q_clock_desc, ARRAY_SIZE(imx6q_clock_desc));
> > -
> > ? ? ? ?/* retrieve the freqency of fixed clocks from device tree */
> > ? ? ? ?for_each_compatible_node(np, NULL, "fixed-clock") {
> > ? ? ? ? ? ? ? ?u32 rate;
> > diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> > index 8bf5fa3..7f35a82 100644
> > --- a/arch/arm/mach-imx/mach-imx6q.c
> > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > @@ -34,6 +34,7 @@ static void __init imx6q_map_io(void)
> > ?{
> > ? ? ? ?imx_lluart_map_io();
> > ? ? ? ?imx_scu_map_io();
> > + ? ? ? imx_clock_map_io();
> > ?}
> >
> > ?static void __init imx6q_gpio_add_irq_domain(struct device_node *np,
> > diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> > index 83b745a..f27ae54 100644
> > --- a/arch/arm/plat-mxc/include/mach/common.h
> > +++ b/arch/arm/plat-mxc/include/mach/common.h
> > @@ -120,6 +120,7 @@ extern void imx_smp_prepare(void);
> > ?static inline void imx_scu_map_io(void) {}
> > ?static inline void imx_smp_prepare(void) {}
> > ?#endif
> > +void imx_clock_map_io(void);
> 
> Richard,
> 
> I don't think we need to export this function.

Instead of putting the extern declaration in mach-imx6q.c which will
introduce a checkpatch warning, it's good to have it in the header.

> And I saw ANATOP mapping
> being removed, will this cause any side effect?

No, ANATOP mapping was not removed.

Regards,
Shawn

> 
> Otherwise looks good to me.
> 
