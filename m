From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 19 Jan 2016 23:01:46 +0800
Subject: [LINUX PATCH 1/5] mmc: Workaround for the issue in auto tuning
 mode.
In-Reply-To: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
Message-ID: <CAGb2v655SF-CUbZKKTif0toHqJ61Z4P4_QzQacfQL9EN0Y0zZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 19, 2016 at 10:17 PM, P L Sai Krishna
<lakshmi.sai.krishna.potthuri@xilinx.com> wrote:
> During the auto tuning mode of SDR104, a couple of transactions
> on rx_tap_value which are not incremental or decremental by 1.
> Since the DLL supports only increment/decrement by 1 during
> dynamic change, observed unexpected delays during both these
> transactions.
> The first transaction occurs when the tap value
> reached 0x1F, it will reset to 0x0 and go till 0x7. This
> transaction can be avoided by changing the corecfg_dis1p5xtuningcnt
> to 1'b1 which is currently tied to 1'b0 in the RTL.
> The second transaction occurs after the tuning is completed.
> Once the tuning is done, the tuning fsm in the host controller
> calculates the average pattern match and will write the value
> on the rx tap value. Therefore observed a transaction from 0x7 to
> the final value which need not be a increment/decrement value.
> Because of this issue DLL tuning will not be accurate and SDR50,
> SDR104 & HS200 modes may not work.
>
> This patch adds workaround to change the SD clock after
> tuning done to provide accurate DLL tuning for SDR50,
> SD104 & HS200 modes.
>
> After receiving the tuning done, program "SDCLK Frequency Select"
> of clock control register with a value different from the desired
> value. Wait for the "Internal Clock Stable" bit of the clock
> control register and program the desired frequency.

Does this series apply to any non-Arasan or non-sdhci mmc hosts?
The subject does not indicate a specific platform.

Thanks
ChenYu

> Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 18 ++++++++++++++++++
>  drivers/mmc/host/sdhci-pltfm.c     |  3 +++
>  drivers/mmc/host/sdhci.c           |  5 +++++
>  drivers/mmc/host/sdhci.h           |  4 ++++
>  4 files changed, 30 insertions(+)
