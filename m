From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Aug 2011 16:13:33 +0100
Subject: [PATCH v4 00/18] Introduce a led trigger for CPU activity and
	consolidate LED driver in ARM
In-Reply-To: <CAK5ve-JM=01vTqSi59R6ASyGU_2fVXzKtjNh42LKeF2HF3NzSA@mail.gmail.com>
References: <1314349415-889-1-git-send-email-bryan.wu@canonical.com>
	<CACRpkda6-8dxSbF12N-Q32cOpogu-ZZmTApnvNBa03iOcEeqaQ@mail.gmail.com>
	<CAK5ve-JM=01vTqSi59R6ASyGU_2fVXzKtjNh42LKeF2HF3NzSA@mail.gmail.com>
Message-ID: <20110829151333.GA17887@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 09:18:29PM +0800, Bryan Wu wrote:
> On Mon, Aug 29, 2011 at 7:00 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Aug 26, 2011 at 11:03 AM, Bryan Wu <bryan.wu@canonical.com> wrote:
> >
> >> Based on Linus Walleij's ARM LED consolidation work, this patchset introduce a
> >> new generic led trigger for CPU not only for ARM but also for others.
> >
> > I think Russell was pretty clear that he saw problems inside the "new LEDs"
> > subsystem (drivers/leds) that need be fixed before we migrate this support
> > to use the LED class devices.
> >
> > Can you see if you can address his comment on the earlier realview patch,
> > i.e. this:
> > http://marc.info/?l=linux-arm-kernel&m=131237280009775&w=2
> >
> 
> Yeah, I replied that email with a patch to select LEDS_CLASS when
> CONFIG_NEW_LEDS=y.

I don't see any point to that:

menuconfig NEW_LEDS
        bool "LED Support"
	select LEDS_CLASS

if NEW_LEDS

config LEDS_CLASS
        bool "LED Class Support"
        help
          This option enables the led sysfs class in /sys/class/leds.  You'll
          need this to do anything useful with LEDs.  If unsure, say N.

So, with that select there, you either have NEW_LEDS=y LEDS_CLASS=y
or NEW_LEDS=n LEDS_CLASS=n.  To put it another way, you can't select
LEDS_CLASS when NEW_LEDS=n, and you can't deselect LEDS_CLASS when
NEW_LEDS=y.

So, either the LEDS_CLASS option is completely pointless, which means
it should be killed off, or LEDS_CLASS needs to be fixed so that it
actually does what it says in its help text and controls whether we
have a LEDS sysfs class _without_ affecting the ability to have
triggers setup by platform code.

What it can't do is stay as-is, because it's clearly broken and the
options help texts don't match reality.
