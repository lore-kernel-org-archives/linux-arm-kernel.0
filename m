From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Aug 2013 12:27:05 +0100
Subject: [alsa-devel] [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
In-Reply-To: <CAOyKLY_mQzPxHAg2RFSMY89uxp-0-OAf6fC=gVY0i+pQhv4iHQ@mail.gmail.com>
References: <20130820133143.GC23006@n2100.arm.linux.org.uk>
 <20130820185019.GP30073@sirena.org.uk>
 <20130820201824.GA17845@n2100.arm.linux.org.uk>
 <1377199370.2618.99.camel@loki>
 <20130822201658.GK6617@n2100.arm.linux.org.uk>
 <1377259994.2444.41.camel@loki>
 <20130823125803.GN6617@n2100.arm.linux.org.uk>
 <20130823165800.GB30617@sirena.org.uk>
 <20130823174505.GQ6617@n2100.arm.linux.org.uk>
 <CAOyKLY_mQzPxHAg2RFSMY89uxp-0-OAf6fC=gVY0i+pQhv4iHQ@mail.gmail.com>
Message-ID: <20130830112705.GU6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 11:12:35PM +0200, Liam Girdwood wrote:
> Do you not see how statements like this will just end up making you look
> like someone who is very difficult to work with when faced with a technical
> disagreement ? I had acknowledged to you that this had not been tested for
> your configuration before you sent this email and that I would fix the
> issue.

Sorry, you're making the assumption that there's a _technical_
disagreement here.  That's not how I view any of this; I believe that
what's been going on has been a stream of misinformation and obstruction
which is a totally different issue.

While it may be true that the bug affects DPCM _too_, it is not DPCM
which is the problem.  That's pretty obvious when you consider that the
patch series which I posted (which is non-DPCM) trips over the bug as
well.

Is it reasonable to continually claim that a bug is due to DPCM when the
code being used which provokes it doesn't make any use of DPCM.

It's that kind of misinformation that I can't stand, and I will make it
plainly obvious when there's blatent misinformation being banded out.

As a result of this, I can never trust anything Mark says; that's
something which I established about a fortnight ago when this same old
wrong story was trotted out for the I don't know how many time.  Of
course people are going to get frustrated and annoyed if that's the
kind of behaviour that's being presented: when the facts show that
something is wrong, repeating it many times doesn't make it any more
right.  All that it does is waste time.

I note that Mark has finally agreed earlier this week for the *first*
time (in reply to the email you quoted) that the bug doesn't necessarily
have anything to do with DPCM - which is at last some progress.  To have
taken four weeks to get to that point is pretty direbolical.

What about the oops bug in ALSA PCM that DPCM causes... am I going to
have to spend another month trying to get that bug recognised?  (That
has been ignored too.)

If this is what it takes, then I'm seriously going to consider rewriting
this as a plain ALSA driver and ditch ASoC; ASoC seems to be too buggy at
the moment and it takes too long just to get bugs recognised.

It's not the actual fixing that I'm particularly worried about: it's a
display that the maintainer correctly recognises the bug, and has the
capability to fix it - and if they don't have time, they can communicate
how they'd like it to be fixed or pass it to someone who does.  Every time
I've asked about how to fix the widget overwriting bug, the replies (if
any) have avoided the question or given the same old misinformation.

You only need to go back and look at the initial patch submission to see
that; the patch containing my hacked workaround has never had any kind of
response.  Is it acceptable to think "the submitter doesn't expect that
to be merged so I'll ignore it"?  The fact that any kind of hack appears
in a patch series means that there's a problem which needs to be solved,
and the submitter may not know how it should be fixed.

That's definitely the case with this patch set: more so since I'd already
asked the question about how it should be solved and already got nowhere.

All in all, there's been:

1. The combining of the CPU and platform code(s) under one device is
   absolutely no problem for ASoC, there's multiple drivers which do this
   already.  While this is a true statement, it creates the bug at the
   heart of this thread - and the bug _occuring_ has nothing to do with
   DPCM.  The bug is caused solely by the combining of the two components.

2. Stream names in DAIs don't have to be globally unique.  This is false
   if you want to try and bind to specific streams - even more so when
   you can end up with multiple codecs with DPCM, where all their output
   streams are called "Playback".

   It may be that the stream names are not supposed to be used in DAPM
   routes, but that is not documented, and to date no one has made such
   a statement.

3. The infamous flippant "DAPM is just a graph walk" statement - it's
   more complicated than that because DAPM widgets have types which affect
   how the graph is walked, and the activation in multiple points in the
   graph make it more difficult to understand.  As for the DAPM contexts
   which affect how the graph gets built, and in some cases whether some
   links even get created.  No, it's more than "just a graph walk" - while
   true at a very basic level, it provides nothing of any use to anyone
   trying to understand this code - the response may as well have been
   "It's written in C".

   (In the course of this, I've given an overview of it to a small number
   of people, and it takes a lot more than six words to even begin to
   describe what it is.)

4. By adding the AIFs and routes, I'm bypassing/abusing the ASoC DAI core.
   If this were to be the case, why does your DPCM driver set them up.
   Therefore, my conclusion is that Mark was wrong about this too.  Yes,
   it may be that for the time being it's not that appealing, because as
   DPCM doesn't work in mainline, I'm unable to separate the DAI link
   between the CPU and the Codec.  That doesn't make the creation of
   the routes any more wrong when they're the exact same routes which
   need to be created for DPCM - especially when they're relied upon for
   there to be any audio output what so ever from the driver.

5. Mark's "suggestion" that I can get this driver to work without this
   hack... I still don't see how, and Mark hasn't effectively explained
   how either - and I'm left wondering whether Mark even read the patch
   to see how it worked, and to see how and why it uses the AIF widgets,
   which brings into question the "review" which was done.

   While the simple solution would be to add some ifdefs, that is not
   acceptable when you consider that this driver is already part of a
   multi-platform kernel - hard-coding it to one kind of output would
   definitely cause regressions.  Also consider that this patch series
   was already my best effort at getting this going without using DPCM
   and without adding ifdefs without causing regressions for other
   Kirkwood platforms.

If those issues mean that I'm difficult to work with... well... I suspect
anyone in my position receiving those kinds of responses would also end
up getting extremely frustrated, as I have.
