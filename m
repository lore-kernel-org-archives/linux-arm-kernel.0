From: javi.merino@arm.com (Javi Merino)
Date: Fri, 12 Jul 2013 12:13:22 +0100
Subject: [PATCH] irqchip: gic: Don't complain in gic_get_cpumask() if UP
 system
In-Reply-To: <1373067573-29946-1-git-send-email-sboyd@codeaurora.org>
References: <1373067573-29946-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130712111322.GC3213@e102654-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 06, 2013 at 12:39:33AM +0100, Stephen Boyd wrote:
> In a uniprocessor implementation the interrupt processor targets
> registers are read-as-zero/write-ignored (RAZ/WI). Unfortunately
> gic_get_cpumask() will print a critical message saying
> 
>  GIC CPU mask not found - kernel will fail to boot.
> 
> if these registers all read as zero, but there won't actually be
> a problem on uniprocessor systems and the kernel will boot just
> fine. Skip this check if we're running a UP kernel or if we
> detect that the hardware only supports a single processor.
> 
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> Maybe we should just drop the check entirely? It looks like it may
> just be debug code that won't ever trigger in practice, even on the
> 11MPCore that caused this code to be introduced.

I agree, we should drop the check.  It's annoying in uniprocessors and
unlikely to be found in the real world unless your gic entry in the dt
is wrong.
