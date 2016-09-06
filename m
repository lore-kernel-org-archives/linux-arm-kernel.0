From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2016 22:22:06 +0100
Subject: [PATCH] ARM: mmp: replace NO_IRQ
In-Reply-To: <CA+55aFyrGTG3xzecScrTQKaqkZ96DizeH2aSjJENKB_DCD6hxA@mail.gmail.com>
References: <20160906140808.2883875-1-arnd@arndb.de>
 <20160906142442.GY1041@n2100.armlinux.org.uk>
 <6239709.hYdxF7WW9G@wuerfel>
 <20160906194443.GC1041@n2100.armlinux.org.uk>
 <CA+55aFyrGTG3xzecScrTQKaqkZ96DizeH2aSjJENKB_DCD6hxA@mail.gmail.com>
Message-ID: <20160906212206.GF1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 01:03:42PM -0700, Linus Torvalds wrote:
> On Tue, Sep 6, 2016 at 12:44 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > My point still stands though.  Merely hiding it doesn't make the problem
> > go away - it's just the same problem but now it won't be as visible, and
> > as such it'll probably never get resolved.
> 
> How much of a legacy thing is this?

I thought we'd got it down to just being a legacy issue, and I thought
there was concensus on "no new NO_IRQ users" as well.  What we probably
failed to do was to get a rule into checkpatch to pick up on new users
of the macro.

> It may not *fix* that particular driver or subsystem, but if it's
> sufficiently well hidden or specialized, at least it won't cause the
> pattern to be copied in the future, I'd hope.

The thing that I'm really worried about is this is going to cause
regressions, especially when the "lets get rid of NO_IRQ" involves
converting from "irq == NO_IRQ" to "!irq" - which is logically a
completely different test - especially if there's cases where irq
can end up being "NO_IRQ" and the definition of NO_IRQ is -1.

I think I said last time that such conversions should be done in a
mindful way of that - converting these places to be <= 0 so we catch
_both_ the !irq and irq == NO_IRQ cases until we've killed NO_IRQ off
and are using irq == 0 meaning "there is no IRQ" universally.

The reason for this is that there's some _really_ awkward cases.
For example:

drivers/scsi/arm/oak.c: host->irq = NO_IRQ;
drivers/scsi/NCR5380.c: tmp[0] = IDENTIFY(((instance->irq == NO_IRQ) ? 0 : 1), cmd->device->lun);

oak uses NCR5380.  NCR5380 is shared across multiple architectures
which have a random selection of NO_IRQ defined as 0 or -1.  To
convert this without regression takes a multi-step process:

1. Verify all architectures using NCR5380 never pass 0 as a valid IRQ
   (they shouldn't today - I think this is true for ARM in this
   instance.)
2. change NCR5380 to recognise both -1 and 0 as being invalid IRQs
   (with a <= 0 test) and kill NO_IRQ in the NCR5380 code.
3. Kill off the uses of NO_IRQ being passed into the NCR5380 code,
   passing 0 instead.
4. Optionally (and preferably) change the test to be !instance->irq.

If we just do the "eliminate NO_IRQ by changing it to constant 0" in
either NCR5380 or oak.c on its own, we're going to end up with a
regression - at least until the other catches up.

This is my concern - some of the interactions are not simple, and it's
certainly not a case that merely replacing each NO_IRQ with 0 or -1
resolves the problem - and it's clear that doing such a thing will
cause regressions.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
