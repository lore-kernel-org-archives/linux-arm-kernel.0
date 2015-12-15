From: graeme.gregory@linaro.org (G Gregory)
Date: Tue, 15 Dec 2015 11:19:14 +0000
Subject: [Linaro-acpi] Touching the initrd before paging_init
In-Reply-To: <566DEED6.3010704@redhat.com>
References: <566D3090.9090509@redhat.com>
 <20151213165942.GN25034@bivouac.eciton.net>
 <23071B8C-D1F9-47A6-9DB4-B26842150B76@redhat.com>
 <566DEB04.2030806@redhat.com>
 <CAGCh1+nb-H-B28crGuTPUKXZrBN_XDn7fNHf4q8LZZOgyhtDmQ@mail.gmail.com>
 <566DEED6.3010704@redhat.com>
Message-ID: <CAGCh1+k8jHzMK+pLbtBgg5=VdT=+3W+OjTGJLMDGjLqLvmQXnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 December 2015 at 22:19, Jon Masters <jcm@redhat.com> wrote:
> On 12/13/2015 05:15 PM, G Gregory wrote:
>> On 13 December 2015 at 22:02, Jon Masters <jcm@redhat.com> wrote:
>>> On 12/13/2015 04:36 PM, Jon Masters wrote:
>>>
>>>> Just thinking from a parity point of view - if you can do it on x86, it should be
>>>> doable on ARM. But that GRUB module approach I quite like!
>>>
>>> Sorry for top post earlier. Was on my phone. In any case, it looks like
>>> the "acpi" command in GRUB currently does an all-or-nothing replace of
>>> all of the tables, not just a named table. We need to be able to
>>> override e.g. just an DSDT or SSDT with a replacement test one.
>>>
>> I think thats just clumsily worded documentation. The code certainly
>> looks like you can replace them individually.
>
> Yea, it does. It's unfortunate that the code is more "obvious" than the
> docs, but hardly the first time ;)
>
>> I think its trying to say in the case RSDP,XSDT,RSDT are in ROM it
>> will create new ones to point to the new tables you've just imported.
>
> Yea. I think it actually ends up creating new tables in any case, then
> copies over the bits that change. It'll actually need to do that anyway
> because it'll want to update the pointers to new tables. I'll try it.
> But I also want to see the initrd approach working in the not too
> distant future - everything someone can do on an x86 system should
> translate 1:1 in terms of experience. It'll help with bringup of newer
> platforms such as the one I have that needs some NUMA related tweaks.
>
>> I had planned to try it this week anyway.
>
> Great :)
>
> Jon.
>

