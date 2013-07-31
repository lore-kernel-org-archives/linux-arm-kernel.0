From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 31 Jul 2013 17:59:10 +0100
Subject: Defining schemas for Device Tree
In-Reply-To: <20130731113401.GM9858@sirena.org.uk>
References: <CAKON4OwNrhmvnznyeD-igtZ5nsm7atUZoa0RJttN5kmwKubaDg@mail.gmail.com>
 <20130730102511.GM9858@sirena.org.uk>
 <CAKON4OxSr13VPJkwkvuF91BwFXfQ6fkAuVeEsiA=JK3cuzmavQ@mail.gmail.com>
 <51F7F596.6020503@wwwdotorg.org>
 <CAKON4OykPqYA8+ZGxjiX00Ut+iM9hqiXr5D9KEZF3PVxoqiM1g@mail.gmail.com>
 <20130730205716.GZ9858@sirena.org.uk>
 <CAKON4Ox7-6Jf0ce64Wqr5E49KS+9E135mqc_iG-PWQ7r8bzWHA@mail.gmail.com>
 <20130730230331.GC9858@sirena.org.uk>
 <CAKON4OzFdZhX0Kzu_6KiimD=KxDr6EM13zUH3GGE=hHaYx=m=Q@mail.gmail.com>
 <20130731113401.GM9858@sirena.org.uk>
Message-ID: <20130731165902.GA3329@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 09:57:16PM +0100, Mark Brown wrote:
> On Tue, Jul 30, 2013 at 01:29:56PM -0400, jonsmirl at gmail.com wrote:
> > On Tue, Jul 30, 2013 at 1:19 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > > On 07/30/2013 07:14 AM, jonsmirl at gmail.com wrote:
> 
> > > > Is something similar to this possible in device tree syntax?
> > > > dmas =  <"tx" &pdma0 7>,  <"rx"  &pdma0 6>;
> 
> > > I /think/ you can physically write that in *.dts, or something very
> > > similar; with the strings outside the <>:
> 
> > > dmas = "tx", <&pdma0 7>, "rx", <&pdma0 6>;
> 
> > Can we turn the strings into string phandles? Then they'd be fixed sized.
> 
> > That might provide a way to internationalize the strings too.
> 
> I don't know how viable or sane this actually is but one suggestion I
> just made elsewhere which might help is to fix this at the dtc level by
> having syntatic sugar which will do the parallel arrays trick that
> people are currently using to write things out.  The user writes one
> array with multiple types of data in it and the actual output is two or
> more matched arrays each with a single type of data.
> 
> It would help legibility and wouldn't impact the parsers.

There may often be a conflict between making _good_ bindings, and making
bindings which are convenient for maintainers to edit in .dts syntax.

I think good bindings (in the sense of good ABI) must take precedence:
good bindings need to interoperate well over a long period of time, and
should be robust against future evolution of hardware platforms OSes.  If
they look nice in the .dts file, that's a bonus -- but I don't think it
should be viewed as a requirement.

A pair of properties like dma-names/dmas may be a bit cumbersome, but
it can be precise, unambiguous, and simple and easy to parse and check.
The semantics can be extended in the future if necessary, by adding
additional companion properties.  From my perspective, this can work as
a template for good bindings.


We could add syntactic sugar to make those property pairs easier to
maintain... but I worry that haphazard extensions to dtc may leave us
with an unmanageable syntax which we will regret later.   This seems to
be a common failure mode of domain-specific languages.

Someone trying to maintain a complex .dts can always make their own life
easier with a bit of scripting.  After all, in a future of stable
bindings, a DT really shouldn't be changing much once it is complete.
I don't see a clear reason why these issues must be solved by dtc
itself.

Cheers
---Dave
