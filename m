From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 6 Feb 2018 15:01:43 +0100
Subject: [PATCH 2/7] arm64: zynqmp: Add support for Xilinx zcu102
In-Reply-To: <CAL_Jsq+N-_8s0d=jD=fMD4y7e76M=tT0kt2vsH0kbOqs-eQ95w@mail.gmail.com>
References: <cover.1516366474.git.michal.simek@xilinx.com>
 <63760114db981535bf22c25be2daf0049f1b9709.1516366474.git.michal.simek@xilinx.com>
 <CAL_Jsq+N-_8s0d=jD=fMD4y7e76M=tT0kt2vsH0kbOqs-eQ95w@mail.gmail.com>
Message-ID: <e29f3553-2452-05fc-568b-17395a42bd37@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,



On 1.2.2018 17:46, Rob Herring wrote:
> On Fri, Jan 19, 2018 at 6:55 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> This patch is adding revA, revB and rev1.0. There are also other
>> revisions between which should be backward compatible with previous
>> versions. Unfortunately all revs are still in use.
> 
> Similar comments to the 1st patch. I won't repeat them here.
> 
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  arch/arm64/boot/dts/xilinx/Makefile                |   3 +
>>  .../arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts |  36 ++
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  | 556 +++++++++++++++++++++
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts  |  42 ++
>>  4 files changed, 637 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
>> index 7266a6a9c0cd..24e3ce801304 100644
>> --- a/arch/arm64/boot/dts/xilinx/Makefile
>> +++ b/arch/arm64/boot/dts/xilinx/Makefile
>> @@ -1,3 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-ep108.dtb
>>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu100-revC.dtb
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revA.dtb
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.0.dtb
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
>> new file mode 100644
>> index 000000000000..4b7477795fbd
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
>> @@ -0,0 +1,36 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * dts file for Xilinx ZynqMP ZCU102 Rev1.0
>> + *
>> + * (C) Copyright 2016 - 2018, Xilinx, Inc.
>> + *
>> + * Michal Simek <michal.simek@xilinx.com>
>> + */
>> +
>> +#include "zynqmp-zcu102-revB.dts"
>> +
>> +/ {
>> +       model = "ZynqMP ZCU102 Rev1.0";
>> +       compatible = "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
> 
> Documented?

Still waiting what exactly should be documented and where this should be
added.
I have seen that broadcom was doing this properly for arm32
(bindings/arm/bcm) but for example brcm,stingray is not documented.

I am happy to document our strings but I would like to do it just once
when I know proper location and style.

> 
>> +};
>> +
>> +&eeprom {
>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>> +
>> +       board_sn: board_sn at 0 {
> 
> Use '-' rather than '_' in node and property names.

I will change this in node name even based on spec and Table 2.1
underscore is also permitted. Maybe priorities should be reflected in
that table too.

>> +       i2cswitch at 75 { /* u60 */
>> +               compatible = "nxp,pca9544";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               reg = <0x75>;
>> +               i2c at 0 { /* i2c mw 75 0 1 */
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       reg = <0>;
>> +                       /* PS_PMBUS */
>> +                       ina226 at 40 { /* u76 */
> 
> Should be what the device does, not part numbers if possible. Standard
> names are defined in the DT spec (additions welcome).

I have suggested power-monitor name for this case. Pull request #15 for
that.

Thanks,
Michal
