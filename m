From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Nov 2018 06:32:26 +0000
Subject: [PATCH] iommu: arm-smmu: Set SCTLR.HUPCF bit
In-Reply-To: <CAF6AEGtgC0V6ii2=p2HGmqvHFKNJhaOLi8873SGPDsrg70xGRg@mail.gmail.com>
References: <20180927224609.19515-1-robdclark@gmail.com>
 <20181029191000.GD16739@arm.com>
 <CAF6AEGtgC0V6ii2=p2HGmqvHFKNJhaOLi8873SGPDsrg70xGRg@mail.gmail.com>
Message-ID: <20181113063225.GA3109@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2018 at 01:01:55PM -0500, Rob Clark wrote:
> On Mon, Oct 29, 2018 at 3:09 PM Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Sep 27, 2018 at 06:46:07PM -0400, Rob Clark wrote:
> > > We seem to need to set either this or CFCFG (stall), otherwise gpu
> > > faults trigger problems with other in-flight transactions from the
> > > GPU causing CP errors, etc.
> > >
> > > In the ARM SMMU spec, the 'Hit under previous context fault' bit is
> > > described as:
> > >
> > >  '0' - Stall or terminate subsequent transactions in the presence
> > >        of an outstanding context fault
> > >  '1' - Process all subsequent transactions independently of any
> > >        outstanding context fault.
> > >
> > > Since we don't enable CFCFG (stall) the behavior of terminating
> > > other transactions makes sense.  And is probably not what we want
> > > (and definately not what we want for GPU).
> > >
> > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > ---
> > > So I hit this issue a long time back on 820 (msm8996) and at the
> > > time I solved it with a patch that enabled CFCFG.  And it resurfaced
> > > more recently on sdm845.  But at the time CFCFG was rejected, iirc
> > > because of concern that it would cause problems on other non-qcom
> > > arm smmu implementations.  And I think I forgot to send this version
> > > of the solution.
> > >
> > > If enabling HUPCF is anticipated to cause problems on other ARM
> > > SMMU implementations, I think I can come up with a variant of this
> > > patch which conditionally enables it for snapdragon.
> > >
> > > Either way, I'd really like to get some variant of this fix merged
> > > (and probably it would be a good idea for stable kernel branches
> > > too), since current behaviour with the GPU means faults turn into
> > > a fantastic cascade of fail.
> >
> > Can you describe how this fantastic cascade of fail improves with this
> > patch, please? If you're getting context faults then something has already
> > gone horribly wrong, so I'm trying to work out how this improves things.
> >
> 
> There are plenty of cases where getting iommu faults with a GPU is
> "normal", or at least not something the kernel or even GL driver can
> control.

Such as? All the mainline driver does is print a diagnostic and clear the
fault, which doesn't seem generally useful.

> With this patch, you still get the iommu fault, but it doesn't cause
> the gpu to crash.  But without it, other memory accesses in flight
> while the fault occurs, like the GPU command-processor reading further
> ahead in the cmdstream to setup next draw, would return zero's,
> causing the GPU to crash or get into a bad state.

I get that part, but I don't understand why we're seeing faults in the first
place and I worry that this patch is just the tip of the iceberg. It's also
not clear that processing subsequent transactions is always the right thing
to do in a world where we actually want to report (and handle) synchronous
faults from devices.

Will
