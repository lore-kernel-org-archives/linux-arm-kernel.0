From: glider@google.com (Alexander Potapenko)
Date: Thu, 3 Mar 2016 18:45:55 +0100
Subject: [PATCHv2 0/3] KASAN: clean stale poison upon cold re-entry to
 kernel
In-Reply-To: <20160303174015.GG19139@leverpostej>
References: <1457024068-2236-1-git-send-email-mark.rutland@arm.com>
 <CAG_fn=WAfu4oD1Qb1xUnX765RpUznWm1y+FKYqqiM8VO53F+Ag@mail.gmail.com>
 <20160303174015.GG19139@leverpostej>
Message-ID: <CAG_fn=VBOqPSwhKy2OCj7cgM=XaD338L=UfPDcg9X3tCwc6B_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 3, 2016 at 6:40 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Thu, Mar 03, 2016 at 06:17:31PM +0100, Alexander Potapenko wrote:
>> Please replace "ASAN" with "KASAN".
>>
>> On Thu, Mar 3, 2016 at 5:54 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > Functions which the compiler has instrumented for ASAN place poison on
>> > the stack shadow upon entry and remove this poison prior to returning.
>> >
>> > In some cases (e.g. hotplug and idle), CPUs may exit the kernel a number
>> > of levels deep in C code. If there are any instrumented functions on
>> > this critical path, these will leave portions of the idle thread stack
>> > shadow poisoned.
>> >
>> > If a CPU returns to the kernel via a different path (e.g. a cold entry),
>> > then depending on stack frame layout subsequent calls to instrumented
>> > functions may use regions of the stack with stale poison, resulting in
>> > (spurious) KASAN splats to the console.
>> >
>> > Contemporary GCCs always add stack shadow poisoning when ASAN is
>> > enabled, even when asked to not instrument a function [1], so we can't
>> > simply annotate functions on the critical path to avoid poisoning.
>> >
>> > Instead, this series explicitly removes any stale poison before it can
>> > be hit. In the common hotplug case we clear the entire stack shadow in
>> > common code, before a CPU is brought online.
>> >
>> > On architectures which perform a cold return as part of cpu idle may
>> > retain an architecture-specific amount of stack contents. To retain the
>> > poison for this retained context, the arch code must call the core KASAN
>> > code, passing a "watermark" stack pointer value beyond which shadow will
>> > be cleared. Architectures which don't perform a cold return as part of
>> > idle do not need any additional code.
>
> For the above, and the rest of the series, ASAN consistently refers to
> the compiler AddressSanitizer feature, and KASAN consistently refers to
> the Linux-specific infrastructure. A simple s/[^K]ASAN/KASAN/ would
> arguably be wrong (e.g. when referring to GCC behaviour above).
I don't think there's been any convention about the compiler feature
name, we usually talked about ASan as a userspace tool and KASAN as a
kernel-space one, although they share the compiler part.

> If there is a this needs rework, then I'm happy to s/[^K]ASAN/ASan/ to
> follow the usual ASan naming convention and avoid confusion. Otherwise,
> spinning a v3 is simply churn.
I don't insist on changing this, I should've chimed in before.
Feel free to retain the above patch description.
> Thanks,
> Mark.



-- 
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra?e, 33
80636 M?nchen

Gesch?ftsf?hrer: Matthew Scott Sucherman, Paul Terence Manicle
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Diese E-Mail ist vertraulich. Wenn Sie nicht der richtige Adressat sind,
leiten Sie diese bitte nicht weiter, informieren Sie den
Absender und l?schen Sie die E-Mail und alle Anh?nge. Vielen Dank.
This e-mail is confidential. If you are not the right addressee please
do not forward it, please inform the sender, and please erase this
e-mail including any attachments. Thanks.
