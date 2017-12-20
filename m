From: a.heider@gmail.com (Andre Heider)
Date: Wed, 20 Dec 2017 09:08:07 +0100
Subject: [PATCH] of: build dbts with symbols when CONFIG_OF_OVERLAY is set
In-Reply-To: <0468b711-ba39-98d8-5bbe-0246a98db863@gmail.com>
References: <20171214151240.14555-1-a.heider@gmail.com>
 <aada8c54-2c26-bf37-8782-4edc43195daf@gmail.com>
 <05291157-a1dc-db84-e453-c43945c1da07@gmail.com>
 <0468b711-ba39-98d8-5bbe-0246a98db863@gmail.com>
Message-ID: <bfbfc41c-46a3-5c19-bae8-1f87f64d564b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/17 23:10, Frank Rowand wrote:
> On 12/16/17 09:25, Andre Heider wrote:
>> Hi Frank,
>>
>> On 15/12/17 22:06, Frank Rowand wrote:
>>> On 12/14/17 07:12, Andre Heider wrote:
>>>> The overlay feature requires the base dtb to be built with symbols, so
>>>> lets build the dtbs with symbols when overlay support was explicitly
>>>> enabled.
>>>>
>>>> With CONFIG_OF_ALL_DTBS on ARCH=arm the 989 dtb files grow about ~38% on
>>>> average.
>>>>
>>>> Totals in bytes with the 3 biggest ones:
>>>>
>>>> Before:
>>>>  ????90471??? arch/arm/boot/dts/am57xx-beagle-x15-revc.dtb
>>>>  ????90521??? arch/arm/boot/dts/am57xx-beagle-x15-revb1.dtb
>>>>  ????92639??? arch/arm/boot/dts/dra7-evm.dtb
>>>>  ????25731296??? total
>>>>
>>>> After:
>>>>  ????133203??? arch/arm/boot/dts/am57xx-beagle-x15-revc.dtb
>>>>  ????133237??? arch/arm/boot/dts/am57xx-beagle-x15-revb1.dtb
>>>>  ????134545??? arch/arm/boot/dts/dra7-evm.dtb
>>>>  ????35464440??? total
>>>>
>>>> Signed-off-by: Andre Heider <a.heider@gmail.com>
>>>> ---
>>>>
>>>> Hi,
>>>>
>>>> while playing around with overlays I noticed that I needed to rebuilt
>>>> my distro's device trees because they didn't come with symbols.
>>>>
>>>> Is that for a reason, maybe the not so minor increase in size?
>>>
>>> Yes, size is the issue.
>>>
>>>
>>>>
>>>> Thanks,
>>>> Andre
>>>>
>>>>  ? drivers/of/unittest-data/Makefile | 7 -------
>>>>  ? scripts/Makefile.lib????????????? | 5 +++++
>>>>  ? 2 files changed, 5 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
>>>> index 32389acfa616..b65061013512 100644
>>>> --- a/drivers/of/unittest-data/Makefile
>>>> +++ b/drivers/of/unittest-data/Makefile
>>>> @@ -15,13 +15,6 @@ targets += overlay.dtb overlay.dtb.S
>>>>  ? targets += overlay_bad_phandle.dtb overlay_bad_phandle.dtb.S
>>>>  ? targets += overlay_bad_symbol.dtb overlay_bad_symbol.dtb.S
>>>>  ? targets += overlay_base.dtb overlay_base.dtb.S
>>>> -
>>>> -# enable creation of __symbols__ node
>>>> -DTC_FLAGS_overlay := -@
>>>> -DTC_FLAGS_overlay_bad_phandle := -@
>>>> -DTC_FLAGS_overlay_bad_symbol := -@
>>>> -DTC_FLAGS_overlay_base := -@
>>>> -
>>>>  ? endif
>>>>  ? ? .PRECIOUS: \
>>>
>>> No.? The unittests require these to be set unconditionally.
>>>
>>>
>>>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>>>> index 1ca4dcd2d500..c7ba4aa8a07a 100644
>>>> --- a/scripts/Makefile.lib
>>>> +++ b/scripts/Makefile.lib
>>>> @@ -278,6 +278,11 @@ DTC_FLAGS += -Wnode_name_chars_strict \
>>>>  ????? -Wproperty_name_chars_strict
>>>>  ? endif
>>>>  ? +ifeq ($(CONFIG_OF_OVERLAY),y)
>>>> +# enable creation of __symbols__ node
>>>> +DTC_FLAGS += -@
>>>> +endif
>>>> +
>>>>  ? DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
>>>>  ? ? # Generate an assembly file to wrap the output of the device tree compiler
>>>>
>>>
>>> Not needed.? Instead set DTC_FLAGS in the make command.? For example:
>>>
>>>  ??? DTC_FLAGS=-@ make qcom-apq8074-dragonboard.dtb
>>>
>>> There are a few architecture Makefiles that need to be fixed to not unconditionally
>>> set DTC_FLAGS.
>>
>> Rebuilding the dts files manually with symbols isn't the problem. The
>> idea was to enable it with a switch which distros simply can flip.
>>
>> Passing DTC_FLAGS to `make` would work too I guess, but on multi
>> platform builds that's still the same issue if there're boards which
>> can't handle that because of the size increase.
>>
>> Would a solution which enables symbols per family work? E.g.
>> CONFIG_MACH_SUN7I chooses to use -@ because it can handle it.
>>
>> Thanks,
>> Andre
> 
> Making it easy for distros to increase the size of .dtb files is
> not the correct answer.  We are trying to decrease the footprint
> of devicetree, not increase it.

I'm not sure I follow. If it's not acceptable to increase the size, 
why's there overlay support in the first place?

There're distros/downstreams that support overlays today, like armbian, 
beaglebone and rpi. All carrying their own patches to enable symbols [1] 
[2] [3] and I'm sure others will follow. Why can't there be some sort of 
switch for those to build their dtbs with symbols?

Regards,
Andre

[1] 
https://github.com/armbian/build/blob/master/patch/kernel/sunxi-next/add-overlay-compilation-support.patch#L98
[2] 
https://github.com/beagleboard/linux/commit/ed6b9450c2a2ec21149f14ff24770b69888abda6
[3] 
https://github.com/raspberrypi/linux/blob/rpi-4.15.y/arch/arm/boot/dts/Makefile#L1124