Tried it, results were not great :-(

set root='hd0,gpt2'
insmod acpi
acpi /DSDT.aml
linux /Image-leg earlycon=pl011,0xe1010000 console=ttyAMA0 acpi=force root
=/dev/sda2

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.4.0-rc1-00058-g5e47260-dirty
(graeme at linaro-seattle.xora.org.uk) (gcc version 4.8.3 20140911 (Red
Hat 4.8.3-9) (GCC) ) #172 SMP PREEMPT Tue Dec 1 17:01:23 GMT 2015
[    0.000000] Boot CPU: AArch64 Processor [411fd072]
[    0.000000] earlycon: Early serial console at MMIO 0xe1010000 (options '')
[    0.000000] bootconsole [uart0] enabled
[    0.000000] Bad mode in Error handler detected, code 0xbf000000 -- SError
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
4.4.0-rc1-00058-g5e47260-dirty #172
[    0.000000] Hardware name: AMD Seattle (RevB) Development Board
(Overdrive) (DT)
[    0.000000] task: fffffe0000dc7500 ti: fffffe0000d90000 task.ti:
fffffe0000d90000
[    0.000000] PC is at setup_arch+0xfc/0x564
[    0.000000] LR is at setup_arch+0xf8/0x564
[    0.000000] pc : [<fffffe0000cb35e8>] lr : [<fffffe0000cb35e4>]
pstate: 000002c5
[    0.000000] sp : fffffe0000d93f00
[    0.000000] x29: fffffe0000d93f00 x28: 00000083f0fa22c0
[    0.000000] x27: fffffe0000081198 x26: 0000008002040000
[    0.000000] x25: 0000008002010000 x24: 0000008001000000
[    0.000000] x23: fffffe0000dc0000 x22: 00000083f0f15228
[    0.000000] x21: fffffe0000080000 x20: fffffe0000cffc00
[    0.000000] x19: fffffdfffa800000 x18: fffffe00008d0bf0
[    0.000000] x17: 000000000000000e x16: 0000000000000007
[    0.000000] x15: 0000000000000001 x14: 0ffffffffffffffe
[    0.000000] x13: 0000000000000020 x12: 0000000000000038
[    0.000000] x11: 0000000000000007 x10: 0101010101010101
[    0.000000] x9 : fffffffffffffffd x8 : 0000000000000008
[    0.000000] x7 : 0000000000000005 x6 : 0000000000000080
[    0.000000] x5 : 000000000000005f x4 : 0000000000000072
[    0.000000] x3 : 0000000000000063 x2 : 0000000000000072
[    0.000000] x1 : 0000000000000000 x0 : 0000000000000001
[    0.000000]
[    0.000000] Internal error: Oops - bad mode: 0 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
4.4.0-rc1-00058-g5e47260-dirty #172
[    0.000000] Hardware name: AMD Seattle (RevB) Development Board
(Overdrive) (DT)
[    0.000000] task: fffffe0000dc7500 ti: fffffe0000d90000 task.ti:
fffffe0000d90000
[    0.000000] PC is at setup_arch+0xfc/0x564
[    0.000000] LR is at setup_arch+0xf8/0x564
[    0.000000] pc : [<fffffe0000cb35e8>] lr : [<fffffe0000cb35e4>]
pstate: 000002c5
[    0.000000] sp : fffffe0000d93f00
[    0.000000] x29: fffffe0000d93f00 x28: 00000083f0fa22c0
[    0.000000] x27: fffffe0000081198 x26: 0000008002040000
[    0.000000] x25: 0000008002010000 x24: 0000008001000000
[    0.000000] x23: fffffe0000dc0000 x22: 00000083f0f15228
[    0.000000] x21: fffffe0000080000 x20: fffffe0000cffc00
[    0.000000] x19: fffffdfffa800000 x18: fffffe00008d0bf0
[    0.000000] x17: 000000000000000e x16: 0000000000000007
[    0.000000] x15: 0000000000000001 x14: 0ffffffffffffffe
[    0.000000] x13: 0000000000000020 x12: 0000000000000038
[    0.000000] x11: 0000000000000007 x10: 0101010101010101
[    0.000000] x9 : fffffffffffffffd x8 : 0000000000000008
[    0.000000] x7 : 0000000000000005 x6 : 0000000000000080
[    0.000000] x5 : 000000000000005f x4 : 0000000000000072
[    0.000000] x7 : 0000000000000005 x6 : 0000000000000080

                                                         [0/1977]
[    0.000000] x5 : 000000000000005f x4 : 0000000000000072
[    0.000000] x3 : 0000000000000063 x2 : 0000000000000072
[    0.000000] x1 : 0000000000000000 x0 : 0000000000000001
[    0.000000]
[    0.000000] Process swapper (pid: 0, stack limit = 0xfffffe0000d90020)
[    0.000000] Stack: (0xfffffe0000d93f00 to 0xfffffe0000d94000)
[    0.000000] 3f00: fffffe0000d93fa0 fffffe0000cb06a0
0000000000000001 fffffe0000cffc00
[    0.000000] 3f20: 000000801fe00000 00000083f0f15228
fffffe0000dc0000 0000008001000000
[    0.000000] 3f40: 0000008002010000 0000008002040000
fffffe0000081198 00000000ffffffc8
[    0.000000] 3f60: 00000083f0f155a0 fffffe0000860080
0000000000000001 000000801fe00000
[    0.000000] 3f80: ffffffffffffffff 8080808080800000
0000808080808080 fefefefefeff736d
[    0.000000] 3fa0: 0000000000000000 000000800184d000
00000083f0f155a0 0000000000000e12
[    0.000000] 3fc0: 000000801fe00000 00000083f0f15228
00000083f0f1523d 0000008001000000
[    0.000000] 3fe0: 0000000000000000 fffffe0000d00428
0000000000000000 0000000000000000
[    0.000000] Call trace:
[    0.000000] [<fffffe0000cb35e8>] setup_arch+0xfc/0x564
[    0.000000] [<fffffe0000cb06a0>] start_kernel+0xd4/0x400
[    0.000000] [<000000800184d000>] 0x800184d000
[    0.000000] Code: 91318000 94002b79 97fff3e7 d50344ff (94000760)
[    0.000000] ---[ end trace f24b6c88ae00fa9a ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task!
