From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Dec 2016 13:14:02 -0800
Subject: [RFC PATCH 00/23] arm: defconfigs: use kconfig fragments
In-Reply-To: <8292218.3BDisRkZdU@wuerfel>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
 <CAOesGMi6gqNLUZw_bQZE2foBts0c70z57bHcMVg1hVZ_E4easg@mail.gmail.com>
 <4222703.VA8eKM008t@amdc3058> <8292218.3BDisRkZdU@wuerfel>
Message-ID: <CAOesGMi_mLG+tS0Ya8G9KLO_sUYGtLmgcvFfpn0Nwbd-KMKOrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 7, 2016 at 1:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday, December 7, 2016 12:41:29 PM CET Bartlomiej Zolnierkiewicz wrote:
>>
>> On Tuesday, December 06, 2016 11:03:34 AM Olof Johansson wrote:
>> > On Tue, Dec 6, 2016 at 4:38 AM, Bartlomiej Zolnierkiewicz
>> > <b.zolnierkie@samsung.com> wrote:
>> > > Hi,
>> > >
>> > > This RFC patchset starts convertion of ARM defconfigs to use kconfig
>> > > fragments and dynamically generate defconfigs.  The goals of this
>> > > work are to:
>> >
>> > You don't provide any motivation as to why this is better. As far as I
>>
>> Benefits are:
>>
>> - no code duplication (this initial patchset alone removes ~1700 lines
>>   from defconfigs without any change in functionality)
>
> This may be interesting

Management of the fragments is the big headache here. I haven't seen
any system that does it well downstream either in a way that scales as
far as we'd need it to.

>> - prevention of "multi" defconfigs (i.e. multi_v7_defconfig) going out
>>   of sync with "SoC-family" ones (i.e. exynos_defconfig) - there will
>>   be just one place to update when changing things
>
> I'm not convinced this is worthwhile: in a lot of cases, the soc-specific
> configs want to enable things built-in, while the more generic ones
> tend to use loadable modules.

Agreed.

>> - possibility to add support for more optimized defconfigs (i.e. board
>>   specific ones) in the future without duplicating the code
>
> I'd prefer seeing fewer top-level options than more of them, so
> this doesn't really help.
>
>> - making it easier to define arch specific parts of defconfigs in
>>   the future if we decide on doing it (i.e. we may want to enable
>>   things like CONFIG_SYSVIPC for all defconfigs)
>
> The example you give is for something that should be decided
> in architecture-independent Kconfig language rather than
> per architecture, and that won't require fragments.
>
>> > am concerned it'll just be a mess.
>> >
>> > So:
>> >
>> > Nack. So much nack. I really don't want to see a proliferation of
>> > config fragments like this.
>> >
>> > I had a feeling it was a bad idea to pick up that one line config
>> > fragment before, since it opened the door for this kind of mess.
>>
>> Like I said in the cover-letter I'm not satisfied with the current
>> patches and they have much room for improvement.
>>
>> However I see that you don't like the idea itself...
>
> I do think that there is some room for more config fragments in
> mainline, but not most of the patches you have here. Some areas
> that I think would benefit from fragments are:
>
> - architecture level selection: v6/v6k/v7/v7ve/v8 could have a
>   common defconfig file that starts out with all v6+ enabled,
>   but then having fragments that disable the older architectures
>   and platforms using them while turning on features that are only
>   available on newer architectures
>
> - A "debug" fragment would be nice, to turn on common options that
>   add a lot of useful runtime checks at the expense of performance
>   or code size.

Hmm, some of these might work but several useful debug options (in
particular DEBUG_LL for early errors) are per-system/platform.

> - A "distro" fragment that turns on all loadable modules that are
>   enabled by common distributions (e.g. two or more of
>   debian/fedora/opensuse/gentoo), to let you build a drop-in
>   replacement kernel for a shipping distro. This would also allow
>   the distros to strip their own config files and just specify
>   whatever differs from the others.

Keeping this in sync with the distro kernel could be a bit awkward
(and possibly churny).


-Olof
