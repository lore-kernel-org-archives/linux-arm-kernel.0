From: monstr@monstr.eu (Michal Simek)
Date: Fri, 2 Mar 2018 19:39:22 +0100
Subject: [PATCH v2 3/8] arm64: zynqmp: Add support for Xilinx zcu102
In-Reply-To: <20180302164803.nb45aqgqvnzxuyn5@rob-hp-laptop>
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <dd5933d6a49247de4b3b7516ed7fab55d1b3eb90.1519396753.git.michal.simek@xilinx.com>
 <20180302164803.nb45aqgqvnzxuyn5@rob-hp-laptop>
Message-ID: <f935102d-149f-cc67-e811-ab62caf4abd1@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2.3.2018 17:48, Rob Herring wrote:
> On Fri, Feb 23, 2018 at 03:40:25PM +0100, Michal Simek wrote:
>> This patch is adding revA, revB and rev1.0. There are also other
>> revisions between which should be backward compatible with previous
>> versions. Unfortunately all revs are still in use.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v2:
>> - Remove i2c mw u-boot commands
>> - Use i2c-mux instead of i2cswitch
>> - Use clock generator without numbers.
>> - Use dash in node name zcu102 rev1.0
>> - Record compatible string to xilinx.txt
>>
>>  Documentation/devicetree/bindings/arm/xilinx.txt   |   5 +
>>  arch/arm64/boot/dts/xilinx/Makefile                |   3 +
>>  .../arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts |  36 ++
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  | 550 +++++++++++++++++++++
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts  |  42 ++
>>  5 files changed, 636 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> 
> Reviewed-by: Rob Herring <robh@kernel.org> 
> 
> but...
> 
> 
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
>> new file mode 100644
>> index 000000000000..ed3cc684931f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
>> @@ -0,0 +1,42 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * dts file for Xilinx ZynqMP ZCU102 RevB
>> + *
>> + * (C) Copyright 2016 - 2018, Xilinx, Inc.
>> + *
>> + * Michal Simek <michal.simek@xilinx.com>
>> + */
>> +
>> +#include "zynqmp-zcu102-revA.dts"
>> +
>> +/ {
>> +	model = "ZynqMP ZCU102 RevB";
>> +	compatible = "xlnx,zynqmp-zcu102-revB", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
>> +};
>> +
>> +&gem3 {
>> +	phy-handle = <&phyc>;
>> +	phyc: phy at c {
>> +		reg = <0xc>;
>> +		ti,rx-internal-delay = <0x8>;
>> +		ti,tx-internal-delay = <0xa>;
>> +		ti,fifo-depth = <0x1>;
>> +	};
>> +	/* Cleanup from RevA */
>> +	/delete-node/ phy at 21;
>> +};
>> +
>> +/* Different qspi 512Mbit version */
> 
> Stray comment

will remove.

> 
>> +
>> +/* Fix collision with u61 */
>> +&i2c0 {
>> +	i2cswitch at 75 {
> 
> Missed this name.
> 
> This probably creates a new node rather than going into the existing 
> tree. If this compiles, we should fix it to not allow the same 
> unit-address twice.

hmm interesting I didn't see that before I sent this. There is a warning
but not error.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/cb7a1f14/attachment.sig>
