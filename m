From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 10 Sep 2014 19:09:07 +0200
Subject: [PATCH 02/13] arm64/kvm: Fix assembler compatibility of macros
In-Reply-To: <1410366914.11440.16.camel@smoke>
References: <cover.1410302383.git.geoff@infradead.org>
 <bc4abc340eaa4da448f62326a134fabfb5a2a875.1410302383.git.geoff@infradead.org>
 <CAKv+Gu_hs-Sv=Bg6uyKc41OV9sKS0sfM1YAcCMaTF7aTH9YPwA@mail.gmail.com>
 <1410366914.11440.16.camel@smoke>
Message-ID: <CAKv+Gu_uU3cQZbsa2w=GtXCGd59PhD-conRn3szLkOFKmTngSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 September 2014 18:35, Geoff Levand <geoff@infradead.org> wrote:
> On Wed, 2014-09-10 at 10:40 +0200, Ard Biesheuvel wrote:
>> On 10 September 2014 00:49, Geoff Levand <geoff@infradead.org> wrote:
>> > Some of the macros defined in kvm_arm.h are useful in the exception vector
>> > routines, but they are not compatible with the assembler.  Change the
>> > definition of ESR_EL2_ISS to be compatible.
>> >
>> > Fixes build errors like these when using kvm_arm.h in assembly
>> > source files:
>> >
>> >   Error: unexpected characters following instruction at operand 3 -- `add x0,x1,#((1U<<25)-1)'
>> >
>> > Signed-off-by: Geoff Levand <geoff@infradead.org>
>> > ---
>> >  arch/arm64/include/asm/kvm_arm.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
>> > index cc83520..e0e7e64 100644
>> > --- a/arch/arm64/include/asm/kvm_arm.h
>> > +++ b/arch/arm64/include/asm/kvm_arm.h
>> > @@ -176,7 +176,7 @@
>> >  #define ESR_EL2_EC_SHIFT       (26)
>> >  #define ESR_EL2_EC             (0x3fU << ESR_EL2_EC_SHIFT)
>> >  #define ESR_EL2_IL             (1U << 25)
>> > -#define ESR_EL2_ISS            (ESR_EL2_IL - 1)
>> > +#define ESR_EL2_ISS            (0xffff)
>>
>> Don't you mean 0x1ffffff?
>
> Hcalls have a 16 bit 'payload', the upper bits of the ISS field
> are specified as zero by the architecture so 0xffff is the same
> as 0x1ffffff.
>

Even if HVC is currently the only exception we are taking in EL2 (is
that the case btw?), it seems wrong to define this field in such a way
that it
(a) deviates from how the architecture specifies ESR_ELx.ISS and
(b) may cause surprises once someone unsuspectingly starts and'ing his
ESR values produced by another exception class with it, expecting the
macro's value to reflect its name

>> And, there is a macro UL() for this purpose, so I suppose you could
>> redefine ESR_EL2_IL as (UL(1) << 25) as well. I know it is not
>> strictly the same thing, but it should be good enough as this is arm64
>> only
>
> Sure that will be OK.  The one other use of ESR_EL2_IL will promote
> the operation to unsigned long without ill effect.  I'll prepare an
> updated patch.
>
> -Geoff
>
>
