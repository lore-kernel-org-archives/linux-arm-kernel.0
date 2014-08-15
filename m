From: olof@lixom.net (Olof Johansson)
Date: Thu, 14 Aug 2014 18:02:33 -0700
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <8599266.1aeEWcB8r7@wuerfel>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <53EC2B35.5010302@linaro.org> <20140814102723.GB9039@arm.com>
 <8599266.1aeEWcB8r7@wuerfel>
Message-ID: <CAOesGMiOzRYmmYcBV=eFr8U-e_BJAUg9gpnT0DPwJuyxBz9-1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 1:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 14 August 2014 11:27:23 Catalin Marinas wrote:
>> On Thu, Aug 14, 2014 at 04:21:25AM +0100, Hanjun Guo wrote:
>> > On 2014-8-14 7:41, Rafael J. Wysocki wrote:
>> > > On Tuesday, August 12, 2014 07:23:47 PM Catalin Marinas wrote:
>> > >> If we consider ACPI unusable on ARM but we still want to start merging
>> > >> patches, we should rather make the config option depend on BROKEN
>> > >> (though if it is that unusable that no real platform can use it, I would
>> > >> rather not merge it at all at this stage).
>> > >
>> > > I agree here.
>> > >
>> > > I would recommend creating a separate branch for that living outside of the
>> > > mainline kernel and merging it when there are real users.
>> >
>> > Real users will coming soon, we already tested this patch set on real hardware
>> > (ARM64 Juno platform),
>>
>> I don't consider Juno a server platform  (but it's good enough for
>> development).
>
> I would expect that Juno is a superset of what servers need. If this
> ACPI patch set is sufficient to support every device present on Juno
> with an ACPI firmware, what would be a strong indication that server
> platforms work as well.
>
> OTOH, if ACPI on Juno only supports half the features that the hardware
> has, that doesn't tell us much about the suitability of ACPI for any
> real-world system, server or not.

Juno is lacking in several components compared to a server platform,
it doesn't have PCIe, SATA, or real ethernet. So it's in many ways
just a few cores with RAM and a few slow interfaces.

The scary parts from the ACPI 5.1 docs (the peripheral ones in
particular) are around the modelling of clocks and other things that
we thought ACPI was going to stay away from. Until we see how steep
that slope is, we're better off taking it easy with merging the
support. It could get quite messy very quickly, and we'd be stuck
supporting whatever solutions are tried in the first ACPI generations
forever if we do enable them now. That's the main reason for holding
off and being conservative (and seeing several real platforms and how
they end up modelling these things).

As I've also commented on some of the documents, I am not excited
about how the ACPI platform code is integrated: Add some ACPI
functions in an acpi-only file that exports some variables. Then, in a
shared file, create a completely separate code path that uses said
variables to do whatever it needs. I'm not crazy at all at the split
of code paths between the platforms, and I want to see it more data
driven (filling in shared structures and sharing code paths). There
are some challenges to make that happen but I also don't think there's
been a whole lot of effort to make it happen -- the ACPI developers
don't seem to like touching the DT code paths to make them fit better.
:-)

>> > and I think ARM64 server chips and platforms will show up before 3.18
>> > is released.
>>
>> That's what I've heard/seen. The questions I have are (a) whether
>> current ACPI patchset is enough to successfully run Linux on such
>> _hardware_ platform (maybe not fully optimised, for example just WFI
>> cpuidle) and (b) whether we still want to mandate a DT in the kernel for
>> such platforms.
>>
>> Given the answer to (a) and what other features are needed, we may or
>> may not mandate (b). We were pretty clear few months ago that (b) is
>> still required but at the time we were only openly talking about ACPI
>> 5.0 which was lacking many features. I think we need to revisit that
>> position based on how usable ACPI 5.1 for ARM (and current kernel
>> implementation) is. Would you mind elaborating what an ACPI-only
>> platform miss?
>>
>> I would expect a new server platform designed with ACPI in mind to
>> require minimal SoC specific code, so we may only see a few patches
>> under drivers/ for such platforms adding ACPI-specific probing (possibly
>> new drivers as well if it's a new component).
>
> That is at least the hope, but I have no way of knowing whether it
> works that way or not, other than seeing the actual patches.
>
> It is rather annoying that we first have to wait for hardware
> to become available to actually see that code, but I guess that
> means that those hardware vendors no longer see ACPI as something
> on their critical path, so we definitely shouldn't hurry things
> until we understand the reason for the endless delay of platform
> support patches.

I've tried reaching out to several vendors but I've heard nothing back
from any of them. Very disappointing.

It is quite concerning that they are not willing to talk to the
community, but it also makes it easy to decide what kind of priority
we should put on reviewing and merging their patches when they do get
posted -- their lack of planning does not constitute an emergency on
our behalf.


-Olof
