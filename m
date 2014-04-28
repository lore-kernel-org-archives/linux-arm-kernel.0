From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Apr 2014 20:10:17 +0100
Subject: [PATCH 00/16] Another 16 L2C patches
In-Reply-To: <535EA090.6030903@wwwdotorg.org>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
 <535E8BEE.1000100@wwwdotorg.org> <535E8F6D.9000803@wwwdotorg.org>
 <20140428173943.GN26756@n2100.arm.linux.org.uk>
 <535E990B.2020405@wwwdotorg.org>
 <20140428181904.GP26756@n2100.arm.linux.org.uk>
 <535EA090.6030903@wwwdotorg.org>
Message-ID: <20140428191017.GT26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 12:40:16PM -0600, Stephen Warren wrote:
> Do you say that simply because to make use of this feature, it also
> needs to be enabled in the A9 but no code in the kernel is currently
> doing that? Or, because enabling the feature stops the cache controller
> from supporting strongly ordered writes?
> 
> It seems like the condition this error message detects is benign; the
> cache controller is prepared to receive these transactions, but the A9
> will never send them. Nothing can go wrong in this case, I believe,
> although admittedly it's a pointless configuration.

Yes, it's benign, but it's an unnecessary difference between platforms
which stands in the way of trying to clean this crap up.

This is what I've been moaning about for a while: totally pointless
differences between platforms which then stand in the way of future
cleanups, because it's impossible to tell whether a difference is there
because it's required or because (speaking plainly) the maintainer
didn't have any clue what they were doing when the wrote the code.

The L2 cache code has suffered a lot from cargo cult programming, and
other sloppiness - so yes, while it's benign, we can now also have a
benign warning to encourage people not to do this kind of stuff.

> Equally, given the required enable sequence in that document, won't this
> error always get printed if BIT(0) is sent in aux_val; before the bit is
> enabled in the cache controller, the associated bit in the A9 /should/
> be disabled.

The point here is that if we are going to enable various Cortex-A9
optimisations, the way it _should_ be done is that the L2 cache code makes
that decision based on the revision of the parts found, and the only
control which platforms should ever have is one to say "this feature is
broken on platform X, please don't enable it" which that done via DT,
and not via random values passed via an initialisation interface.

So, what this error is all about is:

- the platform maintainer decided to set bit 0 which enables a cortex-a9
  specific feature, which is useless given that the enable bit in
  cortex-a9 is disabled.

- the platform maintainer is setting bits without thinking.

- platform maintainers copy code from other platforms without thinking
  (just look at all the crap uses of L2X0_AUX_CTRL_MASK which is only
  suitable for L2C-210, but gets used on everything.)

So once one person does it, it ends up propagating to other platforms,
and the problem just spreads.

> It seems like the test in the kernel should simply check if
> BIT(0) is set in aux_val and ignore the value in the A9 completely, if
> you want to ban people from enabling this feature via aux_val. Or, are
> there some platforms where something outside (before) the kernel enables
> the feature in the A9 even before the kernel cache init code runs, and
> you want to avoid printing the error in that case?

You're asking questions I have no answer to - and this is the whole
problem here.  Platform maintainers go off in their own tiny worlds,
with blinkers on, doing their own crap without really knowing what the
hell they're doing.

I've *no* clue whether there's a platform which gets this wrong and
enables the FLZ bit in the CA9 control register.  Given the kind of
crap that we have in the kernel - with platforms just deciding to set
bit 0 of the L2 cache auxiliary control register without taking any
time to think, I have no reason to doubt that someone hasn't tried
crap like that, and I have no doubt that it _could_ have worked for
someone sufficiently to get into the kernel.

This is the whole problem: I have no idea what kind of bollocks platform
maintainers do in their spare time.

Frankly, this is another in the long list of arm-soc failures: this
is something that should have been fixed a /long/ time ago - it's
far more important than getting rid of silly timex.h header files,
and the problem is more pervasive.  Instead, it was left, and left and
left, and the problem has grown bigger and bigger.

So no, I'm not offering any sympathy here to anyone, partly because of
the shere amount of effort that the L2 cache series has taken to get
this far - and it's now soo big that it in itself is starting to become
unmanageable.  And with many platform maintainers not really taking an
interest in it when it has been posted, I'm at the point where I just
don't give a that much of a damn about their platform code unless they
take an interest and help do some testing.

> > If we decide that we encounter a platform which needs this feature
> > disabled, the correct way to deal with that is to add a L2C-310
> 
> I assume /disabled/enabled/ there?

No, I meant what I said.  Enable the optimistions by default.  If someone
whinges, we'll fix it, but *only* if it causes a failure.  Any other
solution is total madness, and doesn't get much in the way of interest.

It's easy to ignore a plea for help.  It's impossible to ignore if it
causes a problem.

> > specific property to DT, and not to try to crowbar it in via the L2C
> > aux control register masks (which should never have been exposed to
> > platforms using DT.)

We're only at this point _because_ I've forced people to take an interest
in this code.  I know most platform maintainers would rather not think
about it, as evidenced by the wide-spread cargo-cult programming that has
been going on here.  The only way to get this sorted is to ram this kind
of thing down people's throats.  Yes, it's not a nice way to do it, but
it's the only way.

Also, remember that I don't have these huge board farms that Olof and
Kevin have - in comparison I'm a pauper when it comes to platforms I
can directly test.  This makes my job that much harder, especially when
platform maintainers are uncooperative, and is why I resort to pushing
such stuff into linux-next to _force_ the issue, after I've completed
what testing I can do here, and given it a run through Olof's build
system.

Olof's system is useless for remote debugging though, so it is of little
value other than seeing how many platforms succeed or fail.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
