From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Mar 2012 22:55:35 +0100
Subject: ARM11MPcore: tlb_ops_need_broadcast causes deadlock
In-Reply-To: <4F6F7E99.1020500@mac.com>
References: <274124B9C6907D4B8CE985903EAA19E91B2D579066@SI-MBX06.de.bosch.com>
 <20120323173055.GC16225@mudshark.cambridge.arm.com>
 <loom.20120325T135816-592@post.gmane.org>
 <20120325130912.GF5611@n2100.arm.linux.org.uk> <4F6F624D.8060409@mac.com>
 <20120325191556.GA3147@n2100.arm.linux.org.uk> <4F6F7E99.1020500@mac.com>
Message-ID: <20120325215535.GB3147@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 25, 2012 at 10:22:49PM +0200, Peter Waechtler wrote:
> On 25.03.2012 21:15, Russell King - ARM Linux wrote:
>> On Sun, Mar 25, 2012 at 08:22:05PM +0200, Peter Waechtler wrote:
>>> On 25.03.2012 15:09, Russell King - ARM Linux wrote:
>>>> On Sun, Mar 25, 2012 at 12:08:47PM +0000, Peter Waechtler wrote:
>>>>> But Will, is that tlb_flush necessary at all? The ARM has only 3 permission
>>>>> bits in the page table (APX and AP0 and AP1). The young/accessed bit is done
>>>>> via software.
>>>> Yes it most definitely is, because setting a page to be young means we
>>>> must receive a subsequent fault to make it 'old' again.  This means we
>>>> must set the page to be inaccessible to get that fault, and flush the
>>>> TLBs across all CPUs so that any CPU accessing that page receives a
>>>> fault.
>>> Ok I see, it's also not the "right or perfect" fix.
>> It's not a fix or anything, it's required behaviour - otherwise we could
>> end up throwing out pages from the system which are actually 'hot' because
>> they've stayed in the TLB and we haven't received a fault to make them
>> young again.
>
> I'm arguing solely on kswapd making a young page old. So it can't be a  
> hot page.

No, it can be a hot page because the way it finds out that it's a hot
page is when it has to make the page repeatedly young, having first
made it old.

There's no other way the system can know what pages are being accessed
by userspace.

> But yes in theory it's possible that it just become hot on another cpu...
>
> And again I don't understand the abort handler: why do we get a page  
> fault on
> a young page then? grrh

Permissions?  Userspace trying to write to the page when it isn't marked
writable and dirty?

>> Moreover, what about the case where we actually remove the page?
> I don't claim that this is the only way to deadlock - but this is the  
> case we encounter.

No, but you're arguing that we drop the TLB flush for your specific case.
I'm telling you that's pointless if there's other cases as well which
we'll deadlock.

But that's neither here nor there because you haven't fully explained
what the problem is yet...

>> Aren't we also holding the pte lock there?  So I don't think there's an
>> obvious solution to your deadlock.
>>
>> I think the real question is - in your example - why are you touching
>> a userspace page with IRQs off _and_ expecting the fault to be fixed up?
>> You never really explained what CPU B was doing.
> It was running some user space program. It was not in the kernel.
> I will post the jtag probe screenshots tomorrow.

Why do we need silly screen shots, why can't you explain it, or paste
the output?  I'm not going to bother looking at GIFs, PNGs or jpegs
because my mail reader is text only.

Moreover, user space programs can't disable interrupts.  So you should
not be receiving a data abort from userspace with interrupts disabled.
Yes, when the CPU enters the data abort handler, it will disable
interrupts, but we re-enable them before processing the abort.
