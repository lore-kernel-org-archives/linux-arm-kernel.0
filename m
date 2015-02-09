From: peda@axentia.se (Peter Rosin)
Date: Mon, 9 Feb 2015 07:35:50 +0000
Subject: [PATCH v2] ASoC: atmel_ssc_dai: Allow more rates
In-Reply-To: <54D8243C.6090902@atmel.com>
References: <1423050745-6372-1-git-send-email-peda@lysator.liu.se>
 <20150206230951.GL31311@finisterre.sirena.org.uk>
 <9f35349d2e6d47ae977e3e119c5175c6@EMAIL.axentia.se>
 <54D8243C.6090902@atmel.com>
Message-ID: <eefc0f3159f649459f1798c2b0f0f955@EMAIL.axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bo Shen wrote:
> Hi Peter,

Hi!

> On 02/07/2015 06:51 PM, Peter Rosin wrote:
> > Mark Brown wrote:
> >> On Wed, Feb 04, 2015 at 12:52:25PM +0100, Peter Rosin wrote:
> >>
> >>> One thing remains a bit unclear, and that is the 500ppm deduction.
> >>> Is that really warranted? The number was just pulled out of my hat...
> >>
> >> I don't really get what this is supposed to be protecting against.
> >>
> >>> +	case SND_SOC_DAIFMT_CBM_CFS:
> >>> +	case SND_SOC_DAIFMT_CBM_CFM:
> >>> +		t.min = 8000;
> >>> +		t.max = ssc_p->mck_rate / mck_div / frame_size;
> >>> +		/* Take away 500ppm, just to be on the safe side. */
> >>> +		t.max -= t.max / 2000;
> >>> +		t.openmin = t.openmax = 0;
> >>> +		t.integer = 0;
> >>> +		ret = snd_interval_refine(i, &t);
> >>
> >> As I understand it this is a straight divider rather than something
> >> that's doing dithering or anything else more fancy.  Given that it
> >> seems as well just to trust the clock rate we've got - we don't do
> >> any error tracking with the clock API (perhaps we should) and for
> >> many applications some degree of divergence from the nominal rate is
> >> not
> >> *too* bad for audio systems (for application specific values of "some"
> >> and "too" of course).  If it is just dividers I'm not sure the
> >> situation is really improved materially by knocking off the top frequency.
> >>
> >> If we are doing something more fancy than divididing my analysis is
> >> off base of course.
> >
> > I'm thinking that the SSC samples the selected BCK pin using the
> > (possibly
> > divided) peripheral clock. Getting too near the theoretical rate limit
> > would be bad, if these two independent clocks drift the wrong way. At
> > least that is my take on it, but I don't know the internal workings of the SSC, so...
> >
> > I was hoping that someone from Atmel could chime in? Maybe I'm totally
> 
> Sorry for late response.

No problem!

> > off base, and the SSC is doing this completely differently?
> 
> What you mean here? I am not sure I fully understand.

The SSC spec list a maximum rate (which varies with the direction
of various signals, ignoring that for the sake of this explanation). Lets
assume that this maximum rate is 11MHz, derived from the peripheral
clock which might be 66MHz. If you then try to input an 11MHz signal
derived from some unrelated xtal you might think it should work. My
theory was that the rate limit would be broken if the peripheral clock
wasn't really 66MHz, but instead a few ppm lower than nominal, and
the unrelated xtal was a few ppm higher than nominal.

If this matters or not depends on how the SSC is implemented.

There might be other reasons for not caring all that much about
this fringe case, and just trust the nominal rates and limits.

> > In our application, we're not near the limit. Therefore, it really
> > doesn't matter much to us.
> >
> > Should I resend w/o the 500ppm deduction?
> >
> > Cheers,
> > Peter
> >
> 
> Best Regards,
> Bo Shen
