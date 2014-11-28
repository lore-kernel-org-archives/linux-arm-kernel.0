From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Nov 2014 15:30:08 +0000
Subject: [PATCH v2 8/8] ARM: dts: mt8135: Add support for MT6397 regulator
In-Reply-To: <1417146874-5232-9-git-send-email-flora.fu@mediatek.com>
References: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
 <1417146874-5232-9-git-send-email-flora.fu@mediatek.com>
Message-ID: <20141128153008.GS7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 11:54:34AM +0800, Flora Fu wrote:

> Add device tree for MT6397 regulators in mt8135.dtsi.
> 
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> ---
>  arch/arm/boot/dts/mt8135.dtsi | 192 ++++++++++++++++++++++++++++++++++++++++++

This appears to be the DT fragment for a SoC but you are defining the
system integration for the PMIC.  That's bad, the PMIC is a separate
device so should be hooked up by the board using it.  If there's common
elements from a reference design they should be in their own .dtsi.

> +					mt6397_vsramca15_reg: buck_vsramca15 {
> +						regulator-name = "vsramca15";
> +						regulator-min-microvolt = < 700000>;
> +						regulator-max-microvolt = <1493750>;
> +						regulator-ramp-delay = <12500>;
> +						regulator-enable-ramp-delay = <115>;
> +						regulator-always-on;
> +						regulator-boot-on;

Why do these regulators have both a board specific ramp delay specified
and -always-on?  If they are always on presumably they never ramp at
runtime; if this is a generic parameter for the device it should be in
the driver.

Similarly why is boot_on being specified - we can read the startup state
for all these regulators?

> +					};
> +
> +					mt6397_vsramca7_reg: buck_vsramca7 {
> +						regulator-name = "vsramca7";
> +						regulator-min-microvolt = < 700000>;
> +						regulator-max-microvolt = <1493750>;

All these regulators seem to have exactly the same range specified which
looks awfully like it might be the maximum variability the regulator has
rather than the board specific range that's supported; the fact that
they appear to have no consumers that might vary the voltage is another
warning sign.  This is probably wrong, the constraints should be
whatever is verified good for the board.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/d12261be/attachment.sig>
