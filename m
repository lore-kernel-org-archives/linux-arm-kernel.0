From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 19 Jun 2018 15:50:10 -0700
Subject: [PATCH 0/2] Make badr macro compatible with newer GAS versions
In-Reply-To: <CAKv+Gu_zsSxb_8Ej-6QwZOW2X5VfgW0gnjpnHpi62L6nPALoHQ@mail.gmail.com>
References: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
 <20180619203223.GA28370@roeck-us.net>
 <CAKv+Gu-RHM7HAmzWw9Ge+w21kWxKxLbJT7DD5huv-7WWOPUVWA@mail.gmail.com>
 <20180619204531.GB28370@roeck-us.net>
 <CAKv+Gu_zsSxb_8Ej-6QwZOW2X5VfgW0gnjpnHpi62L6nPALoHQ@mail.gmail.com>
Message-ID: <20180619225010.GA740@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 12:23:56AM +0200, Ard Biesheuvel wrote:
> 
> OK, so even the linker handling is inconsistent.
> 
> Working (binutils 2.30)
> 
> c0301164 <local_restart>:
> c0301164:       f8d9 a000       ldr.w   sl, [r9]
> c0301168:       e92d 0030       stmdb   sp!, {r4, r5}
> c030116c:       f01a 0ff0       tst.w   sl, #240        ; 0xf0
> c0301170:       d117            bne.n   c03011a2 <__sys_trace>
> c0301172:       46ba            mov     sl, r7
> c0301174:       f5ba 7fc8       cmp.w   sl, #400        ; 0x190
> c0301178:       bf28            it      cs
> c030117a:       f04f 0a00       movcs.w sl, #0
> c030117e:       f3af 8014       csdb
> c0301182:       f2af 1e83       subw    lr, pc, #387    ; 0x183
>                         c0301182: R_ARM_THM_ALU_PREL_11_0       .Lsym28
> 
> 
> Broken (binutils 2.26)
> 
> c0301184 <local_restart>:
> c0301184:       f8d9 a000       ldr.w   sl, [r9]
> c0301188:       e92d 0030       stmdb   sp!, {r4, r5}
> c030118c:       f01a 0ff0       tst.w   sl, #240        ; 0xf0
> c0301190:       d117            bne.n   c03011c2 <__sys_trace>
> c0301192:       46ba            mov     sl, r7
> c0301194:       f5ba 7fc8       cmp.w   sl, #400        ; 0x190
> c0301198:       bf28            it      cs
> c030119a:       f04f 0a00       movcs.w sl, #0
> c030119e:       f3af 8014       csdb
> c03011a2:       f2af 1ea2       subw    lr, pc, #418    ; 0x1a2
>                         c03011a2: R_ARM_THM_ALU_PREL_11_0       .Lsym30
> 
> 
> Note the even immediate in the subw instruction. So this is another
> dead end, unfortunately.
> 
Looks like someone is trying to make things really difficunt :-(.
I think I'll just stick with binutils 2.28.1. Not optimal, but
at least it works.

Something else: I can boot Cortex-M under qemu (-M mps2-an385). The only problem
I have is this:

/ # kill -1 1
[    3.806568] 
[    3.806568] Unhandled exception: IPSR = 00000006 LR = fffffffd
[    3.807221] CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00043-gba4dbdedd3ed #42
[    3.807590] Hardware name: MPS2 (Device Tree Support)
[    3.808162] PC is at   (null)
[    3.808374] LR is at 0x2170fc37
[    3.808549] pc : [<00000000>]    lr : [<2170fc37>]    psr: 60000000
[    3.808841] sp : 21761b90  ip : 21761f00  fp : 21758c04
[    3.809118] r10: 00000000  r9 : 00000000  r8 : 00000000
[    3.809329] r7 : 00000000  r6 : 00000001  r5 : 00000000  r4 : 2175452c
[    3.809565] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000001
[    3.809791] xPSR: 60000000
[    3.809926] CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00043-gba4dbdedd3ed #42
[    3.810179] Hardware name: MPS2 (Device Tree Support)
[    3.811246] [<2100bd8d>] (unwind_backtrace) from [<2100b13b>] (show_stack+0xb/0xc)
[    3.811656] [<2100b13b>] (show_stack) from [<2100b87b>] (__invalid_entry+0x4b/0x4c)

Everything else seems to work, just sending a signal to init causes it
to blow up. Any idea what might cause this ?

Thanks,
Guenter
