From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Sep 2012 23:06:31 +0100
Subject: [PATCH v3 RESEND 05/17] ARM: LPAE: support 64-bit virt_to_phys
 patching
In-Reply-To: <5060C9C6.8080900@ti.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-6-git-send-email-cyril@ti.com>
 <20120924151305.GA14198@arm.com>
 <alpine.LFD.2.02.1209241152540.6667@xanadu.home> <5060C9C6.8080900@ti.com>
Message-ID: <20120924220631.GI26454@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 04:59:50PM -0400, Cyril Chemparathy wrote:
> I'm thinking of splitting the bank at the 32-bit boundary in such an  
> event, assuming that the remaining memory should be usable as highmem.

I'd say, don't make it any more complicated than it has to be.  Don't
overdesign, especially in this area, and from what I read in this
thread, that's the danger here.

For the time being, we have two classes of systems: those where they
have a decent amount of RAM located below the 4GB mark, and yours which
have all their RAM above the 4GB mark - and again a decent size
contained within any naturally aligned 4GB chunk of the address space.

So, at the moment making the restriction that the top 32-bits of the
address space is constant _is_ the right thing to do.

And given that, I'd suggest that we reduce the size of these changes.
We don't need to go and rewrite the P2V patching stuff - we can merely
extend it.

The p->v translation can work just fine by ignoring the top 32-bits and
adding the offset, as is done today.

The v->p translation can also work in the reverse way, except that we
need to set the high order bits.  That can be done with a mov or movw
instruction, which the v:p patching code _can_ recognise and do the
appropriate thing.

And let's not forget that the range over which the v:p translation has
to work is just the lowmem only, which on most normal configurations
is no more than 1GB.  Though that can be resolved if the high-order
bits need to change by doing this in the v->p translation:

	movw	%hi, #0xVWXY		@ fixup
	adds	%lo, %lo, #offset	@ fixup
	adc	%hi, %hi, #0

_if_ we need to.
