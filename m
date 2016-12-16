From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 16 Dec 2016 09:13:34 -0300
Subject: [PATCH] arm: dt: Initialize boot_command_line from CONFIG_CMDLINE
 in case DT does not provide /chosen/bootargs
In-Reply-To: <201612161246.12155@pali>
References: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
 <20161214235224.GH14217@n2100.armlinux.org.uk> <201612150109.20868@pali>
 <201612161246.12155@pali>
Message-ID: <029ec718-89c0-b08e-de7e-279946c1a9bd@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pali,

On 12/16/2016 08:46 AM, Pali Roh?r wrote:
> On Thursday 15 December 2016 01:09:20 Pali Roh?r wrote:
>> On Thursday 15 December 2016 00:52:24 Russell King - ARM Linux wrote:
>>> On Wed, Dec 14, 2016 at 10:12:43PM +0100, Pali Roh?r wrote:
>>>> Commit 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi
>>>> usage") broke support for setting cmdline on Nokia N900 via
>>>> CONFIG_CMDLINE.
>>>>
>>>> It is because arm code booted in DT mode parse cmdline only via
>>>> function early_init_dt_scan_chosen() and that function does not
>>>> fill variable boot_command_line when DTB does not contain /chosen
>>>> entry. It is called from function early_init_dt_scan_nodes() in
>>>> setup_machine_fdt().
>>>>
>>>> This patch fixes it by explicitly filling boot_command_line in
>>>> function setup_machine_fdt() after calling
>>>> early_init_dt_scan_nodes() in case boot_command_line still
>>>> remains empty.
>>>
>>> This looks like a hack.
>>>
>>> First, the matter of the ATAGs compatibility.  The decompressor
>>> relies on there being a pre-existing /chosen node to insert the
>>> command line and other parameters into.  If we've dropped it (by
>>> dropping skeleton.dtsi) then we've just regressed more than just
>>> N900 - the decompressor won't be able to merge the ATAGs into the
>>> concatenated FDT.
>>
>> Hm... I did not think about it. But right this can be broken too...
> 
> Tony, Javier: are you aware of above ??? problem?
> 
> It looks like commit 008a2ebcd677 ("ARM: dts: omap3: Remove 
> skeleton.dtsi usage") should be really reverted.
> 

I don't think reverting the mentioned commit is the correct fix for your
problem. We are trying to get rid of skeleton.dtsi for many reasons, see
commit commit ("3ebee5a2e141 arm64: dts: kill skeleton.dtsi").

Also, the chosen node is mentioned to be optional in the ePAPR document
and u-boot creates a chosen node if isn't found [0] so this issue is only
present in boards that don't use u-boot like the N900/N950/N9 phones.

So if NOLO doesn't do the same than u-boot and the kernel expects a chosen
node, I suggest to add an empty chosen node in the omap3-n900.dts and
omap3-n950-n9.dtsi device tree source files.

[0]: http://git.denx.de/?p=u-boot.git;a=blob;f=common/fdt_support.c;h=c9f7019e38e8de1469f506cdd57353fd27d8e134;hb=HEAD#l226

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
