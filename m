From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 9 Nov 2015 18:36:19 +0100
Subject: [PATCH v11 2/5] missing include asm/paravirt.h in cputime.c
In-Reply-To: <alpine.DEB.2.02.1511051659580.13541@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
 <1446737696-9749-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <20151105164032.GG3604@twins.programming.kicks-ass.net>
 <alpine.DEB.2.02.1511051659580.13541@kaball.uk.xensource.com>
Message-ID: <20151109173619.GW3604@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 05:30:01PM +0000, Stefano Stabellini wrote:
> On Thu, 5 Nov 2015, Peter Zijlstra wrote:
> > How can this be missing? Things compile fine now, right?
> 
> Fair enough.
> 
> 
> > So please better explain why we do this change.
> 
> asm/paravirt.h is included by one of the other headers included in
> kernel/sched/cputime.c on x86, but not on other architecures. On arm and
> arm64, where I am about to introduce asm/paravirt.h and stolen time
> support, without #include <asm/paravirt.h> in cputime.c I would get:
> 
> kernel/sched/cputime.c: In function ?steal_account_process_tick?:
> kernel/sched/cputime.c:260:24: error: ?paravirt_steal_enabled? undeclared (first use in this function)
>   if (static_key_false(&paravirt_steal_enabled)) {
> 
> A bit of digging on x86 (using gcc -E on cputime.c) tells me that
> asm/paravirt.h is coming from the following include chain:
> 
> #include <kernel/sched/sched.h>
> #include <linux/spinlock.h>
> #include <linux/preempt.h>
> #include <asm/preempt.h>
> #include <linux/thread_info.h>
> #include <asm/thread_info.h>
> #include <asm/processor.h>
> #include <asm/msr.h>
> #include <asm/paravirt.h>


Fair enough; a slightly shorter version of that for a changelog will do
nicely.

Thanks!
