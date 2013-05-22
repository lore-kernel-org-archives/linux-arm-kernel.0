From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 22 May 2013 11:11:56 +0200
Subject: [PATCH] kernel/sched/core.c: need return NULL when BUG() is
 defined as empty.
In-Reply-To: <5199D565.4070307@asianux.com>
References: <5199D565.4070307@asianux.com>
Message-ID: <20130522091156.GC18810@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 03:48:53PM +0800, Chen Gang wrote:
> 
> When neither CONFIG_BUG nor HAVE_ARCH_BUG is defined, need let function
> return failure value ('NULL') instead of random value.

What will such a kernel do? Happily continue running whenever we hit a
BUG? that seems like a particularly bad idea. Should we not have a stub
BUG() function like:

void BUG(void) __attribute__((noreturn))
{
	local_irq_disable();
	while (1) ;
}

Which would at least halt things?
