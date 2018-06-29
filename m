From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 29 Jun 2018 14:50:09 -0700
Subject: [RfC v1 4/5] ARM64: dts: meson-gxl: add support for the S905W SoC
 and the P281 board - WiP
In-Reply-To: <fb3bfe0c-2cfc-5e92-5271-e2159f20b019@baylibre.com> (Neil
 Armstrong's message of "Mon, 25 Jun 2018 14:51:54 +0200")
References: <20180624182814.31691-1-martin.blumenstingl@googlemail.com>
 <20180624182814.31691-5-martin.blumenstingl@googlemail.com>
 <fb3bfe0c-2cfc-5e92-5271-e2159f20b019@baylibre.com>
Message-ID: <7hpo09clf2.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 24/06/2018 20:28, Martin Blumenstingl wrote:
>> S905W is a new SoC from the GXL series. It is a cost-reduced version of
>> the S905X.
>> The P281 development board from Amlogic uses the same layout as the P231
>> (S905D development board). Thus the new P281 board inherits
>> meson-gx-p23x-q20x.dtsi to avoid code-duplication.
>> 
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>>  .../boot/dts/amlogic/meson-gxl-s905w-p281.dts | 22 +++++++++++++++++++
>>  .../boot/dts/amlogic/meson-gxl-s905w.dtsi     | 20 +++++++++++++++++
>>  3 files changed, 43 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dts
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905w.dtsi
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index 34dd0e9b5cbb..6de2e7f5a9cc 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -17,6 +17,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-khadas-vim2.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
>
> [...]
>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w.dtsi
>> new file mode 100644
>> index 000000000000..a4ed586d328b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w.dtsi
>> @@ -0,0 +1,20 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2018 Martin Blumenstingl <martin.blumenstingl@googlemail.com>.
>> + * Based on meson-gxl-s905x.dtsi:
>> + * - Copyright (c) 2016 Endless Computers, Inc.
>> + *   Author: Carlo Caione <carlo@endlessm.com>
>> + */
>> +
>> +#include "meson-gxl.dtsi"
>> +#include "meson-gxl-mali.dtsi"
>> +
>> +/ {
>> +	compatible = "amlogic,s905w", "amlogic,meson-gxl";
>> +};
>> +
>> +/* S905W only has access to it's internal PHY */
>> +&ethmac {
>> +	phy-mode = "rmii";
>> +	phy-handle = <&internal_phy>;
>> +};
>> 
>
> Hi Martin, Kevin, Carlo, Jerome,
>
> I would like to discuss how we should handle all the GXl variants,
> since from linux PoV, S905x, S905W and S805X are the same (S905W and
> S805X only has ledd IO balls, less IO available but same pinctrl
> interface).
>
> At some point, meson-gxl-s905w.dtsi and meson-gxl-s805x.dtsi will be exactly the same as meson-gxl-s905x.dtsi, and maybe the same for S905Z in the Fire TV.
>
> The can be multiple solution :
> - duplicate the files
> - unify all the internal-PHY-only GXL variant into a meson-gxl-sx05x.dtsi
> - use meson-gxl-s905x.dtsi and override the compatible in board dts
> - move the meson-gxl-s905x.dtsi into a separate meson-gxl-internal-phy.dtsi and include it instead of meson-gxl-s905x.dtsi and drop the intermediate package specific dtsi

I vote for unifying, but I think renaming is messy unncessary.

I'd rather just see reuse of the existing s905x .dtsi for any s905w or
s805x boards.  We can add compatibles to s905x.dtsi if we really need
to, but for now I don't even thing that's necessary.

IOW, for this patch, drop the new s905w dtsi, and just have the board
.dts include the s905x.dtsi.

Kevin
