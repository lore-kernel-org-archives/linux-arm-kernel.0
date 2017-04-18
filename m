From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Tue, 18 Apr 2017 10:15:08 +0100
Subject: [PATCH v2 1/5] dt-bindings: gpu: add bindings for the ARM Mali
 Midgard GPU
In-Reply-To: <20170404020056.d7osj7rmog22xbjd@rob-hp-laptop>
References: <cover.1491118230.git.guillaume.tucker@collabora.com>
 <db45d0d68957d699f13a0d92f4f84d8ebfd0270e.1491118230.git.guillaume.tucker@collabora.com>
 <20170404020056.d7osj7rmog22xbjd@rob-hp-laptop>
Message-ID: <b8cf7acd-83e9-49fb-0800-19a76b8dcce5@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 04/04/17 03:00, Rob Herring wrote:
> On Sun, Apr 02, 2017 at 08:59:44AM +0100, Guillaume Tucker wrote:
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
>> +
>> +
>> +ARM Mali Midgard GPU
>> +====================
>> +
>> +Required properties:
>> +
>> +- compatible : Should be "arm,mali-midgard".
>
> As Neil said...

Sure; as discussed in my previous emails.

>> +- reg : Physical base address of the device and length of the register area.
>> +- interrupts : Contains the three IRQ lines required by Mali Midgard devices.
>> +- interrupt-names : Contains the names of IRQ resources in the order they were
>> +  provided in the interrupts property. Must contain: "JOB, "MMU", "GPU".
>> +
>> +Optional:
>> +
>> +- clocks : Phandle to clock for the Mali Midgard device.
>> +- clock-names : Shall be "clk_mali".
>
> "clk_" is redundant. Actually, if there is only 1 clock, then just drop
> names. But there's not at least a core and bus clock?

Only one clock needs to be provided with the Midgard GPU
architecture.  It shares the same bus and system memory as the
CPU.  So I'll remove clock-names in patch v3.

>> +- mali-supply : Phandle to regulator for the Mali device. Refer to
>> +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
>> +- operating-points : Refer to Documentation/devicetree/bindings/power/opp.txt
>> +  for details.
>
> Is this going to be sufficient vs. operating-points-v2? Or should it be
> a power domain with OPPs?

In principle, switching to operating-points-v2 should be very
straightforward.  I have smoke-tested the driver with an
operating-points-v2 table and a phandle to it inside the gpu node
in place of operating-points and it seems to be working fine.  At
least it parsed the OPPs and got initialised correctly.

My understanding is that operating-points (v1) are not deprecated
so we could keep the bindings as-is, but please let me know
otherwise and I can try to address that in my next patch version.
In the documentation, it should only be the case of replacing
operating-points with operating-points-v2.

>> +
>> +Example for a Mali-T602:
>> +
>> +gpu at 0xfc010000 {
>
> Drop the '0x'.

OK, I'm also updating the example with lower-case IRQ names, no
clock-names etc...

Thanks,
Guillaume
