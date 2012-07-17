From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 17 Jul 2012 15:57:55 +0200
Subject: [PATCH 2/8] ARM: MCS814x: add Device Tree based MCS8140 board
 support
In-Reply-To: <201207171353.14070.arnd@arndb.de>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <6873084.DUBYG1ACKX@flexo> <201207171353.14070.arnd@arndb.de>
Message-ID: <2127715.xEAHMTj091@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012 13:53:13 Arnd Bergmann wrote:
> On Tuesday 17 July 2012, Florian Fainelli wrote:
> > On Tuesday 17 July 2012 13:19:43 Arnd Bergmann wrote:
> > > On Sunday 15 July 2012, Florian Fainelli wrote:
> 
> > > > +			adc {
> > > > +				compatible = "simple-bus";
> > > > +				#address-cells = <2>;
> > > > +				#size-cells = <1>;
> > > > +				// 8 64MB chip-selects
> > > > +				ranges = <0 0 0x00000000 0x4000000	// sdram
> > > > +					  1 0 0x04000000 0x4000000	// sdram
> > > > +					  2 0 0x08000000 0x4000000	// reserved
> > > > +					  3 0 0x0c000000 0x4000000	// 
> > flash/localbus
> > > > +					  4 0 0x10000000 0x4000000	// 
> > flash/localbus
> > > > +					  5 0 0x14000000 0x4000000	// 
> > flash/localbus
> > > > +					  6 0 0x18000000 0x4000000	// 
> > flash/localbus
> > > > +					  7 0 0x1c000000 0x4000000>;	// 
> > flash/localbus
> > > > +
> > > > +				sdram: memory at 0,0 {
> > > > +					reg = <0 0 0>;
> > > > +				};
> > > > +
> > > > +				nor: flash at 7,0 {
> > > > +					reg = <7 0 0x4000000>;
> > > > +					compatible = "cfi-flash";
> > > > +					bank-width = <1>;		// 8-bit external 
> > flash
> > > > +					#address-cells = <1>;
> > > > +					#size-cells = <1>;
> > > > +                                };
> > > > +                        };
> > > 
> > > Nice representation of the external buses. It does seem however that at
> > > least the nor flash entry is board specific and should be moved into the
> > > board .dts file.
> > 
> > In fact, MCS8140 only supports 8-bit CFI Flash chips, so this really is 
the 
> > common point of all MCS8140-based boards. As you can see in the following 
> > board-specific DTS patches, only the partition layout is different.
> 
> But is the flash always connected to bank 7? It looks like you could easily 
have
> a NIC on that one and the flash on a different bank.

In fact, the only constraint is that bank7 is the only one which can be used 
for an external boot flash. I do not have any problem moving this to the per-
board DTS file.
--
Florian
