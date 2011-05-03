From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 3 May 2011 15:45:03 +0100
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104281412.40991.arnd@arndb.de>
References: <201104212129.17013.arnd@arndb.de> <11431.1303949729@localhost>
	<1303979259.26744.3.camel@e102109-lin.cambridge.arm.com>
	<201104281412.40991.arnd@arndb.de>
Message-ID: <20110503144503.GA2645@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 02:12:40PM +0200, Arnd Bergmann wrote:
> On Thursday 28 April 2011, Catalin Marinas wrote:
> > On Thu, 2011-04-28 at 01:15 +0100, Valdis.Kletnieks at vt.edu wrote:
> > > On Wed, 27 Apr 2011 12:08:28 BST, Catalin Marinas said:
> > > 
> > > > The current version of the ARM ARM says "unpredictable". But this
> > > > general definition of "unpredictable" does not allow it to deadlock
> > > > (hardware) or have security implications. It is however allowed to
> > > > corrupt data.
> > > 
> > > Not allowed to have security implications, but is allowed to corrupt data.
> > 
> > By security I was referring to TrustZone extensions. IOW, unpredictable
> > in normal (non-secure) world should not cause data corruption in the
> > secure world.
> 
> That definition is rather useless for operating systems that don't use
> Trustzone then, right?

IIUC, the restriction on unpredictable behaviour is basically that the processor
can't do anything which would result in or otherwise imply an escalation of
privilege.

TrustZone is one kind of privilege, but there are plenty of other operations
implying privilege (entering privileged mode from user mode, masking or
intercepting interrupts or exceptions, bypassing or reconfiguring MMU permissions
etc.)  "Unpredictable" behaviours are not allowed to have any such consequences
IIRC.  Without that restriction you wouldn't really have any OS security at all.

In the kernel, we do have to be careful about avoiding unpredictable behaviours,
since we're already running at maximum privilege (not including TZ) -- so the
damage which unpredictable behaviours can wreak is much greater, by running
invalid code, misconfiguring the MMU, allowing caches to get out of sync etc.
But that's not fundamentally different from the general need to avoid kernel bugs
-- the scope of _any_ kernel code to do damage is greater than for userspace code,
whether it involves architecturally unpredictable behaviour, or just plain
ordinary bugs or security holes in the C code.

---Dave

> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
