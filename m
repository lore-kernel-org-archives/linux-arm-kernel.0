From: jean.pihet@linaro.org (Jean Pihet)
Date: Wed, 5 Mar 2014 03:17:00 +0100
Subject: [PATCH 1/3] perf tests: Introduce perf_regs_load function on ARM
In-Reply-To: <20140304110042.GD8766@mudshark.cambridge.arm.com>
References: <1393840403-26639-1-git-send-email-jean.pihet@linaro.org>
 <1393840403-26639-2-git-send-email-jean.pihet@linaro.org>
 <20140304110042.GD8766@mudshark.cambridge.arm.com>
Message-ID: <CAFrcx1=3+zZPErXC7dehwpKHnmwE=cWh1mR0kzN0PONpFZKaUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 4 March 2014 12:00, Will Deacon <will.deacon@arm.com> wrote:
> Hi Jean,
>
> On Mon, Mar 03, 2014 at 09:53:21AM +0000, Jean Pihet wrote:
>> Introducing perf_regs_load function, which is going
>> to be used for dwarf unwind test in following patches.
>>
>> It takes single argument as a pointer to the regs dump
>> buffer and populates it with current registers values.
>
> [...]
>
>> diff --git a/tools/perf/arch/arm/tests/regs_load.S b/tools/perf/arch/arm/tests/regs_load.S
>> new file mode 100644
>> index 0000000..241c6df
>> --- /dev/null
>> +++ b/tools/perf/arch/arm/tests/regs_load.S
>> @@ -0,0 +1,51 @@
>> +#include <linux/linkage.h>
>> +
>> +#define R0 0x00
>> +#define R1 0x08
>
> Why are you using a 64-bit stride for 32-bit registers? (which prevents you
> from using stm later on).
This is because perf internally uses a 64-bit array for the registers,
cf. the function prototype in the comment above.

>
>> +.text
>> +.type perf_regs_load,%function
>> +ENTRY(perf_regs_load)
>> +     push {r1}
>
> Do you only push r1 here so that you can do the stack arithmetic later? That
> doesn't make sense to me -- can't you str sp directly?
Yes indeed! I submitted a new version yesterday with that change and a
fix in the comments.

>
>> +     str r0, [r0, #R0]
>> +     str r1, [r0, #R1]
>> +     str r2, [r0, #R2]
>> +     str r3, [r0, #R3]
>> +     str r4, [r0, #R4]
>> +     str r5, [r0, #R5]
>> +     str r6, [r0, #R6]
>> +     str r7, [r0, #R7]
>> +     str r8, [r0, #R8]
>> +     str r9, [r0, #R9]
>> +     str sl, [r0, #SL]
>> +     str fp, [r0, #FP]
>> +     str ip, [r0, #IP]
>> +     add r1, sp, #4          @ Retrieve and save sp at entry time
>> +     str r1, [r0, #SP]
>> +     str lr, [r0, #LR]
>> +     str lr, [r0, #PC]       @ Save caller PC
>
> This isn't necessarily the `caller PC' (depending on how you define it).
> It's the return address, which is probably (but not always) the instruction
> following the branch to this function.
Agreed. However the perf test code expects a registers buffer filled
in with the caller's values.
I can change the comment here, is that needed?

Thanks for reviewing!
Jean

>
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
