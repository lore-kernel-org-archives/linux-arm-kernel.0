From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Mon, 29 Aug 2016 09:58:42 +0800
Subject: [PATCH 2/2] arm64: dts: rockchip: add eMMC's power domain support
 for rk3399
In-Reply-To: <2ab8ab94-fa4d-2cd6-5805-a92ac5f9697e@rock-chips.com>
References: <20160827134103.28160-1-xzy.xu@rock-chips.com>
 <20160827134103.28160-3-xzy.xu@rock-chips.com>
 <2ab8ab94-fa4d-2cd6-5805-a92ac5f9697e@rock-chips.com>
Message-ID: <57C396D2.4090607@rock-chips.com>
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
It looks nice to me. I was going on to submit with other Pds.

>
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
