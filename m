From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Jul 2014 11:27:19 +0100
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <20140717104512.5d134904@free-electrons.com>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140702164147.GQ32514@n2100.arm.linux.org.uk>
 <20140717102425.34fe0181@free-electrons.com>
 <20140717083342.GS21766@n2100.arm.linux.org.uk>
 <20140717104512.5d134904@free-electrons.com>
Message-ID: <20140717102719.GU21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 10:45:12AM +0200, Thomas Petazzoni wrote:
> Russell,
> 
> On Thu, 17 Jul 2014 09:33:42 +0100, Russell King - ARM Linux wrote:
> 
> > > So wouldn't it be possible to keep the early
> > > assembly code as it is today, and then later, in C code, once we have
> > > identified the platform on which we're running, modify the page tables
> > > to switch to the appropriate page attributes (write allocate cache
> > > policy, shareable attribute, etc.) ?
> > 
> > No - the problem is that we're running from the page table in question
> > with global mappings, and we need to switch all these mappings, including
> > the ones we're currently using to execute from.
> > 
> > We can't even create a new page table and switch to it because the
> > mappings in question are global mappings.
> > 
> > The only way to do that safely from an architectural point of view would
> > be to turn the MMU off, and drop back to assembly code to change the
> > page tables, and re-enable the MMU.  For something as obscure as Marvell's
> > coherency stuff, that's not something I want to see in core code.
> 
> That's indeed tricky. But then, if we don't find solutions to support
> in mainline the features of those SoCs, why are we asking all those SoC
> vendors to push their code mainline?

As I said to you, this would not have been a problem if it weren't for
us moving to device tree, and single zImage.  By doing that, we've made
various problems such as the one you are experiencing several orders of
magnitude more difficult to solve.

Let me illustrate why this is the case.  With the old ATAGs + machine ID
solution, the assembly code used to look up the machine ID in the table
of built-in machines.  Once located, we'd have access to any information
stored in there.

We could have added an entry to that to indicate what level of Marvell
coherency workarounds were required, which could have been read by the
assembly page table setup code to set the page table attributes correctly.

This would have been /really/ easy to do, and would be simple to implement.

Instead, with DT, we have a massive problem instead, because we can't
parse the DT from assembly code to work out which platform we're running
on, which means the early assembly code can't adjust itself according to
the content of DT.

I don't have an answer for this other than those which I've already
stated... and I again feel like I'm being blamed for this issue.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
