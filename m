From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Aug 2013 23:23:33 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130831210518.GK6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk> <5222562B.8010001@metafoo.de>
 <20130831210518.GK6617@n2100.arm.linux.org.uk>
Message-ID: <20130831222332.GL6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 10:05:18PM +0100, Russell King - ARM Linux wrote:
> On Sat, Aug 31, 2013 at 10:46:35PM +0200, Lars-Peter Clausen wrote:
> > On 08/31/2013 09:19 PM, Russell King - ARM Linux wrote:
> > > On Sat, Aug 31, 2013 at 06:28:53PM +0100, Mark Brown wrote:
> > >> On Sat, Aug 31, 2013 at 05:28:26PM +0200, Lars-Peter Clausen wrote:
> > >>
> > >>> Then connect the SPDIF AIF widgets to the SPDIF streams and the I2S AIF
> > >>> widgets to the I2S streams. In your machine driver setup the link config to
> > >>> use DAI 0 if the board uses I2S and DAI 1 if the board uses SPDIF. The ASoC
> > >>> framework will then create the necessary routes all by itself. Of course
> > >>> this won't work on a platform where both the SPDIF and I2S controller are
> > >>> used at the same time, but neither does your current solution.
> > >>
> > >> This is the either/or approach I've been suggesting.
> > > 
> > > Ah, here we go again.  This is precisely why I can't work with you.
> > > Nothing I say seems to stick in your mind.  I've been telling you for the
> > > last four weeks that it doesn't work - and I've shown you the oopses and
> > > warnings I get from trying it.  Your response to date: nothing of any
> > > real use.
> > > 
> > > If you're not going to provide any useful responses on bug reports, it is
> > > totally unreasonable that you even suggest that _that_ is how it should
> > > be done when I've already proved that it's impossible at present.
> > 
> > Russell, please stop being such a bitch. You seem to be the only one who has
> > any problems working with Mark, which maybe should make you wonder if the
> > problem is not on your side. Insulting and screaming at people all the time
> > won't exactly motivate them to help you with your problems. Please try to be
> > constructive, it will makes things much easier for everyone.
> 
> Consider that Mark's been saying the same old stuff for the last four
> weeks, and I've been showing that it doesn't work, and the only thing
> that Mark says is the same old same old - maybe in the hope that if he
> says it enough times the bugs will mysteriously vanish.  Unfortunately,
> that isn't happening.
> 
> It's also not constructive or helpful, and it's extremely frustrating.
> I have very little patience left with ASoC at this point, having spent
> a month trying to get this stuff working.
> 
> I'm not the only one: I've heard other people complain about the _exact_
> same issue with ASoC: ASoC is difficult to work with, and many people
> just seem to give up with it - or keep their stuff in their own trees
> locally.  I can very well see why that happens.
> 
> As for "This is the either/or approach I've been suggesting."  No, that's
> another false statement from Mark.  What Mark has been suggesting all
> along is to use DPCM - and that's something which I tried for ages to
> get working, and it just doesn't work (as evidenced by the oopses and
> warnings that get spat out of the kernel.)
> 
> Mark suggested it _before_ he suggested DPCM, and I tried that approach.
> The problem is that it doesn't fit the hardware.  They aren't two
> separate streams - they're a single stream with two output paths, and
> there's restrictions in the hardware to do with how they're controlled.
> 
> There are two choices in how the hardware is used: either one output
> only is used, or if both outputs are used, they must be used "as one" -
> both outputs must be simultaneously enabled and disabled.  As far as
> I know, that's not possible with two DAIs.
> 
> And here's the patch I tried.
> 
> See - I've been down this route before.  I've tried it, and I know
> what it's problems are.  I'm not making up _anything_ here - I really
> have tried all these "suggestions" and I'm just going round in circles
> because Mark isn't listening to what I've been reporting back.

And this is how I ended up going down the DPCM route - this is from
private mails, so I'm only including those bits which I authored.
This is from an email exchange back in May (yes, this has been going
on since May!)

> > > So, I have this Armada 510 on the Cubox, which is wired up to use mainly
> > > the SPDIF output from the device.
> >
> > > The structure of the device (if you look at the page I point out in the
> > > PDF below) is:
> >
> > > Tx DMA --> Tx FIFO ----> I2S formatter ----> I2S output
> > >                     `--> SPDIF formatter --> SPDIF output
> >
> > > There are separate mute and enable bits for the I2S and SPDIF.  The mute
> > > bits can be set and cleared independently at any time (but it's
> > > recommended
> > > to set the mute bits before pausing the entire block).  However, the
> > > enable bits must be set and cleared simultaneously if both SPDIF and I2S
> > > output are required - setting one then the other is not permitted by
> > > the spec.
> >
> > > Now, Mark describes below about using two front ends and a single back
> > > end to describe this.  So, I've created two DAIs in kirkwood-i2s.c,
> > > one for I2S and one for SPDIF.  I've since come to the conclusion that
> > > this is wrong.  I'm now wondering how all this front end/back end stuff
> > > hangs together, and so forth.

(Liam asks why)

> It's wrong because there's no way to tie the two DAIs together and tell
> ASoC that the second DAI must not be started if the first one is already
> running.
>
> You can a card module come along, bind to the SPDIF one, then have the
> SPDIF output be used (so the transmission starts), then the new card
> module binds separately to the I2S one, at which point that automatically
> starts up - which then violates the conditions layed down that "both
> shall be started together or just one".
>
> There is no way in the CPU DAI backend to tell ALSA "these two DAIs are
> inherently linked and must be either started together or only one."

(Liam includes his relevant parts of a driver he is working on using
DPCM.)

So, it seems that you and Mark disagree with Liam.  That's just great.

I'm getting really tired of being told "you should do it this way" by
various people where their way is different.  I'm just going round and
round in circles with this.
