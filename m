From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Thu, 22 Jun 2017 18:24:45 +0800
Subject: [PATCH V1 9/9] arm64: dts: add ccu for SC9860
In-Reply-To: <20170620012411.GF4493@codeaurora.org>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
 <20170618015855.27738-10-chunyan.zhang@spreadtrum.com>
 <20170620012411.GF4493@codeaurora.org>
Message-ID: <CAAfSe-tBtcsyocumaDAyUP674ey1z+xmfAOR7cqnakM_+MOtfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 20 June 2017 at 09:24, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/18, Chunyan Zhang wrote:
>> diff --git a/arch/arm64/boot/dts/sprd/sc9860-ccu.dtsi b/arch/arm64/boot/dts/sprd/sc9860-ccu.dtsi
>> new file mode 100644
>> index 0000000..e15bf2d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/sprd/sc9860-ccu.dtsi
>> @@ -0,0 +1,67 @@
>> +/*
>> + * Spreadtrum SC9860 SoC CCU
>> + *
>> + * Copyright (C) 2017, Spreadtrum Communications Inc.
>> + *
>> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> + */
>> +
>> +&soc {
>> +     ext_26m: ext-26m {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <26000000>;
>> +             clock-output-names = "ext-26m";
>> +     };
>> +
>> +     ext_32m_sine0: ext-32m-sine0 {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <32000000>;
>> +             clock-output-names = "ext-32m-sine0";
>> +     };
>> +
>> +     ext_32m_sine1: ext-32m-sine1 {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <32000000>;
>> +             clock-output-names = "ext-32m-sine1";
>> +     };
>> +
>> +     ext_rco_100m: ext-rco-100m {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <100000000>;
>> +             clock-output-names = "ext-rco-100m";
>> +     };
>> +
>> +     ext_32k: ext-32k {
>> +             compatible = "fixed-clock";
>> +             #clock-cells = <0>;
>> +             clock-frequency = <32768>;
>> +             clock-output-names = "ext-32k";
>> +     };
>
> These should all be outside of the soc node as they're probably
> on the board and not the SoC? The hint is that they don't have a
> reg property.
>
>> +
>> +     ccu: clk {
>
> clock-controller is a more standard node name.

OK, will address.

>
>> +             compatible = "sprd,sc9860-ccu";
>> +             #clock-cells = <1>;
>> +             reg = <0 0x20000000 0 0x400>,
>> +                   <0 0x20210000 0 0x3000>,
>> +                   <0 0x402b0000 0 0x4000>,
>> +                   <0 0x402d0000 0 0x400>,
>> +                   <0 0x402e0000 0 0x4000>,
>> +                   <0 0x40400000 0 0x400>,
>> +                   <0 0x40880000 0 0x400>,
>> +                   <0 0x415e0000 0 0x400>,
>> +                   <0 0x60200000 0 0x400>,
>> +                   <0 0x61000000 0 0x400>,
>> +                   <0 0x61100000 0 0x3000>,
>> +                   <0 0x62000000 0 0x4000>,
>> +                   <0 0x62100000 0 0x4000>,
>> +                   <0 0x63000000 0 0x400>,
>> +                   <0 0x63100000 0 0x3000>,
>> +                   <0 0x70b00000 0 0x3000>;
>
> There are a lot of reg properties here. Perhaps there needs to be
> different nodes for the different clock controllers in this SoC?
>

On Spreadtrum's platform, clocks are basically located in a few
address areas due to some hardware design issue, that says there're
more than one kinds of clocks in one address range, and one kind of
clocks have more than one physical address bases, except ccu_pll and
ccu_div in this patchset.

We're planning to map the whole device area at one time before
initializing each of them, once that has been done and upstreamed, I
will remove these lists of addressed.

Thanks for your review,
Chunyan

>> +             clocks = <&ext_26m>, <&ext_rco_100m>, <&ext_32k>;
>> +             clock-names = "ext-26m", "ext-rco-100m", "ext-32k";
>> +     };
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
