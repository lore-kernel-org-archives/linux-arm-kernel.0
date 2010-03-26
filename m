From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Mar 2010 22:56:02 +0000
Subject: AACI broken with commit 29a4f2d3
In-Reply-To: <1269608410.807.23.camel@e102109-lin.cambridge.arm.com>
References: <1269438662.29073.121.camel@e102109-lin.cambridge.arm.com>
	<1269443418.29073.147.camel@e102109-lin.cambridge.arm.com>
	<s5h39zou023.wl%tiwai@suse.de>
	<20100325113019.GA6590@n2100.arm.linux.org.uk>
	<s5hvdckskev.wl%tiwai@suse.de> <4BAB4DE8.1030707@mvista.com>
	<1269518557.10064.14.camel@e102109-lin.cambridge.arm.com>
	<20100325121614.GC6590@n2100.arm.linux.org.uk>
	<1269602911.15413.6.camel@localhost.localdomain>
	<1269608410.807.23.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100326225602.GA29179@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 01:00:10PM +0000, Catalin Marinas wrote:
> On Fri, 2010-03-26 at 11:28 +0000, Philby John wrote:
> > --- a/sound/arm/aaci.c
> > +++ b/sound/arm/aaci.c
> > @@ -863,7 +863,11 @@ static int __devinit aaci_probe_ac97(struct aaci *aaci)
> >         struct snd_ac97 *ac97;
> >         int ret;
> > 
> > -       writel(0, aaci->base + AC97_POWERDOWN);
> > +       /*
> > +        * Fix: ac97 read back fail errors by reading
> > +        * from Power down register
> > +        */
> > +       readw(aaci->base + 0x26);
> 
> I still don't understand this. Does aaci->base point to the AACI
> registers? There is no register at offset 0x26 but there is one at 0x24
> (32-bit AACIIE2).

I've covered this several times, and I'm getting sick of saying it.
aaci->base is the base address of the AACI.  aaci->base + 0x26 is a
misaligned address to AACI channel 2 interrupt enable register.

That's the fourth time I've said it.
