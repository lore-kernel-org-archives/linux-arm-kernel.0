From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Sep 2009 23:14:09 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090921212637.GG30821@n2100.arm.linux.org.uk>
References: <1253435940.498.15.camel@pc1117.cambridge.arm.com>	<20090920093139.GA1704@n2100.arm.linux.org.uk>	<20090920190227.GB5413@n2100.arm.linux.org.uk>	<4AB6B0AB.8040307@arm.com>
	<20090921083109.GC20006@shareable.org>	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>	<20090921085425.GC27357@n2100.arm.linux.org.uk>	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>	<20090921100751.GF27357@n2100.arm.linux.org.uk>	<20090921201043.GA14700@shareable.org>
	<20090921212637.GG30821@n2100.arm.linux.org.uk>
Message-ID: <4AB7FAB1.30905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Sep 21, 2009 at 09:10:43PM +0100, Jamie Lokier wrote:
>> And here's a little something:
>>
>> http://www.mail-archive.com/aufs-users at lists.sourceforge.net/msg02093.html
>>
>> It's about MIPS, but has an awful lot of things in common with the bug
>> being discussed in this thread: dynamic linker, constants embedded in
>> the code, using mprotect rx->rw->rx, missing I-cache flush, only
>> affects COW, copy_user_highpage(), is worked around by switching the
>> cache from write-back to write-through...
>>
>> Useful?
> 
> Depends.  ARMv7 has the requirement that memory is not mapped in using
> different cache settings (we already violate that, and ARM Ltd's aware
> of that, but no one yet knows how to solve it in Linux.)

I think so far the hardware can cope with this as long as you don't 
access both mappings at the same time (they would need at least a DSB 
between accesses with different mappings). If a new CPU requires this 
strict rule to be enforced, the solution I see is a hardware one - ACP 
(ARM's Accelerator Coherency Port) - where we get everything, including 
DMA memory, mapped cached.

-- 
Catalin
