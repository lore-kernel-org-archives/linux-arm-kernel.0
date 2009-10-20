From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Oct 2009 21:10:09 +0100
Subject: [PATCH] Use CONFIG_VECTORS_BASE instead of hardcoded 0xffff0000.
In-Reply-To: <63386a3d0910201251n4e6fec18le5a2d2cd0941be78@mail.gmail.com>
References: <1256054856-20404-1-git-send-email-benoit.fouet@free.fr>
	<63386a3d0910201251n4e6fec18le5a2d2cd0941be78@mail.gmail.com>
Message-ID: <20091020201009.GA14305@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2009 at 09:51:35PM +0200, Linus Walleij wrote:
> I think we'd rather get rid of CONFIG_VECTORS_BASE
> with that hex value, this config value could for example
> be CONFIG_VECTORS_LOW | CONFIG_VECTORS_HIGH, mutually
> exclusive instead, and then _LOW will basically never be used
> and things become simpler, I think having a hex value for
> CONFIG_VECTORS_BASE is actually confusing since that
> may give people the (false) idea that this can be set to anything.

In the MMU case, there are only two possible addresses for the vectors -
0x00000000 or 0xffff0000.  Which is in play is entirely dependent on the
state of the V bit in the control register.

Since there are only two possibilities, this is hard-coded into the code,
and VECTORS_BASE is not used - it's pointless and its actually got nothing
to do with what VECTORS_BASE is set to.

In the noMMU case, the base for the vectors is configurable.  Consider
that on noMMU, you need the reset vector to be populated by code before
any RAM is available.  One way to do this is to ensure that ROM or flash
is mapped there.  It could be that the hardware CPU vectors are always
directed to ROM.

So, what noMMU implementations do is they load the ROM image up with
a set of instructions to soft-redirect the CPU vectors (except for
reset) into system RAM, which can be at any address.

This is what VECTORS_BASE is doing - it's allowing noMMU systems to
inform the kernel where the redirected vectors are stored in the system
memory map.

VECTORS_BASE really has no meaning for MMU-based systems.

> Speaking of this: for machines with TCM (like the U300) we'd probably
> like to move our ITCM to 0xffff0000 (CONFIG_VECTORS_BASE) and alter
> the code so that iff CONFIG_VECTORS_BASE == __sitcm_text the
> vectors page will not be allocated and mapped, and vectors go into
> ITCM instead. The idea is that since TCM fast as cache, it's a pretty
> good idea to lock them in there. (Seen on other ARM OS:es...)

No can do - the top of the vector page is used for other purposes,
including storing the current TLS value in that page.  It's not used
solely for the vectors.
