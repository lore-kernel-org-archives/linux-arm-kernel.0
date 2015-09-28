From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Sep 2015 17:42:53 +0100
Subject: [PATCH v4 0/9] Making the generic ACPI GSI layer irqdomain aware
Message-ID: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irqdomain code is not entierely ACPI friendly, as it has some
built-in knowledge of the device-tree. Nothing too harmful, but enough
to scare the ARM ACPI developpers which end up with their own version
of the square wheel.

This small patch series adapts the irqdomain code to remove the
hurdles that prevent the full blown irqdomain subsystem to be used on
ACPI, creates an interface between the GSI layer and the irqdomain,
and as an example, convert the ARM GIC ACPI support to use irqdomains
as originally intended.

Overall, this gives us a way to use irqdomains on both DT and ACPI
enabled platforms, having very little changes made to the actual
drivers (other than the probing infrastructure). Because we keep the
flow of information between the various layers identical between ACPI
and DT, we immediately benefit from the existing infrastructure. The
"convert the GSI information to be DT friendly" is admitedly not very
pretty, but I see it as a stepping stone towards unifying the two
structures.

This has been test-booted on Juno, is based on 4.3-rc3, and available at:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gsi-irq-domain-v4

* From v3:
   - Got rid of the whole "void *" malarchy, and introduce a DT-based
     fwnode_handle allocator. Much smaller patch, better type checking,
     and a path forward to introduce fwnode_handle as the irqdomain
     identifier.
   - Small rework of the GIC stuff (cleanup, mostly).

* From v2:
   - Rebased on vanilla 4.3-rc1
   - Added the IDR infrastructure to irqdomain.c so that drivers don't
     have to come up with their own way of allocating identifiers
   - Changed the acpi_set_irq_model() signature to directly take a
     void *domain_token

* From v1:
  - Improved my Coccinelle foo and hopefully caught all the
    irq_domain.of_node users this time
  - Decoupled acpi_irq_model from domain_token. These are now two
    separate values that can be set independently
  - Moved the duty of populating acpi_gsi_descriptor to the interrupt
    controller, as it keeps the knowledge of the mapping with
    of_phandle_args in a single location
  - Generic accessor to set acpi_irq_model, domain_token and the
    populate function all in one go from the interrupt controller
  - General cleanup

Marc Zyngier (9):
  drivers/of: Introduce of_node_alloc
  genirq/irqdomain: Add irq_create_acpi_mapping
  genirq/irqdomain: Add a fwnode_handle allocator
  acpi/gsi: Always perform an irq domain lookup
  acpi/gsi: Add acpi_set_irq_model to initialize the GSI layer
  acpi/gsi: Select OF_DYNAMIC when ACPI_GENERIC_GSI is selected
  irqchip/GIC: Get rid of gic_init_bases()
  irqchip/GIC: Switch ACPI support to stacked domains
  acpi/gsi: Cleanup acpi_register_gsi

 drivers/acpi/Kconfig            |  1 +
 drivers/acpi/gsi.c              | 61 ++++++++++++++++++++++++-------------
 drivers/irqchip/irq-gic.c       | 66 ++++++++++++++++++++++++++++++-----------
 drivers/of/dynamic.c            | 22 ++++++++++++++
 include/linux/acpi.h            | 14 +++++++++
 include/linux/irqchip/arm-gic.h |  9 ++----
 include/linux/irqdomain.h       |  2 ++
 include/linux/of.h              |  5 ++++
 kernel/irq/irqdomain.c          | 48 ++++++++++++++++++++++++++++++
 9 files changed, 183 insertions(+), 45 deletions(-)

-- 
2.1.4
