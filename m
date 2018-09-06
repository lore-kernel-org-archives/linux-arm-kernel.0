From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Thu, 6 Sep 2018 15:34:07 +0000
Subject: [PATCH] ARM: dts: r9a06g032: Correct UART and add all other UARTs
In-Reply-To: <CAMuHMdVSLaaJmLEnke-iPSrgkRa4SUQyAnm_Tw9TPs3KcekFFA@mail.gmail.com>
References: <1535622742-6237-1-git-send-email-phil.edworthy@renesas.com>
 <CAMuHMdVSLaaJmLEnke-iPSrgkRa4SUQyAnm_Tw9TPs3KcekFFA@mail.gmail.com>
Message-ID: <TY1PR01MB1769A5DF4ECDAA51090BA207F5010@TY1PR01MB1769.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On 06 September 2018 15:38 Geert Uytterhoeven wrote:
> On Thu, Aug 30, 2018 at 11:52 AM Phil Edworthy wrote:
> > - UART0 was missing the bus clock ("apb_pclk").
> > - Now that the relevant rzn1 bindings have been added, replace the
> Synopsys
> >   compat string with the rzn1 strings.
> > - Add all the other UARTs.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Thanks for your patch!
And thanks for your review!
 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> But a few notes/questions below.
> 
> > --- a/arch/arm/boot/dts/r9a06g032.dtsi
> > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> > @@ -78,13 +78,90 @@
> >                 };
> >
> >                 uart0: serial at 40060000 {
> > -                       compatible = "snps,dw-apb-uart";
> > +                       compatible = "renesas,r9a06g032-uart", "renesas,rzn1-uart";
> 
> Apparently not all 8 UARTs are identical: the first 3 don't have DMA, the
> last 5 do, and they have more registers.
> 
> Are you sure no different compatible values are needed to distinguish
> between them?
> Can you handle them purely based on the presence or absence of
> "dmas" properties (which are not yet present)?
Yes, I am pretty sure... the extra registers for the last 5 uarts are only dma
related and we have been using the standard Synopsys driver on the other
3 uarts without issue for some time.

> According to commit 72b0505f0830df95 ("dt: serial: Add Renesas RZ/N1
> binding documentation"), the Synopsis compatible string would work if you
> are not using DMA, so perhaps it should be added for the ports that cannot
> do DMA?
Makes sense, I will make them:
compatible = "renesas,r9a06g032-uart", "renesas,rzn1-uart", "snps,dw-apb-uart";

> >                         reg = <0x40060000 0x400>;
> >                         interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> >                         reg-shift = <2>;
> >                         reg-io-width = <4>;
> > -                       clocks = <&sysctrl R9A06G032_CLK_UART0>;
> > -                       clock-names = "baudclk";
> > +                       clocks = <&sysctrl R9A06G032_CLK_UART0>, <&sysctrl
> R9A06G032_HCLK_UART0>;
> 
> It's a pity the clock names don't match the datasheet, but the output from
> the internal Renesas tools. So I have to trust you to not list them
> in the wrong order.
True... Note that all bus clocks required to access the peripheral's registers
are 'HCLK', other clocks such as baud clks are 'CLK'.

> > +                       clock-names = "baudclk", "apb_pclk";
> > +                       status = "disabled";
> > +               };

Thanks
Phil
