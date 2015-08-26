From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Aug 2015 12:57:52 +0100
Subject: [PATCH 2/3] ARM: DT: STi: STiH407: Add c8sectpfe LinuxDVB DT node.
In-Reply-To: <20150826114433.GB1498@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1440519730-486-1-git-send-email-peter.griffin@linaro.org>
 <1440519730-486-3-git-send-email-peter.griffin@linaro.org>
 <20150826073041.GT19409@x1>
 <20150826114433.GB1498@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20150826115752.GX19409@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Aug 2015, Peter Griffin wrote:
> On Wed, 26 Aug 2015, Lee Jones wrote:
> > On Tue, 25 Aug 2015, Peter Griffin wrote:
> > 
> > > This patch adds in the required DT node for the c8sectpfe
> > > Linux DVB demux driver which allows the tsin channels
> > > to be used on an upstream kernel.
> > > 
> > > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > > ---
> > >  arch/arm/boot/dts/stihxxx-b2120.dtsi | 38 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 38 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> > > index 62994ae..1bc018e 100644
> > > --- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
> > > +++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi

[...]

> > How about *-c8sectpfe-demod?
> 
> That doesn't really make sense, the demod is a seperate device
> typically controlled over I2C bus and connected to this IP block
> via the TS pins. Also although a tsin channel is "normally" connected
> to a demodulator device there is no reason it couldn't be connected
> for example to another STi chipset which is doing tsout.
> 
> Also this IP block can do more than accept tsin, it can
> also do tsout, and merge TS channels together (some coming from
> DDR, external TS pins). Which are features we hope to add
> to the driver in the future so the name needs to be very generic.
> 
> So with that in mind I would prefer to leave the compatible as
> the name of the IP block from the SoC datasheet.

Understood.  Thanks for the explanation.

[...]

> > > +				tsin-num = <0>;
> > > +				serial-not-parallel;
> > > +				i2c-bus = <&ssc2>;
> > 
> > If you are adding this property, I would get Wolfram or one of the DT
> > guys to Ack it.
> 
> This driver is actually already accepted, I just missed off one patch from
> the v2 series which meant this patch broke the build when Mauro applied it,
> which is the reason for re-sending it.
> 
> This binding is the same way the drm display drivers use DT via ddc-i2c-bus
> property to get the i2c bus for EDID control, so I think uncontroversial.

You're still adding a non-vendor property.  If you think it's generic
enough not to require a "<vendor>," prefix, please attempt to document
it in a generic binding document.

> > > +				rst-gpio = <&pio15 4 0>;
> > 
> > Why not use the whole name "reset"?
> > 
> > "-gpio" should be "-gpios".
> > 
> > So, in full: "reset-gpios"?
> > 
> > Flags: GPIO_ACTIVE_HIGH ?
> 
> Doing a grep, that does seem to be "more standard". Will fix in V2 as a single
> atomic commit.

It's not just 'more standard', it's documented in the GPIO binding.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
