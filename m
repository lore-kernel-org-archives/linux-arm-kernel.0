From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 8 Sep 2014 11:22:45 +0100
Subject: [PATCH 2/2] arm: psci: don't call CPU_OFF blindly
In-Reply-To: <alpine.DEB.2.02.1409052132450.2334@kaball.uk.xensource.com>
References: <1409916139-20127-1-git-send-email-mark.rutland@arm.com>
 <1409916139-20127-3-git-send-email-mark.rutland@arm.com>
 <alpine.DEB.2.02.1409052132450.2334@kaball.uk.xensource.com>
Message-ID: <20140908102245.GA12081@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 09:48:46PM +0100, Stefano Stabellini wrote:
> On Fri, 5 Sep 2014, Mark Rutland wrote:
> > The generic PSCI operations for arm check the presence of a CPU_OFF ID
> > far too late, and in the absence of an ID will panic(), rather than
> > producing a warning.
> > 
> > This patch adds a psci_cpu_disable callback which tests the presence of
> > a CPU_OFF id. As this is called earlier than psci_cpu_die, the failure
> > can be handled gracefully without brining down the system. Additionally
> > a check is added for a UP trusted OS in the presence of PSCI 0.2+. Full
> > support will require the use of MIGRATE, but for now rejecting hotplug
> > will prevent psci_cpu_die from brining down the system.
> > 
> > The now redundant check for scpi_ops.cpu_off is removed from
> > psci_cpu_die. At the same time, the whitespace is corrected from seven
> > spaces to tabs.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Cc: Ian Campbell <ian.campbell@citrix.com>
> > Cc: Christoffer Dall <christoffer.dall@linaro.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm/kernel/psci_smp.c | 36 +++++++++++++++++++++++++++++-------
> >  1 file changed, 29 insertions(+), 7 deletions(-)
> > 
> > Stefano, I've followed your lead with the __ref annotation here, but I couldn't
> > figure out why they exist on cpu_die and cpu_kill; it feels rather dodgy. Do
> > you know why they were added, or if they are superfluous?
> 
> I don't think that __ref is needed.
> That particular snipped of code came from Rob Herring, maybe he knows
> why it was added in the first place.

I've traced that back, but can't see any rationale. Perhaps that had
something to do with __cpuinit/__cpuexit, but there doesn't seem to be
any reason for them now. I guess the __ref annotation on cpu_die in
arch/arm/kernel/smp.c can go too given __cpuinit and __cpuexit are gone.

Rob, do you have any idea either way?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/158570.html
