From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Sep 2015 12:30:03 +0100
Subject: [PATCH v2] arm: Fix backtrace generation when IPI is masked
In-Reply-To: <1442315112-14039-1-git-send-email-daniel.thompson@linaro.org>
References: <1442222294-2756-1-git-send-email-daniel.thompson@linaro.org>
 <1442315112-14039-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150915113003.GS21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 12:05:12PM +0100, Daniel Thompson wrote:
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

This patch needs a little more work - what happens to the IPI_CPU_BACKTRACE
we've sent to ourselves?  (It fires after the interrupt handler for the
UART/kbd has finished.)  It ought to be masked out if we're going to
handle it a different way.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
