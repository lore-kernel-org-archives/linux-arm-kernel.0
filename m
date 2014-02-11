From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 11 Feb 2014 14:17:50 +0000
Subject: [PATCH RFC v3 0/3] ARM: defining idle states DT bindings
Message-ID: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v3 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/226901.html

This patchset depends on the following bindings to be approved and augmented
to cater for hierarchical power domains in DT:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/224928.html

Changes in v3:

- Renamed C-states to "idle states" in patches and cover letter
- Added SBSA definitions
- Added power_state parameter to PSCI
- Removed OPP dependency
- Split latency into entry/exit latencies
- Reintroduced processor and cache retention boolean
- Made power_state generic parameter for all entry methods
- Redefined idle state hierarchy

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
power state entry/exit latency) that define how an idle state has to be
managed and its respective properties. ARM partners implement HW power
management schemes through custom HW, with power controllers and relative
control mechanisms differing on both HW implementations and the way SW can
control them. This differentiation forces PM software in the kernel to cope
with states differences in power management drivers, which cause code
fragmentation and duplication of functionality.

Most of the power control scheme HW parameters are not probeable on ARM
platforms from a SW point of view, hence, in order to tackle the drivers
fragmentation problem, this patch series defines device tree bindings to
describe idle states parameters on ARM platforms.

Device tree bindings for idle states also require the introduction of device
tree bindings for processor caches, since idle states entry/exit require
SW cache maintainance; in some ARM systems, where firmware does not
support power down interfaces, cache maintainance must be carried out in the
OS power management layer, which then requires a description of the cache
topology through device tree nodes.

Idle states device tree standardization shares most of the concepts and
definitions with the ongoing ACPI ARM C-state bindings proposal so that
both standards can contain a coherent set of parameters, simplifying the
way SW will have to handle the respective device drivers.

Lorenzo Pieralisi (3):
  Documentation: devicetree: psci: define CPU suspend parameter
  Documentation: arm: add cache DT bindings
  Documentation: arm: define DT idle states bindings

 Documentation/devicetree/bindings/arm/cache.txt       | 165 +++
 Documentation/devicetree/bindings/arm/cpus.txt        |  10 +
 Documentation/devicetree/bindings/arm/idle-states.txt | 690 ++++++++++
 Documentation/devicetree/bindings/arm/psci.txt        |   7 +
 4 files changed, 872 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cache.txt
 create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt

-- 
1.8.4
