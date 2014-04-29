From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Apr 2014 09:21:46 +0100
Subject: [PATCH v2 0/7] Add cros_ec changes for newer boards
In-Reply-To: <CAD=FV=UEwfNX+uf70OV4LB39s=mJyxTkC63g4iYrE7hcvyEdgw@mail.gmail.com>
References: <1398185154-19404-1-git-send-email-dianders@chromium.org>
 <20140423123240.GA640@lee--X1> <5357E832.1000806@wwwdotorg.org>
 <CAD=FV=XbjeOR+A-ZVYgOT69gsdp-YrjbkGrjL2Vf4F31ZkGXTA@mail.gmail.com>
 <CAD=FV=UWnLLzqzmrt0z=38iDOBSRJJLNAG8PL0GSHt1758ACcg@mail.gmail.com>
 <20140428091914.GK6264@lee--X1>
 <CAD=FV=UEwfNX+uf70OV4LB39s=mJyxTkC63g4iYrE7hcvyEdgw@mail.gmail.com>
Message-ID: <20140429082146.GE29462@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> >>> Need to wait for the ARM, DT and I2C guys to review, at which point
> >> >>> I'll be happy to take in and supply a branch for them to pull from if
> >> >>> required. If there are no _true_ dependencies and the MFD changes can
> >> >>> be added independently without fear of build breakages, let me know
> >> >>> and I'll apply them separately.
> >> >>
> >> >> I believe there aren't direct dependencies between the patches. So, the
> >> >> MFD patches can be applied to the MFD tree and the DT patch applied to
> >> >> the Tegra tree. I'm simply waiting for the MFD patches to be applied
> >> >> before applying the DT patch so that I know the DT binding definition is
> >> >> fully accepted before applying a patch that uses it.
> >> >
> >> > All of the MFD patches are safe to apply and in pretty much arbitrary
> >> > order.  The strong dependencies in the chain are:
> >> >
> >> > * We need patch #5 (mfd: cros_ec: Sync to the latest
> >> > cros_ec_commands.h from EC sources) before the i2c tunnel can compile.
> >> >
> >> > * As Stephen says, he shouldn't apply the device tree until we're
> >> > confident that the bindings are right.  However there's no strong
> >> > dependency otherwise.
> >> >
> >> > * Patches #1 #2 and #3 are simply reliability fixes.  Those could land
> >> > at any point in time and will improve other users of cros_ec_spi (like
> >> > the keyboard on tegra124-venice2).
> >> >
> >> > * Patch #4 can apply any time with no issues.  Without it large i2c
> >> > tunnel transfers won't work, but that's not a terrible problem (all
> >> > normal transfers are small).
> >>
> >> Patch #5 (latest ec commands) can also apply at any time with no
> >> issues, but it's needed for patch #6 (the tunnel) to compile.
> >>
> >> All that being said, I'd request that you merge patches #1-#5 as soon
> >> as you can and make sure you can provide a way that Wolfram can pull
> >> them (or at least patch #5) into his i2c tree to keep them applying
> >> when he is ready to land #6.
> >
> > Very well. So if I can obtain Wolfram's Ack, I can apply the MFD
> > changes along with patch #6 and supply him with a branch.
> 
> Can you explain the reason to wait for Wolfram's Ack before applying
> #1 - #5?  I would think:
> 
> 1. Create a topic branch.
> 2. Apply patches 1-5 to the topic branch
> 3. Merge the topic branch to your for-next branch
> 
> When Wolfram wants to take patch #6, he can either:
> A. Pull your topic branch
> B. If it's been long enough, patches will already be in ToT and no extra work.
> 
> If I understand correctly, using a topic branch and doing merges /
> pulls means that you can provide Wolfram with stable git hashes when
> he needs them and there will be no merge conflicts.

I don't use TBs for MFD yet, as I've never seen the need.  The current
WoW is to only create extra branches when I have patch{es, sets} to
share.  If I start using a more TB focused methodology it will be
insinuated that the branches are stable - I like the fact that this is
_not_ the case.  Currently I am able to rebase, rework and reorder the
repo as and when I see fit, and do regularly. Except the IBs of course.

> Patches #1 - #5 are bonafide bugfixes irrespective of the i2c tunnel.

I only want to create an IB if I know it's going to be used, else I'd
prefer the patches remain transient.  Why are you so keen to rush into
having these patches applied?  They _will_ make it into v3.15, whether
they are applied immediately or after a length of time (in the case
that Wolfram does not respond).

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
