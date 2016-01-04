From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 4 Jan 2016 16:24:49 +0100
Subject: linux-4.4-rc8/arch/arm64/kernel/module.c:78: 32/64 bit problem ?
In-Reply-To: <CAKv+Gu8KT-vOPN=ypt-qViLc74CumJUorxxM1wPnzf7h-nqKFg@mail.gmail.com>
References: <DUB128-W158A3195DB26F149DD52E59CF20@phx.gbl>
 <20160104141657.GC1616@arm.com>
 <CAKv+Gu8KT-vOPN=ypt-qViLc74CumJUorxxM1wPnzf7h-nqKFg@mail.gmail.com>
Message-ID: <CAKv+Gu9Ve6=1evFD4V2jtOCHOEqOzhmud=guioVR5NMrc=HPBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 January 2016 at 15:32, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 4 January 2016 at 15:16, Will Deacon <will.deacon@arm.com> wrote:
>> On Mon, Jan 04, 2016 at 08:25:30AM +0000, David Binderman wrote:
>>> Hello there,
>>
>> Hi David,
>>
>>> [linux-4.4-rc8/arch/arm64/kernel/module.c:78] ->
>>> [linux-4.4-rc8/arch/arm64/kernel/module.c:88]: (warning) Shifting 32-bit
>>> value by 64 bits is undefined behaviour. See condition at line 88.
>>
>> Curious, but how are you seeing this warning? GCC is silent for me...
>>
>>> Source code is
>>>
>>>     u64 imm_mask = (1 << len) - 1;
>>>     s64 sval = do_reloc(op, place, val);
>>>
>>>     switch (len) {
>>>     case 16:
>>>         *(s16 *)place = sval;
>>>         break;
>>>     case 32:
>>>         *(s32 *)place = sval;
>>>         break;
>>>     case 64:
>>>
>>> So it seems that len can be 64. Suggest new code
>>>
>>>     u64 imm_mask = (1UL << len) - 1;
>>
>> That still ends up shifting by the width of the type when len == 64,
>> which is potentially still broken. We're better off using GENMASK.
>>
>
> Can't we simply return from the function rather than break from the
> switch statement if len == 64?
> The range check does not make any sense in that case anyway.
>

Or perhaps:

------------8<-----------------
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index f4bc779e62e8..fd1f4e678655 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -75,14 +75,17 @@ static u64 do_reloc(enum aarch64_reloc_op
reloc_op, void *place, u64 val)

 static int reloc_data(enum aarch64_reloc_op op, void *place, u64 val, int len)
 {
-       u64 imm_mask = (1 << len) - 1;
        s64 sval = do_reloc(op, place, val);

        switch (len) {
        case 16:
+               if (sval < S16_MIN || sval > U16_MAX)
+                       return -ERANGE;
                *(s16 *)place = sval;
                break;
        case 32:
+               if (sval < S32_MIN || sval > U32_MAX)
+                       return -ERANGE;
                *(s32 *)place = sval;
                break;
        case 64:
@@ -92,21 +95,6 @@ static int reloc_data(enum aarch64_reloc_op op,
void *place, u64 val, int len)
                pr_err("Invalid length (%d) for data relocation\n", len);
                return 0;
        }
-
-       /*
-        * Extract the upper value bits (including the sign bit) and
-        * shift them to bit 0.
-        */
-       sval = (s64)(sval & ~(imm_mask >> 1)) >> (len - 1);
-
-       /*
-        * Overflow has occurred if the value is not representable in
-        * len bits (i.e the bottom len bits are not sign-extended and
-        * the top bits are not all zero).
-        */
-       if ((u64)(sval + 1) > 2)
-               return -ERANGE;
-
        return 0;
 }
