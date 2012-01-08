From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Jan 2012 10:38:23 +0000
Subject: [PATCH 12/14] mmc: mmci: Decrease current consumption in suspend
In-Reply-To: <1323106560-5218-13-git-send-email-ulf.hansson@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
 <1323106560-5218-13-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20120108103823.GB21765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 06:35:58PM +0100, Ulf Hansson wrote:
> To decrease current consumption in suspend state the
> VCORE regulator, the MCLK and PCLK for the ARM PL18x
> are now disabled.
> 
> When resuming the resourses are re-enabled and
> register values for MMCICLOCK, MMCIPOWER and MMCIMASK0
> are restored.

I still do not agree with this.  The MMC core driver should be shutting
down the interface (turning off the MMC clock, disabling the MMC power).
And indeed it does:

int mmc_suspend_host(struct mmc_host *host)
{
...
        if (!err && !mmc_card_keep_power(host))
                mmc_power_off(host);
}

void mmc_power_off(struct mmc_host *host)
{
...
        host->ios.power_mode = MMC_POWER_OFF;
        host->ios.bus_width = MMC_BUS_WIDTH_1;
        host->ios.timing = MMC_TIMING_LEGACY;
        mmc_set_ios(host);
...
}

On ARM primecells we can _not_ go from power off to power on without
first going through the power up state, so this simple save-and-restore
will not do - we have to go through the proper power up sequence.

Why do you think that the MMC core is not shutting down the power and
clock registers on suspend?
