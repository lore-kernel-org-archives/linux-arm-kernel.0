From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 24 Nov 2009 01:32:31 +0000
Subject: CAS implementation may be broken
In-Reply-To: <20091123231353.GJ18142@n2100.arm.linux.org.uk>
References: <4B08055C.3000408@45mercystreet.com>
	<20091123222830.GA5598@shareable.org>
	<20091123231353.GJ18142@n2100.arm.linux.org.uk>
Message-ID: <20091124013231.GB14645@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Nov 23, 2009 at 10:28:30PM +0000, Jamie Lokier wrote:
> > That could be an improvement for some algorithms, because often if the
> > store doesn't happen, the *inputs* to compare_and_swap() need to be
> > recalculated anyway before another try is likely to succeed.  What's
> > the point in having code which expands to two loops:
> 
> The point is that often its cheaper to retry the LL/SC than it is to
> do the recalculation.
> 
> However, I don't think you've understood the original problem at all.

I think I have - I agreed with you and Catalin already that LL/SC does
not suffice.  But do you mean that Catalin's suggestion to put the
LDREX before the LDR does not work either?  (Maybe it needs a barrier
too).

It probably looks like I didn't understand because I've mixed two
quite different issues in the same mail (same in this one), because I
think the CAS_BOOL has merit.  Having implemented both variants in
userspace, it's actually quite annoying to use CAS and have to
remember the input and compare it with the output sometimes.

For some algorithms, you're right that it can be cheaper to retry the
LL/SC.  But for some algorithms you know the retry will never succeed
and is a waste of time and code space, e.g. ones which do CAS on a
counter which is always incremented.  It makes the caller a bit more
long-winded too.

The final argument is: you can implement CAS in terms of CAS_BOOL, but
you can't do it the other way.  Because everyone copied x86's CAS at
the begining, that's the one we got.

-- Jamie
