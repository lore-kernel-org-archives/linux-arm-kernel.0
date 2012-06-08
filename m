From: marex@denx.de (Marek Vasut)
Date: Fri, 8 Jun 2012 20:32:22 +0200
Subject: [PATCH] MXS: Add DENX M28 dts file
In-Reply-To: <20120606081726.GG2667@S2101-09.ap.freescale.net>
References: <1338084735-12083-1-git-send-email-marex@denx.de>
 <20120606081726.GG2667@S2101-09.ap.freescale.net>
Message-ID: <201206082032.22940.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Sun, May 27, 2012 at 04:12:15AM +0200, Marek Vasut wrote:
> > Missing:
> > AUART
> > LCDIF
[...]

> I just applied Huang's gpmi changes below.  Can you please rebase the
> the patch on top of it?  If you have the same pin setup as imx28-evk,
> we can save above data completely.
> 
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/169351

Ok, I see ... FSL patches get merged with priority?

> > +
> > +				mmc0_pins_data_m28: mmc0-8bit at 0 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <0x2000 0x2010 0x2020
> > +							  0x2030 0x2040 0x2050
> > +							  0x2060 0x2070 0x2080>;
> > +					fsl,drive-strength = <1>;
> > +					fsl,voltage = <1>;
> > +					fsl,pull-up = <1>;
> > +				};
> > +
> > +				mmc0_pins_ctrl_m28: mmc0-8bit at 0 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <0x2090 0x20a0
> > +							  0x30a3 0x31c3>;
> > +					fsl,drive-strength = <2>;
> > +					fsl,voltage = <1>;
> > +					fsl,pull-up = <0>;
> > +				};
> 
> You did a couple of wrong things here (as well as gpmi above).  First
> of all, there shouldn't be multiple pin group nodes for one device,
> supposing you are intending to set up pins for mmc0 in 2 groups nodes
> here.  See the following copied from fsl,mxs-pinctrl.txt.

I see ... so if I need to configure two set of pins, how do I do that? Or it's 
not possible with DT too?

> "On mxs, there is no hardware pin group. The pin group in this binding only
> means a group of pins put together for particular peripheral to work in
> particular function, like SSP0 functioning as mmc0-8bit.  That said, the
> group node should include all the pins needed for one function rather than
> having these pins defined in several group nodes.  It also means each of
> "pinctrl-*" phandle in client device node should only have one group node
> pointed in there, while the phandle can have multiple config node
> referenced there to adjust configurations for some pins in the group."
> 
> The reason I say above "if you are intending to ..." is you may just
> end up with having one "mmc0-8bit at 0" node in the dtb where only the
> data in the last occurrence get encoded in, because these two nodes
> are identical and thus the later one will overwrite the former one.
> 
> Secondly, the pin group node should be defined in imx28.dtsi, as the
> mux setting for particular device is determined by soc.  That said,
> if the existing mmc0_8bit_pins_a works for you, you can just have your
> mmc0 device refer to it than define it over again in your board.dts.
> Otherwise, you should define mmc0_8bit_pins_b in imx28.dtsi, so that
> any other board use that mmc0 mux scheme can refer to it later as too.
> 
> Lastly, the gpio should currently stay away from here.  There are some
> ongoing work at pinctrl core level to have gpio pin properly set up
> when gpio_request() gets called.
> 
> > +
> > +				auart0_pins_m28: auart0 at 0 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <0x3000 0x3010>;
> > +					fsl,drive-strength = <2>;
> > +					fsl,voltage = <1>;
> > +					fsl,pull-up = <0>;
> > +				};
> > +
> > +				auart3_pins_m28: auart3 at 0 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <0x30c0 0x30d0
> > +							  0x30e0 0x30f0>;
> > +					fsl,drive-strength = <2>;
> > +					fsl,voltage = <1>;
> > +					fsl,pull-up = <0>;
> > +				};
> 
> Should be defined in imx28.dtsi, so that other boards can refer to
> them too.

It's specific to our platform, why would it?

> > +
> > +				mac_pin_reset: mac at 0 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <0x30b3>;
> > +					fsl,drive-strength = <2>;
> > +					fsl,voltage = <1>;
> > +					fsl,pull-up = <0>;
> > +				};
> 
> gpio, let's wait for pinctrl core support.

Hm, how long do you intend to block all possible platforms from mainline other 
than FSL EVK ones? I consider having stuff in mainline much better, as it helps 
testing it, but it seems you don't share this opinion.

[...]
