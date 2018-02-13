From: labbott@redhat.com (Laura Abbott)
Date: Tue, 13 Feb 2018 10:32:21 -0800
Subject: [RFC/RFT PATCH 0/2] arm64: per-task stack canaries
In-Reply-To: <CAKv+Gu9Xk852y8q7RZ_gsa28PCT+564fFWJA276S2EB6=JjSiQ@mail.gmail.com>
References: <20180123130302.29409-1-ard.biesheuvel@linaro.org>
 <4f8b8b42-7b95-a396-659f-0563030f5963@redhat.com>
 <CAKv+Gu9Xk852y8q7RZ_gsa28PCT+564fFWJA276S2EB6=JjSiQ@mail.gmail.com>
Message-ID: <821a989e-1d68-972f-e692-fd43259236a5@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2018 02:49 AM, Ard Biesheuvel wrote:
> On 9 February 2018 at 20:20, Laura Abbott <labbott@redhat.com> wrote:
>> On 01/23/2018 05:03 AM, Ard Biesheuvel wrote:
>>>
>>> This is a proof of concept implementation of per-task stack canaries for
>>> arm64. The purpose is to reach agreement between the arm64 kernel and GCC
>>> maintainers on how to implement support for this in the compiler.
>>>
>>> What these patches show is that we can support per-task stack canaries
>>> on arm64 using only very minor changes on the kernel side, i.e., all
>>> that is needed is exposing the offset of stack_canary in task_struct
>>> via an ELF symbol. With that in place, the compiler needs to emit the
>>> following sequence when -fstack-protector-guard=tls is enabled
>>>
>>>     movz    xN, :abs_g0:__stack_chk_guard_offset
>>>     msr     xM, sp_el0
>>>     ldr     xM, [xM, xN]
>>>
>>> Note that this does not involve per-CPU variables, and so there are no
>>> concurrency issues to be addressed. sp_el0 is the current task pointer,
>>> whose value never changes from the POV of the task, even when migrating
>>> to another CPU.
>>>
>>> Patch #1 implements a GCC plugin that patches the sequence
>>>
>>>     adrp    xN, __stack_chk_guard
>>>     add     xN, Xn, :lo12:__stack_chk_guard
>>>
>>> into
>>>
>>>     mrs     xN, sp_el0
>>>     add     xN, xN, :lo12:__stack_chk_guard_offset
>>>
>>> which is a poor man's version of the movz/msr/ldr sequence above (and only
>>> works for small model code), but is sufficient as a proof of concept.
>>>
>>> Patch #2 exposes the __stack_chk_guard_offset symbol and wires up the
>>> plugin
>>> (if enabled in Kconfig)
>>>
>>> Again, the point is not to use GCC plugin based hacks, but to reach
>>> agreement
>>> on how to proceed with this for GCC.
>>>
>>> Comments welcome.
>>>
>>
>> I was seeing some crashes with these when I tried to boot up on my
>> full Fedora system. It looked like a compiler bug with grabbing
>> the wrong literal but I don't think it's worth looking at it since
>> it's probably just something with the plugin which isn't the real
>> focus here. I can send along the crash if you are interested.
>>
> 
> Yes please. Did it crash in a modules? Did you build with
> KASLR/erratum 843419 disabled?
> 

Turning off erratum 843419 makes it work. The crashes were in
modules:

