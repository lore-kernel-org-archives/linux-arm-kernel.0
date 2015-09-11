From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Sep 2015 18:55:55 +0100
Subject: [PATCH v2 7/9] ARM: STi: DT: STiH407: Add FDMA driver dt nodes.
In-Reply-To: <20150911164822.GA1150@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-8-git-send-email-peter.griffin@linaro.org>
 <20150911162749.GD18779@x1>
 <20150911164822.GA1150@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20150911175555.GF18779@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2015, Peter Griffin wrote:
> On Fri, 11 Sep 2015, Lee Jones wrote:
> > On Fri, 11 Sep 2015, Peter Griffin wrote:
> > 
> > > These nodes are required to get the fdma driver working
> > > on STiH407 based silicon.
> > > 
> > > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > > ---
> > >  arch/arm/boot/dts/stih407-family.dtsi | 51 +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 51 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > > index 838b812..da07474b 100644
> > > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > > @@ -565,5 +565,56 @@
> > >  						  <&phy_port2 PHY_TYPE_USB3>;
> > >  			};
> > >  		};
> > > +
> > > +		fdma0: fdma0-audio at 8e20000 {
> > 
> > I'm not familiar with the FDMA driver, so can't comment knowledgeably,
> > but the <dev> part of <dev>@<base_address> should only describe the
> > type of hardware.  I believe in this case it should just be
> > dma at 08e20000.  Also notice the leading zero in the address, which I
> > believe mitigates possible confusion.  Then you be more specific with
> > the label, so something like 'fdma-audio' seems appropriate here.
> 
> Ok, can change to that format in v3.
> 
> > 
> > > +			compatible = "st,stih407-fdma-mpe31";
> > > +			reg = <0x8e20000 0x20000>;
> > 
> > I personally find padding up to 32bits helpful in the addresses.
> 
> None of the stih407-family nodes I can see have this padding, including
> the ones merged by you.

Nither of these two facts mean it's correct.

I'm happy to write a patch to correct them all.

Bear in mind that this isn't a hard and fast rule.  Both work and are
legal.  I just think the padding is more consistent.

> > > +			interrupts = <GIC_SPI 5 IRQ_TYPE_NONE>;
> > > +			dma-channels = <16>;
> > > +			#dma-cells = <3>;
> > > +			st,fdma-id = <0>;
> > 
> > We usually shy away from ID properties.  What is it required for in
> > this case?
> 
> Yes Rob did already mention that over here, see my reply at the bottom
> http://www.spinics.net/lists/devicetree/msg92529.html.
> 
> However I can't think of any other useful properties we could add
> to derive this information. The fdma controller number is used
> by the driver to generate a unique firmware filename.

Who chooses the naming scheme of the firmware binary?

Is there any reason they can't be:

  fdma_STiH407_audio.elf
  fdma_STiH407_app.elf
  fdma_STiH407_free_running.elf

Then you can have a different compatible for each.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
