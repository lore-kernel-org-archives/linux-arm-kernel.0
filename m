From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 09:31:31 +0200
Subject: [PATCH v9 06/20] PM / devfreq: exynos: Add support of bus
 frequency of sub-blocks using passive governor
In-Reply-To: <1460347078-15175-7-git-send-email-cw00.choi@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
 <1460347078-15175-7-git-send-email-cw00.choi@samsung.com>
Message-ID: <570CA453.3060403@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2016 05:57 AM, Chanwoo Choi wrote:
> This patch adds the support of bus frequency feature for sub-blocks which share
> the one power line. If each bus depends on the power line, each bus is not able
> to change the voltage by oneself. To optimize the power-consumption on runtime,
> some buses using the same power line should change the source clock and
> regulator at the same time. So, this patch uses the passive governor to support
> the bus frequency for all buses which sharing the one power line.
> 
> For example,
> 
> Exynos3250 include the two power line for AXI buses as following:
> : VDD_MIF : MIF (Memory Interface) provide the DMC (Dynamic Memory Controller)
>   with the power (regulator).
> : VDD_INT : INT (Internal) provide the various sub-blocks with the power
>   (regulator).
> 
> Each bus is included in as follwoing block. In the case of VDD_MIF, only DMC bus
> use the power line. So, there is no any depencency between buese. But, in the
> case of VDD_INT, various buses share the one power line of VDD_INT. We need to
> make the depenency between buses. When using passive governor, there is no
> problem to support the bus frequency as DVFS for all buses. One bus should be
> operated as the parent bus device which gathering the current load of INT block
> and then decides the new frequency with some governors except of passive
> governor. After deciding the new frequency by the parent bus device, the rest
> bus devices will change the each source clock according to new frequency of the
> parent bus device.
> 
> - MIF (Memory Interface) block
> : VDD_MIF |--- DMC
> 
> - INT (Internal) block
> : VDD_INT |--- LEFTBUS (parent)
>           |--- PERIL
>           |--- MFC
>           |--- G3D
>           |--- RIGHTBUS
>           |--- FSYS
>           |--- LCD0
>           |--- PERIR
>           |--- ISP
>           |--- CAM
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> [tjakobi: Reported debugfs error during booting and cw00.choi fix it.]
> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/devfreq/Kconfig      |   1 +
>  drivers/devfreq/exynos-bus.c | 219 ++++++++++++++++++++++++++++++++++---------
>  2 files changed, 174 insertions(+), 46 deletions(-)


Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
