From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 8 May 2012 13:40:42 +0200 (CEST)
Subject: smp_twd fix for adapting to cpu frequency change
In-Reply-To: <CACRpkdZzAO4hAJKyAoeqnud9LeDG4nSK7y9cLZaEBdVOnq-ocw@mail.gmail.com>
References: <CAPub14_+XXjKyZVh3E8QQjY4sB4gVB=kaApuODptoizqfEUH_Q@mail.gmail.com>
 <CACRpkdZzAO4hAJKyAoeqnud9LeDG4nSK7y9cLZaEBdVOnq-ocw@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1205081337260.6271@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 May 2012, Linus Walleij wrote:
> I guess clockevents_update_freq() could just call
> the .set_mode() function for periodic mode again, but that
> seems a bit ugly, since the modeset code might do other things
> than just reinitialize the timer. And it won't account for the
> running event.
>  
> So this solution will try to do what you describe, but I'm
> still a bit uncertain, since the currently running event will
> probably use the old load value, then the new value won't get
> used until the next event. Maybe that's fair enough?
> 
> I don't know it it's OK for driver code to inspect the internal
> clockevent mode like this code does though, maybe Thomas
> has opinions on this...
> 
> Can you test this snippet?
> Thomas: does this look sane?

In principle yes, but this should be really done from the core code
with an extra callback, eg. update_freq(), which is then called from
clockevents_update_freq() in periodic mode.

Thanks,

	tglx
