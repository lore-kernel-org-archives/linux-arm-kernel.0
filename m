From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 May 2014 15:34:53 +0200
Subject: [PATCH 06/17] pci: host: pcie-designware: Use *base-mask* for
 configuring the iATU
In-Reply-To: <202752041.rgamje4etj@wuerfel>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
 <53721D7F.9070200@ti.com> <202752041.rgamje4etj@wuerfel>
Message-ID: <4528185.oZbgyuuFKX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 May 2014 15:27:46 Arnd Bergmann wrote:
> On Tuesday 13 May 2014 18:56:23 Kishon Vijay Abraham I wrote:
> > > If you have a case where the outbound translation is a 256MB (i.e. 28bit)
> > > section of the CPU address space, that could be represented as
> > > 
> > >       ranges = <0x82000000 0 0  0xb0000000  0 0x10000000>;
> > > 
> > > or 
> > > 
> > >       ranges = <0x82000000 0 0xb0000000  0xb0000000  0 0x10000000>;
> > > 
> > > depending on whether you want the BARs to be programmed using a low
> > > address 0x0-0x0fffffff or an address matching the window
> > > 0xb0000000-0xbfffffff.
> > 
> > The problem is, for configuring the window starting at 0xb0000000, the ATU
> > should be programmed 0x0000000 (the cpu address for it will be 0xb0000000 though).
> > 
> 
> Then use the first of the two?
> 

To clarify: using <0x82000000 0 0  0xb0000000  0 0x10000000> will give you 
a mem_offset of 0xb0000000, which should work just fine for this case.

What I don't understand is why the ATU cares about whether the outbound
address is 0x0000000 or 0xb0000000 if it just decodes the lower 28 bit
anyway. Did you mean that we have to program the BARs using low addresses
regardless of what is programmed in the ATU? That would make more sense,
and it also matches what I suggested.

	Arnd
