From: keescook@chromium.org (Kees Cook)
Date: Mon, 23 Apr 2018 09:30:21 -0700
Subject: Reporting more CPU features in /proc/cpuinfo
In-Reply-To: <20180423145935.2xw5dsvlmxsxzksk@lakrids.cambridge.arm.com>
References: <CAGXu5jKpU+pCi_S9PPqG9pYezkzjekXPohyBXJmXe87GqCEGnw@mail.gmail.com>
 <520006aa-4b67-eb77-253e-4c9dc4aa3329@codeaurora.org>
 <20180423145935.2xw5dsvlmxsxzksk@lakrids.cambridge.arm.com>
Message-ID: <CAGXu5jJEasg4UfVFy7w97q5-fxGNx2KF8WkOf5MSsWRFXqrLvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 7:59 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Apr 23, 2018 at 08:20:43AM -0600, Jeffrey Hugo wrote:
>> On 4/20/2018 2:04 PM, Kees Cook wrote:
>> > Hi!
>> >
>> > I'd like to have more CPU features visible in /proc/cpuinfo so it's
>> > possible to determine from userspace if the running system has various
>> > defenses. For example, I'd like to know that a device has hardware PXN
>> > and PAN. (I'd love to see emulated features listed separately too, but
>> > I could imagine that not being a great match for /proc/cpuinfo.)
>> >
>> > One specific reason for this to do basic feature testing from
>> > userspace without needing to catch the boot-time dmesg output. For
>> > example, being able to answer the question "Does this system provide
>> > PAN?" The answer is yes if either emulated PAN is visible in
>> > /proc/config.gz or if hw PAN Is provided by the CPU (which I'd expect
>> > to discover via /proc/cpuinfo like on x86 for things like SMAP).
>> >
>> > Thoughts?
>> >
>> > -Kees
>>
>> I too, would like to see /proc/cpuinfo to be more useful, but last time this
>> was brought up by Al Stone[1], there was significant pushback from Mark.
>>
>> Maybe Mark has changed his position since then?
>>
>> [1] https://lkml.org/lkml/2017/9/26/786
>
> The big deal is that we cannot change the format of /proc/cpuinfo, i.e.
> no new fields, or changes to the format of existing fields. Nothing has
> changed there.
>
> It's fine to add new hwcaps, so the question is whether PXN and PAN
> should have hwcaps. It would be rather unusual, especially for SW PAN,
> but that's not a hard NAK from me.

I don't mind leaving SW PAN off the hwcaps list; that was just a
fleeting thought. :)

I would, though, like to be able to trivially discover hw support for
PXN, PAN, pointer authentication, etc etc.

> Kees, when does this information matter? e.g. is this some compliance
> test, or something that would run at arbitrary times on a given system?

The driving reason for me bringing this up is the need for Android
devices to pass (new) CTS tests that check for the CDD requirements of
PXN and PAN[1]. Obviously it's not a functional test, but providing a
functional test interface (e.g. LKDTM) on a production device is
undesirable, so being able to answer the easy question "is it expected
to work on this hardware?" is the next best thing.

As this is discoverable already on x86 in /proc/cpuinfo, it seemed
like the best place to do it for ARM. I could cook up some patches if
this is okay? (Though on a quick look, it wasn't entirely obvious how
to tie the boot-time checks with the cpuinfo hwcaps, but I suspect I
just need to look at it longer, or maybe someone has pointers.)

Thanks!

-Kees

[1] https://source.android.com/compatibility/8.1/android-8.1-cdd#9_7_kernel_security_features

-- 
Kees Cook
Pixel Security
