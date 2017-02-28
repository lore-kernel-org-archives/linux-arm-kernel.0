From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 19:14:31 -0600
Subject: [PATCH v4 1/4] Documentation: devicetree: Add document bindings
 for leds-mt6323
In-Reply-To: <709ff2c2-38f3-a3dd-f686-de3db873997d@gmail.com>
References: <1487962041-6548-1-git-send-email-sean.wang@mediatek.com>
 <1487962041-6548-2-git-send-email-sean.wang@mediatek.com>
 <709ff2c2-38f3-a3dd-f686-de3db873997d@gmail.com>
Message-ID: <20170228011431.ogms4cr3dgoysfv3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2017 at 06:35:11PM +0100, Jacek Anaszewski wrote:
> Hi Sean,
> 
> Thanks for the update. I have one comment below.
> 
> On 02/24/2017 07:47 PM, sean.wang at mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > This patch adds documentation for devicetree bindings
> > for LED support on MT6323 PMIC
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  .../devicetree/bindings/leds/leds-mt6323.txt       | 64 ++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/leds-mt6323.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> > new file mode 100644
> > index 0000000..950b8c6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> > @@ -0,0 +1,64 @@
> > +Device Tree Bindings for LED support on MT6323 PMIC
> > +
> > +MT6323 LED controller is subfunction provided by
> > +MT6323 PMIC, so the LED controllers are defined as
> > +the subnode of the function node provided by MT6323
> > +PMIC controller that is being defined as one kind of
> > +Muti-Function Device (MFD) using shared bus called
> > +PMIC wrapper for each subfunction to access remote
> > +MT6323 PMIC hardware.
> > +
> > +For MT6323 MFD bindings see:
> > +Documentation/devicetree/bindings/mfd/mt6397.txt
> > +For MediaTek PMIC wrapper bindings see:
> > +Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> > +
> > +There's sub-node for the LED controller that describes
> > +the initial behavior for each LED physically and currently
> > +only four LED sub-nodes can be supported.
> > +
> > +Required properties:
> > +- compatible : Must be "mediatek,mt6323-led"
> > +- reg : LED channel number (0..3)
> > +
> > +Optional properties:
> > +- label : (optional)
> > +  see Documentation/devicetree/bindings/leds/common.txt
> > +- linux,default-trigger : (optional)
> > +  see Documentation/devicetree/bindings/leds/common.txt
> > +- default-state: (optional) The initial state of the LED
> > +  see Documentation/devicetree/bindings/leds/common.txt
> > +
> > +Example:
> > +
> > +&pwrap {
> > +	pmic: mt6323 {
> > +		compatible = "mediatek,mt6323";
> > +		interrupt-parent = <&pio>;
> > +		interrupts = <150 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-controller;
> > +		#interrupt-cells = <2>;
> > +
> > +		mt6323led: mt6323led{
> > +			compatible = "mediatek,mt6323-led";
> 
> You require here also:
> 
> #address-cells = <1>;
> #size-cells = <0>;
> 
> Without these entries you should notice a warning from dtc compiler.
> 
> 
> > +
> > +			led0: isink0 {

Also, these should be "led at 0"

> > +				reg = <0>;
> > +				label = "LED0"
> > +				linux,default-trigger = "timer";
> > +				default-state = "on";
> > +			};
> > +			led1: isink1 {
> > +				reg = <1>;
> > +				label = "LED1";
> > +				default-state = "on";
> > +			};
> > +			led2: isink2 {
> > +				reg = <2>;
> > +				label = "LED2";
> > +				linux,default-trigger = "timer";
> > +				default-state = "off";
> > +			};
> > +		};
> > +	};
> > +};
> > 
> 
> -- 
> Best regards,
> Jacek Anaszewski
