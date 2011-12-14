From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Dec 2011 09:52:43 +0100
Subject: [PATCH 6/6] HACK: arm: reprogram twd based on clk notifier
In-Reply-To: <1323837088-2469-7-git-send-email-mturquette@ti.com>
References: <1323837088-2469-1-git-send-email-mturquette@ti.com>
 <1323837088-2469-7-git-send-email-mturquette@ti.com>
Message-ID: <CACRpkdYok311RJKsz55mA=Wd0fSjmSwjhYMgeMdLXCwb9OnwJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

I just sent new patches for the TWD CPUfreq stuff, including the bug fix you
provide below for clk_prepare(). They're in Russell's patch tracker:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7210/1
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7211/1
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7212/1

On Wed, Dec 14, 2011 at 5:31 AM, Mike Turquette <mturquette@ti.com> wrote:

> The primary purpose behind this change is to test the new clk notifier
> code. ?If you find it useful beyond that, please let me know!

This is way more elegant that the cpufreq way of doing things.
For several years I was confused by TI:s way of re-reading any
peripheral clock speed in CPUfreq notifiers when there was strictly
no theoretical requirement for the CPU to actually change it's frequency
when the clock frequency for that particular device changed.

See for example drivers/mmc/host/davinci_mmc.c:

#ifdef CONFIG_CPU_FREQ
static int mmc_davinci_cpufreq_transition(struct notifier_block *nb,
                                     unsigned long val, void *data)
{
        struct mmc_davinci_host *host;
        unsigned int mmc_pclk;
        struct mmc_host *mmc;
        unsigned long flags;

        host = container_of(nb, struct mmc_davinci_host, freq_transition);
        mmc = host->mmc;
        mmc_pclk = clk_get_rate(host->clk);

        if (val == CPUFREQ_POSTCHANGE) {
                spin_lock_irqsave(&mmc->lock, flags);
                host->mmc_input_clk = mmc_pclk;
                calculate_clk_divider(mmc, &mmc->ios);
                spin_unlock_irqrestore(&mmc->lock, flags);
        }

        return 0;
}


...what does the CPU has to do with the MMC host->clk again?
Absolutely nothing. There is no point in the MMC framework
knowing that the CPU is changing operating point.
(There is a similar hack in the s3c MMC driver.)

The clk notifiers are the sane way of doing this.

Yours,
Linus Walleij
