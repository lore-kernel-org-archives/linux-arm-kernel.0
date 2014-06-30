From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Jun 2014 12:26:54 +0200
Subject: [PATCH v2] arm64: fpsimd: avoid restoring fpcr if the contents
 haven't changed
In-Reply-To: <20140630090318.GB24879@arm.com>
References: <1403884399-16359-1-git-send-email-will.deacon@arm.com>
 <CAKv+Gu_-nPg5eGj1MHXui=2QkDPGFgjh=4dZhODj984KCGqGEA@mail.gmail.com>
 <20140630090318.GB24879@arm.com>
Message-ID: <CAKv+Gu-KkR4i6pJSR+wjKP7y9e97J9DdkLKL9HKs3RCirC3wZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2014 11:03, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jun 27, 2014 at 06:33:58PM +0100, Ard Biesheuvel wrote:
>> On 27 June 2014 17:53, Will Deacon <will.deacon@arm.com> wrote:
>> > Writing to the FPCR is commonly implemented as a self-synchronising
>> > operation in the CPU, so avoid writing to the register when the saved
>> > value matches that in the hardware already.
>
> [...]
>
>> >  .macro fpsimd_restore_partial state, tmpnr1, tmpnr2
>> >         ldp     w\tmpnr1, w\tmpnr2, [\state]
>> >         msr     fpsr, x\tmpnr1
>> > -       msr     fpcr, x\tmpnr2
>> > +       fpsimd_restore_fpcr x\tmpnr1, x\tmpnr2
>>
>> Ehm, isn't this the wrong way around?
>
> Yup, well spotted. I'll give the crypto selftests a run to test this path
> with the fix (I was just running paranoia in userspace before).
>

That won't cut it, I'm afraid. What I used is

--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -221,6 +221,8 @@ void fpsimd_flush_task_state(struct task_struct *t)
 static DEFINE_PER_CPU(struct fpsimd_partial_state, hardirq_fpsimdstate);
 static DEFINE_PER_CPU(struct fpsimd_partial_state, softirq_fpsimdstate);

+#define in_interrupt() (1)
+
 /*
  * Kernel-side NEON support functions
  */

and run my [lengthy] userland benchmark while doing 'modprobe tcrypt
mode=x' a number of times in another terminal (with only 1 CPU up).
[with x=2 for SHA1 and x=6 for SHA256, for instance]

The first iteration of the interrupt context NEON series had an ARM
counterpart which I was able to test using iperf over a WPA2/CCMP link
(with the bit-sliced AES in CTR mode). No such luck [yet] on arm64,
unfortunately, so I had to improvise a bit.

-- 
Ard.
