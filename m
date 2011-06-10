From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 10 Jun 2011 09:57:52 +0100
Subject: [RFC PATCH 0/2] ARM: Add a generic macro for declaring proc_info
	structs
In-Reply-To: <20110609173836.GF24424@n2100.arm.linux.org.uk>
References: <1307640112-5360-1-git-send-email-dave.martin@linaro.org>
	<20110609173836.GF24424@n2100.arm.linux.org.uk>
Message-ID: <20110610085752.GA2129@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2011 at 06:38:36PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 09, 2011 at 06:21:50PM +0100, Dave Martin wrote:
> > Based on recent problems with variable-size Thumb instructions
> > inside tables, this patch adds an experimental macro for declaring
> > proc_info structs, as an example of the kind of build-time robustness
> > we could implement for these and similar structures.
> 
> Could we just check the size of the proc_info region in the linker
> is a multiple of the struct size we expect?

This might work; it's possible to add assertions in the linker
script, but section alignment padding would mask some errors.
It would be better than having no check, though.

> > However, this may be taking a sledgehammer to crack a nut,
> > and it will cause some churn, though it could leave is with a
> > cleaner situation afterwards.
> 
> It does look very much like a sledge hammer to me.  All we're really
> after is whether the size of the region is what we expect it to be -
> which will tell us whether there's a T2 instruction in there.

True, although the intent was no to solve just that one problem,
but to show how to avoid a whole variety of trivial mistakes.
Since proc_info structs don't tend to get changed much after
they're initially written, I guess that such mistakes don't actually
occur very often, though.

> It's also fragile - if the struct has a member inserted, who says that
> the offsets in the macro will be updated anyway... so it still suffers
> from the same problem of no real build-time checking.

That is actually somewhat solvable using the automatically updated
asm-offsets.h constants.  I only use the constants which already
exist already: there isn't one for every field, but one could be defined
for every field in the structure.

> At least if we check that the size of the region is a multiple of the
> struct size, we can catch whether there's any mismatch between the
> struct size and assembly rather trivially.

For the proc_types stuff in compressed/head.S, I've proposed basically
the same check you describe:
http://article.gmane.org/gmane.linux.ports.arm.kernel/119940/match=proc_type

This is at the other end of the the spectrum, but is pretty non-
invasive, and will probably catch the common mistakes.


As for the heavyweight version, I will file it away under
"interesting exercises".  That technique might come in handy
sometime, but I agree it's probably overkill for this kind of case.

Cheers
---Dave
