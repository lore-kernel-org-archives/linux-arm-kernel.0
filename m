From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2016 13:41:20 +0200
Subject: [PATCH 1/2] char: PC rtc: replace blacklist with whitelist
In-Reply-To: <CAMuHMdWQiqNq7-fgn5NONovLQxhOoGD5s-TAYVYZOVRfEs52Zg@mail.gmail.com>
References: <1456912137-1578635-1-git-send-email-arnd@arndb.de>
 <4192558.Mh1hb3LCLb@wuerfel>
 <CAMuHMdWQiqNq7-fgn5NONovLQxhOoGD5s-TAYVYZOVRfEs52Zg@mail.gmail.com>
Message-ID: <5528499.2P7TrvXfau@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2016 09:09:55 Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> cc linux-m68k
> 
> On Sun, Apr 17, 2016 at 11:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 02 March 2016 11:22:04 Geert Uytterhoeven wrote:
> >> On Wed, Mar 2, 2016 at 10:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > Every new architecture has to add itself to the growing list of those
> >> > that do not support the legacy PC RTC driver.
> >> >
> >> > This replaces the long list of architectures that don't support it
> >> > with a shorter list of those that do.
> >> >
> >> > The list is taken from those architectures that have a non-empty
> >> > asm/mc146818rtc.h header file and were not explicitly blacklisted.
> >>
> >> M68K was blacklisted...
> >
> > I never got back to you on this topic, sorry about that. I've fixed
> > up the patch to leave out m68k now.
> >
> > On a semi-related note, I see that m68k is one of the few architectures
> > still using the (other) genrtc driver. It would be nice to reduce that
> > list and change m68k to use its own rtc driver (ideally one per
> 
> We do have hp_sdc_rtc (HP9000/300; why is that under drivers/input/misc/?),
> and rtc-msm6242 and rtc-rp5c01 (both for Amiga).

fwiw, the hp_sdc_rtc driver does not actually implement the RTC ioctls
(they are there, but commented out).

The other ones are good, you just have two incompatible ways of doing
it because the drivers/rtc subsystem is can not be built into the
kernel at the same time as the old gen_rtc driver for the q40.

> > platform), but the q40 platform is the only one providing
> > get_rtc_pll()/set_rtc_pll() for the RTC_PLL_GET/RTC_PLL_SET ioctl
> > commands.
> 
> Do you mean this is a problem?

Not a big one, assuming that either nobody actually needs these ioctls
(very likely), or they don't care about having a single kernel for
q40 and the other platforms.

The main issue I see is migrating architectures over from gen_rtc to
rtc-generic over time, but this effort has been going on for at least
a decade and there is no rush, but it would still be nice.

	Arnd
