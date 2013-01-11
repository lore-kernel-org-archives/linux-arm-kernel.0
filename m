From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jan 2013 18:12:12 +0000
Subject: [PATCH] ARM: let CPUs not being able to run in ARM mode enter
 in THUMB mode
In-Reply-To: <50F0533C.8070802@arm.com>
References: <1357904397-8476-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130111160753.GC23505@n2100.arm.linux.org.uk> <50F0533C.8070802@arm.com>
Message-ID: <20130111181211.GL23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 06:00:28PM +0000, Jonathan Austin wrote:
> Hi Russell, Uwe
> 
> On 11/01/13 16:07, Russell King - ARM Linux wrote:
> > On Fri, Jan 11, 2013 at 12:39:57PM +0100, Uwe Kleine-K?nig wrote:
> >> +# Select this if your CPU doesn't support the 32 bit ARM instructions.
> >> +config THUMBONLY_CPU
> >> +	bool
> >> +	select THUMB2_KERNEL
> >> +	select ARM_THUMB
> > 
> > Hmm, not convinced this is the best solution.  Yes, fine for there to be
> > a THUMBONLY_CPU option, _but_ not the select statements onto user visible
> > symbols.  We can get this instead by:
> 
> I'm curious what it is about having the select statements onto user
> visible symbols that isn't good. Is it just that it will manipulate
> things underneath the users' feet? 

Consider this: you run make xconfig (or whatever config tool you
prefer).  You're presented with an option, which you want to disable.
It says the possible values for it are 'Y' (n and m are not possible).

So, you start to wonder why this is - why you're even being presented
with an option where it only has one allowable state.  That's not an
option, that's an ultimatum!

Now, you ask the config tool for the reason why the symbol is selected.
It gives you a big long list of dependencies - I've seen some of these
which are over 50 lines long.  A complex nest of options which are &&
and ||'d together.  You've no clue which one(s) result in the symbol
being selected.

So, the presentation of that symbol is nothing more than pure noise
and in some cases just leads to frustration at not being able to achieve
the configuration that's desired.

> (I'm not disagreeing! I like your proposal, but when I saw the
> original patch this didn't raise flags with me, so I'd like to
> understand the reasons)
> 
> > config CPU_ARM
> > 	bool
> > 
> > config CPU_THUMB
> > 	bool
> 
> The only thing I might add is that we don't want people confusing
> the selection of THUMB2_KERNEL with exclusively selecting CPU_THUMB
> (which should be very rare).

Note: these aren't user visible symbols (note the lack of option text
after 'bool' - that makes them hidden).  Instead, these symbols are
to be selected from the CONFIG_CPU_ARM926T etc symbols - so it's a
choice that the developers are making.

We can also add a "help" stanza to both these to describe what they're
representing, or if people prefer a comment before the option.
