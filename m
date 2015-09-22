From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 22 Sep 2015 12:59:00 +0200 (CEST)
Subject: [PATCH v3] arm: Fix backtrace generation when IPI is masked
In-Reply-To: <1442328005-13661-1-git-send-email-daniel.thompson@linaro.org>
References: <1442222294-2756-1-git-send-email-daniel.thompson@linaro.org>
 <1442328005-13661-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <alpine.DEB.2.11.1509221258330.5606@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Sep 2015, Daniel Thompson wrote:

> Currently on ARM when <SysRq-L> is triggered from an interrupt handler
> (e.g. a SysRq issued using UART or kbd) the main CPU will wedge for ten
> seconds with interrupts masked before issuing a backtrace for every CPU
> except itself.
> 
> The new backtrace code introduced by commit 96f0e00378d4 ("ARM: add
> basic support for on-demand backtrace of other CPUs") does not work
> correctly when run from an interrupt handler because IPI_CPU_BACKTRACE
> is used to generate the backtrace on all CPUs but cannot preempt the
> current calling context.
> 
> This can be fixed by detecting that the calling context cannot be
> preempted and issuing the backtrace directly in this case. Issuing
> directly leaves us without any pt_regs to pass to nmi_cpu_backtrace()
> so we also modify the generic code to call dump_stack() when its
> argument is NULL.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

For the genric part.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
