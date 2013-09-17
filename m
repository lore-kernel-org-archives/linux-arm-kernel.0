From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 17 Sep 2013 09:36:19 -0600
Subject: [PATCH] arm: Kirkwood - Remove kirkwood_setup_wins and rely on
 the DT binding
In-Reply-To: <20130917133206.GB2488@localhost>
References: <20130916224743.GA18349@obsidianresearch.com>
 <20130917133206.GB2488@localhost>
Message-ID: <20130917153619.GA14098@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 10:32:07AM -0300, Ezequiel Garcia wrote:

> On Mon, Sep 16, 2013 at 04:47:43PM -0600, Jason Gunthorpe wrote:
> > kirkwood_setup_wins is the last manual caller of mbus in kirkwood, don't
> > call it for DT boards and rely on the board having a mbus node with
> > a proper ranges property to setup these windows.
> > 
> > This makes the DT self consistent, since the physical address of the
> > NAND and CRYPTO are both referenced internally. The arbitary Linux
> > constants KIRKWOOD_NAND_MEM_PHYS_BASE and KIRKWOOD_SRAM_PHYS_BASE
> > no longer have to match the DT values.
> > 
> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> >  arch/arm/boot/dts/kirkwood-db-88f6281.dts              | 5 ++++-
> >  arch/arm/boot/dts/kirkwood-db-88f6282.dts              | 5 ++++-
> >  arch/arm/boot/dts/kirkwood-iconnect.dts                | 5 ++++-
> >  arch/arm/boot/dts/kirkwood-mplcec4.dts                 | 5 ++++-
> >  arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 5 ++++-
> >  arch/arm/boot/dts/kirkwood-nsa310.dts                  | 5 ++++-
> >  arch/arm/boot/dts/kirkwood-ts219-6282.dts              | 5 ++++-
> >  arch/arm/mach-kirkwood/board-dt.c                      | 1 -
> >  8 files changed, 28 insertions(+), 8 deletions(-)
> > 
> 
> I'm trying to figure out why you're changing just these and not
> all of the kirkwood device tree files, but I really can't.

These were the ones that had a pre-existing mbus ranges line, which I
thought was the whole set of boards.

> Am I missing something obvious?

No, I didn't realize that you had only added mbus ranges to boards
that had PCI, every board needs a ranges for proper use of the
binding...

Since they are all the same I'll respin the patch and add the ranges to
the kirkwood.dtsi and remove it from all the board files, (which is
where I started, but then saw that board files had a ranges
already)

Jason
