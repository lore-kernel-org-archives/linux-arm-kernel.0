From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 21 Nov 2009 20:28:40 +0100
Subject: [GIT PULL] iop clocksource support for 2.6.33
In-Reply-To: <63386a3d0911210933g7b7f58faxa79b22e693a8e65a@mail.gmail.com>
References: <1258754448.4011.9.camel@dwillia2-linux.ch.intel.com>
	<63386a3d0911210933g7b7f58faxa79b22e693a8e65a@mail.gmail.com>
Message-ID: <19208.16232.995772.78465@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij writes:
 > 2009/11/20 Dan Williams <dan.j.williams@intel.com>:
 > 
 > (...)
 > 
 > > +static void __init iop_clocksource_set_hz(struct clocksource *cs, unsigned int hz)
 > > +{
 > > + ? ? ? u64 temp;
 > > + ? ? ? u32 shift;
 > > +
 > > + ? ? ? /* Find shift and mult values for hz. */
 > > + ? ? ? shift = 32;
 > > + ? ? ? do {
 > > + ? ? ? ? ? ? ? temp = (u64) NSEC_PER_SEC << shift;
 > > + ? ? ? ? ? ? ? do_div(temp, hz);
 > > + ? ? ? ? ? ? ? if ((temp >> 32) == 0)
 > > + ? ? ? ? ? ? ? ? ? ? ? break;
 > > + ? ? ? } while (--shift != 0);
 > > +
 > > + ? ? ? cs->shift = shift;
 > > + ? ? ? cs->mult = (u32) temp;
 > > +
 > > + ? ? ? printk(KERN_INFO "clocksource: %s uses shift %u mult %#x\n",
 > > + ? ? ? ? ? ? ?cs->name, cs->shift, cs->mult);
 > > +}
 > 
 > (...)
 > 
 > > +static void __init iop_clockevent_set_hz(struct clock_event_device *ce, unsigned int hz)
 > > +{
 > > + ? ? ? u64 temp;
 > > + ? ? ? u32 shift;
 > > +
 > > + ? ? ? /* Find shift and mult values for hz. */
 > > + ? ? ? shift = 32;
 > > + ? ? ? do {
 > > + ? ? ? ? ? ? ? temp = (u64) hz << shift;
 > > + ? ? ? ? ? ? ? do_div(temp, NSEC_PER_SEC);
 > > + ? ? ? ? ? ? ? if ((temp >> 32) == 0)
 > > + ? ? ? ? ? ? ? ? ? ? ? break;
 > > + ? ? ? } while (--shift != 0);
 > > +
 > > + ? ? ? ce->shift = shift;
 > > + ? ? ? ce->mult = (u32) temp;
 > > +
 > > + ? ? ? printk(KERN_INFO "clockevent: %s uses shift %u mult %#lx\n",
 > > + ? ? ? ? ? ? ?ce->name, ce->shift, ce->mult);
 > > ?}
 > 
 > I only recently annoyed TGLX enough to have this generified from the MIPS
 > versions in a few recent patches visible in linux-next.
 > 
 > Not that it can't be fixed afterwards, so no blocker.

If/when Linus' tree has both the iop clocks update and Thomas'
update to make the MIPS shift/mult compute functions generic,
I'll send in a cleanup to make iop's time code use the new generic
functions instead (I've already tested that combo). The iop update
does not conflict with Thomas', but there will temporarily be a
little bit of code duplication.
