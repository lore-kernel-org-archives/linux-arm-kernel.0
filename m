From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Jul 2014 11:16:37 +0100
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <20140717083342.GS21766@n2100.arm.linux.org.uk>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140702164147.GQ32514@n2100.arm.linux.org.uk>
 <20140717102425.34fe0181@free-electrons.com>
 <20140717083342.GS21766@n2100.arm.linux.org.uk>
Message-ID: <20140717101637.GT21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 09:33:42AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 17, 2014 at 10:24:25AM +0200, Thomas Petazzoni wrote:
> > If I understand correctly, we are already changing the page tables
> > anyway, to switch certain pages to be mapped uncached, to do DMA
> > coherent allocations, no?
> 
> I've no idea, I never looked at that code.  I hope that Marek has
> considered the requirements of the architecture when creating that
> code...

On this, it appears that (confirmed by Will) the DMA code is indeed buggy
in that it doesn't take account of the possibility of mismatched aliases.

This was raised before in this thread:

http://archive.arm.linux.org.uk/lurker/thread/20120922.052207.ff853126.en.html

but it was claimed that because it's done very early, it's safe.  That's
not really good enough - what the code relies upon is the hope that the
CPU will not speculatively prefetch from the area being modified.  While
that's unlikely, it's not impossible - and when if it were to happen
mid-update, then we could end up with the TLB containing both a section
mapping _and_ a page mapping.

I suspect that the only reason we haven't seen issues is that we haven't
had seen such aggressive speculation yet.

The code in principle is doing the right thing by clearing the section
mappings first.  What has been forgotten is that if speculative prefetches
have already happened, the TLB may well be populated, and so it needs a
TLB flush immediately after clearing the section mappings with pmd_clear().

Will Deacon agrees with me on this... so, CMA is buggy in this respect.

The reason this can't be done for coherency becomes obvious - in order to
make this change, we would need to clear the section mapping, flush it
from the TLB, and then create the new section mapping.  If the section
mapping we're modifying in that way happens to be the one which maps the
code performing that update, or the one which contains the page table,
than kaboom...

That's why I said that the only alternative is to turn the MMU off.
There are really only two choices here: either detect the platform early
in assembly where we can avoid this issue completely, or turn the MMU
off, update the page tables from assembly code, and then turn the MMU
back on and resume executing C code.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
