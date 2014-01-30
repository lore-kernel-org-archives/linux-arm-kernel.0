From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 30 Jan 2014 19:06:59 +0100
Subject: [PATCH v2 1/6] idle: move the cpuidle entry point to the generic
 idle loop
In-Reply-To: <52EA8BD4.6020803@linaro.org>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-2-git-send-email-nicolas.pitre@linaro.org>
 <alpine.LFD.2.11.1401291526320.1652@knanqh.ubzr>
 <52E9C946.50704@linux.vnet.ibm.com>
 <alpine.LFD.2.11.1401300021530.1652@knanqh.ubzr>
 <52EA5720.8010000@linaro.org>
 <alpine.LFD.2.11.1401301056180.1652@knanqh.ubzr>
 <52EA8BD4.6020803@linaro.org>
Message-ID: <20140130180659.GI5002@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 06:28:52PM +0100, Daniel Lezcano wrote:
> Ok, I think the mess is coming from 'default_idle' which does not re-enable
> the local_irq but used from different places like amd_e400_idle and
> apm_cpu_idle.
> 
> void default_idle(void)
> {
>         trace_cpu_idle_rcuidle(1, smp_processor_id());
>         safe_halt();
>         trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
> }
> 
> Considering the system configured without cpuidle because this one *always*
> enable the local irq, we have the different cases:
> 
> x86_idle = default_idle();
> ==> local_irq_enable is missing
> 

safe_halt() is "sti; hlt" and so very much does the irq_enable.
