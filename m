From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 21 May 2014 17:47:00 +0800
Subject: [PATCH v9 14/14] virt: arm: support hip04 gic
In-Reply-To: <20140521090203.GB39503@lvm>
References: <1400591427-21922-1-git-send-email-haojian.zhuang@linaro.org>
 <1400591427-21922-15-git-send-email-haojian.zhuang@linaro.org>
 <20140520134441.GK5292@lvm>
 <CAD6h2NQyG1GSneWMpHmYxD-dPS7w9w2fe8vDdj-f834T2yqn1w@mail.gmail.com>
 <20140520140153.GL5292@lvm>
 <CAD6h2NQZGBa5U0-tmj=wtsFpcqnV2tHx+_vESrx8+3r7dGpHjQ@mail.gmail.com>
 <20140520150518.GA39503@lvm>
 <CAD6h2NRv3hUa7vhbxVb1LhYi9K5OMVf01pyqp6yUC-+0zU8jkQ@mail.gmail.com>
 <20140521090203.GB39503@lvm>
Message-ID: <CAD6h2NQHqisW0_nYQ9XyHXrX57Z7mcxeVwyFMiSyCm7Tt8n8KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 May 2014 17:02, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Tue, May 20, 2014 at 11:39:12PM +0800, Haojian Zhuang wrote:
>> On 20 May 2014 23:05, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> > On Tue, May 20, 2014 at 10:16:22PM +0800, Haojian Zhuang wrote:
>> >> On 20 May 2014 22:01, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> >> It's the implementation of gich_apr in arm32.
>> >>
>> >> We needn't add or change anything in struct vgic_cpu. And both the
>> >> assembly code and the code could be much easier.
>> >>
>> >
>> > But we do end up with an extra memory access from EL2 in the critical
>> > path, and I believe Marc's concern here is that if we cross a cache
>> > line, this might really hurt performance.
>> >
>>
>> Sorry. Do we may cross a cache line or a TLB entry?
>>
>> I think that you're concerning to cross TLB entries. The reason is in
>>  below.
>>
>> 1. If the problem is on crossing cache line, it's caused by too much
>> instructions. Either the packing nr_lr or the gich_apr adds some
>> instructions. The packing nr_lr needs a little more instructions.
>
> I don't see why this argument is valid.  If you have a separate

I want to make it clear what I missing.

> instruction and data cache, you may be loading from a different cache
> line when placing the static value close to your instructions.  If you
> add a variable to the vcpu struct, all of the fields may no longer fit
> in a single data cache line and you may cause the memory subsystem to
> have to fetch another cache line.  I believe the latter is Marc's

Yes, I forgot new gich_apr is the only variable in the assembly code.
So the gich_apr will be load from a different cache line.

Then let's come back to packing hw_cfg.

Now the high word is used to store the offset of GICH_APR. The
unpacking operation is too complex to calculate the register offset,
especially in arm64 implementation.

How about changing the packing mechanism?

1. Add the definition of enconding in arm-gic.h.

#define HIP04_GIC             (1 << 16)
#define HIP04_GICH_APR   0x70
#define HIP04_GICH_LR0    0x80

2. The code in save_vgic_state could be changed in below.

  ldr     r9, [r2, #GICH_ELRSR1]
+ldr     r10, [r3, #VGIC_CPU_HW_CFG]
+tst     r10, #HIP04_GIC
+ldreq  r10, [r2, #GICH_APR]
+ldrne  r10, [r2, #HIP04_GICH_APR]

Although I used the condition checking@here, the code could
be easier.

I think that the executing time on "ldr" and "ldreq" should be same,
because CPCS should be ready

Then calculation is avoid. Only three instructions are appended
for both GICH_APR & GICH_LR0. The implementation in arm64
should be same & simple.

How do you think so?

Regards
Haojian
