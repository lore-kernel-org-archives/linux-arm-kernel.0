From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 8 Aug 2016 12:56:36 +0100
Subject: [PATCH v5 1/7] mfd: ac100: Add device tree bindings for X-Powers
 AC100 codec/RTC combo IC
In-Reply-To: <20160808115019.GL5243@dell>
References: <1467988422-17934-1-git-send-email-wens@csie.org>
 <1467988422-17934-2-git-send-email-wens@csie.org>
 <20160808115019.GL5243@dell>
Message-ID: <20160808115636.GN5243@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 08 Aug 2016, Lee Jones wrote:

> On Fri, 08 Jul 2016, Chen-Yu Tsai wrote:
> 
> > The AC100 is a multifunction device with an audio codec subsystem and
> > an RTC subsystem. These two subsystems share a common register space
> > and host interface.
> > 
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes since v4:
> > 
> >   - Style changes suggested by Lee.
> >   - Added commit message.
> >   - Added Rob's ack.
> > 
> > Changes since v3:
> > 
> >   - Fixed device node names and added labels.
> >   - Added clock output from codec and input to rtc.
> > 
> > Changes since v2:
> > 
> >   - Fix interrupt line for ac100_codec in provided example.
> > 
> > ---
> >  Documentation/devicetree/bindings/mfd/ac100.txt | 54 +++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt
> 
> For my own reference:
>   Acked-by: Lee Jones <lee.jones@linaro.org>

Applied, thanks.

> > diff --git a/Documentation/devicetree/bindings/mfd/ac100.txt b/Documentation/devicetree/bindings/mfd/ac100.txt
> > new file mode 100644
> > index 000000000000..b8ef00667599
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ac100.txt
> > @@ -0,0 +1,54 @@
> > +X-Powers AC100 Codec/RTC IC Device Tree bindings
> > +
> > +AC100 is a audio codec and RTC subsystem combo IC. The 2 parts are
> > +separated, including power supplies and interrupt lines, but share
> > +a common register address space and host interface.
> > +
> > +Required properties:
> > +- compatible: "x-powers,ac100"
> > +- reg: The I2C slave address or RSB hardware address for the chip
> > +- sub-nodes:
> > +  - codec
> > +    - compatible:		"x-powers,ac100-codec"
> > +    - interrupt-parent:		The parent interrupt controller
> > +    - interrupts:		SoC NMI / GPIO interrupt connected to the
> > +    				IRQ_AUDIO pin
> > +    - #clock-cells:		Shall be 0
> > +    - clock-output-names:	"4M_adda"
> > +
> > +    - see clock/clock-bindings.txt for common clock bindings
> > +
> > +  - rtc
> > +    - compatible:		"x-powers,ac100-rtc"
> > +    - interrupt-parent:		The parent interrupt controller
> > +    - interrupts:		SoC NMI / GPIO interrupt connected to the
> > +    				IRQ_RTC pin
> > +    - clocks:			A phandle to the codec's "4M_adda" clock
> > +    - #clock-cells:		Shall be 1
> > +    - clock-output-names:	"cko1_rtc", "cko2_rtc", "cko3_rtc"
> > +
> > +    - see clock/clock-bindings.txt for common clock bindings
> > +
> > +Example:
> > +
> > +ac100: codec at e89 {
> > +	compatible = "x-powers,ac100";
> > +	reg = <0xe89>;
> > +
> > +	ac100_codec: codec {
> > +		compatible = "x-powers,ac100-codec";
> > +		interrupt-parent = <&r_pio>;
> > +		interrupts = <0 9 IRQ_TYPE_LEVEL_LOW>; /* PL9 */
> > +		#clock-cells = <0>;
> > +		clock-output-names = "4M_adda";
> > +	};
> > +
> > +	ac100_rtc: rtc {
> > +		compatible = "x-powers,ac100-rtc";
> > +		interrupt-parent = <&nmi_intc>;
> > +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&ac100_codec>;
> > +		#clock-cells = <1>;
> > +		clock-output-names = "cko1_rtc", "cko2_rtc", "cko3_rtc";
> > +	};
> > +};
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
