From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Feb 2010 12:16:43 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <20100223111036.GA10501@n2100.arm.linux.org.uk>
References: <20100223110105.11048.8143.stgit@e102109-lin.cambridge.arm.com>
	<20100223111036.GA10501@n2100.arm.linux.org.uk>
Message-ID: <1266927403.3123.56.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-02-23 at 11:10 +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 23, 2010 at 11:01:05AM +0000, Catalin Marinas wrote:
> > -#define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> > -#define rmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> > -#define wmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> > +#define mb()		dsb()
> > +#define rmb()		dmb()
> > +#define wmb()		dsb()
> 
> What is the reason for getting rid of the arch_is_coherent() bit here
> and imposing non-compiler barriers on everything?  

The original code defines the mandatory barriers only if
__LINUX_ARCH_ARM__ >= 7 || CONFIG_SMP. However we still need them for
earlier architectures (v6). We can change the #if here to test for
earlier architectures as well and only do the arch_is_coherent() check
for some early implementations that don't have barriers.

> This also breaks ARMv3 since you now issue a mcr for the write buffer
> on architectures which have no write buffer.

Is this the case for another #ifdef? I can add it.

-- 
Catalin
