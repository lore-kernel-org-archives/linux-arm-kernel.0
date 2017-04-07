From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 7 Apr 2017 15:45:09 +0200
Subject: [PATCH] ARM: dts: hi6220: Reset the mmc hosts
In-Reply-To: <1489673004-11075-1-git-send-email-daniel.lezcano@linaro.org>
References: <1489673004-11075-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20170407134509.GK2078@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 03:03:24PM +0100, Daniel Lezcano wrote:
> The MMC hosts could be left in an unconsistent or uninitialized state from
> the firmware. Instead of assuming, the firmware did the right things, let's
> reset the host controllers.
> 
> This change fixes a bug when the mmc2/sdio is initialized leading to a hung
> task:
> 
> [  242.704294] INFO: task kworker/7:1:675 blocked for more than 120 seconds.
> [  242.711129]       Not tainted 4.9.0-rc8-00017-gcf0251f #3
> [  242.716571] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  242.724435] kworker/7:1     D    0   675      2 0x00000000
> [  242.729973] Workqueue: events_freezable mmc_rescan
> [  242.734796] Call trace:
> [  242.737269] [<ffff00000808611c>] __switch_to+0xa8/0xb4
> [  242.742437] [<ffff000008d07c04>] __schedule+0x1c0/0x67c
> [  242.747689] [<ffff000008d08254>] schedule+0x40/0xa0
> [  242.752594] [<ffff000008d0b284>] schedule_timeout+0x1c4/0x35c
> [  242.758366] [<ffff000008d08e38>] wait_for_common+0xd0/0x15c
> [  242.763964] [<ffff000008d09008>] wait_for_completion+0x28/0x34
> [  242.769825] [<ffff000008a1a9f4>] mmc_wait_for_req_done+0x40/0x124
> [  242.775949] [<ffff000008a1ab98>] mmc_wait_for_req+0xc0/0xf8
> [  242.781549] [<ffff000008a1ac3c>] mmc_wait_for_cmd+0x6c/0x84
> [  242.787149] [<ffff000008a26610>] mmc_io_rw_direct_host+0x9c/0x114
> [  242.793270] [<ffff000008a26aa0>] sdio_reset+0x34/0x7c
> [  242.798347] [<ffff000008a1d46c>] mmc_rescan+0x2fc/0x360
> 
> [ ... ]
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Hi Xu,

gentle ping.

Thanks.

  -- Daniel

>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 470461d..1e5129b 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -774,6 +774,7 @@
>  			clocks = <&sys_ctrl 2>, <&sys_ctrl 1>;
>  			clock-names = "ciu", "biu";
>  			resets = <&sys_ctrl PERIPH_RSTDIS0_MMC0>;
> +			reset-names = "reset";
>  			bus-width = <0x8>;
>  			vmmc-supply = <&ldo19>;
>  			pinctrl-names = "default";
> @@ -797,6 +798,7 @@
>  			clocks = <&sys_ctrl 4>, <&sys_ctrl 3>;
>  			clock-names = "ciu", "biu";
>  			resets = <&sys_ctrl PERIPH_RSTDIS0_MMC1>;
> +			reset-names = "reset";
>  			vqmmc-supply = <&ldo7>;
>  			vmmc-supply = <&ldo10>;
>  			bus-width = <0x4>;
> @@ -815,6 +817,7 @@
>  			clocks = <&sys_ctrl HI6220_MMC2_CIUCLK>, <&sys_ctrl HI6220_MMC2_CLK>;
>  			clock-names = "ciu", "biu";
>  			resets = <&sys_ctrl PERIPH_RSTDIS0_MMC2>;
> +			reset-names = "reset";
>  			bus-width = <0x4>;
>  			broken-cd;
>  			pinctrl-names = "default", "idle";
> -- 
> 1.9.1
> 

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
