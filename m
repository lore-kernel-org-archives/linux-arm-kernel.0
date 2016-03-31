From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Mar 2016 17:43:16 +0100
Subject: [RFC] [PATCH] arm64: survive after access to unimplemented
 register
In-Reply-To: <20160331160500.GC29800@yury-N73SV>
References: <1459391223-3826-1-git-send-email-ynorov@caviumnetworks.com>
 <20160331100547.GA26532@leverpostej>
 <20160331122859.GA27859@yury-N73SV>
 <20160331131231.GF26532@leverpostej>
 <20160331160500.GC29800@yury-N73SV>
Message-ID: <20160331164316.GB26393@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 07:05:00PM +0300, Yury Norov wrote:
> On Thu, Mar 31, 2016 at 02:12:31PM +0100, Mark Rutland wrote:
> > On Thu, Mar 31, 2016 at 03:28:59PM +0300, Yury Norov wrote:
> > > On Thu, Mar 31, 2016 at 11:05:48AM +0100, Mark Rutland wrote:
> > > > On Thu, Mar 31, 2016 at 05:27:03AM +0300, Yury Norov wrote:
> > > > > Not all vendors implement all the system registers ARM specifies.
> > > > 
> > > > The ID registers in question are precisely documented in the ARM ARM
> > > > (see table C5-6 in ARM DDI 0487A.i). Specifically, the ID space
> > > > ID_AA64MMFR2_EL1 now falls in to is listed as RAZ.
> > > > 
> > > > Any deviation from this is an erratum, and needs to be handled as such
> > > > (e.g. listing in silicon-errata.txt).
> > > > 
> > > > Does the issue affect ThunderX natively?
> > > 
> > > Yes, Thunder is involved, but I cannot tell more due to NDA.
> > > And this error is not in silicon-errata.txt.
> > > I'll ask permission to share more details.
> > 
> > Ok. Regardless of how this is solved, we need to know the details of the
> > erratum (and need an entry in silicon-errata.txt).

[...]

> > Before we can do any of this, we need to know the conditions of the
> > erratum, however.

[...]

> > > Initially I was thinking about erratas as well, but Arnd suggested
> > > this approach, and now think it's better. From consumer point of view,
> > > it's much better to have a warning line in dmesg, instead of bricked
> > > device, after another kernel or driver update.
> > 
> > Having some warning is certainly better, though I think we need to
> > scream _very loudly_ for cases we do not expect, as non-fatal warnings
> > are easily/often ignored, and can later turn out to be more critical
> > than previously believed.
> > 
> > Thanks,
> > Mark.
> 
> So what? Are we drop it? Or I can prepare new version with loud
> warning and runtime patching.

As above, we need to know the precise conditions of the erratum. For
example:

* Do all reserved / RAZ registers trap, or only a subset?

* Do other registers trap?

* Which revisions of the core are affected?

* How widely deployed are the affected revisions (is this production
  silicon or early test chips)?

Once we know that we can assess how/where the kernel will be affected,
which approaches are suitable as workarounds, whether this needs to be a
selectable option, etc.

Until we know that, we cannot assess the situation.

Thanks,
Mark.
