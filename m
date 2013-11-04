From: david@gibson.dropbear.id.au (David Gibson)
Date: Tue, 5 Nov 2013 00:28:28 +1000
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <1432962.yW4lKnaQJE@flatron>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <E1VZjCU-0005RE-Vt@jdl.com>
 <20131025231106.GC17659@voom.redhat.com>
 <1432962.yW4lKnaQJE@flatron>
Message-ID: <20131104142828.GD3430@voom.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 12:15:58AM +0100, Tomasz Figa wrote:
> On Saturday 26 of October 2013 10:11:06 David Gibson wrote:
> > On Fri, Oct 25, 2013 at 10:21:22AM -0500, Jon Loeliger wrote:
> > > > On 10/25/2013 12:43 AM, Grant Likely wrote:
> > > > > On Thu, 24 Oct 2013 22:51:28 +0100, Stephen Warren
> > > > > <swarren@wwwdotorg.org>> > 
> > > > wrote:
> > > > >> From: Stephen Warren <swarren@nvidia.com>
> > > > >> 
> > > > >> This is a very quick proof-of-concept re: how a DT schema checker
> > > > >> might
> > > > >> look if written in C, and integrated into dtc.
> > > > > 
> > > > > Thanks for looking at this.
> > > > > 
> > > > > Very interesting. Certainly an expedient way to start checking
> > > > > schemas,
> > > > > and for certain bindings it may be the best approach. The downside
> > > > > is it forces a recompilation of DTC to bring in new bindings and
> > > > > it isn't a great meduim for mixing schema with documentation in
> > > > > the bindings.> > 
> > > > This approach would certainly require recompiling something. I threw
> > > > the code into dtc simply because it was the easiest container for
> > > > the demonstration. It could be a separate DT validation utility if
> > > > we wanted, although we'd need to split the DT parser from dtc into
> > > > a library to avoid code duplication. The resultant utility could be
> > > > part of the repo containing the DTs, so it didn't end up as a
> > > > separate package to manage.
> > > > 
> > > > I think the additional documentation could be added as comments in
> > > > the
> > > > validation functions, just like IIRC it was to be represented as
> > > > comments even in the .dts-based schema proposals.
> > > 
> > > DTers,
> > > 
> > > I think the additional benefit of starting with a direct C
> > > implementation is that it causes us to begin to actually
> > > codify the schema requirements.  Sure, it may not be ideal
> > > at first, but over time it may reveal consistent patterns
> > > that can be extracted.  And it may reveal what a real schema
> > > might look like and how it might be expressed better.  Which
> > > is to say that perhaps we are letting "perfect" get in the
> > > way of "good enough to start"?
> > > 
> > > In the meantime, someone has shown us the code and we can
> > > get started.  It's a Small Matter of Refactoring later. :-)
> > 
> > Yes!  This!
> > 
> > Think of this prototype as a mechanism for collating and applying a
> > bunch of schemas to the tree.  At the moment the schemas are all hard
> > coded in C, but it can be extended to load some or all of them
> > dynamically from a description / template / whatever.
> > 
> > That also gives us the flexibility to start out with a simple but
> > limited schema language which handles common cases, while leaving the
> > complex cases in C, at least until we understand the requirements well
> > enough to extend the schema language.
> 
> This is fine as an intermediate step, but I'm afraid that the overhead of 
> work needed to describe all the bindings using C language directly will be 
> pretty big. C language isn't really best fitted for such purposes.

I don't disagree.

> If we agree to base on this, but solely as a mechanism and a base for 
> further work, my idea would be to introduce a schema description language 
> anyway and then some code generator that would generate C code from 
> schemas described using such language

I suspect interpreting the schemas rather than compiling them into C
code will be more convenient, but that's a detail, really.

> (and possibly also something to 
> generate textual documentation from schemas, so we could have a central 
> repository of indexed DT bindings, for example on [1] - maybe kerneldoc 
> could be reused here).

Hrm.  I think trying to generate documentation from a schema is a bit
backwards.  I think it makes more sense to think of the binding as the
documentation, some parts of which are machine parseable to generate
the formal schema.  Literate schema programming, if you want to think
of it that way.

> Such design would allow for describing a lot of cases using a simple 
> description language, while leaving the possibility of adding inline C 
> snippets, like PHP in HTML, to handle those super complex ones.
> 
> [1] https://www.kernel.org/doc/htmldocs/
> 
> Best regards,
> Tomasz
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131105/e29ceb55/attachment.sig>
