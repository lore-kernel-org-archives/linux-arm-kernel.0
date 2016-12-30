From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 30 Dec 2016 10:44:26 +0100
Subject: [BUG] ARM64: amlogic: gxbb: unhandled level 2 translation fault
 (11)
In-Reply-To: <c9e66a1f-a53f-9993-dd15-5e566c5f46f0@baylibre.com>
References: <20161224140028.4205-1-xypron.glpk@gmx.de>
 <478f1429-03f2-a944-8d47-3757a4d44a40@baylibre.com>
 <130a3716-a643-d14f-fd7c-9ad3bb67f3a7@gmx.de>
 <c9e66a1f-a53f-9993-dd15-5e566c5f46f0@baylibre.com>
Message-ID: <c91b83af-0eb8-c519-3428-12f34b04d725@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/30/2016 09:51 AM, Neil Armstrong wrote:
> On 12/29/2016 10:18 PM, Heinrich Schuchardt wrote:
>> On 12/29/2016 10:07 AM, Neil Armstrong wrote:
>>> On 12/24/2016 03:00 PM, Heinrich Schuchardt wrote:
>>>> When trying to run sddm on an Hardkernel Odroid C2 I invariably run into the
>>>> translation fault below.
>>>>
>>>> The following mail thread relates this kind of problem to TLB (translation
>>>> lookaside buffer) broadcasting.
>>>>
>>>> https://lkml.org/lkml/2014/4/15/207
>>>>
>>>> [ 3163.014263] sddm[1851]: unhandled level 2 translation fault (11) at 0x00000160, esr 0x82000006
>>>> [ 3163.017287] pgd = ffff80007bf86000
>>>> [ 3163.020589] [00000160] *pgd=000000007a8a3003
>>>> [ 3163.024733] , *pud=000000007be9c003
>>>> [ 3163.028095] , *pmd=0000000000000000
>>>>
>>>>
>>>> [ 3163.033026] CPU: 1 PID: 1851 Comm: sddm Not tainted 4.9.0-next-20161212-r022-arm64 #1
>>>> [ 3163.040831] Hardware name: Hardkernel ODROID-C2 (DT)
>>>> [ 3163.045698] task: ffff80007bc6d780 task.stack: ffff80007c524000
>>>> [ 3163.051563] PC is at 0x160
>>>> [ 3163.054231] LR is at 0xffff9a9fbc98
>>>> [ 3163.057686] pc : [<0000000000000160>] lr : [<0000ffff9a9fbc98>] pstate: 40000000
>>>> [ 3163.065022] sp : 0000ffffd7180130
>>>> [ 3163.068281] x29: 0000ffffd7180130 x28: 0000ffffd7180288 
>>>> [ 3163.073538] x27: 0000ffff9aa94000 x26: 0000000000000001 
>>>> [ 3163.078798] x25: 0000000000000000 x24: 0000ffffd7180410 
>>>> [ 3163.084060] x23: 000000000e0c2190 x22: 000000000e0ca5c0 
>>>> [ 3163.089322] x21: 0000ffff9ac35000 x20: 0000000000454fa9 
>>>> [ 3163.094583] x19: 0000000000454fa8 x18: 000000000e0b5938 
>>>> [ 3163.099843] x17: 0000ffff9a3f2988 x16: 0000ffff9ac36aa0 
>>>> [ 3163.105105] x15: 0000000000000000 x14: 0000000000000000 
>>>> [ 3163.110367] x13: 6d00640064007300 x12: 0800000005000000 
>>>> [ 3163.115627] x11: 0000040000000000 x10: 0000a00000000000 
>>>> [ 3163.120889] x9 : 00003fffffffffff x8 : 0000000000000000 
>>>> [ 3163.126150] x7 : 000000000e0cb520 x6 : 0000000000454fc0 
>>>> [ 3163.131412] x5 : 0000ffffd717ffd8 x4 : 000000000e0cb510 
>>>> [ 3163.136680] x3 : 0000000000000004 x2 : f2f9022b551b3900 
>>>> [ 3163.141935] x1 : 0000000000000160 x0 : 000000000e0ca5c0 
>>>>
>>>> Best regards
>>>>
>>>> Heinrich Schuchardt
>>>
>>> Hi Heinrich,
>>>
>>> I personally never had this issue even while loading huge applications loke LibreOffice and Gnome environment.
>>>
>>> I will have a look and try to reproduce this issue, can you provide us your configuration and user-space complete use case ?
>>>
>>> Neil
>>>
>>
>> Hello Neil,
>>
>> the kernel is build with
>> https://github.com/xypron/kernel-odroid-c2/tree/f8d565ff755e92fd585f5ae10123ce20abe03968
>>
>> Especially look at the patch directory and config/config-next-20161212.
>>
>> The userland is Debian Stretch with this package:
>> https://packages.debian.org/stretch/sddm
>>
>> The link
>> https://www.spinics.net/lists/arm-kernel/msg550204.html
>> that you mention in a separate mail just links to this very thread due
>> to linux-arm-kernel at lists.infradead.org being in copy.
>>
>> Best regards
>>
>> Heinrich Schuchardt
>>
> 
> Hi,
> 
> Thanks for the details, but why do you use the next-20161212 tag ? does it work with 4.10-rc1 or previous next tags ?
> 
> Neil
> 

