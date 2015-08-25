From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 25 Aug 2015 14:02:54 +0100
Subject: [PATCH v3 1/1] misc: sram: add dev_pm_ops to support module power
 gate
In-Reply-To: <1438272681-29338-1-git-send-email-shenwei.wang@freescale.com>
References: <1438272681-29338-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <55DC677E.1030004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/07/15 17:11, Shenwei Wang wrote:
> When system goes into low power states like SUSPEND_MEM and
> HIBERNATION, the hardware IP block may be powered off to reduce
> the power consumption. This power down will lost all the
> data inside the ram. This patch added the dev_pm_ops and
> implemented two callbacks: suspend_noirq and resume_noirq, which
> will save the data in the on-chip-ram right before power down
> and restore it after system resumes.
>

Who uses this SRAM ? Can't they be released before suspending ?
This might not be feasible and time consuming as the size of SRAM increases.

Also I just check the entire tree for the users of gen_pool, I found
it's used for video/audio and crypto which needs to on-demand basis.
Apart from that it's mainly used for low power modes in which case,
SRAM needs to be powered on. So can you provide more details on your
use-case.

> A new property string named "can-power-gate" is added to
> the devicetree bindings too.
>
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
> Change log:
>
> PATCH v3
> 	Removed the unnecessary clk_enable/clk_disable.
>
> PATCH v2
> 	Use vmalloc to allocate the SRAM backup memory.
> 	Code clean up.
>
>   Documentation/devicetree/bindings/misc/sram.txt |  2 ++
>   drivers/misc/sram.c                             | 42 +++++++++++++++++++++++++
>   2 files changed, 44 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/misc/sram.txt b/Documentation/devicetree/bindings/misc/sram.txt
> index 36cbe5a..1170086 100644
> --- a/Documentation/devicetree/bindings/misc/sram.txt
> +++ b/Documentation/devicetree/bindings/misc/sram.txt
> @@ -33,6 +33,8 @@ Optional properties in the area nodes:
>
>   - compatible : standard definition, should contain a vendor specific string
>                  in the form <vendor>,[<device>-]<usage>
> +- can-power-gate: a property to tell the driver that the sram can support
> +		power gate
>

Please cc device-tree list for such generic bindings.

Regards,
Sudeep
