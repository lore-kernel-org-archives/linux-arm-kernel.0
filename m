From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 19 Apr 2016 13:58:06 +0800
Subject: [PATCH v2 1/3] arm64: mm: make pr_cont() per line in Virtual
 kernel memory layout
In-Reply-To: <5714DD6B.6050108@arm.com>
References: <1460533772-13314-1-git-send-email-wangkefeng.wang@huawei.com>
 <1460948988-7477-1-git-send-email-wangkefeng.wang@huawei.com>
 <1460948988-7477-2-git-send-email-wangkefeng.wang@huawei.com>
 <5714C1F1.6000504@arm.com>
 <CAKv+Gu-bOjOYRWVV7NfSfOJy9AtdKNmgrARdRHTT=HsGWVKoYA@mail.gmail.com>
 <5714DD6B.6050108@arm.com>
Message-ID: <5715C8EE.1080206@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/4/18 21:13, James Morse wrote:
> Hi Ard,
> 
> On 18/04/16 12:21, Ard Biesheuvel wrote:
>> On 18 April 2016 at 13:16, James Morse <james.morse@arm.com> wrote:
>>> On 18/04/16 04:09, Kefeng Wang wrote:
>>>> Each line with single pr_cont() in Virtual kernel memory layout,
>>>> or the dump of the kernel memory layout in dmesg is not aligned
>>>> when PRINTK_TIME enabled, due to the missing time stamps.
>>>
>>> Looks good to me, but I can't reproduce the miss-aligned output on v4.6-rc4, I get:
>>>> [    0.000000] .text : 0xffffff8008080000 - 0xffffff8008887000   (  8220 KB)
>>>> [    0.000000] .rodata : 0xffffff8008887000 - 0xffffff8008bdc000 (  3412 KB)
>>>> [    0.000000] .init : 0xffffff8008bdc000 - 0xffffff8008cc3000   (   924 KB)
>>>> [    0.000000] .data : 0xffffff8008cc3000 - 0xffffff8008dd7200   (  1105 KB)
>>>
>>> without this patch, but it evidently happens for you. Do you have any special
>>> build options or kernel version? I'd like to understand if there is some
>>> kconfig/earlycon option that affects this!
>>>
>>
>> Interestingly, for me it only occurs when running dmesg, and not when
>> observing the output from the console directly.
> 
> Hmmm, after some more digging: dmesg on Ubuntu 15.04 miss-aligns this, but
> Ubuntu 14.04 doesn't....
> 
> Regardless, the patch fixes it, (and it looks the same on both ubuntu versions):
> Tested-by: James Morse <james.morse@arm.com>
> 

Thanks :)

> 
>>From the comment above 'pr_cont()' in include/linux/printk.h:
>> * Like KERN_CONT, pr_cont() should only be used when continuing
>> * a line with no newline ('\n') enclosed. Otherwise it defaults
>> * back to KERN_DEFAULT.
> 
> arm64 is probably confusing dmesg with its use of pr_cont("...\n").

After check the util-linux, find this commit(b45c3da2e1581 tags/v2.26-rc2~86)

commit b45c3da2e15814ca0c5b2ed2608de34df60af4da
Author: Ingo Br<C3><BC>ckl <ib@wupperonline.de>
Date:   Wed Jan 14 19:36:55 2015 +0100

    dmesg: Enable proper indent for messages containing line breaks

    Messages containing line breaks somehow look broken when additional time,
    facility or level information is displayed, because they partly appear in
    time/facility/level column.

    Indent them accordingly.

    Signed-off-by: Karel Zak <kzak@redhat.com>

After with this patch, the dmesg shows below,

[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffffff8000000000 - 0xffffff8008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffffff8008000000 - 0xffffffbdbfff0000   (   246 GB)
[    0.000000]       .text : 0xffffff8008080000 - 0xffffff8008755000   (  6996 KB)
                   .rodata : 0xffffff8008755000 - 0xffffff8008a3d000   (  2976 KB)
                     .init : 0xffffff8008a3d000 - 0xffffff8008b09000   (   816 KB)
                     .data : 0xffffff8008b09000 - 0xffffff8008ba6800   (   630 KB)
[    0.000000]     vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
                             0xffffffbdc0000000 - 0xffffffbdc8000000   (   128 MB actual)
[    0.000000]     fixed   : 0xffffffbffe7fd000 - 0xffffffbffec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffffffbffee00000 - 0xffffffbfffe00000   (    16 MB)
[    0.000000]     memory  : 0xffffffc000000000 - 0xffffffc200000000   (  8192 MB)


BRs,
Kefeng

> 
> 
> Thanks,
> 
> James
> 
> 
> 15.04: util-linux 2.25.2-4ubuntu3
> 14.04: util-linux 2.20.1-5.1ubuntu20
> 
> .
> 
