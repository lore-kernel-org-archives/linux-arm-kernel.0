From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 19 Apr 2011 20:21:43 -0400 (EDT)
Subject: MT_HIGH_VECTOR mapping set read-only creating illegal access
In-Reply-To: <4DAE0E07.9030806@codeaurora.org>
References: <4DA4F170.4020009@codeaurora.org>
	<alpine.LFD.2.00.1104122308400.28032@xanadu.home>
	<4DAE0E07.9030806@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1104191956290.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Apr 2011, Michael Bohan wrote:

> On 4/12/2011 8:31 PM, Nicolas Pitre wrote:
> > On Tue, 12 Apr 2011, Michael Bohan wrote:
> > If set_tls() writes to 0xffff0ff0 in your case, then you must have an
> > ARM core which is prior ARMv6k.
> 
> Actually, no, but for historical reasons we were not using the hwreg TLS
> support for all configurations. Our libc expected the data at this address.

Are you saying that your user space libc was reading at 0xffff0ff0 
directly?  I hope not, because if you did so, you clearly abused the 
interface and the contract between user space and the kernel.  Here's 
what I wrote in the comment right above the related code:

 * These are segment of kernel provided user code reachable from user space
 * at a fixed address in kernel memory.  This is used to provide user space
 * with some operations which require kernel help because of unimplemented
 * native feature and/or instructions in many ARM CPUs. The idea is for
 * this code to be executed directly in user mode for best efficiency but
 * which is too intimate with the kernel counter part to be left to user
 * libraries.  In fact this code might even differ from one CPU to another
 * depending on the available  instruction set and restrictions like on
 * SMP systems.  In other words, the kernel reserves the right to change
 * this code as needed without warning. Only the entry points and their
 * results are guaranteed to be stable.

This has been there since April 29th 2005 i.e. 6 years ago.

> > > Is there a reason this mapping must be read-only?
> > 
> > It is read-only for user space to prevent user space from messing with
> > the vector table.
> > 
> > In the kernel, it is read-only _only_ when CONFIG_CPU_USE_DOMAINS is not
> > enabled which may happen with ARMv6k and above.  Otherwise, if you are
> > pre ARMv6k, you do use domains, and then the vector page is read-write
> > for the kernel.
> 
> Yes, this seems to be the the key. In previous versions the kernel was given
> this privilege unconditionally in arch/arm/mm/proc-macros.S.
> 
> > > Perhaps we could apply write
> > > access for these special cases only?
> > 
> > I'd rather suggest you investigate what changes you did to your kernel
> > tree that would explain the apparent inconsistency in your kernel
> > config.
> 
> Yes, the inconsistency was on our end. We will revert all hacks and mandate
> that our libc do things correctly.

Good!  Search for "User helpers" in arch/arm/kernel/head-armv.S and see 
following comments if you want proper usage examples.


Nicolas
