From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Wed, 18 Nov 2015 11:01:56 +0100
Subject: Minimal support for dm814x
In-Reply-To: <D5E377BD-5AAE-4302-B2C3-2B17A00892B5@audioscience.com>
References: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
 <20151109150602.GR3199@atomide.com>
 <CAALWOA-NUyRYaGbmBZpc6CcFga8_BKPZ9WQTxa3t09bHS_6=qA@mail.gmail.com>
 <7933071D-84FD-4A85-8CD0-CC504CE1D9D1@audioscience.com>
 <20151111174028.GF3218@atomide.com>
 <CAALWOA_dEtajQBLrXesQ2bRCDf-1Dzg_tJw_=yAmaO=T3=KMZQ@mail.gmail.com>
 <20151112174155.GM3218@atomide.com>
 <CAALWOA9o80rhaqwaa6=XxmNN1FcWzHDXiaqkqFVO81CAMX=04w@mail.gmail.com>
 <CAALWOA-29pK=GbNKhdY=4oJzhnueVxNAPruu9Uacqi5vMJN=OA@mail.gmail.com>
 <20151113145216.GC2517@atomide.com>
 <CAALWOA-PjKW9M3qqxum4OqJ3V3AwKaaEDzA17jdZmgUNNE79Wg@mail.gmail.com>
 <D5E377BD-5AAE-4302-B2C3-2B17A00892B5@audioscience.com>
Message-ID: <CAALWOA8bEeLtO-QmyiS9H-z2-pToc-HY3HPuTEsmvZ2BSWf75Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 November 2015 at 09:26, Delio Brignoli <dbrignoli@audioscience.com> wrote:
>> This works in principle, but both minimizing the DCO and (often
>> needlessly) using the fractional multiplier seem like recipes to
>> maximize the clock jitter. Mind you, I don't know how much jitter
>> we?re talking about here, I don't recall having seen specs about this.
>
> We haven?t seen any specs either but testing shows that changing DCO mode causes
> the PLL to lose lock at least temporarily.

Losing lock on reconfiguration is entirely a separate matter from
clock jitter. The fractional multiplier works by essentially by
alternating between the nearest integer multiplier values. This will
be smoothed out by the loop filter, but it's not going to vanish.

To put this in perspective, some docs (I can't immediately find which
one) warned that when using the fractional multiplier of DPLLS, its
value needed to be at least 100 to ensure max 2.5% jitter. To put this
in perspective, if I grab the datasheet of an audio DAC I find:
   Although the architecture of the PCM4104 is tolerant to
   phase jitter on the system clock, it is recommended that
   the user provide a low jitter clock (100 picoseconds or less)
   for optimal performance.
For a typical 24.576 MHz audio system clock that means max 0.25%
jitter. Whoops :P

Now DPLLLJ will presumably do better, but without actual specs the
safe option is to avoid the fractional multiplier altogether.

Matthijs
