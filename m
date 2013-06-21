From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 21 Jun 2013 16:53:14 +0800
Subject: [PATCH v2 05/12] ARM: barrier: allow options to be passed to
 memory barrier instructions
In-Reply-To: <20130621085102.GC6983@mudshark.cambridge.arm.com>
References: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
 <1371738086-6707-6-git-send-email-will.deacon@arm.com>
 <CACVXFVPrkc4YY25J9QzbKB9A6uerq9m9VQjTZTMN45DvKbx3SA@mail.gmail.com>
 <20130621085102.GC6983@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVNSyuNYe3CX1u8e-fAS64KcOteCvj1sbn8zE-JPfRHT1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 4:51 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hello,
>
> On Fri, Jun 21, 2013 at 09:37:14AM +0100, Ming Lei wrote:
>> On Thu, Jun 20, 2013 at 10:21 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > On ARMv7, the memory barrier instructions take an optional `option'
>> > field which can be used to constrain the effects of a memory barrier
>> > based on shareability and access type.
>> >
>> > This patch allows the caller to pass these options if required, and
>> > updates the smp_*() barriers to request inner-shareable barriers,
>> > affecting only stores for the _wmb variant. wmb() is also changed to
>> > use the -st version of dsb.
>> >
>> > Reported-by: Albin Tonnerre <albin.tonnerre@arm.com>
>> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> > Signed-off-by: Will Deacon <will.deacon@arm.com>
>> > ---
>> >  arch/arm/include/asm/assembler.h |  4 ++--
>> >  arch/arm/include/asm/barrier.h   | 32 ++++++++++++++++----------------
>> >  2 files changed, 18 insertions(+), 18 deletions(-)
>
> [...]
>> > @@ -42,7 +42,7 @@
>> >  #elif defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
>> >  #define mb()           do { dsb(); outer_sync(); } while (0)
>> >  #define rmb()          dsb()
>>
>> The above two dsb() are missed?
>
> I don't think so. What would you suggest changing them to? Remember: there's
> no `load' barrier variant in ARMv7, and the non smp_ barriers may be used to
> ensure ordering outside of the inner-shareable domain (for example, in I/O
> accessors).

SY can be omitted, sorry for the noise.

Thanks,
-- 
Ming Lei
