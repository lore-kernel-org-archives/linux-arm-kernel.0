From: vviswana@codeaurora.org (Vijay Viswanath)
Date: Tue, 12 Sep 2017 14:57:09 +0530
Subject: [PATCH v1 0/5] mmc: sdhci-msm: Corrections to implementation of
 power irq
In-Reply-To: <1504097509-58983-1-git-send-email-vviswana@codeaurora.org>
References: <1504097509-58983-1-git-send-email-vviswana@codeaurora.org>
Message-ID: <45f67de0-ba85-74b8-0dea-5b8e8a337dbe@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adrian, Ulf,

I have addressed the comments on previous patch series. Can you please 
tell how I should proceed from here?

Thanks,
Vijay

On 8/30/2017 6:21 PM, Vijay Viswanath wrote:
> Register writes which change voltage of IO lines or turn the IO bus on/off
> require sdhc controller to be ready before progressing further. Once a
> register write which affects IO lines is done, the driver should wait for
> power irq from controller. Once the irq comes, the driver should acknowledge
> the irq by writing to power control register. If the acknowledgement is not
> given to controller, the controller may not complete the corresponding
> register write action and this can mess up the controller if drivers proceeds
> without power irq completing.
> 
> Changes since RFC:
> 	wait_for_completion_timeout replaced with wait_event_timeout when
> 	waiting for power irq.
> 	Removed the spinlock within power irq handler and API which waits
> 	for power irq.
> 	Added comments to sdhci msm register write functions, warning that they
> 	can sleep.
> 	Sdhci msm register write functions will do a memory barrier before
> 	writing to the register if the particular register can trigger
> 	power irq.
> 	Instead of enabling SDHCI IO ACCESSORS config in arm64/defconfig, it
> 	will be selected in mmc/host/Kconfig if the platform is MMC_SDHCI_MSM.
> 
> 
> Sahitya Tummala (2):
>    mmc: sdhci-msm: Fix HW issue with power IRQ handling during reset
>    mmc: sdhci-msm: Add support to wait for power irq
> 
> Subhash Jadavani (1):
>    mmc: sdhci-msm: fix issue with power irq
> 
> Vijay Viswanath (2):
>    mmc: sdhci-msm: Add ops to do sdhc register write
>    mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS
> 
>   drivers/mmc/host/Kconfig     |   1 +
>   drivers/mmc/host/sdhci-msm.c | 253 ++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 249 insertions(+), 5 deletions(-)
> 
