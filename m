From: liuwenliang@huawei.com (Liuwenliang (Lamb))
Date: Tue, 17 Oct 2017 11:27:19 +0000
Subject: [PATCH 04/11] Define the virtual space of KASan's shadow region
In-Reply-To: <CAKv+Gu98M9PZk3qm0PYC8nQ3zMvLZmNmOn4=hNdFE7NTBuHbgg@mail.gmail.com>
References: <20171011082227.20546-5-liuwenliang@huawei.com>
 <201710141957.mbxeZJHB%fengguang.wu@intel.com>
 <B8AC3E80E903784988AB3003E3E97330C005B9BF@dggemm510-mbx.china.huawei.com>
 <CAKv+Gu98M9PZk3qm0PYC8nQ3zMvLZmNmOn4=hNdFE7NTBuHbgg@mail.gmail.com>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C005CAC2@dggemm510-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2017 12:40 AM, Abbott Liu wrote:
> Ard Biesheuvel [ard.biesheuvel at linaro.org] wrote
>This is unnecessary:
>
>ldr r1, =TASK_SIZE
>
>will be converted to a mov instruction by the assembler if the value of TASK_SIZE fits its 12-bit immediate field.
>
>So please remove the whole #ifdef, and just use ldr r1, =xxx

Thanks for your review. 

The assembler on my computer don't convert ldr r1,=xxx into mov instruction. Here is the objdump for vmlinux:

c0a3b100 <__irq_svc>:
c0a3b100:       e24dd04c        sub     sp, sp, #76     ; 0x4c
c0a3b104:       e31d0004        tst     sp, #4
c0a3b108:       024dd004        subeq   sp, sp, #4
c0a3b10c:       e88d1ffe        stm     sp, {r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip}
c0a3b110:       e8900038        ldm     r0, {r3, r4, r5}
c0a3b114:       e28d7030        add     r7, sp, #48     ; 0x30
c0a3b118:       e3e06000        mvn     r6, #0
c0a3b11c:       e28d204c        add     r2, sp, #76     ; 0x4c
c0a3b120:       02822004        addeq   r2, r2, #4
c0a3b124:       e52d3004        push    {r3}            ; (str r3, [sp, #-4]!)
c0a3b128:       e1a0300e        mov     r3, lr
c0a3b12c:       e887007c        stm     r7, {r2, r3, r4, r5, r6}
c0a3b130:       e1a0972d        lsr     r9, sp, #14
c0a3b134:       e1a09709        lsl     r9, r9, #14
c0a3b138:       e5990008        ldr     r0, [r9, #8]
---c0a3b13c:       e59f1054        ldr     r1, [pc, #84]   ; c0a3b198 <__irq_svc+0x98>  //ldr r1, =TASK_SIZE
c0a3b140:       e5891008        str     r1, [r9, #8]
c0a3b144:       e58d004c        str     r0, [sp, #76]   ; 0x4c
c0a3b148:       ee130f10        mrc     15, 0, r0, cr3, cr0, {0}
c0a3b14c:       e58d0048        str     r0, [sp, #72]   ; 0x48
c0a3b150:       e3a00051        mov     r0, #81 ; 0x51
c0a3b154:       ee030f10        mcr     15, 0, r0, cr3, cr0, {0}
---c0a3b158:       e59f103c        ldr     r1, [pc, #60]   ; c0a3b19c <__irq_svc+0x9c>  //orginal irq_svc also used same instruction
c0a3b15c:       e1a0000d        mov     r0, sp
c0a3b160:       e28fe000        add     lr, pc, #0
c0a3b164:       e591f000        ldr     pc, [r1]
c0a3b168:       e5998004        ldr     r8, [r9, #4]
c0a3b16c:       e5990000        ldr     r0, [r9]
c0a3b170:       e3380000        teq     r8, #0
c0a3b174:       13a00000        movne   r0, #0
c0a3b178:       e3100002        tst     r0, #2
c0a3b17c:       1b000007        blne    c0a3b1a0 <svc_preempt>
c0a3b180:       e59d104c        ldr     r1, [sp, #76]   ; 0x4c
c0a3b184:       e59d0048        ldr     r0, [sp, #72]   ; 0x48
c0a3b188:       ee030f10        mcr     15, 0, r0, cr3, cr0, {0}
c0a3b18c:       e5891008        str     r1, [r9, #8]
c0a3b190:       e16ff005        msr     SPSR_fsxc, r5
c0a3b194:       e8ddffff        ldm     sp, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr, pc}^
---c0a3b198:       b6e00000        .word   0xb6e00000   //TASK_SIZE:0xb6e00000
c0a3b19c:       c0ccccf0        .word   0xc0ccccf0



Even "ldr r1, =TASK_SIZE"  won't be converted to a mov instruction by some assembler, I also think it is better
to remove the whole #ifdef because the influence of performance by ldr is very limited. 
