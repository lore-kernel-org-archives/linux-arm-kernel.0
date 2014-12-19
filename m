From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 Dec 2014 18:35:20 +0100
Subject: [PATCH v2 3/4] mmc: sunxi: Convert MMC driver to the standard
 clock phase API
In-Reply-To: <CAGb2v64iWS65t31JP_YRTigGBi5+eaJX60s7nNjv87gt2aojXw@mail.gmail.com>
References: <1418765936-12542-1-git-send-email-maxime.ripard@free-electrons.com>
 <1418765936-12542-4-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64iWS65t31JP_YRTigGBi5+eaJX60s7nNjv87gt2aojXw@mail.gmail.com>
Message-ID: <20141219173520.GK4820@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 17, 2014 at 12:17:36PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Wed, Dec 17, 2014 at 5:38 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Now that we have proper support to use the generic phase API in our clock
> > driver, switch the MMC driver to use it.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Acked-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> > ---
> >  .../devicetree/bindings/mmc/sunxi-mmc.txt          |  8 +--
> >  drivers/mmc/host/sunxi-mmc.c                       | 72 +++++++++++++++-------
> >  2 files changed, 53 insertions(+), 27 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> > index 91b3a3467150..4bf41d833804 100644
> > --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> > @@ -10,8 +10,8 @@ Absolute maximum transfer rate is 200MB/s
> >  Required properties:
> >   - compatible : "allwinner,sun4i-a10-mmc" or "allwinner,sun5i-a13-mmc"
> >   - reg : mmc controller base registers
> > - - clocks : a list with 2 phandle + clock specifier pairs
> > - - clock-names : must contain "ahb" and "mmc"
> > + - clocks : a list with 4 phandle + clock specifier pairs
> > + - clock-names : must contain "ahb", "mmc", "output" and "sample"
> >   - interrupts : mmc controller interrupt
> >
> >  Optional properties:
> > @@ -25,8 +25,8 @@ Examples:
> >         mmc0: mmc at 01c0f000 {
> >                 compatible = "allwinner,sun5i-a13-mmc";
> >                 reg = <0x01c0f000 0x1000>;
> > -               clocks = <&ahb_gates 8>, <&mmc0_clk>;
> > -               clock-names = "ahb", "mod";
> > +               clocks = <&ahb_gates 8>, <&mmc0_clk>, <&mmc0_output_clk>, <&mmc0_sample_clk>;
> > +               clock-names = "ahb", "mod", "output", "sample";
> >                 interrupts = <0 32 4>;
> >                 status = "disabled";
> >         };
> > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> > index d1663b3c4143..afe20c322e55 100644
> > --- a/drivers/mmc/host/sunxi-mmc.c
> > +++ b/drivers/mmc/host/sunxi-mmc.c
> > @@ -22,7 +22,6 @@
> >
> >  #include <linux/clk.h>
> >  #include <linux/clk-private.h>
> > -#include <linux/clk/sunxi.h>
> 
> This conflicts with
> 
>     05e07d8 mmc: sunxi: Remove unused includes of linux/clk-private.h
> 
> when applied over
> 
>     a0eda58 (linux-next/master) Add linux-next specific files for 20141216

Thanks for the warning :)

It's a pretty trivial conflict though, and I'll be the one merging it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141219/ebab5b2a/attachment.sig>
