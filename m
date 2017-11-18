From: liuwenliang@huawei.com (Liuwenliang (Abbott Liu))
Date: Sat, 18 Nov 2017 10:40:08 +0000
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <20171117073556.GB28855@cbox>
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
 <20171117073556.GB28855@cbox>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C00638D4@dggemm510-mbs.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 17, 2017  15:36 Christoffer Dall [mailto:cdall at linaro.org]  wrote:
>If your processor does support LPAE (like a Cortex-A15 for example),
>then you have both the 32-bit accessors (MRC and MCR) and the 64-bit
>accessors (MRRC, MCRR), and using the 32-bit accessor will simply access
>the lower 32-bits of the 64-bit register.
>
>Hope this helps,
>-Christoffer

If you know the higher 32-bits of the 64-bits cp15's register is not useful for your system,
then you can use the 32-bit accessor to get or set the 64-bit cp15's register.
But if the higher 32-bits of the 64-bits cp15's register is useful for your system,
then you can't use the 32-bit accessor to get or set the 64-bit cp15's register.

TTBR0/TTBR1/PAR's higher 32-bits is useful for CPU supporting LPAE.
The following description which comes from ARM(r) Architecture Reference
Manual ARMv7-A and ARMv7-R edition tell us the reason:

64-bit TTBR0 and TTBR1 format:
...
BADDR, bits[39:x] : 
Translation table base address, bits[39:x]. Defining the translation table base address width on
page B4-1698 describes how x is defined.
The value of x determines the required alignment of the translation table, which must be aligned to
2x bytes.

Abbott Liu: Because BADDR on CPU supporting LPAE may be bigger than max value of 32-bit, so bits[39:32] may 
be valid value which is useful for the system.

64-bit PAR format
...
PA[39:12]
Physical Address. The physical address corresponding to the supplied virtual address. This field
returns address bits[39:12].

Abbott Liu: Because Physical Address on CPU supporting LPAE may be bigger than max value of 32-bit, 
so bits[39:32] may be valid value which is useful for the system.

Conclusion: Don't use 32-bit accessor to get or set TTBR0/TTBR1/PAR on CPU supporting LPAE,
if you do that, your system may run error.
