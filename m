From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Nov 2015 11:31:34 +0000
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <564CD206.9040402@arm.com>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej> <564CB1DA.4090304@arm.com>
 <20151118180434.GB13355@leverpostej> <564CD206.9040402@arm.com>
Message-ID: <20151119112923.GA24570@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 01:31:18PM -0600, Jeremy Linton wrote:
> On 11/18/2015 12:04 PM, Mark Rutland wrote:
> 
> >You're racing against other parts of the CPU (the page table walker(s),
> >I-caches, etc). The flushing only minimises the window for a race, and
> >does not prevent the race from being possible.
> >
> >Given that the envelope is constantly pushing forward w.r.t. how
> >aggressive CPUs may be in this area, we need to fix the issue by
> >reasoning against what the architecture guarantees us.
> 	Its also not suppose to fault on speculative access, and to me that
> means page table walks/etc that are the result of speculative
> access.

I was under the impression that TLB conflict abort could be delivered
for asynchronous events (e.g. speculative I-cache fetches rather than
for speculative execution of already fetched instructions).

Having looked at the ARM ARM, I appear to have been mistaken. As you
say, it appears that TLB conflict aborts are always delivered
synchronously.

> Which AFAIK, closes the window significantly. I would only
> really worry about interrupt activity, and updates to the memory
> containing the PTE's themselves. Either way the simple change
> (rather than rewriting the whole code path) is probably to flag the
> fault handler to simply resume from these kinds of faults during
> create_mapping_late().

Unfortunately that may not be sufficient. The conflicting address range
might cover the current stack or the text of the exception handler, and
in those cases trying to handle the exception would result in taking
another TLB conflict abort recursively.

> 	But that isn't what is happening here AFAIK, the faults are long
> after the PTE's have been updated, and are the result of failure to
> flush the TLB..

It's not quite the same case, certainly.

It's also possible that the faults you are seeing see are also possible
earlier, but simply less likely, and that we get away without seeing the
other potential issues because of things that may change (i.e. the way
the compiler lays out the text).

I think that if we need to do something more drastic to account for the
other issues above (e.g. by ensuring that we can never allocate
conflicting TLB entries in the first place), and that said strategy
would also fix this problem, that would be preferable, given that we're
going to have to do that eventually anyway.

Mark.
