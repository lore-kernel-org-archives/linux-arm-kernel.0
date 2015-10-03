From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Oct 2015 16:40:43 +0100
Subject: [PATCH v3] arm: Fix backtrace generation when IPI is masked
In-Reply-To: <1442328005-13661-1-git-send-email-daniel.thompson@linaro.org>
References: <1442222294-2756-1-git-send-email-daniel.thompson@linaro.org>
 <1442328005-13661-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20151003154042.GH21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 03:40:05PM +0100, Daniel Thompson wrote:
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

When submitting a patch to the patch system, please ensure that you pick
up people's acks _before_ submitting it to there - don't expect me to
search the mailing list, identify which patch version is the one in the
patch system, and then read the entire thread finding all the acks, then
having to amend the commit to add them.

A patch in the patch system with no acks looks like a patch which hasn't
been sent to the mailing lists.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
