From: peterz@infradead.org (Peter Zijlstra)
Date: Sat, 25 Feb 2017 10:51:17 +0100
Subject: [tip:perf/urgent] perf/core: Fix the perf_cpu_time_max_percent
 check
In-Reply-To: <58B13BFD.2050304@huawei.com>
References: <1487829879-56237-1-git-send-email-tanxiaojun@huawei.com>
 <tip-1572e45a924f254d9570093abde46430c3172e3d@git.kernel.org>
 <58B13BFD.2050304@huawei.com>
Message-ID: <20170225095117.GU6500@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2017 at 04:10:37PM +0800, Tan Xiaojun wrote:

> Recently I was using perf_fuzzer for testing in Hisilicon
> D03/D05(arm64, linux-4.10-rc1).
> 
> As we know perf_fuzzer will write a random value to procfs interface
> of perf event(like sysctl_perf_cpu_time_max_percent). The value may be
> 0 or 100, and I get logs like below:
> 
> ----------------------------------
> [ 4046.358811] perf: Dynamic interrupt throttling disabled, can hang your system!
> ----------------------------------
> 
> Most of the time, there is no problem, and the perf_fuzzer test can
> end without any warings or errors.  But there is a small probability
> that triggers the RCU and watchdog (The log is attached at the end).
> It hungs after local_irq_enable() in __do_softirq.
> 
> I think this is due to the dynamic interrupt throttling disabled and
> too many hardware interruptions come. So I limit the
> sysctl_perf_cpu_time_max_percent can only be set 1 to 99 in the kernel
> codes. I test more than 20 times in D03, and there are no errors or
> warnings in the test.
> 
> So I want to ask:
> 
> 1)Is it a problem or not? (It has already given you a warning.)
> 
> 2)If it is, where we will fix it more appropriate, perf_fuzzer(not set
> 0 or 100) or kernel(limit 1 to 99), or maybe it is the bug of
> hardware(too many hardware interruptions)?

I think the best would be if the fuzzer would not set 0,100, those are
clearly 'unsafe' settings and you pretty much get to keep the pieces.

I would like to preserve these settings for people that 'know' what
they're doing and are willing to take the risk, but clearly, when you
take the guard-rails off, things can come apart.