[    5.105030] Internal error: Accessing user space memory outside uaccess.hP
[    5.115500] Modules linked in: sdhci_of_arasan(+) sdhci_pltfm i2s
[    5.127261] CPU: 5 PID: 336 Comm: systemd-udevd Not tainted 4.15.0-canary+ #6
[    5.135909] Hardware name: AppliedMicro X-Gene Mustang Board/X-Gene M6
[    5.146981] pstate: 20400005 (nzCv daif +PAN -UAO)
[    5.153130] pc : sdhci_arasan_probe+0x30/0x638 [sdhci_of_ara]
[    5.160482] lr : platform_drv_probe+0x60/0xc0
[    5.166190] sp : ffff00000c17b970
[    5.170866] x29: ffff00000c17b970 x28: ffff000008ae48a8
[    5.177530] x27: ffff000000b5f298 x26: ffff000000b5f108
[    5.184194] x25: ffff000000b5f280 x24: ffff8003fffe6ea8
[    5.190857] x23: ffff000000b5f028 x22: 0000000000000000
[    5.197002] x21: 0000000000000590 x20: ffff8003ec98e010
[    5.202288] x19: ffff8003ec98e000 x18: 0000000000000001
[    5.207573] x17: 0000000000000004 x16: 0000000000000000
[    5.212859] x15: ffffffffffffffff x14: ffff8003e3e85f90
[    5.218145] x13: ffff8003937afb0a x12: 0000000000000030
[    5.223430] x11: 0000000000000003 x10: 0101010101010101
[    5.228716] x9 : fffffffffffffffa x8 : 7f7f7f7f7f7f7f7f
[    5.234000] x7 : fefefeff646c606d x6 : 1e0e1a00f2ade4ef
[    5.239286] x5 : 6f642d72001a0e1e x4 : 8080808000000000
[    5.244572] x3 : 837bbb2b916b2378 x2 : 82962d9749f72000
[    5.249856] x1 : ffff000000b5e850 x0 : ffff000008726598
[    5.255142] Process systemd-udevd (pid: 336, stack limit = 0x00000000d88c80b)
[    5.262329] Call trace:
[    5.264765]  sdhci_arasan_probe+0x30/0x638 [sdhci_of_arasan]
[    5.270395]  platform_drv_probe+0x60/0xc0
[    5.274384]  driver_probe_device+0x2a0/0x468
[    5.278632]  __driver_attach+0x124/0x128
[    5.282534]  bus_for_each_dev+0x84/0xd8
[    5.286349]  driver_attach+0x30/0x40
[    5.289906]  bus_add_driver+0x26c/0x298
[    5.293721]  driver_register+0x6c/0x110
[    5.297537]  __platform_driver_register+0x54/0x60
[    5.302218]  sdhci_arasan_driver_init+0x1c/0x1000 [sdhci_of_arasan]
[    5.308455]  do_one_initcall+0x58/0x160
[    5.312271]  do_init_module+0x60/0x1f0
[    5.316001]  load_module+0x13fc/0x1728
[    5.319730]  SyS_finit_module+0xfc/0x118
[    5.323632]  __sys_trace_return+0x0/0x4
[    5.327449] Code: d503201f 58002ae1 58002a55 f9413e78 (f94002a0)
[    5.333513] ---[ end trace aabd65049cbf2f2e ]---