Hi Heinrich,

I'm able to reproduce the bug using SDMM from Ubuntu running a 4.10-rc1 patched with memory zones :
[   17.988446] sddm-greeter[2366]: unhandled level 2 translation fault (11) at 0x00000000, esr 0x92000006
[   17.988451] pgd = ffff80003c3ee000
[   17.988472] [00000000] *pgd=00000000398bd003
[   17.988474] , *pud=00000000398bf003
[   17.990477] , *pmd=0000000000000000


[   17.990485] CPU: 3 PID: 2366 Comm: sddm-greeter Not tainted 4.10.0-rc1-00004-gd3f812382-dirty #488
[   17.990487] Hardware name: Amlogic Meson GXBB P200 Development Board (DT)
[   17.990489] task: ffff80003c160000 task.stack: ffff80003c314000
[   17.990493] PC is at 0xffffb2999994
[   17.990495] LR is at 0xffffb299f774
[   17.990497] pc : [<0000ffffb2999994>] lr : [<0000ffffb299f774>] pstate: 20000000
[   17.990503] sp : 0000ffffd2d1d5b0
[   17.990504] x29: 0000ffffd2d1d5b0 x28: 0000ffffad10e010
[   17.990508] x27: 0000000009c376d0 x26: 0000000000000001
[   17.990511] x25: 0000ffffb2b67000 x24: 0000ffffad10e010
[   17.990514] x23: 0000000000000000 x22: 0000000000000000
[   17.990517] x21: 0000000009c376d0 x20: 0000ffffb2fcdcb8
[   17.990520] x19: 0000ffffb2b2b000 x18: 0000000009c78450
[   17.990523] x17: 0000ffffb2b68068 x16: 0000ffffb2022158
[   17.990526] x15: 0000ffffb2fcd000 x14: 0000000000000000
[   17.990529] x13: aaaaaaaaaaaaaaab x12: 0000000000010000
[   17.990532] x11: 0000000000000008 x10: 0000000009c3b980
[   17.990535] x9 : 0000000009c38c40 x8 : 0000ffffd2d1d4e0
[   17.990538] x7 : 0000000000000000 x6 : 0000000009c3b998
[   17.990541] x5 : 0000000009c3b980 x4 : 0000800000000000
[   17.990544] x3 : 00000000fffffff0 x2 : 0000ffffad10e010
[   17.990547] x1 : 0000000009c379d8 x0 : 0000000000000000

Looking about other occurrence of such error, it seems it may be a issue from sdmm instead.

I'll continue searching,
Neil
