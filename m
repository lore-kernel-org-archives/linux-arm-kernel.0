From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 May 2011 17:23:39 +0100
Subject: [PATCH] ARM: fix missing 'cpu_relax()' declaration
In-Reply-To: <20110523160944.GA15138@n2100.arm.linux.org.uk>
References: <1306157607-18406-1-git-send-email-marc.zyngier@arm.com>
	<20110523160944.GA15138@n2100.arm.linux.org.uk>
Message-ID: <20110523162339.GC15138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2011 at 05:09:44PM +0100, Russell King - ARM Linux wrote:
> On Mon, May 23, 2011 at 02:33:27PM +0100, Marc Zyngier wrote:
> > ARM build fails with the following symptom:
> > 
> >   CC      arch/arm/kernel/asm-offsets.s
> > In file included from include/linux/seqlock.h:29,
> >                  from include/linux/time.h:8,
> >                  from include/linux/timex.h:56,
> >                  from include/linux/sched.h:57,
> >                  from arch/arm/kernel/asm-offsets.c:13:
> > include/linux/spinlock.h: In function 'spin_unlock_wait':
> > include/linux/spinlock.h:360: error: implicit declaration of function 'cpu_relax'
> > make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
> > 
> > Fix it by including <asm/processor.h>.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Wonder why we haven't see this before.  Could you send this to the patch
> system please?

Hmm, this doesn't fix the problem:

  CC      arch/arm/kernel/asm-offsets.s
In file included from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:57,
                 from arch/arm/kernel/asm-offsets.c:13:
include/linux/spinlock.h: In function ?spin_unlock_wait?:
include/linux/spinlock.h:360: error: implicit declaration of function ?cpu_relax?

My guess is that it does for you because you're building SMP, but the above
also happens with UP.  So, I don't think this is the right fix.

I think its time to use git bisect to try and find what broke this and why.
