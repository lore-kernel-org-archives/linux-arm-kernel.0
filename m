From: cdall@linaro.org (Christoffer Dall)
Date: Fri, 17 Nov 2017 08:35:56 +0100
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <B8AC3E80E903784988AB3003E3E97330C0063816@dggemm510-mbs.china.huawei.com>
References: <8e959f69-a578-793b-6c32-18b5b0cd08c2@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063545@dggemm510-mbs.china.huawei.com>
 <87a7znsubp.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063587@dggemm510-mbs.china.huawei.com>
 <bbf43f92-3d0c-940d-b66b-68f92eb9b282@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C00635F3@dggemm510-mbs.china.huawei.com>
 <87po8ir1kg.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C006371B@dggemm510-mbs.china.huawei.com>
 <87375eqobb.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063816@dggemm510-mbs.china.huawei.com>
Message-ID: <20171117073556.GB28855@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 17, 2017 at 07:18:45AM +0000, Liuwenliang (Abbott Liu) wrote:
> On 16/11/17  22:41 Marc Zyngier [mailto:marc.zyngier at arm.com] wrote:
> >No, it doesn't. It cannot work, because Cortex-A9 predates the invention
> >of the 64bit accessor. I suspect that you are testing stuff in QEMU,
> >which is giving you a SW model that always supports LPAE. I suggest you
> >test this code on *real* HW, and not only on QEMU.
> 
> I am sorry. My test is fault. I only defined TTBR0 as __ACCESS_CP15_64,
> but I don't use the definition TTBR0 as __ACCESS_CP15_64. 
> 
> Now I use the definition TTBR0 as __ACCESS_CP15_64 on CPU supporting
> LPAE(vexpress_a9)

What does a "CPU supporting LPAE(vexpress_a9) mean?  As Marc pointed
out, a Cortex-A9 doesn't support LPAE.  If you configure your kernel
with LPAE it's not going to work on a Cortex-A9.

> I find it doesn't work and report undefined instruction error
> when execute "mrrc" instruction.
> 
> So, you are right that 64bit accessor of TTBR0 cannot work on LPAE.
> 

It's the other way around.  It doesn't work WITHOUT LPAE, it only works
WITH LPAE.

The ARM ARM explains this quite clearly:

"Accessing TTBR0

To access TTBR0 in an implementation that does not include the Large
Physical Address Extension, or bits[31:0] of TTBR0 in an implementation
that includes the Large Physical Address Extension, software reads or
writes the CP15 registers with <opc1> set to 0, <CRn> set to c2, <CRm>
set to c0, and <opc2> set to 0. For example:

MRC p15, 0, <Rt>, c2, c0, 0
  ; Read 32-bit TTBR0 into Rt
MCR p15, 0, <Rt>, c2, c0, 0
  ; Write Rt to 32-bit TTBR0

In an implementation that includes the Large Physical Address Extension,
to access all 64 bits of TTBR0, software performs a 64-bit read or write
of the CP15 registers with <CRm> set to c2 and <opc1> set to 0. For
example:

MRRC p15, 0, <Rt>, <Rt2>, c2
  ; Read 64-bit TTBR0 into Rt (low word) and Rt2 (high word)
MCRR p15, 0, <Rt>, <Rt2>, c2
  ; Write Rt (low word) and Rt2 (high word) to 64-bit TTBR0

In these MRRC and MCRR instructions, Rt holds the least-significant word
of TTBR0, and Rt2 holds the most-significant word."

That is, if your processor (like the Cortex-A9) does NOT support LPAE,
all you have is the 32-bit accessors (MRC and MCR).

If your processor does support LPAE (like a Cortex-A15 for example),
then you have both the 32-bit accessors (MRC and MCR) and the 64-bit
accessors (MRRC, MCRR), and using the 32-bit accessor will simply access
the lower 32-bits of the 64-bit register.

Hope this helps,
-Christoffer
