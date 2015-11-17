From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Nov 2015 17:12:13 +0000
Subject: [PATCH] arm64: kernel: pause/unpause function graph tracer in
 cpu_suspend()
In-Reply-To: <1447761051-811-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1447761051-811-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20151117171213.GL6556@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 11:50:51AM +0000, Lorenzo Pieralisi wrote:
> The function graph tracer adds instrumentation that is required to trace
> both entry and exit of a function. In particular the function graph
> tracer updates the "return address" of a function in order to insert
> a trace callback on function exit.
> 
> Kernel power management functions like cpu_suspend() are called
> upon power down entry with functions called "finishers" that are in turn
> called to trigger the power down sequence but they may not return to the
> kernel through the normal return path.
> 
> When the core resumes from low-power it returns to the cpu_suspend()
> function through the cpu_resume path, which leaves the trace stack frame
> set-up by the function tracer in an incosistent state upon return to the
> kernel when tracing is enabled.
> 
> This patch fixes the issue by pausing/resuming the function graph
> tracer on the thread executing cpu_suspend() (ie the function call that
> subsequently triggers the "suspend finishers"), so that the function graph
> tracer state is kept consistent across functions that enter power down
> states and never return by effectively disabling graph tracer while they
> are executing.
> 
> Fixes: 819e50e25d0c ("arm64: Add ftrace support")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: <stable@vger.kernel.org> # 3.16+

Patch applied. Thanks.

-- 
Catalin
