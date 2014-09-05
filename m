From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Fri, 5 Sep 2014 14:22:18 -0400
Subject: [PATCH 1/2] arm64: psci: respect MIGRATE_INFO_TYPE
In-Reply-To: <20140905141345.GF20164@leverpostej>
References: <1409915540-20044-1-git-send-email-mark.rutland@arm.com>
 <1409915540-20044-2-git-send-email-mark.rutland@arm.com>
 <CAJ5Y-eZqWsLT1ERWsdzCQASgzCfFTgn6fCBCpc7ceMoU2ONkNA@mail.gmail.com>
 <20140905141345.GF20164@leverpostej>
Message-ID: <CAJ5Y-eb3jJSaR4VCPFe+A+PVbLAbyVGBAcb+_zsOQQ=Rhk9Q0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 September 2014 10:13, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Sep 05, 2014 at 02:50:44PM +0100, Ashwin Chaugule wrote:
>> On 5 September 2014 07:12, Mark Rutland <mark.rutland@arm.com> wrote:
>> > Commit e71246a23acb (PSCI: Add initial support for PSCIv0.2 functions)
>> > added hooks for MIGRATE_INFO_TYPE, but didn't call it anywhere. This
>> > means that currently a UP Trusted OS can reject CPU_OFF calls, which
>> > will cause things to blow up.
>> >
>> > This patch ensures we test MIGRATE_INFO_TYPE before calling CPU_OFF. If
>> > there's a UP trusted OS hotplug is rejected. Full support for PSCI in
>> > the presence of a UP trusted OS will require the use of MIGRATE and will
>> > have to come as a later patch.
>> >
>> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> > Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> > Cc: Rob Herring <robh@kernel.org>
>> > Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
>> > Cc: Ian Campbell <ian.campbell@citrix.com>
>> > Cc: Christoffer Dall <christoffer.dall@linaro.org>
>> > Cc: Will Deacon <will.deacon@arm.com>
>> > Cc: Catalin Marinas <catalin.marinas@arm.com>
>> > ---
>> >  arch/arm64/kernel/psci.c | 14 ++++++++++++++
>> >  1 file changed, 14 insertions(+)
>> >
>> > diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
>> > index 5539547..a5407af 100644
>> > --- a/arch/arm64/kernel/psci.c
>> > +++ b/arch/arm64/kernel/psci.c
>> > @@ -386,6 +386,20 @@ static int cpu_psci_cpu_disable(unsigned int cpu)
>> >         /* Fail early if we don't have CPU_OFF support */
>> >         if (!psci_ops.cpu_off)
>> >                 return -EOPNOTSUPP;
>> > +
>> > +       /*
>> > +        * In the presence of a UP trusted OS, it might not be possible to
>> > +        * hotplug certain CPUs, and CPU_OFF may return (which would be bad).
>> > +        * Supporting a UP trusted OS requires careful use of
>> > +        * MIGRATE_INFO_UP_CPU and MIGRATE, so for now fail in the presence of
>> > +        * a UP Trusted OS.
>> > +        */
>> > +       if (psci_ops.migrate_info_type &&
>> > +               psci_ops.migrate_info_type() != PSCI_0_2_TOS_MP) {
>> > +                       pr_warn("Unable to handle UP trusted OS\n");
>> > +                       return -EPERM;
>> > +       }
>> > +
>>
>> Guessing there is no way for us to know which CPU the UP TOS is
>> running on and only deny hotplug on that CPU?
>
> In the comment above I mention we can use MIGRATE_INFO_UP_CPU for that.
> I started down that route, but the plumbing for it ended up looking a
> little crazy so I thought it was better for the moment to have a simple
> solution that we can backport to stable.

Ah. I faintly recollect experiencing similar craziness when I was
adding v0.2 support.

>
> No systems with a UP trusted OS (migrateable or not) have hit my radar
> yet, and we're currently broken for them anyhow. So for the moment it
> didn't seem worthwhile implementing support for those. We can add the
> requisite MIGRATE_INFO_UP_CPU and MIGRATE calls in a later series.

Ok.

Acked-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>

Cheers,
Ashwin
