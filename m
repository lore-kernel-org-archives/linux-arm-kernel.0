From: jnair@caviumnetworks.com (Jayachandran C)
Date: Thu, 18 Jan 2018 09:56:16 -0800
Subject: [PATCH v2] arm64: Branch predictor hardening for Cavium ThunderX2
In-Reply-To: <20180118135354.GB20783@arm.com>
References: <20180108164651.GQ25869@arm.com>
 <1515502022-7376-1-git-send-email-jnair@caviumnetworks.com>
 <e9a192da-f603-6523-6d2e-858eb9c7d1b2@jonmasters.org>
 <20180116234554.GA38392@jc-sabre> <20180118135354.GB20783@arm.com>
Message-ID: <20180118175615.GF38392@jc-sabre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 01:53:55PM +0000, Will Deacon wrote:
> Hi JC,
> 
> On Tue, Jan 16, 2018 at 03:45:54PM -0800, Jayachandran C wrote:
> > On Tue, Jan 16, 2018 at 04:52:53PM -0500, Jon Masters wrote:
> > > On 01/09/2018 07:47 AM, Jayachandran C wrote:
> > > 
> > > > Use PSCI based mitigation for speculative execution attacks targeting
> > > > the branch predictor. The approach is similar to the one used for
> > > > Cortex-A CPUs, but in case of ThunderX2 we add another SMC call to
> > > > test if the firmware supports the capability.
> > > > 
> > > > If the secure firmware has been updated with the mitigation code to
> > > > invalidate the branch target buffer, we use the PSCI version call to
> > > > invoke it.
> > > 
> > > What's the status of this patch currently? Previously you had suggested
> > > to hold while the SMC got standardized, but then you seemed happy with
> > > pulling in. What's the latest?
> > 
> > My understanding is that the SMC standardization is being worked on
> > but will take more time, and the KPTI current patchset will go to
> > mainline before that.
> > 
> > Given that, I would expect arm64 maintainers to pick up this patch for
> > ThunderX2, but I have not seen any comments so far.
> > 
> > Will/Marc, please let me know if you are planning to pick this patch
> > into the KPTI tree.
> 
> Are you really sure you want us to apply this? If we do, then you can't run
> KVM guests anymore because your IMPDEF SMC results in an UNDEF being
> injected (crash below).
> 
> I really think that you should just hook up the enable_psci_bp_hardening
> callback like we've done for the Cortex CPUs. We can optimise this later
> once the SMC standarisation work has been completed (which is nearly final
> now and works in a backwards-compatible manner).

I think Marc's patch here:
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=kvm-arm64/kpti&id=d35e77fae4b70331310c3bc1796bb43b93f9a85e
handles returning for undefined smc calls in guest.

I think in this case we have to choose between crashing or giving a false
sense of security when a guest compiled with HARDEN_BRANCH_PREDICTOR is
booted on an hypervisor that does not support hardening. Crashing maybe
a reasonable option.

JC.
