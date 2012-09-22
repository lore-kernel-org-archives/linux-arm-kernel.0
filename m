From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 22 Sep 2012 13:57:37 +0100
Subject: [PATCH] arm: add SDIV/UDIV emulation for ARMv7 processors
In-Reply-To: <1348314563-8436-1-git-send-email-murzin.v@gmail.com>
References: <1348314563-8436-1-git-send-email-murzin.v@gmail.com>
Message-ID: <20120922125737.GJ15609@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 22, 2012 at 03:49:23PM +0400, Vladimir Murzin wrote:
> The Virtualization Extensions introduce the requirement for an ARMv7-A
> implementation to include SDIV and UDIV.  Any implementation of the
> Virtualization Extensions must include the SDIV and UDIV instructions
> in the Thumb and ARM instruction sets.
> 
> In an ARMv7-A implementation that does not include the Virtualization
> Extensions, it is IMPLEMENTATION DEFINED whether:
>  *  SDIV and UDIV are not implemented
>  *  SDIV and UDIV are implemented only in the Thumb instruction set
>  *  SDIV and UDIV are implemented in the Thumb and ARM instruction sets.

We don't want to do emulation of instructions in the kernel because it's
slow.  It's far better for userspace to figure this stuff out itself and
select appropriate libraries and instructions to use than to have the CPU
take an exception, have to save a lot of state, and then emulate the
instruction.

We learnt that with the old FPA emulation code.  We're not making the same
mistake again.

If there's a problem with that, the folk to complain to are at ARM Ltd
for this "implementation defined" madness when it comes to instructions.
