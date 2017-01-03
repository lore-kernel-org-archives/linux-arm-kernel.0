From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Jan 2017 10:04:53 +0000
Subject: [RFC PATCH] sched: Remove set_task_state()
In-Reply-To: <1483121873-21528-1-git-send-email-dave@stgolabs.net>
References: <1483121873-21528-1-git-send-email-dave@stgolabs.net>
Message-ID: <20170103100453.GB5605@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2016 at 10:17:53AM -0800, Davidlohr Bueso wrote:
> Secondly for a higher overview, an unlink microbenchmark was used,
> which pounds on a single file with open, close,unlink combos with
> increasing thread counts (up to 4x ncpus). While the workload is
> quite unrealistic, it does contend a lot on the inode mutex or now
> rwsem. With the archs I had access to, the differences are as follows:
> 
> == 1. arm64 ==
> 
> 0000000000002784 <set_task_state>:
>     2784:       f9000c1f        str     xzr, [x0,#24]
> 
> 0000000000002790 <set_current_state>:
>     2790:       d5384100        mrs     x0, sp_el0
>     2794:       f9000c1f        str     xzr, [x0,#24]
> 
> Avg runtime set_task_state():    2648 msecs
> Avg runtime set_current_state(): 2686 msecs

> Unsurprisingly, the big looser is arm64, due to the masking of sp_el0.
> otoh, x86-64 (known to be fast for get_current()/this_cpu_read_stable()
> caching) and ppc64 (with paca) show similar improvements in the unlink
> microbenches. x86's write latencies delta is similar to the opposite of
> arm64: 50ms vs -40ms, respectively. The small delta for ppc64 (2ms), does
> not represent the gains on the unlink runs. In the case of x86, there was
> a decent amount of variation in the latency runs, but always within a 20
> to 50ms increase), ppc was more constant.
> 
> So, do we want to get rid of the interface (and improve performance on
> other archs) at the expense of arm64? Can arm64 do better?

We can defineitely do better; the asm constraints in read_sysreg() are
overly pessimistic for get_current().

Does the below help?

Thanks,
Mark.

---->8----
diff --git a/arch/arm64/include/asm/current.h b/arch/arm64/include/asm/current.h
index f2bcbe2..c9ba5ac 100644
--- a/arch/arm64/include/asm/current.h
+++ b/arch/arm64/include/asm/current.h
@@ -11,7 +11,11 @@
 
 static __always_inline struct task_struct *get_current(void)
 {
-       return (struct task_struct *)read_sysreg(sp_el0);
+       struct task_struct *tsk;
+
+       asm ("mrs %0, sp_el0" : "=r" (tsk));
+
+       return tsk;
 }
 
 #define current get_current()
