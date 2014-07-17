From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 17 Jul 2014 10:24:25 +0200
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <20140702164147.GQ32514@n2100.arm.linux.org.uk>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140702164147.GQ32514@n2100.arm.linux.org.uk>
Message-ID: <20140717102425.34fe0181@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Jumping back to this topic.

On Wed, 2 Jul 2014 17:41:47 +0100, Russell King - ARM Linux wrote:

> The most important first step in that is working out how, in the early
> assembly code, we can identify these Armada SoCs.  That's a task I
> can't undertake because I know next to nothing about the SoCs you're
> dealing with.  Yes, I know that Marvell released a TRM a short while
> back, which is great, but not everyone has time to go around reading
> every TRM which every silicon vendor releases into the public domain.
> 
> If it /is/ possible to detect the Armada SoCs in the early assembly,
> then we can start to solve this.

Instead of having the absolute requirement to detect the Armada SoC in
the early assembly code, wouldn't it be possible to re-adjust the page
tables afterwards?

If I understand correctly, we are already changing the page tables
anyway, to switch certain pages to be mapped uncached, to do DMA
coherent allocations, no? So wouldn't it be possible to keep the early
assembly code as it is today, and then later, in C code, once we have
identified the platform on which we're running, modify the page tables
to switch to the appropriate page attributes (write allocate cache
policy, shareable attribute, etc.) ?

Remember that this special page attribute configuration is only needed
to provide hardware I/O coherency, i.e when we start doing DMA
transfers. It is therefore possible to do the change of the page
attributes in for example ->init_early(), which happens before any DMA
transfer has taken place.

What would be the complexity of achieving this? Would there be a way to
handle the TTBR register value as well?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
