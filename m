From: liuwenliang@huawei.com (Liuwenliang (Lamb))
Date: Tue, 17 Oct 2017 13:02:06 +0000
Subject: [PATCH 04/11] Define the virtual space of KASan's shadow region
In-Reply-To: <CAKv+Gu-+yOyAC4R_JNNy7NqWiSQ=HwfR=uTr1Ntt=2cDzAZ5nw@mail.gmail.com>
References: <20171011082227.20546-5-liuwenliang@huawei.com>
 <201710141957.mbxeZJHB%fengguang.wu@intel.com>
 <B8AC3E80E903784988AB3003E3E97330C005B9BF@dggemm510-mbx.china.huawei.com>
 <CAKv+Gu98M9PZk3qm0PYC8nQ3zMvLZmNmOn4=hNdFE7NTBuHbgg@mail.gmail.com>
 <B8AC3E80E903784988AB3003E3E97330C005CAC2@dggemm510-mbx.china.huawei.com>
 <CAKv+Gu-+yOyAC4R_JNNy7NqWiSQ=HwfR=uTr1Ntt=2cDzAZ5nw@mail.gmail.com>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C005CB08@dggemm510-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2017 8:45 PM, Abbott Liu wrote:
>What I said was
>
>'if the value of TASK_SIZE fits its 12-bit immediate field'
>
>and your value of TASK_SIZE is 0xb6e00000, which cannot be decomposed in the right way.
>
>If you build with KASAN disabled, it will generate a mov instruction instead.

Thanks for your explain. I understand now.  I has tested and the testing result proves that what 
you said is right. 

Here is test log:
c010e9e0 <__irq_svc>:
c010e9e0:       e24dd04c        sub     sp, sp, #76     ; 0x4c
c010e9e4:       e31d0004        tst     sp, #4
c010e9e8:       024dd004        subeq   sp, sp, #4
c010e9ec:       e88d1ffe        stm     sp, {r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip}
c010e9f0:       e8900038        ldm     r0, {r3, r4, r5}
c010e9f4:       e28d7030        add     r7, sp, #48     ; 0x30
c010e9f8:       e3e06000        mvn     r6, #0
c010e9fc:       e28d204c        add     r2, sp, #76     ; 0x4c
c010ea00:       02822004        addeq   r2, r2, #4
c010ea04:       e52d3004        push    {r3}            ; (str r3, [sp, #-4]!)
c010ea08:       e1a0300e        mov     r3, lr
c010ea0c:       e887007c        stm     r7, {r2, r3, r4, r5, r6}
c010ea10:       e1a0972d        lsr     r9, sp, #14
c010ea14:       e1a09709        lsl     r9, r9, #14
c010ea18:       e5990008        ldr     r0, [r9, #8]
c010ea1c:       e3a014bf        mov     r1, #-1090519040        ; 0xbf000000  // ldr r1,=0xbf000000
