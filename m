From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 15 Oct 2018 15:33:27 +0530
Subject: [Freedreno] [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu
 device nodes
In-Reply-To: <20181011145456.GG9977@jcrouse-lnx.qualcomm.com>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-6-jcrouse@codeaurora.org>
 <20181010094628.wejfgmvcv6stzoco@vireshk-i7>
 <20181010142905.GB9977@jcrouse-lnx.qualcomm.com>
 <20181010143149.4e3ct3efkuwxa2hw@vireshk-i7>
 <20181010144856.GC9977@jcrouse-lnx.qualcomm.com>
 <20181010145139.nvalsr2ij2lj53dh@vireshk-i7>
 <20181010151006.GD9977@jcrouse-lnx.qualcomm.com>
 <20181011050216.4ba5i3ghh5rbvjbl@vireshk-i7>
 <20181011145456.GG9977@jcrouse-lnx.qualcomm.com>
Message-ID: <20181015100327.qoojonf46lh6g3sh@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-10-18, 08:54, Jordan Crouse wrote:

I understand what you are trying to say Jordan and I agree with those
expectations. But what I am looking for is consistency across Qcom
code using the same feature. Which enables better support for the code
going forward, etc. And if we are going to go a different way, there
must be a very good reason to do that.

But let me try to understand the hardware a bit first..

> The GPU domain is completely controlled by the GMU hardware and is powered
> independently of the CPU. For various reasons the GMU can't come up with
> the vote itself so we need to construct a vote and send it during
> initialization.

So it is the kernel which needs to send this vote on behalf of the GMU
to RPM ? Who does the vote aggregation in this case ? I thought there
has to be a single vote going from CPU side to the RPM. Isn't the GMU
vote part of that ?

> For this we duplicate the code that rmphd does to query the
> cmd-db and build the values using qcom,level as a guide. This is necessary
> copypasta as the alternative would be to add the hooks into genpd or add a
> side hook into the rpmhd to get the values we need and none of that is worth
> it for a few lines of walking an array.

Initially when I was designing this qcom,level or generically called
"performance-state" thingy, I kept the values directly in the OPP node
of the consumer (the way you have done it), but then there were
discussions which forced us to move this to the genpd level. For
example, what will you do if you also need to pass voltage/current in
addition to performance-state to the RPM? StephenB actually said we
may or may not know these values and we must support both the cases.

The opp-microvolt properties of the consumer device (GPU here) should
be used to handle the regulators which are controlled by kernel itself
and so they can't additionally handle the RPMs data. And so we created
separate OPP table for the RPM and represented that as a genpd and we
now handle the aggregation in genpd core itself on behalf of all the
consumers.

> qcom,level serves the purpose for us in this case because we can get the value
> we need and construct the vote. If we move to using required-opp, thats just
> another step of parsing for the driver and

The OPP core shall have all the infrastructure to parse these things
and we should keep all such code there to avoid duplication.

> it establishes a relationship with
> rmphd on the CPU that shouldn't exist.

Sure. I am not suggesting that the representation in software should
be different from what the hardware is, maybe I didn't understood the
hardware design well.

> I do see a good argument for using the symbolic bindings (i.e.
> RPMH_REGULATOR_LEVEL_TURBO_L1) and we can do that easily but beyond that I
> don't think that we need the extra parsing step.

-- 
viresh
