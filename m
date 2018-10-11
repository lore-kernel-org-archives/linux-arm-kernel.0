From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Thu, 11 Oct 2018 08:54:56 -0600
Subject: [Freedreno] [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu
 device nodes
In-Reply-To: <20181011050216.4ba5i3ghh5rbvjbl@vireshk-i7>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-6-jcrouse@codeaurora.org>
 <20181010094628.wejfgmvcv6stzoco@vireshk-i7>
 <20181010142905.GB9977@jcrouse-lnx.qualcomm.com>
 <20181010143149.4e3ct3efkuwxa2hw@vireshk-i7>
 <20181010144856.GC9977@jcrouse-lnx.qualcomm.com>
 <20181010145139.nvalsr2ij2lj53dh@vireshk-i7>
 <20181010151006.GD9977@jcrouse-lnx.qualcomm.com>
 <20181011050216.4ba5i3ghh5rbvjbl@vireshk-i7>
Message-ID: <20181011145456.GG9977@jcrouse-lnx.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2018 at 10:32:16AM +0530, Viresh Kumar wrote:
> On 10-10-18, 09:10, Jordan Crouse wrote:
> > On Wed, Oct 10, 2018 at 08:21:39PM +0530, Viresh Kumar wrote:
> > > On 10-10-18, 08:48, Jordan Crouse wrote:
> > > > qcom,level comes straight from:
> > > > 
> > > > https://lore.kernel.org/lkml/20180627045234.27403-2-rnayak at codeaurora.org/
> > > > 
> > > > But in this case instead of using the CPU to program the RPMh we are passing
> > > > the value to a microprocessor (the GMU) and that will do the vote on our behalf
> > > > (Technically we use the value to look up the vote in the cmd-db database and
> > > > pass that to the GMU)
> > > > 
> > > > This is why the qcom,level was added in the first place so we could at least
> > > > share the nomenclature with the rpmhd if not the implementation.
> > > 
> > > How you actually pass the vote to the underlying hardware, RPMh or
> > > GMU, is irrelevant to the whole thing. What is important is how we
> > > describe that in DT and how we represent the whole thing.
> > > 
> > > We have chosen genpd + OPP to do this and same should be used by you
> > > as well. Another benefit is that the genpd core will do vote
> > > aggregation for you here.
> > 
> > I'm not sure what you are suggesting? The vote is represented in DT exactly as
> > described in the bindings. 
> 
> Look at how Rajendra has done it to see the difference.
> 
> https://lore.kernel.org/lkml/20180627045234.27403-3-rnayak at codeaurora.org/

The GPU domain is completely controlled by the GMU hardware and is powered
independently of the CPU. For various reasons the GMU can't come up with
the vote itself so we need to construct a vote and send it during
initialization. For this we duplicate the code that rmphd does to query the
cmd-db and build the values using qcom,level as a guide. This is necessary
copypasta as the alternative would be to add the hooks into genpd or add a
side hook into the rpmhd to get the values we need and none of that is worth
it for a few lines of walking an array.

qcom,level serves the purpose for us in this case because we can get the value
we need and construct the vote. If we move to using required-opp, thats just
another step of parsing for the driver and it establishes a relationship with
rmphd on the CPU that shouldn't exist.

I do see a good argument for using the symbolic bindings (i.e.
RPMH_REGULATOR_LEVEL_TURBO_L1) and we can do that easily but beyond that I
don't think that we need the extra parsing step.

Thanks,
Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
