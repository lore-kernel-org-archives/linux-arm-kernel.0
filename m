From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Sep 2016 11:07:33 +0100
Subject: [PATCH] arm64: use preempt_disable_notrace in _percpu_read/write
In-Reply-To: <1473338802-18712-1-git-send-email-zhang.chunyan@linaro.org>
References: <1473338802-18712-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <20160909100732.GD20192@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 08:46:42PM +0800, Chunyan Zhang wrote:
> When debug preempt or preempt tracer is enabled, preempt_count_add/sub()
> can be traced by function and function graph tracing, and
> preempt_disable/enable() would call preempt_count_add/sub(), so in Ftrace
> subsystem we should use preempt_disable/enable_notrace instead.
> 
> In the commit 345ddcc882d8 ("ftrace: Have set_ftrace_pid use the bitmap
> like events do") the function this_cpu_read() was added to
> trace_graph_entry(), and if this_cpu_read() calls preempt_disable(), graph
> tracer will go into a recursive loop, even if the tracing_on is
> disabled.
> 
> So this patch change to use preempt_enable/disable_notrace instead in
> this_cpu_read().
> 
> Since Yonghui Yang helped a lot to find the root cause of this problem,
> so also add his SOB.
> 
> Signed-off-by: Yonghui Yang <mark.yang@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  arch/arm64/include/asm/percpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Looks good to me:

Acked-by: Will Deacon <will.deacon@arm.com>

However, don't you need to make a similar change to asm-generic/percpu.h
for other architectures (e.g. arch/arm/)?

Will
