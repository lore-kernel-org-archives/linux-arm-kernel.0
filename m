From: robherring2@gmail.com (Rob Herring)
Date: Wed, 6 Nov 2013 12:39:18 -0600
Subject: [PATCH] arm64: enable EDAC on arm64
In-Reply-To: <20131106152608.GD979@arm.com>
References: <1383742944-28059-1-git-send-email-robherring2@gmail.com>
 <20131106152608.GD979@arm.com>
Message-ID: <CAL_JsqLwFHeRZzaMAxNmPSfNeVb_W2Ng=mXBkyUPQx+=beHyTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 9:26 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Nov 06, 2013 at 01:02:24PM +0000, Rob Herring wrote:
>> +static inline void atomic_scrub(void *va, u32 size)
>> +{
>> +     unsigned int *virt_addr = va;
>> +     unsigned int temp, temp2;
>> +     unsigned int i;
>> +
>> +     for (i = 0; i < size / sizeof(*virt_addr); i++, virt_addr++) {
>> +             /*
>> +              * No need to check for store failure, another write means
>> +              * the scrubbing has effectively already been done for us.
>> +              */
>> +             asm volatile("\n"
>> +                     "       ldxr    %0, %2\n"
>> +                     "       stxr    %w1, %0, %2\n"
>> +                     : "=&r" (temp), "=&r" (temp2), "+Q" (virt_addr)
>> +                     : : "cc");
>
> But failure of stxr does not necessarily mean another write. It can be
> an interrupt, cache line migration etc. The exclusive monitor can be
> emulated in many ways.

Right, I was thinking I could simplify things.

In that case, I could implement this with just "atomic64_add(0,
virt_addr)", but is there any guarantee that atomic64_t has a size of
8 bytes and that I can simply increment an atomic64_t ptr?

> BTW, can you not use 64-bit loads/stores?

Correct, that should be a long instead of int.

Rob
