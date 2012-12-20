From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Dec 2012 10:49:45 +0000
Subject: [PATCH] kexec: disable non-boot CPUs
In-Reply-To: <1355960681-32015-1-git-send-email-swarren@wwwdotorg.org>
References: <1355960681-32015-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121220104945.GC16887@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Dec 19, 2012 at 11:44:41PM +0000, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Both the regular reboot and shutdown paths do this. It seems reasonable
> for kexec to work the same way.
> 
> On the Tegra ARM SoC at least, this change allows kexec to work with SMP
> enabled. ARM's machine_shutdown() simply puts all CPUs into a loop. If
> the code of that loop is over-written, the CPUs may crash, and cause the
> kexec'd kernel not to be able to initialize them. In practice, this
> causes the kexec'd kernel to hang and/or crash. The intended way to
> solve this is for ARM machines to provide a cpu_kill SMP operation to
> e.g. power down the CPUs, or place them in reset. However, at least on
> Tegra, the implementation of that function would simply be duplicating
> the hotplug code that already exists, so it seems simpler to just call
> disable_nonboot_cpus() for the kexec path, just like reboot/shutdown.

If you do manage to get this merged, please can you follow up with a patch
to remove the smp_kill_cpus bits from arch/arm/kernel/smp.c please? It only
exists as a hook to do exactly this and currently nobody is using it afaict.

Cheers,

Will
