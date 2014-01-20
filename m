From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 20 Jan 2014 17:47:57 +0000
Subject: [PATCH RFC v2 0/2] ARM: defining power states DT bindings
Message-ID: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/215544.html

This patchset depends on the following bindings to be approved and augmented
to cater for hierarchical power domains in DT:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/224928.html

Changes in v2:

- Updated cache bindings according to review
- Added power domain phandle to cache bindings
- Added power domains to C-states bindings
- Removed useless reg property from C-states bindings
- Removed cpu-map references from C-states bindings
- Added dependency on OPP in C-states parameters
- Added C-state state hierarchy

ARM based systems embed power management HW that allows SW to enter
low-power states according to run-time criteria based on parameters (eg
power state entry/exit latency) that define how a power state has to be
managed and its respective properties. ARM partners implement HW power
management schemes through custom HW, with power controllers and relative
control mechanisms differing on both HW implementations and the way SW can
control them. This differentiation forces PM software in the kernel to cope
with states differences in power management drivers, which cause code
fragmentation and duplication of functionality.

Most of the power control scheme HW parameters are not probeable on ARM
platforms from a SW point of view, hence, in order to tackle the drivers
fragmentation problem, this patch series defines device tree bindings to
describe power states parameters on ARM platforms.

Device tree bindings for power states also require the introduction of device
tree bindings for processor caches, since power states entry/exit require
SW cache maintainance; in some ARM systems, where firmware does not
support power down interfaces, cache maintainance must be carried out in the
OS power management layer, which then requires a description of the cache
topology through device tree nodes.

The power states on ARM are described as "C-states" in this patchset,
borrowing the nomenclature from ACPI power states bindings which have by now
been widely adopted on both x86 and ARM world as power states names.

C-states device tree standardization shares most of the concepts and
definitions with the ongoing ACPI ARM C-state bindings proposal so that
both standards can contain a coherent set of parameters, simplifying the
way SW will have to handle the respective device drivers.

Lorenzo Pieralisi (2):
  Documentation: arm: add cache DT bindings
  Documentation: arm: define DT C-states bindings

 Documentation/devicetree/bindings/arm/c-states.txt | 774 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/cache.txt    | 187 +++++
 Documentation/devicetree/bindings/arm/cpus.txt     |  10 +
 3 files changed, 971 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/c-states.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cache.txt

-- 
1.8.4
