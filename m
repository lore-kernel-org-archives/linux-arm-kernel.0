From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 4 Feb 2011 10:58:06 +0000
Subject: [PATCH v2 1/5] ARM: omap4: Correct definition of do_wfi()
	forCONFIG_THUMB2_KERNEL
In-Reply-To: <d813cf9e0b404d0243c3973841baa6dc@mail.gmail.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
	<1296756161-26092-2-git-send-email-dave.martin@linaro.org>
	<b0242fa556f17e47222fa7f30a36d75b@mail.gmail.com>
	<20110203190758.GA15004@n2100.arm.linux.org.uk>
	<d813cf9e0b404d0243c3973841baa6dc@mail.gmail.com>
Message-ID: <AANLkTin_mc2e=xaotifjix_ii5iaugVFo1RuAkzZEWwF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 3, 2011 at 7:30 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
>> Sent: Friday, February 04, 2011 12:38 AM
>> To: Santosh Shilimkar
>> Cc: Dave Martin; linux-arm-kernel at lists.infradead.org; Tony
>> Lindgren; Nicolas Pitre; linux-omap at vger.kernel.org; Jean Pihet-XID
>> Subject: Re: [PATCH v2 1/5] ARM: omap4: Correct definition of
>> do_wfi() forCONFIG_THUMB2_KERNEL
>>
>> On Fri, Feb 04, 2011 at 12:09:34AM +0530, Santosh Shilimkar wrote:
>> > > -----Original Message-----
>> > > From: Dave Martin [mailto:dave.martin at linaro.org]
>> > > Sent: Thursday, February 03, 2011 11:33 PM
>> > > To: linux-arm-kernel at lists.infradead.org
>> > > Cc: Dave Martin; Tony Lindgren; Santosh Shilimkar; Jean Pihet;
>> > > linux-omap at vger.kernel.org; Nicolas Pitre
>> > > Subject: [PATCH v2 1/5] ARM: omap4: Correct definition of
>> do_wfi()
>> > > for CONFIG_THUMB2_KERNEL
>> > >
>> > > For the Thumb-2 case, the "wfi" mnemonic is used, since in this
>> > > case the tools will necessarily be new enough to support it.
>> > >
>> > > Signed-off-by: Dave Martin <dave.martin@linaro.org>
>> >
>> > I guess, we discussed this patch in your previous post.
>> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> >
>> > > ---
>> > > ?arch/arm/mach-omap2/include/mach/omap4-common.h | ? ?5 +++++
>> > > ?1 files changed, 5 insertions(+), 0 deletions(-)
>> > >
>> > > diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h
>> > > b/arch/arm/mach-omap2/include/mach/omap4-common.h
>> > > index 5b0270b..68ce058 100644
>> > > --- a/arch/arm/mach-omap2/include/mach/omap4-common.h
>> > > +++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
>> > > @@ -17,8 +17,13 @@
>> > > ? * wfi used in low power code. Directly opcode is used instead
>> > > ? * of instruction to avoid mulit-omap build break
>> > > ? */
>> > > +#ifdef CONFIG_THUMB2_KERNEL
>> > > +#define do_wfi() ? ? ? ? ? ? ? ? \
>> > > + ? ? ? ? __asm__ __volatile__ ("wfi" : : : "memory")
>> > > +#else
>> > > ?#define do_wfi() ? ? ? ? ? ? ? ? \
>> > > ? ? ? ? ? __asm__ __volatile__ (".word ? ?0xe320f003" : : :
>> > > "memory")
>> > > +#endif
>>
>> We actually have this:
>>
>> #if __LINUX_ARM_ARCH__ >= 7 || ? ? ? ? ?\
>> ? ? ? ? (__LINUX_ARM_ARCH__ == 6 && defined(CONFIG_CPU_32v6K))
>> #define sev() ? __asm__ __volatile__ ("sev" : : : "memory")
>> #define wfe() ? __asm__ __volatile__ ("wfe" : : : "memory")
>> #define wfi() ? __asm__ __volatile__ ("wfi" : : : "memory")
>> #endif
>>
>> in asm/system.h, so maybe it should be using wfe() from asm/system.h
>> ?
> I assume you mean wfi here.
> The problem is, omap2plus build breaks because it builds
> CPU_32v6 and CPU_32v7 as well which doesn't support the wfi
> instruction. Hence I used opcode directly to keep build
> working.

I guess that's right, OMAP2 is ARM1136 and doesn't have the K extensions.

Would it make sense to have the v6 MCR equivalent as an altetnative?
Something like:

#elseif __LINUX_ARM_ARCH__ >= 6
#define wfi()   __asm__ __volatile__ ( \
    "mov     r0, #0\n\t" \
    "mcr     p15, 0, r0, c7, c0, 4\n\t" \
    ::: "r0"
)
#endif

This MCR is a mandatory part of the architecture for v6, but it's not
mandatory for older processors.

Cheers
---Dave
