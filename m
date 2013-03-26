From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Mar 2013 15:04:44 +0000
Subject: [PATCH v2 6/6] [RFC] arm: use PSCI if available
In-Reply-To: <1364308875-26484-6-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1303261423530.4430@kaball.uk.xensource.com>
 <1364308875-26484-6-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20130326150444.GI20252@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On Tue, Mar 26, 2013 at 02:41:15PM +0000, Stefano Stabellini wrote:
> Check for the presence of PSCI before setting smp_ops, use PSCI if it is
> available.
> 
> This is useful because at least when running on Xen it's possible to have a
> PSCI node for example on a Versatile Express or an Exynos5 machine. In these
> cases the PSCI SMP calls should be the ones to be called.
> 
> Remove virt_smp_ops and platsmp.c from mach-virt because they aren't needed
> anymore.

[...]

> +struct smp_operations __initdata psci_smp_ops = {
> +	.smp_init_cpus		= psci_smp_init_cpus,
> +	.smp_prepare_cpus	= psci_smp_prepare_cpus,
> +	.smp_secondary_init	= psci_secondary_init,
> +	.smp_boot_secondary	= psci_boot_secondary,
> +};

Whilst I like the idea of this, I don't think things will pan out this
nicely in practice. There will almost always be a level of indirection
required between the internal Linux SMP operations and the expectations of
the PSCI firmware, whether this is in CPU numbering or other,
platform-specific fields in various parameters.

Tying these two things together like this confuses the layering in my
opinion and will likely lead to potentially subtle breakages if platforms
start trying to adopt this.

If this can indeed work for the virtual platforms (Xen and KVM), then I
think it would be better expressed using `virt' smp_ops, which map directly
to PSCI, rather than putting them here. Even then, it's tying KVM and Xen
together on the firmware side of things...

Will
