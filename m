From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Tue, 11 Apr 2017 18:40:37 +0100
Subject: [PATCH v2 1/5] dt-bindings: gpu: add bindings for the ARM Mali
 Midgard GPU
In-Reply-To: <a01a50d3-bb1b-2c56-2a15-30651fa2fac9@baylibre.com>
References: <cover.1491118230.git.guillaume.tucker@collabora.com>
 <db45d0d68957d699f13a0d92f4f84d8ebfd0270e.1491118230.git.guillaume.tucker@collabora.com>
 <a01a50d3-bb1b-2c56-2a15-30651fa2fac9@baylibre.com>
Message-ID: <936a53ee-2ed8-11e4-a860-744256676af9@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/17 09:12, Neil Armstrong wrote:
> On 04/02/2017 09:59 AM, Guillaume Tucker wrote:
>> The ARM Mali Midgard GPU family is present in a number of SoCs
>> from many different vendors such as Samsung Exynos and Rockchip.
>>
>> Import the device tree bindings documentation from the r16p0
>> release of the Mali Midgard GPU kernel driver:
>>
>>   https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/mali-midgard-gpu/TX011-SW-99002-r16p0-00rel0.tgz
>>
>> The following optional bindings have been omitted in this initial
>> version as they are only used in very specific cases:
>>
>>   * snoop_enable_smc
>>   * snoop_disable_smc
>>   * jm_config
>>   * power_model
>>   * system-coherency
>>   * ipa-model
>>
>> The example has been simplified accordingly.
>>
>> The compatible string definition has been limited to
>> "arm,mali-midgard" to avoid checkpatch.pl warnings and to match
>> what the driver actually expects (as of r16p0 out-of-tree).
>>
>> CC: John Reitan <john.reitan@arm.com>
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>> ---
>>  .../devicetree/bindings/gpu/arm,mali-midgard.txt   | 53 ++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>>
>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>> new file mode 100644
>> index 000000000000..da8fc6d21bbf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>> @@ -0,0 +1,53 @@
>> +#
>> +# (C) COPYRIGHT 2013-2016 ARM Limited.
>> +# Copyright (C) 2017 Collabora Ltd
>> +#
>> +# This program is free software and is provided to you under the terms of the
>> +# GNU General Public License version 2 as published by the Free Software
>> +# Foundation, and any use by you of this program is subject to the terms
>> +# of such GNU licence.
>> +#
> Hi Guillaume,
> This is unnecessary, please remove.

Hi Neil,

I see most other documentation files don't have such a header,
including the arm,mali-utgard.txt one.  I left it in my patch
after copying the file from the driver tarball as removing it
didn't seem right from a GPL and copyright point of view.  If
it's safe in practice to remove it then fine.

>> +
>> +
>> +ARM Mali Midgard GPU
>> +====================
>> +
>> +Required properties:
>> +
>> +- compatible : Should be "arm,mali-midgard".
>> +- reg : Physical base address of the device and length of the register area.
>> +- interrupts : Contains the three IRQ lines required by Mali Midgard devices.
>> +- interrupt-names : Contains the names of IRQ resources in the order they were
>> +  provided in the interrupts property. Must contain: "JOB, "MMU", "GPU".
>
>
> Please follow the bindings introduced for the utgard family :
> https://patchwork.kernel.org/patch/9553745/
>
> - an entry for each mali-midgard revision, i.e. "arm,mali-t820"

Sure.  It's a bit more complicated with Midgard (more variants,
some have the number of cores in the last digit...) but it should
be possible to put together a suitable list in v3.

> - an entry for each vendor specific wrapping if necessary, i.e. "amlogic,meson-gxm-mali"

Well, fine although I'm a bit confused about this - please see
below.

> - low-case for interrupt names

OK, can change that in v3.  It means however that the out-of-tree
driver will need to be patched as it's looking for these names in
capital letters.  This shouldn't be a big issue but adds a bit of
work to anyone maintaining a kernel driver package.

>> +
>> +Optional:
>> +
>> +- clocks : Phandle to clock for the Mali Midgard device.
>> +- clock-names : Shall be "clk_mali".
>> +- mali-supply : Phandle to regulator for the Mali device. Refer to
>> +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
>> +- operating-points : Refer to Documentation/devicetree/bindings/power/opp.txt
>> +  for details.
>
> Please add :
>    * Must be one of the following:
>       "arm,mali-t820"
>    * And, optionally, one of the vendor specific compatible:
>       "amlogic,meson-gxm-mali"
>
> with my Ack for the amlogic platform.

It seems to me that as long as the GPU architecture hasn't been
modified (I don't think I've ever encountered such a case) then
it has to be a standard ARM Mali type regardless of the SoC
vendor.  So unless a Mali-T820 in the Amlogic S912 SoC is not the
same as a T820 in a different SoC, please forgive me but I don't
understand why a vendor compatible string is needed.  My main
concern is that it's going to be very hard to keep that list
up-to-date with all existing Midgard SoC variants.  If do we need
to add vendor compatible strings to correctly describe the
hardware then I'm happy to add the amlogic one in my patch v3; I
would just like to understand why that's necessary.


Thanks,
Guillaume
