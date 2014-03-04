From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Tue, 04 Mar 2014 01:55:31 -0800
Subject: [PATCH v6 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <53111e0f.a50a430a.6ef6.ffff99ae@mx.google.com>
References: <1393545478-14908-1-git-send-email-sebastian.capella@linaro.org>
 <1393545478-14908-3-git-send-email-sebastian.capella@linaro.org>
 <20140228095022.GA25090@e102568-lin.cambridge.arm.com>
 <20140228201557.29118.62126@capellas-linux>
 <20140228224933.GA11040@e102568-lin.cambridge.arm.com>
 <53111e0f.a50a430a.6ef6.ffff99ae@mx.google.com>
Message-ID: <5315a319.a3b2440a.039b.ffffc66e@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sebastian Capella (2014-02-28 15:38:54)
> Quoting Lorenzo Pieralisi (2014-02-28 14:49:33)
> > On Fri, Feb 28, 2014 at 08:15:57PM +0000, Sebastian Capella wrote:
> > > > 
> > > > This does not guarantee your stack is 8-byte aligned, that's not AAPCS
> > > > compliant and might buy you trouble.
> > > > 
> > > > Either you align the stack or you align the pointer you are passing.
> > > > 
> > > > Please have a look at kernel/process.c
> > > 
> > > I've added this for now, do you see any issues?
> > > 
> > > -static u8 resume_stack[PAGE_SIZE/2] __nosavedata;
> > > +static u64 resume_stack[PAGE_SIZE/2/sizeof(u64)] __nosavedata;
> > > -               resume_stack + sizeof(resume_stack));
> > > +               resume_stack + ARRAY_SIZE(resume_stack));
> > 
> > I do not see why the stack depends on the PAGE_SIZE. I would be surprised
> > if you need more than a few bytes (given that soft_restart switches stack
> > again...), go through it with a debugger, it is easy to check the stack
> > usage and allow for some extra buffer (but half a page is not needed).
> 
> I assuming this is becase the no-save region is one page anyway (we skip
> restoring the no-save region physical page).  So maybe 1/2 is a way to
> leave some room for whatever else may need to be here, but in any case
> the 4k is used for nosave.  I think you're right that it can be much less.

Hi Lorenzo,

Are you ok with this just being half a page?  Or do you want me to try
to reduce the stack size?  I am at Connect without my debugger, so in
that case it would have to wait until next week.

The change for alignment is in as discussed.

Thanks!

Sebastian
