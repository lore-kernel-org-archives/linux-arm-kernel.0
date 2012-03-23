From: will.deacon@arm.com (Will Deacon)
Date: Fri, 23 Mar 2012 17:30:55 +0000
Subject: ARM11MPcore: tlb_ops_need_broadcast causes deadlock
In-Reply-To: <274124B9C6907D4B8CE985903EAA19E91B2D579066@SI-MBX06.de.bosch.com>
References: <274124B9C6907D4B8CE985903EAA19E91B2D579066@SI-MBX06.de.bosch.com>
Message-ID: <20120323173055.GC16225@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Thanks for the detailed explanation. However, there's one bit I'm not sure
that I follow:

On Thu, Mar 22, 2012 at 12:24:47PM +0000, EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31) wrote:
> The cpuB executes some user code hitting that page and because the PTE
> is marked "inaccessible", so that the attempt can be stored, it results
> in a page fault.

Shouldn't this trigger a prefetch abort rather than a data abort?

> Unluckily the kswapd calls tlb_flush and that is configured to inform all
> cpus about that change via IPIs. cpuB is in an user abort handler (__dabt_usr)
> and the disaster takes its course:
> 
> For checking if it's a thumb instruction that caused the fault the abort handler
> accesses the page resulting into another fault - but now entering svc abort handler
> (__dabt_svc) and that turns off interrupts!

This is where I'm confused - why are we in the data abort handler due to an
I-side fault?

Thanks,

Will
