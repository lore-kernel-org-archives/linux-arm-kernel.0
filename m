From: robherring2@gmail.com (Rob Herring)
Date: Wed, 4 Dec 2013 18:53:33 -0600
Subject: [PATCH v2] arm64: enable EDAC on arm64
In-Reply-To: <20131126153747.GC692@arm.com>
References: <1385154308-31335-1-git-send-email-robherring2@gmail.com>
 <20131126153747.GC692@arm.com>
Message-ID: <CAL_JsqJLf-kjzafMJ=wh_ZZa63SOMKy20M_5xjy9GRdofiZVCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 9:37 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Fri, Nov 22, 2013 at 09:05:08PM +0000, Rob Herring wrote:
>> +static inline void atomic_scrub(void *va, u32 size)
>> +{
>> +     unsigned int *virt_addr = va;
>> +     unsigned int i;
>> +
>> +     for (i = 0; i < size / sizeof(*virt_addr); i++, virt_addr++) {
>
> BTW, maybe the compiler is smart enough to drop the i but why not just
> use a int *last_addr = va + size - 3; and just compare against this?

Evidently, the compiler is not that smart. Here's what I ended up
with. There's no need to subtract 3 that I can see:

unsigned int *last_addr = va + size;
for (; virt_addr < last_addr; virt_addr++) {

original:

ffffffc0001b0280 <atomic_scrub>:
ffffffc0001b0280:       53027c21        lsr     w1, w1, #2
ffffffc0001b0284:       34000141        cbz     w1, ffffffc0001b02ac
<atomic_scrub+0x2c>
ffffffc0001b0288:       51000421        sub     w1, w1, #0x1
ffffffc0001b028c:       91000421        add     x1, x1, #0x1
ffffffc0001b0290:       8b010801        add     x1, x0, x1, lsl #2
ffffffc0001b0294:       885f7c02        ldxr    w2, [x0]
ffffffc0001b0298:       88037c02        stxr    w3, w2, [x0]
ffffffc0001b029c:       35ffffc3        cbnz    w3, ffffffc0001b0294
<atomic_scrub+0x14>
ffffffc0001b02a0:       91001000        add     x0, x0, #0x4
ffffffc0001b02a4:       eb01001f        cmp     x0, x1
ffffffc0001b02a8:       54ffff61        b.ne    ffffffc0001b0294
<atomic_scrub+0x14>
ffffffc0001b02ac:       d65f03c0        ret

using last_addr:

ffffffc0001b0280 <atomic_scrub>:
ffffffc0001b0280:       8b214001        add     x1, x0, w1, uxtw
ffffffc0001b0284:       eb01001f        cmp     x0, x1
ffffffc0001b0288:       540000e2        b.cs    ffffffc0001b02a4
<atomic_scrub+0x24>
ffffffc0001b028c:       885f7c02        ldxr    w2, [x0]
ffffffc0001b0290:       88037c02        stxr    w3, w2, [x0]
ffffffc0001b0294:       35ffffc3        cbnz    w3, ffffffc0001b028c
<atomic_scrub+0xc>
ffffffc0001b0298:       91001000        add     x0, x0, #0x4
ffffffc0001b029c:       eb00003f        cmp     x1, x0
ffffffc0001b02a0:       54ffff68        b.hi    ffffffc0001b028c
<atomic_scrub+0xc>
ffffffc0001b02a4:       d65f03c0        ret

Rob
