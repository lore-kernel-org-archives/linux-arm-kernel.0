From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Sep 2013 17:43:56 +0100
Subject: [PATCH 2/7] iommu/arm-smmu: Calculate SMMU_CB_BASE from smmu
 register values
In-Reply-To: <20130924180720.GV4845@alberich>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380035221-11576-3-git-send-email-andreas.herrmann@calxeda.com>
 <20130924153457.GC20774@mudshark.cambridge.arm.com>
 <20130924180720.GV4845@alberich>
Message-ID: <20130925164356.GF14502@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 07:07:20PM +0100, Andreas Herrmann wrote:
> On Tue, Sep 24, 2013 at 11:34:57AM -0400, Will Deacon wrote:
> > On Tue, Sep 24, 2013 at 04:06:56PM +0100, Andreas Herrmann wrote:
> > > Currently it is derived from smmu resource size. If the resource size
> > > is wrongly specified (e.g. too large) this leads to a miscalculation
> > > and can cause undefined behaviour when context bank registers are
> > > modified.

[...]

> > Hmm, this is a tricky one. We know that we have an inconsistency (i.e. the
> > DT and the hardware don't agree on the size of the device) but we warn and
> > attempt to continue with the value from the DT. I don't think that trusting
> > the hardware is the right thing to do in this case, since it's not possible
> > to change so we should let the DT act as an override.
> 
> > In other words: if the device tree is wrong, go fix it.
> 
> Yes, I've found this issue with a wrong DT. With the original code
> there was some weirdness when setting certain context bank
> registers. (Identifying the root cause was not straight forward.)
> 
> I think it's somehow odd not to trust the hardware values in the first
> place and to add (right from the beginning) a quirk for potential
> implementation bugs. Are there already implementations that use wrong
> register values that are required to determine the partitioning of the
> SMMU address space?

I don't know of any, but you can bet that people will want to run old
kernels on future hardware, so we should try and get this right from day
one.

> If there is a mismatch it's hard to say which value is the correct
> one. I think there are three options:
> (1) just print a warning about the mismatch
> (2) print a warning + override based on DT
> (3) print a warning + override based on DT + have an option to switch
>     off the override
> 
> So, what's your choice?

I had gone for (2), on the assumption that fixing a broken DT shouldn't be
too hard as well as allowing people to work around broken hardware. Yes, it
means we treat the DT as golden, but that's already the case in the absence
of fully probable hardware.

Will
