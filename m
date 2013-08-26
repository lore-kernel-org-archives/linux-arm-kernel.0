From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Aug 2013 16:19:59 -0600
Subject: [PATCH] tegra-cpuidle: provide stub when !CONFIG_CPU_IDLE
In-Reply-To: <20130826153050.GC8764@redacted.bos.redhat.com>
References: <20130826153050.GC8764@redacted.bos.redhat.com>
Message-ID: <521BD48F.1060202@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2013 09:30 AM, Kyle McMartin wrote:
> While poking at something using the for-3.12/* trees, I hit the
> following compile error:
> drivers/built-in.o: In function `tegra_pcie_map_irq':
> /builddir/build/BUILD/kernel-3.10.fc20/linux-3.11.0-0.rc6.git4.1.fc20.armv7hl/drivers/pci/host/pci-tegra.c:640:
> undefined reference to `tegra_cpuidle_pcie_irqs_in_use'
> drivers/built-in.o: In function `tegra_msi_map':
> /builddir/build/BUILD/kernel-3.10.fc20/linux-3.11.0-0.rc6.git4.1.fc20.armv7hl/drivers/pci/host/pci-tegra.c:1227:
> undefined reference to `tegra_cpuidle_pcie_irqs_in_use'
> make: *** [vmlinux] Error 1
> 
> Since our .config had CONFIG_CPU_IDLE off. We should probably provide
> an empty function to handle this to avoid cluttering up pci-tegra.c
> with conditionals.

Another approach would be to use if (IS_ENABLED(CPU_IDLE)) at the call
site. I guess the approach in this patch is better than that though,
since it doesn't pollute the callers with knowledge of when this
function is available.

Thierry, if you're OK with this, I can forward it on to arm-soc.
