From: olof@lixom.net (Olof Johansson)
Date: Fri, 15 Nov 2013 13:44:17 -0800
Subject: ACPI vs DT at runtime
In-Reply-To: <201311152158.32644.arnd@arndb.de>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <201311152158.32644.arnd@arndb.de>
Message-ID: <CAOesGMhkCn2zeJj_ZZAZu_wJya-4evWEqNHpVJEpjxzWHVWY3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 12:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 15 November 2013, Olof Johansson wrote:
>> So, I'm strongly urging that whatever the server guys try to do, it
>> will in the end result in the ACPI data being translated into DT
>> equivalents, such that the kernel only needs to handle data via DT.
>
> I don't think that a translation layer is the answer, I see the problem
> more in things that cannot be translated automatically. The parts that
> are similar enough to allow translation could also just be handled by
> a thin abstraction layer in the kernel, which I think we will see
> on embedded x86 with DT-in-ACPI-syntax.

I'm not so sure that converting everything yet again to another
abstraction layer is a good solution. We've got one level of
abstraction today -- DT. And we've got the un-abstracted layer of
platform devices. Churning all drivers yet again seems like the wrong
way to do this. For things that we can pre-populate instead of adding
runtime abstraction, we should.

> I think we can still treat ACPI on ARM64 as a beginner's mistake and
> provide hand-written DT blobs for the few systems that start shipping
> with that.

I think we can do better -- we can ask those vendors to not ship ACPI
at all, and ship DT themselves (together with us for review, etc).
Especially since doing a broken ACPI implementation today _just for
us_ will just distract them. If they need one for RT, fine. As I
mentioned elsewhere, shipping a flashed DTB is no different from
shipping ACPI from a future-proof point of view; we'll end up
overriding either at some point once we figure out things better.

> The main reason for doing it in the first place was the
> expected number of Windows RT servers, but WinRT isn't doing well
> at the moment, so it's not unreasonable to assume it's going the same
> way as WinRT tablets.

It's sort of impossible to tell today. Since there are no ARM64
servers on the market, there's no market for RT on them. Nor are there
any machines that can be acquired to look at how they implemented
stuff. And the silicon vendors who have started doing some of this
work are mostly doing it in secret on their own.

> During the kernel summit, Grant (as one of the proponents of doing
> ACPI on ARM) already mentioned that he only sees this as viable
> on PC-like systems. My feeling is that when (if?) AMD or someone else
> comes out with a server system where they basically replace the
> x86 core with an ARM one but keep the system design, there won't
> be much to describe in terms of internal components anyway, and also
> no need to translate a lot of device information -- everything is
> already a PCI device in that case and does not get handled through
> the platform bus.

i2c devices and several other things are not probable, either are ECs
on LPC, etc. All of those mostly fall into the category of
simple-to-describe-in-any-format though.

> However, until we see code or system-level specs
> for such a system, I'd rather keep ACPI out of the ARM kernel so we
> don't give people the wrong ideas.

Strong agreement from me.


-Olof
