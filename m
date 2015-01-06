From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 6 Jan 2015 19:07:57 +0100
Subject: [PATCH v2 7/7] ARM: mvebu: Add Armada 385 Access Point
 Development Board support
In-Reply-To: <20150106173101.GB7853@lukather>
References: <1420558100-4700-1-git-send-email-maxime.ripard@free-electrons.com>
 <1420558100-4700-8-git-send-email-maxime.ripard@free-electrons.com>
 <20150106155705.GB23784@lunn.ch> <20150106173101.GB7853@lukather>
Message-ID: <20150106180757.GC25030@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime

> > Maybe add
> > 
> > stdout-path = &uart1;
> 
> Does that even work with the 8250? Last time I tried with a 3.18, it
> didn't, and you still needed the console= bootargs.

It is for the bootloader, not Linux. barebox will use this, etc.  I
think there are also plans for linux to use this. Not sure how far it
has got.

> > > +			i2c0: i2c at 11000 {
> > > +				pinctrl-names = "default";
> > > +				pinctrl-0 = <&i2c0_pins>;
> > > +				status = "okay";
> > > +				clock-frequency = <100000>;
> > > +			};
> > > +
> > > +			i2c1: i2c at 11100 {
> > > +				status = "okay";
> > > +				clock-frequency = <100000>;
> > > +			};
> > 
> > Is there anything on these two i2c busses?
> 
> One goes to some pin of the mPCIe slot, the other is connected to the
> EEPROM.

So could you add the EEPROM, and a comment about the mPCIe slot?

> > If not, why enable them and increase the clock speed?
> 
> The clock speed is not increased, it's actually the driver's default.

Dio you need this then? Is it in the dtsi file?

> > > +			uart0: serial at 12000 {
> > > +				pinctrl-names = "default";
> > > +				pinctrl-0 = <&uart0_pins>;
> > > +				status = "okay";
> > > +			};
> > > +
> > > +			uart1: serial at 12100 {
> > > +				pinctrl-names = "default";
> > > +				pinctrl-0 = <&uart1_pins>;
> > > +				status = "okay";
> > > +			};
> > 
> > If it is not obvious from the silk screen, could you describe which
> > connector this uart is on, what pins are what?
> 
> There's two UART connectors documented in the user guide (JP8 and
> JP9). UART1 is also connected to a FTDI chip, that is exposed through
> a mini-USB connector.

I'm guessing the user guide is only available under NDA? Where as you
can get the hardware without an NDA. At least i have a 370-rd, but no
NDA. So some minimal documentation would be nice. Especially since it
is backwards around to what most people would expect.
 
> > > +
> > > +			ethernet at 30000 {
> > > +				status = "okay";
> > > +				phy = <&phy1>;
> > > +				phy-mode = "sgmii";
> > > +			};
> > > +
> > > +			ethernet at 34000 {
> > > +				status = "okay";
> > > +				phy = <&phy2>;
> > > +				phy-mode = "sgmii";
> > > +			};
> > > +
> > > +			ethernet at 70000 {
> > > +				pinctrl-names = "default";
> > > +
> > > +				/*
> > > +				 * The Reference Clock 0 is used to
> > > +				 * provide a clock to the PHY
> > > +				 */
> > 
> > Does this clock need enabling? Should it be listed in the clocks
> > property?
> 
> From what I understood, this clock is always running, it's just
> exposed to some external pin, and hence needs some muxing.

O.K, thanks for the explanation.

     Andrew
