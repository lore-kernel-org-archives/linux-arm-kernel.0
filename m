From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Apr 2016 00:16:35 -0500
Subject: [PATCH v2 02/16] arm64: dts: add sp804 timer node for Hi6220
In-Reply-To: <CACRpkdbWuKx6=aF5xW=3EKfuUf-MYM_EEnovyhBnOGVOeHyCmQ@mail.gmail.com>
References: <1459589383-16914-1-git-send-email-guodong.xu@linaro.org>
 <1459589383-16914-3-git-send-email-guodong.xu@linaro.org>
 <CACRpkdbWuKx6=aF5xW=3EKfuUf-MYM_EEnovyhBnOGVOeHyCmQ@mail.gmail.com>
Message-ID: <20160404051635.GQ17806@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 03, 2016 at 09:23:42PM +0200, Linus Walleij wrote:
> On Sat, Apr 2, 2016 at 11:29 AM, Guodong Xu <guodong.xu@linaro.org> wrote:
> 
> > From: Leo Yan <leo.yan@linaro.org>
> >
> > Add sp804 timer for hi6220, so it can be used as broadcast timer.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
> > ---
> >  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > index ad1f1eb..82c4756 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > @@ -209,5 +209,14 @@
> >                         clock-names = "uartclk", "apb_pclk";
> >                         status = "disabled";
> >                 };
> > +
> > +               dual_timer0: dual_timer at f8008000 {

timer at ...

> > +                       compatible = "arm,sp804", "arm,primecell";
> > +                       reg = <0x0 0xf8008000 0x0 0x1000>;
> > +                       interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&ao_ctrl 27>;
> > +                       clock-names = "apb_pclk";
> 
> How can this work? You only give the apb_pclk for clocking the
> bus to the timer.
> 
> Most platforms using this driver has something like this:
> 
>                 timer01: timer at 10104000 {
>                         compatible = "arm,sp804", "arm,primecell";
>                         reg = <0x10104000 0x1000>;
>                         interrupt-parent = <&intc_dc1176>;
>                         interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>, <0 9
> IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&timclk>, <&timclk>, <&pclk>;
>                         clock-names = "timer1", "timer2", "apb_pclk";
>                 };
> 
> It then reads the two clocks in the beginning of clocks() to
> determine the frequency of each timer.
> 
> By chance the code in the driver will allow just one clock and
> will then assume that both the bus to the timer and the timer
> itself is clocked from the same clock. But I highly doubt that this
> is the case.

I believe 1 clock was allowed for early bindings, but yes it should be 
3.

Rob
