From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 13 Oct 2015 17:39:09 +0100
Subject: [PATCH v2 00/17] Divorcing irqdomain and device_node
In-Reply-To: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
References: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151013163909.GA32295@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 12:51:28PM +0100, Marc Zyngier wrote:
> [This patch series used to be called "Making the generic ACPI GSI
> layer irqdomain aware", but as I've radically changed my approach to
> this problem, I've decided to reset the counters...]
> 
> The irqdomain code is not entierely ACPI friendly, as it has some
> built-in knowledge of the device-tree. Nothing too harmful, but enough
> to scare the ARM ACPI developpers which end up with their own version
> of the square wheel. And some of the ramifications actually run deeper
> than initially expected.
> 
> This series adapts the irqdomain code to use 'struct fwnode_handle'
> instead of 'struct device_node' as the identifier for a domain
> (compatibility interfaces are of course added). It also introduces a
> generic IRQ specifier that firmware interfaces (DT or ACPI) can
> directly use to configure interrupts, and allow the ACPI GSI code to
> be plugged into this.
> 
> As examples, we convert the ARM GIC ACPI support to use irqdomains as
> originally intended, and rework the MSI code to also move away from
> using device nodes when using irqdomains.
> 
> Overall, this gives us a way to use irqdomains on both DT and ACPI
> enabled platforms, having very little changes made to the actual
> drivers (other than the probing infrastructure). Because we keep the
> flow of information between the various layers identical between ACPI
> and DT, we immediately benefit from the existing infrastructure.
> 
> This has been test-booted on Juno, is based on 4.3-rc5 + tip/irq/core
> (in order to avoid potential conflicts), and available at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irq-domain-fwnode-v2

Tested on AMD Supercharger (ACPI PCI+MSI), by applying dependent series [0,1]
and some code soon to be posted to match gic v2m fwnode using this neat
patch series :-)

Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

[0] https://lkml.org/lkml/2015/6/8/443
[1] http://comments.gmane.org/gmane.linux.kernel.pci/40904
