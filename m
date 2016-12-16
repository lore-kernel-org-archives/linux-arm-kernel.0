From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 16 Dec 2016 09:38:34 -0300
Subject: [PATCH] arm: dt: Initialize boot_command_line from CONFIG_CMDLINE
 in case DT does not provide /chosen/bootargs
In-Reply-To: <201612161332.36406@pali>
References: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
 <201612161246.12155@pali>
 <029ec718-89c0-b08e-de7e-279946c1a9bd@osg.samsung.com>
 <201612161332.36406@pali>
Message-ID: <5c56e769-76be-295e-b655-8431dde35370@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pali,

On 12/16/2016 09:32 AM, Pali Roh?r wrote:
> Hi!
> 
> On Friday 16 December 2016 13:13:34 Javier Martinez Canillas wrote:
>> Hello Pali,
>>
>> On 12/16/2016 08:46 AM, Pali Roh?r wrote:
>>> On Thursday 15 December 2016 01:09:20 Pali Roh?r wrote:
>>>> On Thursday 15 December 2016 00:52:24 Russell King - ARM Linux
>>>> wrote:
>>>>> On Wed, Dec 14, 2016 at 10:12:43PM +0100, Pali Roh?r wrote:
>>>>>> Commit 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi
>>>>>> usage") broke support for setting cmdline on Nokia N900 via
>>>>>> CONFIG_CMDLINE.
>>>>>>
>>>>>> It is because arm code booted in DT mode parse cmdline only via
>>>>>> function early_init_dt_scan_chosen() and that function does not
>>>>>> fill variable boot_command_line when DTB does not contain
>>>>>> /chosen entry. It is called from function
>>>>>> early_init_dt_scan_nodes() in setup_machine_fdt().
>>>>>>
>>>>>> This patch fixes it by explicitly filling boot_command_line in
>>>>>> function setup_machine_fdt() after calling
>>>>>> early_init_dt_scan_nodes() in case boot_command_line still
>>>>>> remains empty.
>>>>>
>>>>> This looks like a hack.
>>>>>
>>>>> First, the matter of the ATAGs compatibility.  The decompressor
>>>>> relies on there being a pre-existing /chosen node to insert the
>>>>> command line and other parameters into.  If we've dropped it (by
>>>>> dropping skeleton.dtsi) then we've just regressed more than just
>>>>> N900 - the decompressor won't be able to merge the ATAGs into the
>>>>> concatenated FDT.
>>>>
>>>> Hm... I did not think about it. But right this can be broken
>>>> too...
>>>
>>> Tony, Javier: are you aware of above ??? problem?
>>>
>>> It looks like commit 008a2ebcd677 ("ARM: dts: omap3: Remove
>>> skeleton.dtsi usage") should be really reverted.
>>
>> I don't think reverting the mentioned commit is the correct fix for
>> your problem. We are trying to get rid of skeleton.dtsi for many
>> reasons, see commit commit ("3ebee5a2e141 arm64: dts: kill
>> skeleton.dtsi").
> 
> $ git show 3ebee5a2e141
> 
> * The default empty /chosen and /aliases are somewhat useless...
> 
> That is not truth, they are not useless as Russell King wrote -- 
> removing them break ATAG support.
> 
> (But that commit is for arm64 which probably is not using ATAGs... But I 
> do not know. At least it is not truth for 32bit arm.)
> 
>> Also, the chosen node is mentioned to be optional in the ePAPR
>> document and u-boot creates a chosen node if isn't found [0] so this
>> issue is only present in boards that don't use u-boot like the
>> N900/N950/N9 phones.
> 
> Linux arm decompressor does not propagate ATAGs when /chosen is missing. 
> Sorry, but if for Linux /chosen is required (and without it is broken!) 
> then some ePARP document does not apply there. Either Linux code needs 
> to be fixed (so /chosen will be really only optional) or /chosen stay in 
> Linux required. There is no other option.
> 
> And I hope that U-boot is not the only one bootloader which Linux kernel 
> supports. I thought that I can use *any* bootloader to boot Linux kernel 
> not just U-Boot which is doing some magic...
>
> With this step you are basically going to break booting Linux kernel 
> with all others bootloaders... And personally I really dislike this 
> idea.
> 
>> So if NOLO doesn't do the same than u-boot and the kernel expects a
>> chosen node, I suggest to add an empty chosen node in the
>> omap3-n900.dts and omap3-n950-n9.dtsi device tree source files.
> 
> That would fix a problem for N900, N950 and N9. But not for all other 
> ARM devices which bootloader pass some ATAGs.
> 
> IIRC rule of kernel is not to break compatibility and that commit 
> 008a2ebcd677 really did it.
> 
> Note: I'm not saying if 008a2ebcd677 is good or bad. I'm just saying 
> that it cause problems which need to be properly fixed. And if fixing 
> them is harder and will take more time, then correct option is to revert 
> 008a2ebcd677 due to breaking support for more devices.
> 

If you think that others boards may have the same issue, then you could
add an empty chosen node to omap3.dtsi. As I said I think that in practice
this will only be needed for the machines using NOLO but you are right
that in theory you could boot them using other bootloaders and having an
empty node doesn't cause any harm anyway.

>> [0]:
>> http://git.denx.de/?p=u-boot.git;a=blob;f=common/fdt_support.c;h=c9f
>> 7019e38e8de1469f506cdd57353fd27d8e134;hb=HEAD#l226
>>
>> Best regards,
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
