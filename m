From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 2 Jan 2018 14:04:07 +0000
Subject: [PATCH v3 0/2] Avoid calling cpu_pm functions for retention idle
 states
In-Reply-To: <1510765910-23739-1-git-send-email-pprakash@codeaurora.org>
References: <1510765910-23739-1-git-send-email-pprakash@codeaurora.org>
Message-ID: <20180102140406.kjso7mgizlp6aj4b@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 10:11:48AM -0700, Prashanth Prakash wrote:
> CPU_PM_CPU_IDLE_ENTER() treats all idle states whose idx != 0 as a
> state that loses some context, but we can have deeper idle states that
> doesn't lose any software context. If a CPU is entering such a low power
> idle state where it retains the context, then there is no need to call
> cpu_pm_enter()/cpu_pm_exit().
> 
> Add a new macro(CPU_PM_CPU_IDLE_ENTER_RETENTION) to be used by cpuidle
> drivers when they are entering retention state. By not calling cpu_pm_enter
> and cpu_pm_exit we reduce the latency involved in entering and exiting
> the retention states.
> 
> On ARM64 based Qualcomm server platform we measured below overhead for
> for calling cpu_pm_enter and cpu_pm_exit for retention states.
> 
> workload: stress --hdd #CPUs --hdd-bytes 32M  -t 30
> Overhead of cpu_pm_enter - 1.2us(Average), 6.5us(Max)
> Overhead of cpu_pm_exit  - 3.1us(Average), 11.1us(Max)

I queued the patches in the arm64 tree for 4.16. Thanks.

-- 
Catalin
