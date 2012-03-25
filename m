From: pwaechtler@mac.com (Peter Waechtler)
Date: Sun, 25 Mar 2012 12:08:47 +0000 (UTC)
Subject: ARM11MPcore: =?utf-8?b?dGxiX29wc19uZWVkX2Jyb2FkY2FzdA==?= causes
 deadlock
References: <274124B9C6907D4B8CE985903EAA19E91B2D579066@SI-MBX06.de.bosch.com>
 <20120323173055.GC16225@mudshark.cambridge.arm.com>
Message-ID: <loom.20120325T135816-592@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon <at> arm.com> writes:

> 
> > The cpuB executes some user code hitting that page and because the PTE
> > is marked "inaccessible", so that the attempt can be stored, it results
> > in a page fault.
> 
> Shouldn't this trigger a prefetch abort rather than a data abort?
> 

Yes, I think the abort part is not completely understood yet.

So it's a data abort, some code referenced a page resulting in a dabrt_usr.
Then the abort handler tries to read the instruction and gets another dabrt.

That would mean that the code page was marked as inaccessible in the
mean time.
Now how could that happen? Probably on the other cpu?

Weird stuff.

But Will, is that tlb_flush necessary at all? The ARM has only 3 permission
bits in the page table (APX and AP0 and AP1). The young/accessed bit is done
via software.


    Peter
