From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Jan 2018 09:53:26 +0000
Subject: [PATCH 2/2] arm64: Branch predictor hardening for Cavium ThunderX2
In-Reply-To: <20180109022617.GA4924@jc-sabre>
References: <20180108063115.GA163286@jc-sabre>
 <1515394416-166994-1-git-send-email-jnair@caviumnetworks.com>
 <1515394416-166994-2-git-send-email-jnair@caviumnetworks.com>
 <20180108164651.GQ25869@arm.com> <20180108171943.GA180149@jc-sabre>
 <20180108172341.GV25869@arm.com> <20180109022617.GA4924@jc-sabre>
Message-ID: <20180109095326.GC4297@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 06:26:20PM -0800, Jayachandran C wrote:
> On Mon, Jan 08, 2018 at 05:23:41PM +0000, Will Deacon wrote:
> > On Mon, Jan 08, 2018 at 09:19:43AM -0800, Jayachandran C wrote:
> > > On Mon, Jan 08, 2018 at 04:46:52PM +0000, Will Deacon wrote:
> > > > On Sun, Jan 07, 2018 at 10:53:36PM -0800, Jayachandran C wrote:
> > > > > +	arm_smccc_smc(CAVIUM_TX2_SIP_SMC_CALL, CAVIUM_TX2_BTB_HARDEN_CAP, 0, 0, 0, 0, 0, 0, &res);
> > > > 
> > > > One thing to be aware of here is that if somebody configures qemu to emulate
> > > > a TX2, this may actually disappear into EL3 and not return. You're better
> > > > off sticking with PSCI GET_VERSION in terms of portability, but it's your
> > > > call -- I'd expect you to deal with any breakage reports on the list due
> > > > to the SMC above. Fair?
> > > 
> > > I don't like having a custom SMC here either. But Overloading PSCI get version
> > > is the problem as I wrote earlier - there is no way to check if the firmware
> > > implements BTB hardening with overloading. There is a good chance that users
> > > with old firmware will just fail without any warning.
> > 
> > That's true, but there is precedent for this elsewhere. For example, CPU
> > errata that require a firmware change are often not probable. Also, your SMC
> > call won't always work (see the qemu comment below). Note that I'm not
> > saying I won't take this code, just that you need to be aware of what
> > you're doing.
> > 
> > > Is there a reason for overloading PSCI get version? Allocating a new standard
> > > SMC number would make checking for existance and usage much simpler.
> > 
> > PSCI get version is what we have today. We're working on extending PSCI to
> > allocate a new standard SMC number, but we need something that can be used
> > with existing firmware too and standardisation doesn't happen overnight.
> 
> Can you hold this patchset until the SMC number is published? Otherwise we
> will end up with two incompatible interfaces, and the mess of supporting
> both.

This has already been queued, and will be necessary for older PSCI versions
that can be extended to perform the BP invalidation in get version, but
which cannot be upgraded to a newer version of the spec. But that's fine; we
can support both interfaces because the new one will need to be discoverable
anyway.

> Or if there is a plan standardize this later, I can pickup a vendor specific
> SMC for now, and switch over to the standard one later. Any suggestions here?

I would suggest using GET VERSION for now and switching later, but it's
entirely up to you.

Wil
