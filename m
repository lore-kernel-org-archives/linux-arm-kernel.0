From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Wed, 15 Feb 2012 17:09:07 +0100
Subject: [PATCH RFC 0/4] Scheduler idle notifiers and users
In-Reply-To: <20120215160028.GD27825@n2100.arm.linux.org.uk>
References: <1328670355.2482.68.camel@laptop>
 <20120208202314.GA28290@redhat.com> <1328736834.2903.33.camel@pasglop>
 <20120209075106.GB18387@elte.hu> <4F35DD3E.4020406@codeaurora.org>
 <20120211144530.GA497@elte.hu> <4F3AEC4E.9000303@codeaurora.org>
 <1329313085.2293.106.camel@twins>
 <20120215140245.GB27825@n2100.arm.linux.org.uk>
 <1329318063.2293.136.camel@twins>
 <20120215160028.GD27825@n2100.arm.linux.org.uk>
Message-ID: <1329322147.2293.145.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-02-15 at 16:00 +0000, Russell King - ARM Linux wrote:
> 
> > A third possibility is to self-IPI and take it from there.. assuming
> > these platforms can actually self-IPI.
> 
> Even if there was an IPI (not talking about SMP anyway) I'm not sure
> what good it would be.  We can (and do) get an IRQ from the LCD
> controller when its shutdown is complete, but that would have to be
> somehow propagated back up to the cpufreq code.  And the cpufreq code
> would have to know that the LCD controller was alive and therefore had
> to be waited for.  All sounds rather yucky to me. 

If can self-ipi from the scheduler context (which has IRQs disabled),
once you get to the ipi handler your scheduler locks are gone and you
can queue a worklet or wake some kthread to do all the sleeping stuff.
