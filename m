From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 18 Jun 2014 20:46:14 -0700
Subject: [PATCH v4 12/14] ARM64: KVM: vgic_elrsr and vgic_eisr need to be
 byteswapped in BE case
In-Reply-To: <20140614154747.GA18355@lvm>
References: <1402590613-3341-1-git-send-email-victor.kamensky@linaro.org>
 <1402590613-3341-13-git-send-email-victor.kamensky@linaro.org>
 <20140614150459.GH14023@lvm>
 <CAA3XUr3dApGFWmr36rpme+2TRMpFdGp=aCbbk_930jeZ-Eyjuw@mail.gmail.com>
 <20140614154747.GA18355@lvm>
Message-ID: <CAA3XUr1Cifos8vMBoF6nb_PftC8mJpLmnCeJ3hcp+pd+wXiy+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christoffer, Marc,

Please see inline. I am looking for your opinion/advise on how
we go further about this patch.

On 14 June 2014 08:47, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Sat, Jun 14, 2014 at 08:42:58AM -0700, Victor Kamensky wrote:
>> On 14 June 2014 08:04, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> > On Thu, Jun 12, 2014 at 09:30:11AM -0700, Victor Kamensky wrote:
>> >> On arm64 'u32 vgic_eisr[2];' and 'u32 vgic_elrsr[2]' are accessed as
>> >> one 'unsigned long *' bit fields, which has 64bit size. So we need to
>> >> swap least significant word with most significant word when code reads
>> >> those registers from h/w.
>> >>
>> >> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>> >> ---
>> >>  arch/arm64/kvm/hyp.S | 7 +++++++
>> >>  1 file changed, 7 insertions(+)
>> >>
>> >> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
>> >> index 0620691..5035b41 100644
>> >> --- a/arch/arm64/kvm/hyp.S
>> >> +++ b/arch/arm64/kvm/hyp.S
>> >> @@ -415,10 +415,17 @@ CPU_BE( rev     w11, w11 )
>> >>       str     w4, [x3, #VGIC_CPU_HCR]
>> >>       str     w5, [x3, #VGIC_CPU_VMCR]
>> >>       str     w6, [x3, #VGIC_CPU_MISR]
>> >> +#ifndef CONFIG_CPU_BIG_ENDIAN
>> >>       str     w7, [x3, #VGIC_CPU_EISR]
>> >>       str     w8, [x3, #(VGIC_CPU_EISR + 4)]
>> >>       str     w9, [x3, #VGIC_CPU_ELRSR]
>> >>       str     w10, [x3, #(VGIC_CPU_ELRSR + 4)]
>> >> +#else
>> >> +     str     w7, [x3, #(VGIC_CPU_EISR + 4)]
>> >> +     str     w8, [x3, #VGIC_CPU_EISR]
>> >> +     str     w9, [x3, #(VGIC_CPU_ELRSR + 4)]
>> >> +     str     w10, [x3, #VGIC_CPU_ELRSR]
>> >> +#endif
>> >>       str     w11, [x3, #VGIC_CPU_APR]
>> >>
>> >>       /* Clear GICH_HCR */
>> >> --
>> >> 1.8.1.4
>> >>
>> > I thought Marc had something here which allowed you to deal with the
>> > conversion in the accessor functions and avoid this patch?
>>
>> Christoffer, I appreciate your review comments.
>>
>> I think I was missing something. Yes, Marc mentioned in [1] about
>> his new changes in vgic3 series. But just after rereading it now, I
>> realized that he was suggesting to pick up his commits and add
>> them to this series. Is it my right understanding that they should
>> be [2] and [3] ... looking a bit closer to it, it seems that [4] is needed
>> as well. I am concerned that I don't understand all dependencies
>> and impact of those. Wondering about other way around. When vgic3
>> series introduced could we just back off above change and do it in
>> new right way?
>>
>> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009618.html
>> [2] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009475.html
>> [3] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009472.html
>> [4] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009473.html
>>
>> Other question: I was testing all this directly on vanilla v3.15, should I
>> use some other armkvm specific integration branch to make sure it works
>> with all other in a queue armkvm changes.
>>
>> In mean time I will try to pick up [4], [2], and [3] into v3.15 and see
>> how it goes.
>>
> ok, thanks.  I'm ok with potentially adjusting this later if it turns
> out to be a pain, depends on what Marc says.

I've tried BE KVM series along with Marc's vgic3 series
and looked closely at picking up accessors to eisr and elrsr
from the vgic3 series ([1] and [2]). It is not trivial. First of
all, existing patches besides accessors introduce callbacks
in vgic_ops, and that pulls pretty much everything before it.
I did try to split [1] and [2] into couple patches each,
one with accessors and another adding vgic_ops callbacks.
In such way I could pick first part and leave vgic_ops
callback in the series. Split worked OK. I can give example
how it would look. However when I've tried to move accessors
part to top of Marc's vgic3 series I got massive conflicts.
Personally I don't have confidence that I can resolve them
correctly, and I don't think Marc would want to do that
as well. I don't think it is worth it.

Instead I propose let's come back to cleaning it up latter
after vgic3 code gets in. I've tried the following patch in
tree with combined series and it worked OK.

Author: Victor Kamensky <victor.kamensky@linaro.org>
Date:   Tue Jun 17 21:20:25 2014 -0700

    ARM64: KVM: change vgic2 eisr and elrsr word order in big endian case

    Now when code uses eisr and elrsr the accessors, move big endian
    related code into the accessors. Now in eisr and elrsr arrays
    keep least siginificant word at index 0 and most siginificant
    word at index 1. Asm code that stores values in array is the
    same for little and big endian cases. Correct endian neutral
    access to u64 values provided by accessors functions.

    Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>

diff --git a/arch/arm64/kvm/vgic-v2-switch.S b/arch/arm64/kvm/vgic-v2-switch.S
index d5fc5aa..ae21177 100644
--- a/arch/arm64/kvm/vgic-v2-switch.S
+++ b/arch/arm64/kvm/vgic-v2-switch.S
@@ -67,17 +67,10 @@ CPU_BE(     rev     w11, w11 )
        str     w4, [x3, #VGIC_V2_CPU_HCR]
        str     w5, [x3, #VGIC_V2_CPU_VMCR]
        str     w6, [x3, #VGIC_V2_CPU_MISR]
-#ifndef CONFIG_CPU_BIG_ENDIAN
        str     w7, [x3, #VGIC_V2_CPU_EISR]
        str     w8, [x3, #(VGIC_V2_CPU_EISR + 4)]
        str     w9, [x3, #VGIC_V2_CPU_ELRSR]
        str     w10, [x3, #(VGIC_V2_CPU_ELRSR + 4)]
-#else
-       str     w7, [x3, #(VGIC_V2_CPU_EISR + 4)]
-       str     w8, [x3, #VGIC_V2_CPU_EISR]
-       str     w9, [x3, #(VGIC_V2_CPU_ELRSR + 4)]
-       str     w10, [x3, #VGIC_V2_CPU_ELRSR]
-#endif
        str     w11, [x3, #VGIC_V2_CPU_APR]

        /* Clear GICH_HCR */
diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
index a55a9a4..a4b6f13 100644
--- a/virt/kvm/arm/vgic-v2.c
+++ b/virt/kvm/arm/vgic-v2.c
@@ -79,14 +79,30 @@ static void vgic_v2_sync_lr_elrsr(struct kvm_vcpu
*vcpu, int lr,

 static u64 vgic_v2_get_elrsr(const struct kvm_vcpu *vcpu)
 {
+       u64 ret;
        const u32 *elrsr = vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr;
-       return *(u64 *)elrsr;
+       /*
+        * vgic v2 elrsr is kept as two words, with least significant
+        * word first. Get its value in endian agnostic way.
+        */
+       ret = *(elrsr + 1);
+       ret = ret << 32;
+       ret = ret | *elrsr;
+       return ret;
 }

 static u64 vgic_v2_get_eisr(const struct kvm_vcpu *vcpu)
 {
+       u64 ret;
        const u32 *eisr = vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr;
-       return *(u64 *)eisr;
+       /*
+        * vgic v2 eisr is kept as two words, with least siginificant
+        * word first. Get its value in endian agnostic way.
+        */
+       ret = *(eisr + 1);
+       ret = ret << 32;
+       ret = ret | *eisr;
+       return ret;
 }

 static u32 vgic_v2_get_interrupt_status(const struct kvm_vcpu *vcpu)

Basically it backoffs this commit and changes accessor to read
values assuming that vgic_v2 eisr and elrsr array holds value of
least siginificant word@index 0, and most significant word at
index 1.

Please let me know what you think.

Thanks,
Victor

[1] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009475.html
[2] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009472.html

> I can probably fix up any conflicts when I apply the patches, but I do
> appreciate getting patches that apply to the next branch in [1].  (But
> wait until the next branch merges 3.16-rc1).
>
> -Christoffer
>
> [1]: https://git.kernel.org/cgit/linux/kernel/git/kvmarm/kvmarm.git/
