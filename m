From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 21 Apr 2015 16:51:01 +0100
Subject: your mail
In-Reply-To: <CAKv+Gu8Wd5MX0Ly5Okx57MpUeGpkNGHhqFCSqxy_HWFbsgtnOQ@mail.gmail.com>
References: <CAKv+Gu9u73+YKn+aR1vk+1eNF_voC71THWRQS96jyAt4HB3BQw@mail.gmail.com>
 <20150421104634.GA3996@e103592.cambridge.arm.com>
 <CAKv+Gu-3iM2+TvAgfV91FzfgAQuZhr=beeJ8RWmmGjTChbUrtQ@mail.gmail.com>
 <20150421111042.GB3996@e103592.cambridge.arm.com>
 <20150421112420.GV12732@n2100.arm.linux.org.uk>
 <20150421125049.GW12732@n2100.arm.linux.org.uk>
 <CAKv+Gu9TkvEGLz-8K_F3jbvourWw8R-XScGSPagxbaakRXZKpg@mail.gmail.com>
 <20150421132139.GE3996@e103592.cambridge.arm.com>
 <CAKv+Gu8Wd5MX0Ly5Okx57MpUeGpkNGHhqFCSqxy_HWFbsgtnOQ@mail.gmail.com>
Message-ID: <20150421135720.GA20723@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 03:28:14PM +0200, Ard Biesheuvel wrote:
> On 21 April 2015 at 15:21, Dave P Martin <Dave.Martin@arm.com> wrote:
> > On Tue, Apr 21, 2015 at 02:10:42PM +0100, Ard Biesheuvel wrote:
> >> On 21 April 2015 at 14:50, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Tue, Apr 21, 2015 at 12:24:20PM +0100, Russell King - ARM Linux wrote:
> >> >> We should probably create a badr macro to complement the adr pseudo-op
> >> >> which incorporates the BSYM thing so make this clearer - and a comment
> >> >> before it.  This is really the case where BSYM should be used.
> >> >
> >> > Something like this.  Note that I've also removed the BSYM() usage in
> >> > the KVM code.
> >> >
> >>
> >> Yes, that is much better. It is a pity that we still can't use '| 1'
> >> but the fact that you are forced to use 'adr' now probably mostly
> >> eliminates the risk regarding that.
> >>
> >> I did notice that are are 4 or 5 instances (commented inline) of an
> >> ARM to thumb mode switch which can just as easily be implemented as
> >> 'blx 1f' instead of using this badr macro (whose use we want to
> >> discourage, I assume, since the address arithmetic is still slightly
> >> dodgy). Do you think we should do something about that as well?
> >
> > Err, probably.  That just looks like an oversight -- I think I'm
> > responsible for at least some of those.
> >
> > There's no good reason not to replace adr+BSYM+bx.
> >
> > For switches from ARM, this could be replaced with bx <label> which
> > should work just fine.  There shouldn't be any instances of this from
> > Thumb, because switching instruction set is the whole point here.
> >
> > (Thumb doesn't have bx <label>, but blx <label> is available at the cost
> > of clobbering lr).
> >
> 
> It appears neither have 'bx <label>', but 'add pc, pc, #1; nop' does

Duh, I'm getting myself confused.  Yes, both have blx <label> but not
bx <label>.

Note that blx may result in suboptimal branch prediction because it
looks like a function call.  But these aren't hot paths, so I doubt
it matters.

> the job nicely as well.

Bit icky though...

Cheers
---Dave
