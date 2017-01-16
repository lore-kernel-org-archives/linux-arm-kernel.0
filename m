From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 16 Jan 2017 16:06:48 +0100
Subject: [PATCH v4] ARM64: dts: meson-gx: Add reserved memory zone and
 usable memory range
In-Reply-To: <7fcb8d94-840a-de2c-f43b-9123ccc65514@baylibre.com>
References: <1484129414-23325-1-git-send-email-narmstrong@baylibre.com>
 <m21sw66828.fsf@baylibre.com> <d3a00788-c3c1-4b10-90bf-2a8bc6a138f8@suse.de>
 <7fcb8d94-840a-de2c-f43b-9123ccc65514@baylibre.com>
Message-ID: <14a56ed0-8b84-d617-d9cf-925f258c1d75@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Am 16.01.2017 um 11:39 schrieb Neil Armstrong:
> On 01/15/2017 03:43 PM, Andreas F?rber wrote:
>> Am 13.01.2017 um 21:03 schrieb Kevin Hilman:
>>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>>
>>>> The Amlogic Meson GXBB/GXL/GXM secure monitor uses part of the memory space,
>>>> this patch adds this reserved zone and redefines the usable memory range.
>>>>
>>>> The memory node is also moved from the dtsi files into the proper dts files
>>>> to handle variants memory sizes.
>>>>
>>>> This patch also fixes the memory sizes for the following platforms :
>>>> - gxl-s905x-p212 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
>>>> - gxm-s912-q201 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
>>>> - gxl-s905d-p231 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
>>>> - gxl-nexbox-a95x : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
>>>>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>
>>> Queued for v4.10-rc.
>>
>> What is the motivation for this change? I have a local U-Boot patch to
>> detect the amount of memory available as done downstream, but U-Boot
>> only updates the reg property that you seem to be abandoning here...
>>
>> So for devices that come in multiple RAM configurations - like R-Box Pro
>> - this would require separate .dts files now! This looks very wrong to
>> me, especially since I am not aware of other platforms doing the same.
>> Instead, there's memory reservations for top and bottom done in U-Boot
>> for reg, plus reserved-memory nodes for anything in the middle.
>>
>> Another thing to consider is that uEFI boot (bootefi) handles memory
>> reservation differently yet again, on the bootloader level. I have had
>> that working fine on Odroid-C2 and Vega S95.
>>
>> So if there's no bug this is fixing (none mentioned in commit message) I
>> strongly object to this patch.
>>
>> Regards,
>> Andreas
>>
> 
> Hi Andreas,
[snip]

Let's not copy&paste replies, see my response there.

> Handling multiple RAM configuration is another story, and the Arm-Soc and DT maintainers should give us
> their advices.

My point is, this should be thought through _before_ merging the patch,
not after.

It is the bootloader's task to deliver the correct memory _size_, with
kernel .dts having the minimum. If there's 1G and 2G models then the
linux.git .dts will have 1G, so that it can run on both, should the
bootloader fail to update it.
The consequence of your change would be that U-Boot needs to set
different $fdtfile values based on memory size, which is a plain stupid
idea for the reasons I already gave. And it has been fought by DT
maintainers in previous cases, such as FPGA configurations or
daughter-boards. Amlogic's vendor U-Boot does have the "fdt" command
available, for any user to adequately tweak a loaded .dtb for use with
mainline Linux (e.g., add linux,usable-memory there) - it can be
automated via environment variables or for lack of "source" command
maybe via "autoscr".

The reason that there are three vega-s95 .dts files never was the
differing memory reg size (which gets overridden), but rather connector
and Wifi chipset features as well as them simply having different names
and therefore different compatible strings.

Ideally I expect to be able to use one .dts for both R-Box Pro models as
well as for both Khadas Vim models - they are not marketed with
differing names, so the differences should hopefully be minor,
especially when we're using brcm,bcm4329-fmac for any chipset anyway.

> Actually there is a severe bug fixed here that cause a huge crash if such memory is not reserved while
> running stock u-boot version on various shipped products and Amlogic's own development boards.
> 
> The bug is easily triggered by running :
> # stress --vm 4 --vm-bytes 128M --timeout 10s &

First, that should've gone into the commit message please.

But this is what I get for that command line:

flag provided but not defined: -vm
Usage of stress:
  -failure regexp
    	fail only if output matches regexp
  -ignore regexp
    	ignore failure if output matches regexp
  -kill
    	kill timed out processes if true, otherwise just print pid (to
attach with gdb) (default true)
  -p N
    	run N processes in parallel (default 8)
  -timeout duration
    	timeout each process after duration (default 10m0s)

The only "stress" I found is in golang-org-x-tools package.

> [   46.937975] Bad mode in Error handler detected on CPU1, code 0xbf000000 -- SError
> ...
> [   47.058536] Internal error: Attempting to execute userspace memory: 8600000f [#3] PREEMPT SMP
> ...
> 
> Note this is a fix targeted for 4.10 to make the system stable and various users reported some severe
> crash now the system has more drivers and read-world use-cases are running on Amlogic SoCs.

I have been running "large" KVM guests on a Vega S95 Telos, with vendor
U-Boot as well as mainline U-Boot, and did not run into such a problem.

What I did run into yesterday during a large system update was multiple:

INFO: task grub2-probe:22018 blocked for more than 120 seconds.
      Not tainted 4.10.0-rc3-next-20170113+ #58
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
grub2-probe     D    0 22018  22017 0x00000000
Call trace:
[<ffffff8008085628>] __switch_to+0x90/0xa8
[<ffffff8008746238>] __schedule+0x188/0x570
[<ffffff8008746658>] schedule+0x38/0xa0
[<ffffff80081fb234>] wb_wait_for_completion+0x4c/0x80
[<ffffff80081fb2f0>] __writeback_inodes_sb_nr+0x88/0xa0
[<ffffff80081fb34c>] writeback_inodes_sb+0x2c/0x38
[<ffffff80081ff494>] sync_filesystem+0x3c/0xa8
[<ffffff8008208688>] fsync_bdev+0x20/0x70
[<ffffff80083508e8>] blkdev_ioctl+0x8b0/0x9d8
[<ffffff800820801c>] block_ioctl+0x34/0x40
[<ffffff80081e2d04>] do_vfs_ioctl+0xa4/0x748
[<ffffff80081e3434>] SyS_ioctl+0x8c/0xa0
[<ffffff8008082f30>] el0_svc_naked+0x24/0x28

I'm assuming that's an unrelated linux-next regression.

I have also been running vendor U-Boot on the R-Box Pro, without problems.

On the Odroid-C2 however the bootloader is provided on SD by the user,
so there is no excuse really for the user to use a broken bootloader.
Even if not using the mainline version for lack of MMC drivers, the
Hardkernel branch can easily be patched if necessary.

> Please feel free to push whatever changes that makes this memory reservation more coherent for 4.11,
> and respect the behavior of already shipped u-boot version and mainline U-Boot, UEFI, whatever...

Whatever the issue is, this patch is clearly wrong by design. Please
revert it ASAP!

For starters, have you tried simply adding a reserved-memory node for
0..0x01000000? v1 did not have that and instead messed with reg.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
