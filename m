From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Sep 2014 17:23:02 +0100
Subject: [PATCH] ARM: mm: clear SCTLR.HA instead of setting it for LPAE
In-Reply-To: <20140923161628.GD6858@e104818-lin.cambridge.arm.com>
References: <1411398137-5521-1-git-send-email-will.deacon@arm.com>
 <20140923161628.GD6858@e104818-lin.cambridge.arm.com>
Message-ID: <20140923162302.GL28608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 05:16:29PM +0100, Catalin Marinas wrote:
> On Mon, Sep 22, 2014 at 04:02:17PM +0100, Will Deacon wrote:
> > SCTLR.HA (hardware access flag) is deprecated, not actually implemented
> > by any CPUs
> 
> That I agree.
> 
> > and would probably break Linux if it was (since we don't use
> > atomics when accessing page table entries).
> 
> But not here. The ARMv7 ARM states:
> 
>   Any implementation of hardware management of the Access flag must
>   ensure that any software changes to the translation table are not
>   overwritten. The architecture does not require software that changes
>   translation table entries to use interlocked operations. The hardware
>   management mechanisms for the Access flag must prevent any loss of
>   data written to translation table entries that might occur when, for
>   example, a write by another processor occurs between the read and
>   write phases of a translation table walk that updates the Access flag.
> 
> So basically you should not be required to change the OS for atomic
> accesses to the page table entries. There is indeed a chance that the OS
> would inadvertently clear the AF bit but that's only affecting the
> statistics a bit.

Well, that explains why nobody managed to implement this in hardware! I'll
remove that part from the commit message.

> > Furthermore, it can confuse cr_alignment checks where the whole value
> > of SCTLR is compared against the value sitting in the hardware, since
> > the bit is actually RAZ/WI and will not match the saved cr_alignment
> > value.
> 
> Is this the right fix for cr_alignment? What if we get other bits in the
> future which are RAZ/WI on ARMv7 and RW on 32-bit ARMv8?

In that case, we'd need to adjust our masks to avoid setting RAZ/WI bits.
This will only be a problem where we were trying to use a feature that was
removed, so it's a useful exercise to go through anyway (an alternative is
to read back the value and see what stuck, but that feels fragile).

Will
