From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Jul 2014 09:33:42 +0100
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <20140717102425.34fe0181@free-electrons.com>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140702164147.GQ32514@n2100.arm.linux.org.uk>
 <20140717102425.34fe0181@free-electrons.com>
Message-ID: <20140717083342.GS21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 10:24:25AM +0200, Thomas Petazzoni wrote:
> If I understand correctly, we are already changing the page tables
> anyway, to switch certain pages to be mapped uncached, to do DMA
> coherent allocations, no?

I've no idea, I never looked at that code.  I hope that Marek has
considered the requirements of the architecture when creating that
code...

> So wouldn't it be possible to keep the early
> assembly code as it is today, and then later, in C code, once we have
> identified the platform on which we're running, modify the page tables
> to switch to the appropriate page attributes (write allocate cache
> policy, shareable attribute, etc.) ?

No - the problem is that we're running from the page table in question
with global mappings, and we need to switch all these mappings, including
the ones we're currently using to execute from.

We can't even create a new page table and switch to it because the
mappings in question are global mappings.

The only way to do that safely from an architectural point of view would
be to turn the MMU off, and drop back to assembly code to change the
page tables, and re-enable the MMU.  For something as obscure as Marvell's
coherency stuff, that's not something I want to see in core code.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
