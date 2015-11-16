From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2015 22:33:38 +0000
Subject: [PATCH 1/2] drm: Improve drm_of_component_probe() to correctly
 handle ports and remote ports.
In-Reply-To: <20151116211735.GA12564@bart.dudau.co.uk>
References: <1447685093-26129-1-git-send-email-Liviu.Dudau@arm.com>
 <1447685093-26129-2-git-send-email-Liviu.Dudau@arm.com>
 <20151116162241.GN8644@n2100.arm.linux.org.uk>
 <20151116164907.GA4158@e106497-lin.cambridge.arm.com>
 <20151116172248.GP8644@n2100.arm.linux.org.uk>
 <20151116211735.GA12564@bart.dudau.co.uk>
Message-ID: <20151116223337.GN8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 09:17:35PM +0000, Liviu Dudau wrote:
> On Mon, Nov 16, 2015 at 05:22:48PM +0000, Russell King - ARM Linux wrote:
> > Put those two sentences together and please think about it.  If the
> > pointer type is unknown to component_match_add(), how could it ever
> > use of_node_get() on it?  What if it's a string?  Or a struct device?
> > Or something else.
> 
> I did not say of_node_get() I said "some reference counting of sorts".
> One option would be to have (yet) another callback that the user of the
> components framework has to provide that does resource management.

I really do not see the point of anything other than a "release this
void pointer" callback which is exactly what I proposed at the
beginning of this discussion.  There's no reason to add a "take a
reference on this void pointer" - in fact, adding that brings with
it a _huge_ amount of complexity, such as:

void component_match_add(struct device *dev, struct component_match **matchptr,
        int (*compare)(struct device *, void *), void *compare_data)

would become:

