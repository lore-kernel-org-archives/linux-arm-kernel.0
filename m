From: lsun@mellanox.com (Liming Sun)
Date: Tue, 17 Oct 2017 15:52:03 +0000
Subject: [PATCH 0/9] Enable dw-mmc multi-card support
In-Reply-To: <8e433531-8f67-d575-635e-c6ced29f6804@rock-chips.com>
References: <cover.1507315433.git.lsun@mellanox.com>
 <8e433531-8f67-d575-635e-c6ced29f6804@rock-chips.com>
Message-ID: <AM2PR05MB07533A822C7CCBA7111FD58FA14C0@AM2PR05MB0753.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Hrm.... it's so unlucky that your patchset comes a little late. As your patch 8 and 9 said, you need them to fix problem for multi-card support, so definitely there was no such use case, and even the code was buggy to support it right? That makes the code hard to read and maintain, so we decide to remove it.

Thanks for the feedback. Yes, earlier the multi-card support was buggy indeed. We spent some time to debug it and got it working.

>> Havn'e check the databook for details yet, but I think it's ok to re-introduce multi-slot support if a real user benefits from it. But you need a new patch to silent the log "num-slots property not found, assuming 1 slot is available" as we removed all the num-slots from DT at that time.

The " num-slots property not found..." log message has already been removed by 8a629d26f back in 2016. Looks like we're good on this one. In dw_mci_probe (), it has code to check pdata->num_slots. If 0, the host->num_slots will be set to 1. So the logic of setting default num_slots seems already there. But correct me if I am wrong.

Thanks,
Liming

-----Original Message-----
From: Shawn Lin [mailto:shawn.lin at rock-chips.com] 
Sent: Monday, October 16, 2017 9:36 PM
To: Liming Sun <lsun@mellanox.com>; Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Kukjin Kim <kgene@kernel.org>; Krzysztof Kozlowski <krzk@kernel.org>; shawn.lin at rock-chips.com; linux-mmc at vger.kernel.org; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-samsung-soc at vger.kernel.org
Subject: Re: [PATCH 0/9] Enable dw-mmc multi-card support


On 2017/10/7 3:21, Liming Sun wrote:
> This series of commits enables the multi-card support for the dw-mmc 
> controller. It includes two parts as below.
> 
> The first part (patches 1-7) reverts the series of recent commits that 
> removed the multi-card support with comments saying there was no such 
> use case in the real world. Actually this feature is being used in 
> Mellanox Bluefield SoC and has been requested by customers.

Hrm.... it's so unlucky that your patchset comes a little late. As your patch 8 and 9 said, you need them to fix problem for multi-card support, so definitely there was no such use case, and even the code was buggy to support it right? That makes the code hard to read and maintain, so we decide to remove it.

> 
> The second part (patches 8-9) fixes the DesignWare multi-card support 
> according to the dw-mmc databook (synnopsys: DesignWare Cores Mobile 
> Storage Host Databook, 2.70a). It has changes to set the card number 
> into the CMD register to multiplex requests to different cards when 
> working in SD_MMC_CEATA mode, set the CTYPE / CLKENA / CDTHRCTL 
> registers properly according to the spec, and parse the per-card 
> configuration to match the Linux Documentation 
> (bindings/mmc/synopsys-dw-mshc.txt).

Havn'e check the databook for details yet, but I think it's ok to re-introduce multi-slot support if a real user benefits from it. But you need a new patch to silent the log "num-slots property not found, assuming 1 slot is available" as we removed all the num-slots from DT at that time.


> 
> Liming Sun (9):
>    Revert "Documentation: dw-mshc: deprecate num-slots"
>    Revert "mmc: dw_mmc: remove the unnecessary slot variable"
>    Revert "mmc: dw_mmc: use the 'slot' instead of 'cur_slot'"
>    Revert "mmc: dw_mmc: remove the 'id' arguments about functions
>      relevant to slot"
>    Revert "mmc: dw_mmc: change the array of slots"
>    Revert "mmc: dw_mmc: remove the loop about finding slots"
>    Revert "mmc: dw_mmc: deprecated the "num-slots" property"
>    mmc: dw_mmc: Support two SD_MMC_CE-ATA cards
>    mmc: dw_mmc: Parse slot-specific configuration
> 
>   .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  16 +-
>   drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
>   drivers/mmc/host/dw_mmc.c                          | 277 ++++++++++++++++-----
>   drivers/mmc/host/dw_mmc.h                          |  17 +-
>   4 files changed, 236 insertions(+), 78 deletions(-)
> 
