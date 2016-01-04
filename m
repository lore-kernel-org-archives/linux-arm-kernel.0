From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 4 Jan 2016 10:00:36 +0000
Subject: [PATCH 4.4-rc5 v22 4/4] ARM: Allow IPI_CPU_BACKTRACE to exploit
 FIQ
In-Reply-To: <201512210618.hMZqsBKl%fengguang.wu@intel.com>
References: <201512210618.hMZqsBKl%fengguang.wu@intel.com>
Message-ID: <568A42C4.4050106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/12/15 22:12, kbuild test robot wrote:
> Hi Daniel,
>
> [auto build test ERROR on v4.4-rc5]
> [also build test ERROR on next-20151218]
> [cannot apply to tip/irq/core]
>
> url:    https://github.com/0day-ci/linux/commits/Daniel-Thompson/irq-arm-Use-FIQ-for-NMI-backtrace-when-possible/20151221-045854
> config: arm-iop-adma (attached as .config)
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>     arch/arm/kernel/traps.c: In function 'handle_fiq_as_nmi':
>>> arch/arm/kernel/traps.c:489:2: error: implicit declaration of function 'handle_arch_irq' [-Werror=implicit-function-declaration]
>       handle_arch_irq(regs);
>       ^
>     cc1: some warnings being treated as errors

Thanks. I'll look at this.


> vim +/handle_arch_irq +489 arch/arm/kernel/traps.c
>
>     483		 * Either the interrupt controller supports FIQ, meaning it will
>     484		 * do the right thing with this call, or we will end up treating a
>     485		 * spurious FIQ (which is normally fatal) as though it were an IRQ
>     486		 * which, although it risks deadlock, still gives us a sporting
>     487		 * chance of surviving long enough to log errors.
>     488		 */
>   > 489		handle_arch_irq(regs);
>     490	
>     491		nmi_exit();
>     492	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
