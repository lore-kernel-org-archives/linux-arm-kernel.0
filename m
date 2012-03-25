From: pwaechtler@mac.com (Peter Waechtler)
Date: Sun, 25 Mar 2012 20:22:05 +0200
Subject: ARM11MPcore: tlb_ops_need_broadcast causes deadlock
In-Reply-To: <20120325130912.GF5611@n2100.arm.linux.org.uk>
References: <274124B9C6907D4B8CE985903EAA19E91B2D579066@SI-MBX06.de.bosch.com>
 <20120323173055.GC16225@mudshark.cambridge.arm.com>
 <loom.20120325T135816-592@post.gmane.org>
 <20120325130912.GF5611@n2100.arm.linux.org.uk>
Message-ID: <4F6F624D.8060409@mac.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.03.2012 15:09, Russell King - ARM Linux wrote:
> On Sun, Mar 25, 2012 at 12:08:47PM +0000, Peter Waechtler wrote:
>> But Will, is that tlb_flush necessary at all? The ARM has only 3 permission
>> bits in the page table (APX and AP0 and AP1). The young/accessed bit is done
>> via software.
> Yes it most definitely is, because setting a page to be young means we
> must receive a subsequent fault to make it 'old' again.  This means we
> must set the page to be inaccessible to get that fault, and flush the
> TLBs across all CPUs so that any CPU accessing that page receives a
> fault.
Ok I see, it's also not the "right or perfect" fix.

But the worst thing that can happen is:

young page: causes no page fault anymore and stays longer young than
kswapd wants in case a TLB has a stale entry but that access would have
marked it young again - no big deal?

old page: causes a page fault so that it can be made young, a stale TLB
would cause still a page fault - but in that path the tlb_flush still 
happens

 From my point of view: I definitively prefer to avoid the deadlock ;)

I'm afraid that I missed something? I hope not :)

     Peter
