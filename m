From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Mon, 6 Feb 2017 16:02:30 +0000
Subject: [PATCH] ARM: shmobile: r7s72100: Enable L2 cache
In-Reply-To: <CAMuHMdW0-KPEKS5wFRK7aRKwvvUcjQDa7Rmo0cDDwnfGAAmJ5w@mail.gmail.com>
References: <20170202212000.10768-1-chris.brandt@renesas.com>
 <CAMuHMdU6kJDxGtjUT1S2JkQTLvzrgtF3mkqa5Xo08oF6d3tUbw@mail.gmail.com>
 <SG2PR06MB11657125A12CC1BDE6AD17748A400@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <CAMuHMdW0-KPEKS5wFRK7aRKwvvUcjQDa7Rmo0cDDwnfGAAmJ5w@mail.gmail.com>
Message-ID: <SG2PR06MB1165CCD49259621136C4517C8A400@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Monday, February 06, 2017, Geert Uytterhoeven wrote:
> > I agree that faking out a secure write function just so the fill-zeros
> > sideband feature is not enabled is a bit of a hack, but I'm not sure
> > if modifying the cache-l2x0.c was an option.
> 
> Given I've added "arm,shared-override" in the past, I'd say yes ;-)
> 
> > If you think so, I can try the "arm,pl310-no-sideband" path first, and
> > if that doesn't get in I can fall back to what I'm doing now.
> >
> > Thoughts???
> 
> According to the "CoreLink Level 2 Cache Controller L2C-310" TRM, "no
> sideband signals" is even the default configuration?

Good point. So technically there is nothing "illegal" about hooking up
only the AXI interface and not the sideband signals.

I guess that also means things like "Early BRESP Enable" are not really
going to work either.
Of course you'll still see "L2C-310 enabling early BRESP for Cortex-A9"
printed out on boot, which is true because it was enabled in the PL310,
but in reality it will never get used.
False hope :(


At first I'll put together a patch just for Full line of zero write since
that one changes the behavior of the CA9....and will break a system.


Thanks,
Chris
