From: ivan.djelic@parrot.com (Ivan Djelic)
Date: Wed, 10 Oct 2012 18:38:41 +0200
Subject: [PATCH v2 00/14] OMAP-GPMC related cleanup for common zImage
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9F7B0A@DBDE01.ent.ti.com>
References: <cover.1349672877.git.afzal@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9F7B0A@DBDE01.ent.ti.com>
Message-ID: <20121010163840.GA13585@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 07:08:08AM +0100, Mohammed, Afzal wrote:
> Hi Ivan,
> 
> On Mon, Oct 08, 2012 at 11:05:56, Mohammed, Afzal wrote:
> 
> > This series cleans up omap-gpmc related code so that omap can
> > be a part of common zImage.
> 
> > This series moves gpmc.h from plat-omap/include/plat to mach-omap2
> > so that header file is local.
> 
> > Patches 7 & 8 cleans up the already moved platform data header files
> > to contain only platform data. Also gpmc-nand information is moved
> > to nand platform data header.
> > 
> > Patches 9-13 makes nand driver independent of gpmc header file
> > 
> > And the final patch localizes gpmc header.
> 
> BCH[48] support that you have added on OMAP using gpmc exported
> symbols has been changed such that nand driver now takes care
> of BCH support without relying on gpmc exported symbols.
> 
> This is more or less a cut & paste of your implementation, which was
> necessitated now due to common ARM zImage cleanup w.r.t header files.
> 
> Please verify that BCH[48] works as earlier with this series.

Hi Afzal,

I ran several mtd regression tests on a Beagle Board on your gpmc-czimage-v2 tag.
All BCH error correcting tests passed successfully.

I occasionally had weird read errors though, especially when reading blank pages:
the omap driver returned 512-byte sectors containing something like:

30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff
30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff
30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff
30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff
30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff
30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

instead of:

ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

I was able to reproduce the problem also on l2-mtd tip, albeit less often.
The problem seems to occur quite randomly, it may be a hardware issue on
my board...

Anyway, the ECC handling part looks OK to me.

Best regards,
--
Ivan
