From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Mon, 15 Oct 2018 08:34:44 -0600
Subject: [Freedreno] [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu
 device nodes
In-Reply-To: <20181015100327.qoojonf46lh6g3sh@vireshk-i7>
References: <20180827151112.25211-6-jcrouse@codeaurora.org>
 <20181010094628.wejfgmvcv6stzoco@vireshk-i7>
 <20181010142905.GB9977@jcrouse-lnx.qualcomm.com>
 <20181010143149.4e3ct3efkuwxa2hw@vireshk-i7>
 <20181010144856.GC9977@jcrouse-lnx.qualcomm.com>
 <20181010145139.nvalsr2ij2lj53dh@vireshk-i7>
 <20181010151006.GD9977@jcrouse-lnx.qualcomm.com>
 <20181011050216.4ba5i3ghh5rbvjbl@vireshk-i7>
 <20181011145456.GG9977@jcrouse-lnx.qualcomm.com>
 <20181015100327.qoojonf46lh6g3sh@vireshk-i7>
Message-ID: <20181015143444.GA4751@jcrouse-lnx.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 03:33:27PM +0530, Viresh Kumar wrote:
> On 11-10-18, 08:54, Jordan Crouse wrote:
> 
> I understand what you are trying to say Jordan and I agree with those
> expectations. But what I am looking for is consistency across Qcom
> code using the same feature. Which enables better support for the code
> going forward, etc. And if we are going to go a different way, there
> must be a very good reason to do that.

I agree that consistency is good. But the GPU is by design outside of the
control of the genpd universe so it is by design not using the same features.
It unfortunately does happen to use a similar number in an OPP binding to
construct the level mapping but since we can't read the cmd-db from the GMU
space this is a necessary evil.

> But let me try to understand the hardware a bit first..
> 
> > The GPU domain is completely controlled by the GMU hardware and is powered
> > independently of the CPU. For various reasons the GMU can't come up with
> > the vote itself so we need to construct a vote and send it during
> > initialization.
> 
> So it is the kernel which needs to send this vote on behalf of the GMU
> to RPM ? Who does the vote aggregation in this case ? I thought there
> has to be a single vote going from CPU side to the RPM. Isn't the GMU
> vote part of that ?

For clarity the GMU and GPU are in different domains. The GMU (which is
controlled by the CPU) is responsible for generating and sending the vote on
behalf of the GPU. From an RPMh perspective The GPU is considered to be
separate from the CPU vote.

Also, I probably confused you by saying that the kernel constructs the vote
for the GPU. It actually constructs the mapping that the GMU can use to send 
the vote. This is equivalent to rpmhpd_update_level_mapping() in the rpmhpd
driver if that helps.

> > For this we duplicate the code that rmphd does to query the
> > cmd-db and build the values using qcom,level as a guide. This is necessary
> > copypasta as the alternative would be to add the hooks into genpd or add a
> > side hook into the rpmhd to get the values we need and none of that is worth
> > it for a few lines of walking an array.
> 
> Initially when I was designing this qcom,level or generically called
> "performance-state" thingy, I kept the values directly in the OPP node
> of the consumer (the way you have done it), but then there were
> discussions which forced us to move this to the genpd level. For
> example, what will you do if you also need to pass voltage/current in
> addition to performance-state to the RPM? StephenB actually said we
> may or may not know these values and we must support both the cases.

I agree that genpd has many responsibilities because it has to deal with many
different devices.

The GMU / GPU is built for a single purpose and the hardware has been designed
accordingly. For the foreseeable future we will not need to know anything
beyond the level mapping to operate the GPU.

> The opp-microvolt properties of the consumer device (GPU here) should
> be used to handle the regulators which are controlled by kernel itself
> and so they can't additionally handle the RPMs data. And so we created
> separate OPP table for the RPM and represented that as a genpd and we
> now handle the aggregation in genpd core itself on behalf of all the
> consumers.

Yes and it should continue to be that way. This just happens to be a
situation where one of the consumers is out of your area of control by
design.

> > qcom,level serves the purpose for us in this case because we can get the value
> > we need and construct the vote. If we move to using required-opp, thats just
> > another step of parsing for the driver and
> 
> The OPP core shall have all the infrastructure to parse these things
> and we should keep all such code there to avoid duplication.

Using required-opp to look up another opp to look up the qcom,level is
by definition additional parsing. It doesn't imply that there would be
code duplication.

> > it establishes a relationship with
> > rmphd on the CPU that shouldn't exist.
> 
> Sure. I am not suggesting that the representation in software should
> be different from what the hardware is, maybe I didn't understood the
> hardware design well.
> 
> > I do see a good argument for using the symbolic bindings (i.e.
> > RPMH_REGULATOR_LEVEL_TURBO_L1) and we can do that easily but beyond that I
> > don't think that we need the extra parsing step.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
