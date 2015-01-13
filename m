From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 13 Jan 2015 14:12:55 +0000
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <20150112193905.GB5281@amd>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel>
 <CACxGe6vRN2Tc97=Sx05gri02goxBaHnZm30hR37q=002agFLAA@mail.gmail.com>
 <CACxGe6sbGu53x5rsx2sWVVVVCnnFvmkQAk3Se9ZGNOXCkqpi=A@mail.gmail.com>
 <20150112142358.GA23680@amd>
 <CACxGe6ub0UsUNs1-2NziK_sGEtpxTjcDD+Eto3YOsNkvWxaNcw@mail.gmail.com>
 <20150112193905.GB5281@amd>
Message-ID: <CACxGe6tTTu5mSbixDWp7SdPzHVKDsvaT8BAEufygz-2ZgPHaVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 7:39 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2015-01-12 14:41:50, Grant Likely wrote:
>> On Mon, Jan 12, 2015 at 2:23 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> > On Sat 2015-01-10 14:44:02, Grant Likely wrote:
>> >> On Wed, Dec 17, 2014 at 10:26 PM, Grant Likely <grant.likely@linaro.org> wrote:
>> >> > On Tue, Dec 16, 2014 at 11:27 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> >> On Monday 15 December 2014 19:18:16 Al Stone wrote:
>> >> >>> 7. Why is ACPI required?
>> >> >>>    * Problem:
>> >> >>>      * arm64 maintainers still haven't been convinced that ACPI is
>> >> >>>        necessary.
>> >> >>>      * Why do hardware and OS vendors say ACPI is required?
>> >> >>>    * Status: Al & Grant collecting statements from OEMs to be posted
>> >> >>>      publicly early in the new year; firmware summit for broader
>> >> >>>      discussion planned.
>> >> >>
>> >> >> I was particularly hoping to see better progress on this item. It
>> >> >> really shouldn't be that hard to explain why someone wants this feature.
>> >> >
>> >> > I've written something up in as a reply on the firmware summit thread.
>> >> > I'm going to rework it to be a standalone document and post it
>> >> > publicly. I hope that should resolve this issue.
>> >>
>> >> I've posted an article on my blog, but I'm reposting it here because
>> >> the mailing list is more conducive to discussion...
>> >>
>> >> http://www.secretlab.ca/archives/151
>> >
>> > Unfortunately, I seen the blog post before the mailing list post, so
>> > here's reply in blog format.
>> >
>> > Grant Likely published article about ACPI and ARM at
>> >
>> > http://www.secretlab.ca/archives/151
>> >
>> > . He acknowledges systems with ACPI are harder to debug, but because
>> > Microsoft says so, we have to use ACPI (basically).
>>
>> Please reread the blog post. Microsoft is a factor, but it is not the
>> primary driver by any means.
>
> Ok, so what is the primary reason? As far as I could tell it is
> "Microsoft wants ACPI" and "hardware people want Microsoft" and
> "fragmentation is bad so we do ACPI" (1) (and maybe "someone at RedHat
> says they want ACPI" -- but RedHat people should really speak for
> themselves.)

The primary driver is abstraction. It is a hard requirement of the
hardware vendors. They have to have the ability to adapt their
products at a software level to support existing Linux distributions
and other operating system releases. This is exactly what they do now
in the x86 market, and they are not going to enter the ARM server
market without this ability.

Even if DT was chosen, the condition would have been to add an
abstraction model into DT, and then DT would end up looking like an
immature ACPI.

The secondary driver is consistency. When hardware vendors and OS
vendors produce independent products for the same ecosystem that must
be compatible at the binary level, then it is really important that
everyone in that ecosystem uses the same interfaces. At this level it
doesn't matter if it is DT or ACPI, just as long as everyone uses the
same thing.

[Of course, vendors have the option of completely rejecting the server
specifications as published by ARM, with the understanding that they
will probably need to either a) ship both the HW and OS themselves, or
b) create a separate and competing ecosystem.]

If the reason was merely as you say, "because Microsoft says so", then
my blog post would have been much shorter. I would have had no qualms
about saying so bluntly if that was actually the case. Instead, this
is the key paragraph to pay attention to:

> > However, the enterprise folks don't have that luxury. The platform/kernel split isn't a design choice. It is a characteristic of the market. Hardware and OS vendors each have their own product timetables, and they don't line up. The timeline for getting patches into the kernel and flowing through into OS releases puts OS support far downstream from the actual release of hardware. Hardware vendors simply cannot wait for OS support to come online to be able to release their products. They need to be able to work with available releases, and make their hardware behave in the way the OS expects. The advantage of ACPI OSPM is that it defines behaviour and limits what the hardware is allowed to do without involving the kernel.

All of the above applies regardless of whether or not vendors only
care about Linux support. ACPI is strongly desired regardless of
whether or not Microsoft is in the picture. Their support merely adds
weight behind an argument that is already the choice preferred by
hardware vendors.

> You snipped quite a lot of reasons why ACPI is inferior that were
> below this line in email.

Yes, I did. My primary point is that ACPI was chosen because the
hardware OEMs require some level of abstraction. If you don't agree
that the abstraction is important, then we fundamentally don't agree
on what the market looks like. In which case there is absolutely no
value in debating the details because each of us are working from a
different set of requirements.

>                                                                         Pavel
>
> (1) ignoring fact that it causes fragmentation between servers and phones.

That's a red herring. ARM servers are not an extension of the ARM
phone market. The software ecosystem is completely different (the
phone vendor builds and ships the OS instead of being provided by one
of many independent OS vendors). ARM servers are an extension of the
x86 server market, and they will be judged in terms of how they
compare to a similar x86 machine. It is in the HW vendors best
interest to make using an ARM server as similar to their existing x86
products as possible.

When confronted with the choice of similarity with ARM phones or with
from x86 servers, the vendors will chose to follow x86's lead, and
they will be right to do so.
