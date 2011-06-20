From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Jun 2011 22:39:31 +0200
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <alpine.LFD.2.00.1106201622160.2142@xanadu.home>
References: <Pine.LNX.4.44L0.1106201240240.2113-100000@iolanthe.rowland.org>
	<201106202207.23104.arnd@arndb.de>
	<alpine.LFD.2.00.1106201622160.2142@xanadu.home>
Message-ID: <201106202239.31997.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 June 2011 22:28:49 Nicolas Pitre wrote:
> On Mon, 20 Jun 2011, Arnd Bergmann wrote:
> 
> > On Monday 20 June 2011 19:39:34 Alexander Holler wrote:
> > > That packed without an additional aligned() caused errors on ARM with 
> > > gcc 4.6 is another problem which got (currently) fixed by removing packed.
> > 
> > Packed caused errors because it is *wrong*. The code as it was used undefined
> > behavior in the language.
> 
> I wouldn't call this issue as such, but this is a Red herring.
> 
> Could you please provide a pointer to the structure definition so a 
> second opinion to the usefulness of __packed there could be provided?  

The structures in question are ehci_caps, ehci_regs and ehci_dbg_port.
The patch that remove the __packed attribute was 139540170 "USB: ehci:
remove structure packing from ehci_def".

The reason why I consider it a bug is that an access to a register
using readl/writel on the structure requires casting a pointer with
byte alignment to a pointer with word alignment, which is undefined
in C. Gcc just tries to be helpful and work around this by turning
the access into bytewise load/store instructions. In older gcc versions,
it would not do that if you happen to also case from non-volatile to
volatile pointer, but according to Uli that was not an intentional
feature of gcc but the ARM code just worked by pure coincidence.

> If it is not matching any of the fairly limited cases where having 
> __packed is relevant then we can just confirm that it should go.

It's already gone.

	Arnd
