From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Sep 2011 17:26:53 +0100
Subject: [PATCH 03/11] ARM: pm: some ARMv7 requires a dsb in resume to
	ensure correctness
In-Reply-To: <20110907161906.GA2327@n2100.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
	<E1Qz6hr-00078J-2k@rmk-PC.arm.linux.org.uk>
	<CAHkRjk65O3wJLazxZeOOQrDuM-XkZXo4fcOuVZf4Jzq9OP3p3g@mail.gmail.com>
	<20110907161906.GA2327@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk6q+0igtZVn7LE4NfDhcXEtQCJZ3cBrtfY4brtW7M86NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 September 2011 17:19, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Sep 07, 2011 at 04:41:32PM +0100, Catalin Marinas wrote:
>> On 1 September 2011 13:49, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > Add a dsb after the isb to ensure that the previous writes to the
>> > CP15 registers take effect before we enable the MMU.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> > ---
>> > ?arch/arm/mm/proc-v7.S | ? ?1 +
>> > ?1 files changed, 1 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
>> > index dec72ee..a773f4e 100644
>> > --- a/arch/arm/mm/proc-v7.S
>> > +++ b/arch/arm/mm/proc-v7.S
>> > @@ -255,6 +255,7 @@ ENTRY(cpu_v7_do_resume)
>> > ? ? ? ?mcr ? ? p15, 0, r4, c10, c2, 0 ?@ write PRRR
>> > ? ? ? ?mcr ? ? p15, 0, r5, c10, c2, 1 ?@ write NMRR
>> > ? ? ? ?isb
>> > + ? ? ? dsb
>>
>> Isn't an ISB enough here? We usually have the DSB for some background
>> operations like cache maintenance.
>
> That depends whether you're including the effects of the cache
> maintanence instructions in this. ?The ARM ARM tells me that
> a DSB is required to ensure that all cache maintanence is issued
> before the dsb is complete at the point that the dsb is executed.
>
> So for architectural compliance, yes, a dsb is required. ?The isb
> is also required to ensure that instruction cache maintanence is
> properly visible.

That's correct, I got the wrong impression that there was a DSB
earlier in the code after he TLB and cache maintenance, but that's not
the case, so a DSB here is needed.

-- 
Catalin
