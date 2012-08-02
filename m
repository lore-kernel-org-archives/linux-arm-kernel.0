From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Aug 2012 20:49:31 +0100
Subject: doubts about switch_mm
In-Reply-To: <501AD023.3020204@xenomai.org>
References: <501AD023.3020204@xenomai.org>
Message-ID: <20120802194931.GY6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 09:08:19PM +0200, Gilles Chanteperdrix wrote:
> switch_mm code, as of 3.5 contains:
> 
> 1   if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next) {  
> 2           check_and_switch_context(next, tsk);                             
> 3           if (cache_is_vivt())                                             
> 4                   cpumask_clear_cpu(cpu, mm_cpumask(prev));                
> 5   }                                                                        
> 
> Line 1 seems to mean that maybe switch_mm is called with prev == next.
> But then, what line 4 does is certainly wrong if prev == next.

Look at it more carefully.

If prev == next, then we're already running with *this* mm.  The bit
in the CPU mask for this CPU will be set.

So, cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) will be true, and
because the condition is inverted, the first half of the if condition
is false.

The second half is false, because prev == next.  So lines 2-4 will not
be executed.