0000000000000840 <sdhci_arasan_probe>:
  840:   a9b67bfd        stp     x29, x30, [sp, #-160]!
  844:   910003fd        mov     x29, sp
  848:   a90153f3        stp     x19, x20, [sp, #16]
  84c:   f90013f5        str     x21, [sp, #32]
  850:   a90363f7        stp     x23, x24, [sp, #48]
  854:   f90023f9        str     x25, [sp, #64]
  858:   aa0003f3        mov     x19, x0
  85c:   aa1e03e0        mov     x0, x30
  860:   94000000        bl      0 <_mcount>
  864:   58002ae1        ldr     x1, dc0 <sdhci_arasan_probe+0x580>
  868:   58002a55        ldr     x21, db0 <sdhci_arasan_probe+0x570> <---- This looks like garbage
  86c:   f9413e78        ldr     x24, [x19, #632]
  870:   f94002a0        ldr     x0, [x21]

There was another crash in xfs:

[    6.273348] Internal error: Accessing user space memory outside uaccess.h roP
[    6.282530] Modules linked in: xfs libcrc32c sdhci_of_arasan(+) sdhci_pltfm s
[    6.294138] CPU: 1 PID: 467 Comm: mount Tainted: G      D          4.15.0-ca6
[    6.302016] Hardware name: AppliedMicro X-Gene Mustang Board/X-Gene Mustang 6
[    6.311710] pstate: 40400005 (nZcv daif +PAN -UAO)
[    6.316666] pc : xfs_parseargs+0x2c/0x668 [xfs]
[    6.321330] lr : xfs_fs_fill_super+0x120/0x550 [xfs]
[    6.326269] sp : ffff00000c82bba0
[    6.329566] x29: ffff00000c82bba0 x28: ffff800393869e00
[    6.334852] x27: ffff000008ad1000 x26: 0000000fffffffe0
[    6.340138] x25: 0000000000000590 x24: 0000000000000000
[    6.345424] x23: ffff000000c5df68 x22: ffff00000819cef8
[    6.350709] x21: ffff8003929b1000 x20: ffff800393431000
[    6.355995] x19: ffff8003929b1000 x18: 0000000000000009
[    6.361280] x17: 0000000000000000 x16: 0000000000000000
[    6.366566] x15: ffffffffffffffff x14: ffffffffff000000
[    6.371851] x13: ffffffffffffffff x12: 0000000000000018
[    6.377136] x11: 0101010101010101 x10: ffff00000c82bcb0
[    6.382421] x9 : 0000000000000000 x8 : ffff800393432000
[    6.387706] x7 : 0000000000000000 x6 : ffff000000bdfaf8
[    6.392992] x5 : ffff000000be0670 x4 : 0000000000000000
[    6.398277] x3 : 0000000000000000 x2 : 00000000000000c0
[    6.403562] x1 : 0000000000000000 x0 : ffff000000bf71f8
[    6.408850] Process mount (pid: 467, stack limit = 0x00000000cda0c16d)
[    6.415344] Call trace:
[    6.417933]  xfs_parseargs+0x2c/0x668 [xfs]
[    6.422256]  xfs_fs_fill_super+0x120/0x550 [xfs]
[    6.426854]  mount_bdev+0x1a0/0x1d0
[    6.430477]  xfs_fs_mount+0x40/0x58 [xfs]
[    6.434468]  mount_fs+0x5c/0x190
[    6.437680]  vfs_kern_mount.part.9+0x54/0x178
[    6.442014]  do_mount+0x1f8/0xc68
[    6.445312]  SyS_mount+0xfc/0x118
[    6.448612]  __sys_trace_return+0x0/0x4
[    6.452431] Code: d503201f 58002ed9 52801802 f9400293 (f9400320)
[    6.458496] ---[ end trace aabd65049cbf2f2f ]---

0000000000088a00 <xfs_parseargs>:
    88a00:       a9b47bfd        stp     x29, x30, [sp, #-192]!
    88a04:       910003fd        mov     x29, sp
    88a08:       a90153f3        stp     x19, x20, [sp, #16]
    88a0c:       f90023f9        str     x25, [sp, #64]
    88a10:       aa0003f4        mov     x20, x0
    88a14:       aa1e03e0        mov     x0, x30
    88a18:       f90037e1        str     x1, [sp, #104]
    88a1c:       94000000        bl      0 <_mcount>
    88a20:       58002ed9        ldr     x25, 88ff8 <xfs_parseargs+0x5f8> <---- also looks bogus
    88a24:       52801802        mov     w2, #0xc0                       // #192
    88a28:       f9400293        ldr     x19, [x20]
    88a2c:       f9400320        ldr     x0, [x25]
...
    88fec:       a90363f7        stp     x23, x24, [sp, #48]
    88ff0:       a904effa        stp     x26, x27, [sp, #72]
    88ff4:       94000000        bl      0 <__stack_chk_fail>
         ...


> 
>> It looked good to me otherwise.
>>
> 
> Thanks. I intend to try and restart the discussion on this topic this week.
> 
>>
>>> Ard Biesheuvel (2):
>>>     gcc-plugins: add support plugin for arm64 per-task stack canaries
>>>     arm64: kernel: use a unique stack canary value for each task
>>>
>>>    arch/Kconfig                                    |   4 +
>>>    arch/arm64/Kconfig                              |   7 ++
>>>    arch/arm64/include/asm/stackprotector.h         |   4 +-
>>>    arch/arm64/kernel/asm-offsets.c                 |   3 +
>>>    arch/arm64/kernel/process.c                     |   4 +
>>>    arch/arm64/kernel/vmlinux.lds.S                 |   8 ++
>>>    scripts/Makefile.gcc-plugins                    |   2 +
>>>    scripts/gcc-plugins/arm64_ssp_per_task_plugin.c | 121
>>> ++++++++++++++++++++
>>>    8 files changed, 152 insertions(+), 1 deletion(-)
>>>    create mode 100644 scripts/gcc-plugins/arm64_ssp_per_task_plugin.c
>>>
>>
