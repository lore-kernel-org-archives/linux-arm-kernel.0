From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Mon, 29 Aug 2016 10:50:51 +0800
Subject: [PATCH 2/2] arm64: dts: rockchip: add eMMC's power domain support
 for rk3399
In-Reply-To: <2ab8ab94-fa4d-2cd6-5805-a92ac5f9697e@rock-chips.com>
References: <20160827134103.28160-1-xzy.xu@rock-chips.com>
 <20160827134103.28160-3-xzy.xu@rock-chips.com>
 <2ab8ab94-fa4d-2cd6-5805-a92ac5f9697e@rock-chips.com>
Message-ID: <57C3A30B.5080707@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/27/2016 11:05 PM, Shawn Lin wrote:
> On 2016/8/27 21:41, Ziyuan Xu wrote:
>> Control power domain for eMMC via genpd to reduce power consumption.
>>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
>>
>
> It looks nice to me. But this should be merged after applying that[0]
> as your patch will break bind/unbind test for sdhci-of-arasan on rk3399
> without it[0]. Moreover, Elaine should make sure that upstreamed
> rockchip power domain stuff would not off pd for emmc, *otherwise*, I
> should update my patch to make sure we update clkmul every time when
> doing suspend 2 resume..
>
>
Forgot to say:
If use pd, Although there is no call to power odd the pd_emmc,
it will be power off when the system doing suspend 2 resume.
(Because the system call 
__device_suspend_noirq->pm_genpd_suspend_noirq->rockchip_pd_power_off)

And it's important to note:
If the pd has been power off, some grf regs will be back to the default 
value.(which grf regs in this pd)
So if the pd support power off , this grf regs need to save and restore 
or reinit.
For example:
pd_emmc
	aclk_emmc_grf

If the pd is always on,and this pd have wakeup func.
The device need to add device_init_wakeup() to make the pd always on 
when the system doing suspend 2 resume.

>
> [0]: https://patchwork.kernel.org/patch/9300971/
>
>> ---
>>
>>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index 32aebc8..71733d4 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -239,6 +239,7 @@
>>          #clock-cells = <0>;
>>          phys = <&emmc_phy>;
>>          phy-names = "phy_arasan";
>> +        power-domains = <&power RK3399_PD_EMMC>;
>>          status = "disabled";
>>      };
>>
>> @@ -611,6 +612,11 @@
>>          status = "disabled";
>>      };
>>
>> +    qos_emmc: qos at ffa58000 {
>> +        compatible = "syscon";
>> +        reg = <0x0 0xffa58000 0x0 0x20>;
>> +    };
>> +
>>      qos_hdcp: qos at ffa90000 {
>>          compatible = "syscon";
>>          reg = <0x0 0xffa90000 0x0 0x20>;
>> @@ -739,6 +745,11 @@
>>              };
>>
>>              /* These power domains are grouped by VD_LOGIC */
>> +            pd_emmc at RK3399_PD_EMMC {
>> +                reg = <RK3399_PD_EMMC>;
>> +                clocks = <&cru ACLK_EMMC>;
>> +                pm_qos = <&qos_emmc>;
>> +            };
>>              pd_vio at RK3399_PD_VIO {
>>                  reg = <RK3399_PD_VIO>;
>>                  #address-cells = <1>;
>>
>
>
