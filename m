From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 14:35:01 +0100
Subject: [PATCH 01/17] leds: create a trigger for CPU activity
In-Reply-To: <CAMPhdO9QmCpGFB8fd5Rp-a0iAv1ByA962FZKOwc59R86OTpxAQ@mail.gmail.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-2-git-send-email-bryan.wu@canonical.com>
	<CAMPhdO9QmCpGFB8fd5Rp-a0iAv1ByA962FZKOwc59R86OTpxAQ@mail.gmail.com>
Message-ID: <20110706133501.GY8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 09:16:47PM +0800, Eric Miao wrote:
> On Wed, Jul 6, 2011 at 8:34 PM, Bryan Wu <bryan.wu@canonical.com> wrote:
> > + ? ? ? switch (ledevt) {
> > + ? ? ? case CPU_LED_START:
> > + ? ? ? case CPU_LED_IDLE_START:
> > + ? ? ? ? ? ? ? /* Will turn the LED on, max brightness */
> > + ? ? ? ? ? ? ? if (trigdata->led)
> > + ? ? ? ? ? ? ? ? ? ? ? led_set_brightness(trigdata->led,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?trigdata->led->max_brightness);
> > + ? ? ? ? ? ? ? break;
> > +
> > + ? ? ? case CPU_LED_STOP:
> > + ? ? ? case CPU_LED_IDLE_END:
> > + ? ? ? case CPU_LED_HALTED:
> > + ? ? ? ? ? ? ? /* Will turn the LED off */
> > + ? ? ? ? ? ? ? if (trigdata->led)
> > + ? ? ? ? ? ? ? ? ? ? ? led_set_brightness(trigdata->led, LED_OFF);
> > + ? ? ? ? ? ? ? break;
> > +
> > + ? ? ? default:
> > + ? ? ? ? ? ? ? /* Will leave the LED as it is */
> > + ? ? ? ? ? ? ? break;
> > + ? ? ? }
> > +}
> 
> I'm a bit worrying about the LED brightness hardcoded here, what if
> a platform requires different behavior, e.g. LED_OFF when IDLE_START.

Indeed - there are platforms (Netwinder, Assabet etc) which use LED=ON
to mean that the system is not idle - and also turn the LED on when
halted.

A change of behaviour could be fairly disasterous too.  Eg, some people
use Netwinders in a stand-alone mode, and getting the LED behaviour correct
is _critical_ as it is the only display that some people may see - and
they may use that display to decide whether they can pull the power after
shutdown.  Changing it may mean that they end up pulling the power while
the system is still alive.
