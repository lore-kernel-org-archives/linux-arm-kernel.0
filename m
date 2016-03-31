From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 31 Mar 2016 19:05:00 +0300
Subject: [RFC] [PATCH] arm64: survive after access to unimplemented
 register
In-Reply-To: <20160331131231.GF26532@leverpostej>
References: <1459391223-3826-1-git-send-email-ynorov@caviumnetworks.com>
 <20160331100547.GA26532@leverpostej>
 <20160331122859.GA27859@yury-N73SV>
 <20160331131231.GF26532@leverpostej>
Message-ID: <20160331160500.GC29800@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 02:12:31PM +0100, Mark Rutland wrote:
> On Thu, Mar 31, 2016 at 03:28:59PM +0300, Yury Norov wrote:
> > Hi Mark,
> > 
> > On Thu, Mar 31, 2016 at 11:05:48AM +0100, Mark Rutland wrote:
> > > On Thu, Mar 31, 2016 at 05:27:03AM +0300, Yury Norov wrote:
> > > > Not all vendors implement all the system registers ARM specifies.
> > > 
> > > The ID registers in question are precisely documented in the ARM ARM
> > > (see table C5-6 in ARM DDI 0487A.i). Specifically, the ID space
> > > ID_AA64MMFR2_EL1 now falls in to is listed as RAZ.
> > > 
> > > Any deviation from this is an erratum, and needs to be handled as such
> > > (e.g. listing in silicon-errata.txt).
> > > 
> > > Does the issue affect ThunderX natively?
> > 
> > Yes, Thunder is involved, but I cannot tell more due to NDA.
> > And this error is not in silicon-errata.txt.
> > I'll ask permission to share more details.
> 
> Ok. Regardless of how this is solved, we need to know the details of the
> erratum (and need an entry in silicon-errata.txt).
> 
> > > > So access them causes undefined instruction abort and then kernel
> > > > panic. There are 3 ways to handle it we can figure out:
> > > >  - use conditional compilation and erratas;
> > > >  - use kernel patching;
> > > >  - inline fixups resolving the abort.
> > > > 
> > > > Last option is more robust as it does not require additional efforts
> > > > to support targers. It is looking reasonable because in many cases
> > > > optional registers should be RAZ if not implemented. Special cases may
> > > > be handled by underlying __read_cpuid() when needed.
> > > 
> > > I don't think we should do this if the only affected implementations are
> > > software emulators which can be patched (and have already been, in the
> > > case of QEMU).
> > > 
> > > In future it's very likely that early assembly code (potentially in
> > > hypervisor context) will need to access ID registers which are currently
> > > reserved/RAZ, and it will be rather painful to fix up accesses to this.
> > 
> > So we will not fix. This one fixes el1 only, and don't pretend for more. 
> 
> At some point, it's practically guaranteed that we will have to access
> reserved/RAZ ID registers in other cases, so we _will_ need workarounds
> that cater for those sooner or later.
> 
> We need to consider how we can handle those, in case it implies
> constraints on our solution elsewhere, or requires a more complex, but
> more general solution (which we can implement part of today).
> 
> For example:
> 
> * The sanity checks code will perform many back-to-back register
>   accesses. Trapping lots of these could be expensive, so not performing
>   the MRS at all when known to be unsafe may be preferable.
> 
> * Some registers may be read in a hot/critical path, or potentially in a
>   context where we cannot handle trapping (e.g. early boot code or parts
>   of KVM). In some cases, patching may be preferable to an MRS that only
>   gets executed depending on a branch condition.
> 
> Before we can do any of this, we need to know the conditions of the
> erratum, however.
> 

No matter, patching is preferable by many reasons, of course. But kernel
patching requires some investigations, and may take time. This is the last
resort for kernel to stay alive.

> > > Additionally, this workaround will silently mask other bugs in this area
> > > (e.g. if registers like ID_AA64MMFR0_EL1 were to trap for some reason on
> > > an implementation), which doesn't seem good.
> > 
> > We can mask it less silently, for example, print message to dmesg.
> > 
> > Initially I was thinking about erratas as well, but Arnd suggested
> > this approach, and now think it's better. From consumer point of view,
> > it's much better to have a warning line in dmesg, instead of bricked
> > device, after another kernel or driver update.
> 
> Having some warning is certainly better, though I think we need to
> scream _very loudly_ for cases we do not expect, as non-fatal warnings
> are easily/often ignored, and can later turn out to be more critical
> than previously believed.
> 
> Thanks,
> Mark.

So what? Are we drop it? Or I can prepare new version with loud
warning and runtime patching.

Yury.
