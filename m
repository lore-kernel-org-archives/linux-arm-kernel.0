From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Mar 2013 17:23:06 +0000
Subject: [PATCH v3] [RFC] arm: use PSCI if available
In-Reply-To: <alpine.DEB.2.02.1303271610430.4430@kaball.uk.xensource.com>
References: <1364388639-11210-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130327133811.GE18429@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1303271610430.4430@kaball.uk.xensource.com>
Message-ID: <20130327172306.GB20990@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 04:23:15PM +0000, Stefano Stabellini wrote:
> OK, let's see if I can make this acceptable to you.
> 
> 
> Would you agree on a patch that moves virt_smp_ops out of mach-virt and
> renames them to psci_smp_ops (maybe to arch/arm/kernel/psci_smp_ops.c)?

Moving the code out of psci.c is certainly a good first step, yes.

> Would you agree on initializing psci from setup_arch, right after the
> call to arm_dt_init_cpu_maps()?

Hmmm. An early_initcall runs before SMP is up, so why do you need this
earlier than that? Is it because you don't want to set the SMP ops later on?

> Finally the most controversial point: would you agree on using
> psci_smp_ops by default if they are available?
> If not, would you at least agree on letting Xen overwrite the default
> machine smp_ops?
> We need one or the other for dom0 support.

Again, I think there needs to be a dummy layer between the smp_ops and PSCI,
rather than assigning the things directly if we're going to use this as a
default implementation. I still question whether default PSCI operations make
any sense though... I understand that you're currently saying `yes, Xen can
use the same firmware interface as KVM' but will that always be true? What
happens when we want to run virtual machines on multi-cluster platforms, for
example? Will KVM and Xen make sure that CPU affinities are described in the
same way? What if one or the other decides to pass side-band information in
the power_state parameters?

In all of these cases, we'd have to split the code back up, so I don't see
any long-term value in consolidating everything just because it might be
possible today. The real problem you're trying to solve seems to stem from
patching the smp_ops in your dom0 kernel. Can you elaborate a bit more on
what's going on here please? How would having PSCI default smp_ops help you?

Cheers,

Will
