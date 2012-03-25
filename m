From: pwaechtler@mac.com (Peter Waechtler)
Date: Sun, 25 Mar 2012 22:22:49 +0200
Subject: ARM11MPcore: tlb_ops_need_broadcast causes deadlock
In-Reply-To: <20120325191556.GA3147@n2100.arm.linux.org.uk>
References: <274124B9C6907D4B8CE985903EAA19E91B2D579066@SI-MBX06.de.bosch.com>
 <20120323173055.GC16225@mudshark.cambridge.arm.com>
 <loom.20120325T135816-592@post.gmane.org>
 <20120325130912.GF5611@n2100.arm.linux.org.uk> <4F6F624D.8060409@mac.com>
 <20120325191556.GA3147@n2100.arm.linux.org.uk>
Message-ID: <4F6F7E99.1020500@mac.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.03.2012 21:15, Russell King - ARM Linux wrote:
> On Sun, Mar 25, 2012 at 08:22:05PM +0200, Peter Waechtler wrote:
>> On 25.03.2012 15:09, Russell King - ARM Linux wrote:
>>> On Sun, Mar 25, 2012 at 12:08:47PM +0000, Peter Waechtler wrote:
>>>> But Will, is that tlb_flush necessary at all? The ARM has only 3 permission
>>>> bits in the page table (APX and AP0 and AP1). The young/accessed bit is done
>>>> via software.
>>> Yes it most definitely is, because setting a page to be young means we
>>> must receive a subsequent fault to make it 'old' again.  This means we
>>> must set the page to be inaccessible to get that fault, and flush the
>>> TLBs across all CPUs so that any CPU accessing that page receives a
>>> fault.
>> Ok I see, it's also not the "right or perfect" fix.
> It's not a fix or anything, it's required behaviour - otherwise we could
> end up throwing out pages from the system which are actually 'hot' because
> they've stayed in the TLB and we haven't received a fault to make them
> young again.

I'm arguing solely on kswapd making a young page old. So it can't be a 
hot page.
But yes in theory it's possible that it just become hot on another cpu...

And again I don't understand the abort handler: why do we get a page 
fault on
a young page then? grrh

> Moreover, what about the case where we actually remove the page?
I don't claim that this is the only way to deadlock - but this is the 
case we encounter.

> Aren't we also holding the pte lock there?  So I don't think there's an
> obvious solution to your deadlock.
>
> I think the real question is - in your example - why are you touching
> a userspace page with IRQs off _and_ expecting the fault to be fixed up?
> You never really explained what CPU B was doing.
It was running some user space program. It was not in the kernel.
I will post the jtag probe screenshots tomorrow.

     Peter