void component_match_add(struct device *dev, struct component_match **matchptr,
	int (*take_ref)(void *),
	int (*release_ref)(void *),
	int (*compare)(struct device *, void *), void *compare_data)
{
	struct component_match *match = *matchptr;

	if (IS_ERR(match))
		return;

	if (take_ref) {
		int ret = take_ref(compare_data);
		if (ret) {
			/*
			 * add code to walk the list of already added
			 * matches and call their own release_refs
			 */ 
			free(match);
			*matchptr = ERR_PTR(ret);
			return;
		}
	}

And this is exactly why I believe it's pointless to have this callback:
anything you do in take_ref() you can do before calling this function,
and if you do it before calling this function, you are more efficient.

However, let's continue on:

	if (!match || match->num == match->alloc) {
		size_t new_size = match ? match->alloc + 16 : 15;

		match = component_match_realloc(dev, match, new_size);

		... this becomes much more complicated as well -
		component_match_realloc() can fail (just like standard
		realloc()), but we'd need to release all the references
		here as well.

	... rest of existing function ...
}

Then there's component_master_add_with_match() itself, which has
several failure points, which also have to do a dance with the
refcounting.

Rather than all this, what I'm suggesting is:

1. Add component_match_init() which allocates an initial match struct,
   which contains a head node which stores the error status (so if we
   fail to extend the array, we can keep the old array around.)
2. component_match_add() appends to the match array, taking an optional
   release function for the void pointer.  Any failure adding the current
   match results in the release function being called.
3. component_master_add_with_match() does its current job of
   validating the list, and creating the final array of matches.
   Any failure at this point walks the array and calls their optional
   release function.
4. component_master_del() walks the array and calls their optional
   release function.

This should result in a relatively simple implementation without multiple
failure cleanup paths.

There is absolutely zero need for some additional complex resource
management framework to be built around this at all.

> And for
> the record, I did thought about it and not for just a few minutes. I also
> came out of the thought process with the conclusion that while the components
> framework is doing the job it was coded for, it needs serious improvements
> in terms of documentation.

Just like the rest of the kernel, I've put it on the same todo list that
other maintainers put that on, which is the one which is always pushed to
the very back of the queue, because there's always more pressing matters
to attend to.  I can pull out lots of examples where I've spent a long
time getting to know the code where there are almost zero comments - and
this is one of the reasons why such stuff gets pushed to the back.  If
everyone documented their code and kept it up to date, then we wouldn't
need to read any code, and life would be wonderful.

I wouldn't need to spend the time trying to understand kernel code, I
could use that time to write documentation!

> > > I feel that holding onto a reference to a counted resource without
> > > incrementing the use count is not the right way of doing things, or
> > > at least it should be clearly documented in the interface of
> > > component_match_add() so that people understand the mess they are
> > > getting into.
> > 
> > That's just crap.  You're not thinking before you hit your keyboard.
> 
> Russell, I have no idea what do I need to do in order to gain your respect
> and for you to start treating me like a human being. Maybe *I* need to
> lower my expectations and stop hoping to have a civilised discussion with
> you.

Sorry, but I'm direct and blunt in email.  That's the way I am in email.
It's not about respect, I do respect others, but I say things directly.

> > Why should component_match_add(), which has _zero_ knowledge about
> > what it's being used with, have documentation attached to it which
> > would be:
> > 
> > "If you use component_match_add() with X, you need to do X'.  If you
> > use it with Y, you need to do Y'.  If you use it with Z, you need to
> > do Z'."
> > 
> > No, that's utterly insane.
> 
> No. It is utterly insane not to have documentation when using the framework
> or the function leads to memory leaks.

I've pointed out that the lack of "how can the void *data pointer be
freed" is currently something that isn't currently implemented.  That's
something on my todo list - along with getting some other patches out
the door for the component helper which I've had knocking around for
the last 18 months:

Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Fri Apr 18 23:05:53 2014 +0100

    component: track components via array rather than list

Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Wed Apr 23 10:46:11 2014 +0100

    component: move check for unbound master into try_to_bring_up_masters()

Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Fri Apr 18 22:10:32 2014 +0100

    component: remove old add_components method

Now, consider this: if it takes more than 18 months for me to get my
/own/ patches into the kernel, what hope do you think there is for me
to get around to writing documentation?

> You might think that the code is the proper documentation and ultimately that
> is right, but even code is wrong sometimes and (as we discovered with the
> component_match_add() discussion here) its side effects are not easy to spot
> even to the authors of the code.

Sorry?  It's not new to me, I've known about it for the last year or
more, I just haven't found the time to address it.  So far from "not
easy to spot even to the authors of the code", the authors of the
code know it's shortcomings, know it lacks documentation, and know
it needs more attention.  Even have outstanding patches against it
for a long time.

> Another example: of the 6 commits for drivers/base/component.c, 3 of them
> have "fixed ... handling/cleanup/bug". So it is not easy to get it right.

That's stretching it.  2 of them.
	drivers/base: fix devres handling for master device
	component: fix missed cleanup in case of devres failure

The third which I assume you refer to:
	component: fix bug with legacy API
is a side effect of modifying the code in:
	component: add support for component match array

which would not have been an issue had the above three outstanding
commits had gone in - instead, the issue there would've been "hey,
the legacy API has gone!" due to an addition of a new user in the
same merge window which would've removed the legacy API.  Hence,
it's very unfair to say that this is an example of the author not
understanding his own code.

You'll notice that the above three outstanding commits pre-date this
last fix.

> No, I was operating under the belief that if some framework holds a pointer
> to a resource it should also do the management of that resource. Your
> choice for the component framework has been different and you have decided
> that it is just a conduit for data gathering and binding, without any deep
> knowledge of what that data is. But that is not documented anywhere, so I
> don't feel too bad about having a different view.

It's no different from something like qsort().  qsort() does not care
what the underlying data is - it's given a pointer to some memory,
size of elements, the number of elements, and a match function.  It
doesn't know what's stored there - it could be numbers of apples,
pointers to addresses, refcounted objects, etc.

This is no different.  It's not some "different choice", it's a
standard construct going back years in programming history.

All that's going on here is it's gathering up a list of pointers and
their corresponding comparison function (and if I can get a round tuit,
a release function).  There are only two chunks of code which have any
business deferencing those pointers, and they are the comparison
and release functions.

It would be against programming principles to create an API that takes
void pointers and then casts them to something else so that they can
be dereferenced.  Sorry, I don't code like that.  Where there's a void
pointer, that means "this is an opaque object that's being passed in
that we won't dereference".

There's another example where this applies.  request_irq(), free_irq()
and the IRQ handler.  These two functions take a void pointer, and
have exactly the same behaviour that the component helper has: it's
an undereferencable cookie as far as they are concerned.  In the IRQ
case, the only thing that's allowed to dereference those void pointers
is the IRQ handler, which knows the type of the object.  Same for the
component helper: the only thing that's allowed to dereference the
void pointer is the associated compare (and release) functions.

> I understand your point. You have also written some excellent piece of
> documentation for the behaviour of the component framework that I feel
> should be included in the kernel rather than being lost in the sea of emails.

No, it's not documentation for the component framework at all.  The
description was largely a description of memory pointers and reference
counting in general, which I believe is pretty standard stuff.

However, what I have done above is documented _your_ code by describing
what _your_ drm_of_component_probe is doing.  I find that rather ironic.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
