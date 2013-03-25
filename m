From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 25 Mar 2013 15:22:30 -0500
Subject: [PATCH V2] Sound: sgtl5000 Allow codec clock frequency to be set.
In-Reply-To: <20130322093344.20605.49509.stgit@localhost>
References: <20130322093344.20605.49509.stgit@localhost>
Message-ID: <CAKGA1bnFiwECxr=2aja-WQVp+Qbr8ULzUmbZsEgSFOQV+nt7wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm a little confused why there need to be 3 different alternative bindings.

The first is valid (phandle only), the second is redundant
(clock-frequency only) - why not just REQUIRE a clock phandle? There
is not a single use case where you supply a valid clock on the PCB but
cannot write it's frequency into a 3-line DT node, except in allowing
non-internally-consistent device trees (which I frown at :)

I can think of several reasons I don't like the 3rd way (dynamic
clock, phandle+frequency) because it implies lack of trust in the
bootloader and/or early platform init code... that said since you need
the frequency value to configure the codec, you either get it from the
clock (but it may not be valid) or you force a value upon it from
clock-frequency.. I would like a little warning, maybe, that the
expected clock-frequency was not available at the time it read the
value from the phandle, since this would allow sgtl5000-using hardware
designers and linux implementers to know immediately that they have
missed something important (bootloader setup of the codec clock).

It's rare that any real hardware design house would leave a clock like
that unconfigured as being able to test the frequency from whatever
source and how clean it is and what the levels are for debugging is
easier done in the bootloader than with an operating system running
(re power management etc.) but for the cases where we, for want of a
better way of describing it, forgot to actually set it up.. it should
still really, really be in the bootloader and bitching about it.

I wholeheartedly support the third method (clock+freq) in the hope
that it forces bootloader developers to properly configure fixed
clocks (such as the codec clock which is very hard to change at
runtime) at boot, before the OS has any need for it (and to relieve it
of the task of setting the clock frequency), but on the basis that
eventually people would get a clue or get their task list in order for
bootloader support and make it redundant (at which point it could be
removed..).

Second method (just the frequency alone) has to go away though in my
opinion, third way should be considered a "legacy" check in migration
from non-DT to DT support.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.


On Fri, Mar 22, 2013 at 4:33 AM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:
> Currently the sgtl5000 driver allows its clock to be
> specified either as a raw frequency using "clock-frequency"
> in the device tree (the original method) or, since commit
> 81e8e49 "ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000",
> as a preconfigured clock from the device tree.
>
> This patch adds, in addition to the existing methods,
> the possibility to use a rate configurable clock from the
> device tree and actually set its rate.
>
> This is done by specifiying both clocks and clock-frequency
> in the driver's DT node.
>
> This is useful when a programmable clock is used as the codec clock.
>
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
> Changelog:
> V2 - Improved binding document and patch description following
> remarks from Timur Tabi.
> ---
>  .../devicetree/bindings/sound/sgtl5000.txt         |   59 ++++++++++++++++++++
>  sound/soc/fsl/imx-sgtl5000.c                       |   20 +++++--
>  2 files changed, 75 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
> index 9cc4444..f586ba7 100644
> --- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
> +++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
> @@ -5,9 +5,68 @@ Required properties:
>
>  - reg : the I2C address of the device
>
> +Optional properties:
> +- clocks:              phandle to of codec clock
> +- clock-frequency:     clock frequency to set or use (see below)
> +
> +If a clock is provided, clock-frequency is optional
> +
> +If no clock is provided clock-frequency is required (this represents the codec
> +being clocked by an external signal not present in the clock tree)
> +
> +If both a clock and clock-frequency are provided clock must support
> +the set_rate operation and its frequency will be set to the value specified
> +by clock-frequency
> +
> +
> +Hence the possible configurations and their use cases are:
> +
> +1) only 'clocks' specified
> +clock points to a clock specified in the DT which already has an
> +appropriate frequency and is configured by some other means external to the
> +sgtl5000 driver (bootloader, board setup code, or just a fixed rate clock)
> +
> +Example:
> +clocks {
> +       audioclk: ext20Mz {
> +               compatible = "fixed-clock";
> +               clock-frequency = <20000000>;
> +       };
> +};
> +
> +codec: sgtl5000 at 0a {
> +       compatible = "fsl,sgtl5000";
> +       reg = <0x0a>;
> +       clocks = <&audioclk>; /* cko1 */
> +};
> +
> +
> +2) only 'clock-frequency' specified
> +The chip is assumed to be clocked by a signal having the given
> +frequency, which may even be generated by a clock unknown to linux.
> +This could actually be represented as a special case of 1) by defining a
> +fixed-rate clock in the DT.
> +
> +Example:
> +
> +codec: sgtl5000 at 0a {
> +       compatible = "fsl,sgtl5000";
> +       reg = <0x0a>;
> +       clock-frequency = <20000000>;
> +};
> +
> +
> +3) Both 'clocks' and 'clock-frequency' specified
> +The chip is assumed to be clocked by a rate programmable clock defined
> +in the clock tree.
> +clk_set_rate() will be called for this clock to set its rate to that
> +specified by clock-frequency
> +
>  Example:
>
>  codec: sgtl5000 at 0a {
>         compatible = "fsl,sgtl5000";
>         reg = <0x0a>;
> +       clocks = <&clks 162>; /* cko1 */
> +       clock-frequency = <20000000>;
>  };
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 424347e..71ce1f6 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -128,18 +128,30 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>                 goto fail;
>         }
>
> +       ret = of_property_read_u32(codec_np, "clock-frequency",
> +                                       &data->clk_frequency);
>         data->codec_clk = clk_get(&codec_dev->dev, NULL);
> +
>         if (IS_ERR(data->codec_clk)) {
> -               /* assuming clock enabled by default */
> +               /* assuming clock enabled by default (frequency required) */
>                 data->codec_clk = NULL;
> -               ret = of_property_read_u32(codec_np, "clock-frequency",
> -                                       &data->clk_frequency);
> -               if (ret) {
> +               if (!data->clk_frequency) {
>                         dev_err(&codec_dev->dev,
>                                 "clock-frequency missing or invalid\n");
>                         goto fail;
>                 }
>         } else {
> +               if (data->clk_frequency) {
> +                       ret = clk_set_rate(
> +                                       data->codec_clk, data->clk_frequency);
> +                       if (ret) {
> +                               dev_err(&codec_dev->dev,
> +                                       "failed to set clock-frequency to %u\n",
> +                                       data->clk_frequency);
> +                               goto fail;
> +                       }
> +               }
> +
>                 data->clk_frequency = clk_get_rate(data->codec_clk);
>                 clk_prepare_enable(data->codec_clk);
>         }
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
