From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 7 Dec 2013 21:21:55 -0500 (EST)
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
In-Reply-To: <CAL_Jsq+7j62ucsA96TbRrFSqHBR5SGUvWeqdsxtUvEtcbtdGyQ@mail.gmail.com>
References: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
 <201312052250.38986.arnd@arndb.de>
 <CAL_JsqLf0Ubi55mc-p0-qPwY0LzHEZ-SF9QwcELkKPfZH=9t_g@mail.gmail.com>
 <201312061741.33427.arnd@arndb.de>
 <CAL_JsqJmwPwVmNzibr8S-RH8ibwCzXVFMdJA-STPTHG+H0113w@mail.gmail.com>
 <20131207181052.GR4360@n2100.arm.linux.org.uk>
 <CAL_Jsq+7j62ucsA96TbRrFSqHBR5SGUvWeqdsxtUvEtcbtdGyQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.10.1312072111410.15948@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 7 Dec 2013, Rob Herring wrote:

> On Sat, Dec 7, 2013 at 12:10 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Dec 06, 2013 at 02:01:51PM -0600, Rob Herring wrote:
> >> On Fri, Dec 6, 2013 at 10:41 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > This prevents you from building a plain v6 SMP kernel, and we've
> >> > had a variation of that since CONFIG_SMP was first marked non-BROKEN.
> >>
> >> I'm saying a v6k enabled kernel would not work on pure v6 h/w. But
> >> since all implementations appear to support doubleword exclusives and
> >> there may not be any pure v6 only h/w, then we may never have a
> >> problem with the code below.
> >
> > I wonder why we have the SMP_ON_UP option.  It's there so that we can
> > do exactly this - build a SMP kernel (so, one for V6K or later) _and_
> > have it run on non-SMP capable V6 platforms.
> 
> Exactly, but __kuser_cmpxchg64 is missing the necessary SMP_ON_UP
> patching or correct ifdef logic. I have yet to get my head around what
> is the right fix here.

The right fix is probably to leave it as is and optimize your user space 
for ARMv6k instead, meaning that this operation would then be 
implemented inline rather than relying on the kernel helper.

Otherwise if you really want to optimize the kernel helper at runtime 
for ARMv6k when ARMv6 is also configured in, then you could do some 
instruction patching in kuser_init() as we already do for getting the 
TLS value.


Nicolas
