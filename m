From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 23 Apr 2018 17:48:29 +0100
Subject: Reporting more CPU features in /proc/cpuinfo
In-Reply-To: <CAGXu5jJEasg4UfVFy7w97q5-fxGNx2KF8WkOf5MSsWRFXqrLvg@mail.gmail.com>
References: <CAGXu5jKpU+pCi_S9PPqG9pYezkzjekXPohyBXJmXe87GqCEGnw@mail.gmail.com>
 <520006aa-4b67-eb77-253e-4c9dc4aa3329@codeaurora.org>
 <20180423145935.2xw5dsvlmxsxzksk@lakrids.cambridge.arm.com>
 <CAGXu5jJEasg4UfVFy7w97q5-fxGNx2KF8WkOf5MSsWRFXqrLvg@mail.gmail.com>
Message-ID: <20180423164828.od3f2d543z3uffvi@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 09:30:21AM -0700, Kees Cook wrote:
> On Mon, Apr 23, 2018 at 7:59 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Apr 23, 2018 at 08:20:43AM -0600, Jeffrey Hugo wrote:
> >> On 4/20/2018 2:04 PM, Kees Cook wrote:
> >> > Hi!
> >> >
> >> > I'd like to have more CPU features visible in /proc/cpuinfo so it's
> >> > possible to determine from userspace if the running system has various
> >> > defenses. For example, I'd like to know that a device has hardware PXN
> >> > and PAN. (I'd love to see emulated features listed separately too, but
> >> > I could imagine that not being a great match for /proc/cpuinfo.)
> >> >
> >> > One specific reason for this to do basic feature testing from
> >> > userspace without needing to catch the boot-time dmesg output. For
> >> > example, being able to answer the question "Does this system provide
> >> > PAN?" The answer is yes if either emulated PAN is visible in
> >> > /proc/config.gz or if hw PAN Is provided by the CPU (which I'd expect
> >> > to discover via /proc/cpuinfo like on x86 for things like SMAP).
> >> >
> >> > Thoughts?
> >> >
> >> > -Kees
> >>
> >> I too, would like to see /proc/cpuinfo to be more useful, but last time this
> >> was brought up by Al Stone[1], there was significant pushback from Mark.
> >>
> >> Maybe Mark has changed his position since then?
> >>
> >> [1] https://lkml.org/lkml/2017/9/26/786
> >
> > The big deal is that we cannot change the format of /proc/cpuinfo, i.e.
> > no new fields, or changes to the format of existing fields. Nothing has
> > changed there.
> >
> > It's fine to add new hwcaps, so the question is whether PXN and PAN
> > should have hwcaps. It would be rather unusual, especially for SW PAN,
> > but that's not a hard NAK from me.
> 
> I don't mind leaving SW PAN off the hwcaps list; that was just a
> fleeting thought. :)
> 
> I would, though, like to be able to trivially discover hw support for
> PXN, PAN, pointer authentication, etc etc.

Luckily, you can always assume PXN is present. That's always part of
ARMv8, and IIRC we've used that for user mappings since day one of the
arm64 port. :)

I appreciate you're after a general mechanism to do this, though.

For pointer authentication, the ID_AA64ISAR1_EL1.{API,APA} register
fields can be read from userspace, and when the APIA hwcap is set, this
means that userspace can make use of instructions which use APIAKey_EL0.

For PAN we currently mask the ID_AA64MMFR1_EL1.PAN when read by
userspace. Maybe we should revisit the policy on what to expose.

> > Kees, when does this information matter? e.g. is this some compliance
> > test, or something that would run at arbitrary times on a given system?
> 
> The driving reason for me bringing this up is the need for Android
> devices to pass (new) CTS tests that check for the CDD requirements of
> PXN and PAN[1]. Obviously it's not a functional test, but providing a
> functional test interface (e.g. LKDTM) on a production device is
> undesirable, so being able to answer the easy question "is it expected
> to work on this hardware?" is the next best thing.
> 
> As this is discoverable already on x86 in /proc/cpuinfo, it seemed
> like the best place to do it for ARM. I could cook up some patches if
> this is okay? (Though on a quick look, it wasn't entirely obvious how
> to tie the boot-time checks with the cpuinfo hwcaps, but I suspect I
> just need to look at it longer, or maybe someone has pointers.)

If we're ok with exposing hwcaps, I believe this would just require
entries in the arm64_elf_hwcaps array.

Perhaps we should consider exposing the raw ID register values under
sysfs for cases like this?

Thanks,
Mark.
