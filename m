From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 6 Nov 2013 14:57:05 +0000
Subject: Raw notes from ARM summit.
Message-ID: <CACxGe6vwNv7a4h_SzyN2pgnY_2HfDLQqtw9ZsJqqba4HeQKD0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm really close to getting a summarized report from the arm summit
finished and posted, but it has dragged out longer than I would like.
Therefore here are the raw notes from Etherpad. You can expect the
report form to be published in the next 24 hours.

http://etherpad.osuosl.org/arm-ksummit-2013

The calendar:
http://goo.gl/ifLxHl

Tuesday 22 October
9:00 Welcome
9:15 ARM Maintenance
ARM SoC Tree
Olof: Uncontentious as of late. Hitting a few cases where pull
requests are getting lost
- If you pull req isn't getting pulled, send it again (1 week is a
reasonable timeout)
- Olof asks for pull requests to be based on the earliest rc possible
- Russell: wants the same thing, otherwise it looks like extra stuff
is getting pulled in.
- Online kernel test reports posted to the lists - useful
    - Olof, Kevin, Paul doing thi
    - Reports posted to <kernel-build-reports@lists.linaro.org>
    - Mike working on a similar system to catch power regressions
    - Possible extensions: dashboard, delta e-mails to only be
notified when something changes, unified format
    - Grant: would like to test PowerPC, x86, etc also to ensure that
those platforms aren't breaking anything
    - 0-day build tests are great, but Intel hasn't committed to keep
it running in the future, so we can't rely on it in our process. If we
want to run similar tests as part of our process, we need a system
that we can maintain (possibly with Linaro?)

Russell King
- "for the most part it's working quite well"
- It's good for folks to send a reminder a week after their pull
requests to make sure that Russell gets it
    - 8000-9000 messages per month on the list, so it's easy for
things to get lost
    - Pull requests should be sent or cc'ed to linux+pull at arm.linux.org.uk

Olof: it's difficult to tell, when sent a patch, whether the sender
intends for folks to apply it or review it
    - if the intention is for the arm-soc folks to apply it, please say so
    - Use arm at kernel.org for arm-soc patches to be applied and pull
requests, since extra people on CC (but also CC regular mailing lists)


Catalin Marinas
- ARM64: no official SoC support yet, core patches are merged
- kprobes, three sets of big-endian patches, two sets of ftrace patches

Will Deacon
- folks are writing code, but not reviewing code
    - particularly for ARM64
        - lots of junk: #if 0s, Thumb-2 code

Reviews
- Olof: "just because code is reviewed internally in a company doesn't
mean that it's been reviewed on the list"
- Internal reviews vs. reviews on the public mailing lists
- rmk: Please _read through your own patch_ before submitting

Patches for old boards/old subarches
- Tony: best to avoid patches for boards that no one is using -
probably only 12 boards that are commonly used
- rmk: some subarches/boards might be stable, and therefore might not
need patching
- Olof: some platforms have only half the code they need for them to
build and boot  - particularly some corporate platforms
- Arnd/Mark: hopefully many of these will be caught by multi-configs
and allmodconfig
    - Arnd: allyesconfig has been broken for ~9 months
        - Olof: will get worse
        - Kernel size is exceeding 32 MB which causes problems for
handcoded branches in assembly
        - depend on COMPILE_TEST for build coverage
    - Wolfram: allnoconfig is also interesting to catch missing dependencies
        - Arnd: but this will also affect the NOMMU code - lots of
Kconfig-related breakage here
    - Grant: should old subarches be deprecated?
        - Arnd: let's talk about this in five years
        - (will return to this after the break)

Future of NOMMU
    - Upcoming Cortex-M3 platforms?
    - R-class: MPU support and SMP in mainline, potential for limited
multi-platform via suggested memory map (see ARMv7 PMSA)

(maintainership session over)

10:30a kernel consolidation

Still missing from multiplatform:
    - MSM, sh-mobile, realview, AT91, exynos, ... ?

Linus Walleij presented his per-subarch spreadsheet of what's
remaining to be done for CONFIG_ARCH_MULTIPLATFORM
Google Doc: http://goo.gl/GD9MAO

Status:
    - AT91: in progress: Nicolas F. - common clock framework being
reviewed those days
    - clps*: being done on the side
         - also a v4 platform
    - exynos: stalled as of about a year ago
    - integrator: LinusW working on it
    - versatile: Grant working on it, LinusW
    - realview: LinusW
    - shmobile: in progress - renesas folks
    - s5p: ?
    - s3c: tomasz figa, maxime
    - gemini: no need to convert these - no response on the patches
    - lpc32xx: almost done
    - davinci: hardly anyone's working on it @ TI - no bandwidth to work on it
        - still mainline users

Arnd: All of the "multiplatform-never" subarches are strongarm/xscale based
    - non-standard PCI I/O space implementation

Arnd: pxa has a huge hobbyist community, but is also very difficult to
convert to multiplatform
    - will probably get pxa DT support since it's close to MMP

Q: What's the timeline?
Olof: we have to look for movement
    - AT91: haven't seen very much work for a while
        - Nicolas: Working on CCF port - patches posted - unlikely to
make it for v3.13
    - Kevin: speed is not the issue, just seeing consistent movement over time

Olof: please keep posting and staging code over time
    - Let's try to avoid the pileup of patches around -rc6
        - Usually a corporate way of working due to managers, milestones, etc.

Arnd: v4 will soon be multiplatform, except for StrongARM

OMAP1: Tony: should be pretty easy to make multiplatform
    - CCF conversion might be a pain

imx: Sascha: not all have DT support yet
    - still have board files for some chips

** Anyone can help who has hardware

Olof: "a day in linux-next is probably enough" before sending pull
requests to arm-soc

Arnd: would like more topic branches, rather than large pull requests

Kevin: Please make it clear whether a pull request is a replacement of
an existing pull request, or whether it's a brand new pull requests
    - clarify terminology like "v2", "take 2", "part 2"
        - it _should_ mean a replacement of the previous pull request

Olof: happy to apply patches individually, rather than pull requests,
if there are a small number of patches

rmk: please don't modify branches that you've already asked to be pulled

Olof: don't replace old tags that you've already sent pull requests for

rmk: will often pull a branch, test it, then go back a few days later
and re-pull it

Stephen: question about the defconfigs
    - tegra_defconfig has lots of drivers enabled
    - should probably remove many of these defconfigs, and switch to
multi_v7_defconfig
    - but can't patch multi_v7_defconfig in subarch trees due to
potential for conflicts
    - Olof: arm-soc can directly apply patches for these common files,
rather than taking pull requests.
    - switch to multi_v7_defconfig?
        Olof: am happy with enabling the superset of drivers to
multi_v7_defconfig

Tony: is there a plan to make multi_v7_defconfig modular?
    - has to happen to scale it

Olof: suggest switching driver kconfig entries to 'M' in multi_v7_defconfig
    - but please build in drivers that are needed to boot from disk,
so you don't need an initramfs

Olof: most embedded devices are not shipping with modules enabled

Tony: most dependencies that are enforced via explicit initcall
ordering seem to be artificial
    - switching to modules will expose those
    - ... what about IOMMUs? (all use subsys_initcall, needed early to
initialise bus)

Arnd: early clocks might be a problem

Tony: for clocks that are needed early, these can be registered early
and separately with the CCF

Tony: using the standard Linux driver interfaces & dynamic loadable
modules provides extra protection against spaghetti code

Kevin: let's all agree that the long-term goal is to make almost
everything modular for multi_v7_defconfig

Grant: is a tool needed to build an initramfs?
    - Kevin: but that's the same thing as maintaining a mini-distro
and nobody wants to do that
    - Grant: intended to be a development tool
    ? Any takers for someone to work on this?
        - Tony volunteered himself and Kevin for this
        - mturquette: Dracut? https://dracut.wiki.kernel.org/index.php/Main_Page

Jonathan Austin: what about Kconfig fragments?
    - Olof: almost worse than having defconfigs due to the number of
permutations

Magnus: is there a list of Kconfig options that shouldn't be touched?  HIGHMEM?

Olof: per-platform defconfig should be useful for the maintainer, so
the choice of Kconfig options should be up to the maintainer

Kevin: Kconfig fragments for power management setup?
    - Olof: should just turn them on - if they cause crashing, that
should be addressed

Olof: it's nice to have explicit documentation in the Kconfig help
about where UARTs are mapped on which boards

[Reasons not to use] Thumb-2:
    - Early A15 (r0p4) cannot use a thumb-2 guest kernel. Later versions are OK.
    - hackbench performance regression (toolchain issue?)
    - Restricted module virtual space (due to branch limitations)
    - Backtracing? (no frame pointer)

Early debugging:
Stephen: on DEBUG_LL, should there be a common mechanism for the
bootloader to pass the UART parameters to the kernel?
    - Olof: the way x86 does it is great
    - Sascha: could set a DT property
    - Tony: use an SoC-specific or ARM-specific earlycon
    - Catalin: on ARM64, we have a "late earlycon"
    - Tony: limit the DEBUG_LL to be really really early so people
don't rely on it for later debugging
    - Russell: DEBUG_LL was never meant to be an earlycon implementation
        - Keeping DEBUG_LL as a hard-configured option that should be
only used for really early debugging
        - Vast range of different UARTs that are available
    - Olof: bootargs should be sufficient
    - Catalin: problem is that the DT has not yet been unflattened
    - Arnd: but the unflattened DT can be parsed
    - Olof: what about enabling clocks, etc?
    - Russell: trying to get away from platform-specific drivers for UARTs, etc.
        - UART parameters should be passed in dynamically
    - Magnus: on sh-mobile, we pass the driver name
        - could be extended to use DT and possibly usable for more platforms?
    - Russell: early platform_driver seems like a hack
        - Arnd/Grant don't like it either
    - Magnus: used on sh-mobile for timers and early serial output
    - Grant: in a DT-based boot, how to determine whether a device
should be probed early or not?
    - Arnd: with DT, there's no need to create early platform_devices
- can just read the data straight from DT?
    - Grant: use of_clk_init, of_irq_init?
    - Arnd: need system controller driver?
    - Kumar: the list of dependencies keep growing
    - Grant: do they need to be tied into the driver model?
    - Kumar: example: hardware semaphores are needed for the QCOM
system controller, but OMAP doesn't
        - the set of device dependencies can be different for each SoC vendor
    - Kumar: there is still an initcall issue
        - adding more of_<blah>_init() is not a good approach
        - deferred probe is not enough
    * How much needs to be done before initcalls start?
    - Olof: with the device model that we have today, we don't have a
good way to describe dependencies
    - Grant: how to build multi-hierarchy dependencies into the device model?
        - deferred probe is easier to implement than refcounting
    - Magnus: SMP bringup should happen later - once initcalls start
        - right now it happens before the initcalls start (after early
initcalls)
    - Russell: ubuntu systems load kernel modules in parallel
        - kernel serializes the load, but initialization can sleep and
another module can run)

(12:04 break for lunch)

1:00p Non-probeable system topologies
Will Deacon

DT data does not depict the actual topology of the device

Things are working today, but things are about to get hairy:
- Cache coherency: CCI
    - QoS, PM, nested buses, rings, shareability domains
    - constraints?
- SMMU
    - Look at Will's driver
    - Requester ID (RID) -> Stream ID (SID) -> Device ID (DID)
        - RIDs allocated by the SoC integrator
        - RIDs may not map directly to SID
    - PCIe
    - Can have multiple SMMUs
- DMA - between endpoints
- GIC - support for MSI and virtual interrupts (DIDs and ITS)
- Interconnects
    - Loss of metadata (stripped off during the interconnect)

Will has an idea for per-master coherency

(Marc drawing on flipbook)
    - imagine you have a PCIe root complex - connected to an SMMU -
connected to an interconnect
    - PCIe devices writing through this topology
    - If the hardware removes any of the requestor ID data, the kernel
has to recreate it somehow

Olof: can you just tag the PCIe controller with a DID?

Arnd: can this be handled with DMA ranges in the DT?

GregKH: isn't PCIe supposed to be completely probeable?

Stephen: GPUs could initiate transactions with 1 or more device IDs
    - the set of IDs are static, but perhaps it's dynamic

Will: PCIe is a good example of this because it's hotpluggable
    - RID-SID mappings can be dynamic

Also virtualization has an impact here

GregKH: on x86, the mappings are all handled by firmware - hidden from
the host OS

Will: at the moment, we have the SMMU driver, we can describe its inputs in DT
    - but we can't talk to the PCIe controller
    - interrupt source IDs also needed for MSI

Stephen: Does ARM mandate that you have to use the ITS block for MSI GIC usage?
    - GregKH: no

Grant: not a UEFI issue, it's an ACPI issue or firmware or secure world issue

Arnd: during the bootup it doesn't matter
    - as long as the IOMMU isn't used, it doesn't matter
    - Will: for MSI, the DIDs are needed

Marc: but ITS cannot be programmed for 1:1 mapping

UEFI: Can UEFI platform drivers be hosted in the TianoCore repositories?
    - "Contributed-under" tag

Will: can also have a choice of ITS blocks to use

Firmware vs. non-firmware implementation
- Not all ARM integrators can use firmware approaches
- x86 uses firmware implementations (mostly, except for the phone SoCs)

Mark: the Intel phone SoCs need board files

1:30p ARM64 firmware: MCPM & PSCI / ARMv8 board support
Catalin Marinas

ARMv8 (secure) firmware requirements

- Try to force people to do some initialization in their firmware
rather than in the early kernel code, since the kernel doesn't know
what SoC it's booted on yet

- PSCI specification
    - Standard API to (secure) firmware
- MCPM - Multi-cluster power management
    - Linux kernel framework for multicluster power coordination
    - Developed by Nico and Dave Martin

ARMv8 Exception Model
- Privilege levels: EL3 - highest, EL0 - lowest
    - EL3 may not be used on all platforms
- Transition to higher levels via exception, lower levels via ERET
- EL3 mode on reset on ARMv8 (vs. Secure SVC on ARMv7)

Firmware requirements
- Booting responsibilities
    - Hardware init, secondary CPU parking, start secure OS, start
UEFI or bootloader
- Runtime responsibilities
    - Separation of the secure & non-secure worlds
    - Consequently, some CPU registers and peripherals are secure-only
        - ACTLR (SMP bit), CCI regs, errata workarounds

Existing firmware (primarily ARMv7)
- Mostly in ROM
- SoC-specific interface for secure-only functionality
    - ACTLR, some power management (flushing caches, etc)
- Non-standard SMC calls
    - CPU power up/down/idle, secondary CPU booting, etc.

So to try to standardize this, ARM has proposed the PSCI interface
    - CPU power up/down/idle, system off/restart
    - Applies to AArch32 & 64
    - Standard SMC interface

Power management
    - Linux vs firmware
        - Firmware disadvantages
            - Can get it wrong - bad if it's in ROM
            - Cannot be entirely avoided on ARMv8
    - Alternatives for multi-cluster power management
        - MCPM: usually assumes Linux running in secure mode
        - Future lightweight firmware interface?
        - Definitely not: random SoC-specific SMC calls
        - ACPI can hide some of the SoC-specific register poking

Paul: cannot assume that PSCI will be the only interface for CPU power
management

Catalin: for ARMv8: for booting, it's PSCI or spin-tables

Kumar: is this argument simply about not wanting to have per-SoC code
under arch/arm64/* ?

Development platforms (e.g., vexpress) vs actual end-products

Olof: there's a tension with merging development platforms with
complex interfaces.  One wishes to avoid having other platforms model
their code based on that.  But one also wants to boot the development
platforms with mainline Linux.

Grant: there are some ecosystems where the firmware vendor will be
third-party and high quality, and other platforms that are vertically
integrated where the firmware might be wrong
    - largest part of the ARM market is vertically integrated

Kumar: the TrustZone folks are pushing back against adding more secure
code since it's harder to audit

Catalin: to summarize: if you're going to do CPU power management via
SMC, use PSCI

There is the SMC standard calling convention
- Kevin: but the Trusted Foundations code doesn't follow that convention

ARMv8 board support
Catalin Marinas

A lot of code can go into drivers now

Generic timer

ARMv8 implementation has been based on the arm-soc tree
- So far, development has been based on the software model

Uses PSCI for CPU power management

PCIe is still missing

Arnd: use the PowerPC or the ARM implementation of PCIe? leaning towards the ARM
    - PowerPC code has some features that the ARM code doesn't
    - whoever does the work will make the decision
        - and have to convince the maintainers

Arnd: would like to end up with only one PCIe implementation in drivers/host

Sekhar/Arnd: Exynos, TI, ST, Freescale are all using DesignWare for
their host controller driver

Arnd: current code hooks back into architecture-specific code, but
that should not be necessary

SoC-specific code vs. architecture-specific code

Arnd: there are two parts: the host controller driver and another
SoC-specific part

Arnd: we don't have to worry about StrongARM & XScale because they
won't be multiplatform

RobH: we tried to move some of the code out of arch/powerpc but BenH
objected - said there was a lot of legacy code there

Olof: what about DVFS?
MikeT: let's talk about that tomorrow

Kumar: what about moving DT source data out of the kernel tree?
Olof: will talk about that tomorrow

3:30p Break

4:00p Exploit mitigation, security
Kees Cook

http://outflux.net/slides/2013/arm/mitigation.pdf

Overview
- Classic attack structure
- Fuzzing and static analysis
- Page permission mitigation
- Reduced target exposure
- ASLR
- Existing infrastructure/work

Classic attack structure:
Example: linux-rds-exploit.c

Fuzzing and static analysis
- Trinity
    * Consider running Trinity for ten minutes and then shuts down as
part of automated test setups
- Custom hardware
    - Facedancer for USB
        - Kees found 12 bugs in USB HID
- smatch
- coccinelle

? Are Trinity failures reproducible?
    - Marc: not necessarily

Page permission mitigations
- Do not write RO data
- Do not execute data
- Do not allow code to be written
- Do not execute userspace from kernel
    - x86: SMEP, ARM: PXN.  Can be emulated.
- Do not read/write userspace from kernel
    - x86: SMAP, ARM does not support this right now.  Can be emulated

Reducing target exposure
- Certain areas of the kernel are only written at init time and/or very rarely
- Make these read-only (and if we must, allow for limited & well-known
runtime exceptions)
    - Various function tables, e.g., x86 IDT
    - ARM vectors mapping is RW in kernel
- Largely unexplored in upstream

ASLR in the kernel
- Disrupts finding where to write & execute
    - Statistical defense - very vulnerable to information leaks
- Well established in userspace
- Kernel ASLR
    - Now: text (x86)
    - Soon: modules, kmalloc, vmalloc
    - Need help: text (arm)

Does relocation support exist for ARM?
rmk: it does not exist for the core code
    - cannot easily work out phys-to-virt translations
    - x86 does not have the problem that you don't know where physical
memory lives
        - on ARM, memory can start anywhere in the physical address space
        - on LPAE, memory might actually start above the 4 GiB boundary

Arnd: isn't it only randomized within a small region?
    Kees: yes

Kees: sounds like there's tons of work to be done to get this working on ARM

Existing infrastructure
- x86, s390: set_memory_ro(), set_memory_nx()
    - CONFIG_DEBUG_RODATA, CONFIG_DEBUG_SET_MODULE_RONX
- equivalent of CONFIG_X86_PTDUMP
    - x86: /sys/kernel/debug/kernel_page_tables
    - ARM via /dev/mem: grsecurity kmaps*.c code
        * would like this to use the x86 debugfs interface also

Existing work
- Larry Bassel, Laura Abbott: CONFIG_STRICT_MEMORY_RWX
    - RFC for initial R, RW, RX support
- grsecurity/PaX
    - Fully RO, RW, RX, "KERNEXEC", and "UDEREF"
    - forums.grsecurity.net post - f=7 t=3292

Laura: sent out patches to add NX support for modules also

Arnd: what about using the 4G/4G split for security reasons?
    - problem is, copy_{to,from}_user() gets quite expensive because
kmap() must be called first

rmk: vectors page is also an issue
    - it's now RO
        - there is one corner case where they have to be updated via FIQs
        - Arnd: can FIQs be disabled?
        - Russell: most platforms don't use them - but then there's kgdb
            - Laura: and useful for "NMI" watchdog purposes
    - it's almost impossible to get rid of all the information leakage here

Laura: stack canary is currently not randomizable
        - it's initialized before the RNG is initialized & ARM has no
common hardware RNG
Russell: found this problem also
    - considered using RTC, but it too is initialized afterwards
    - cycle counter probably not usable

Tony: How does Google deal with having lots of vendor trees for
security? - primarily for Android
(No one from Android here)

Paul: also watching out for sysfs and debugfs interfaces is important

Russell: remote coprocessors also are a big problem since they often
have the ability to read and write arbitrary memory controlled by the
ARM cores
    - Really need to move to DRM
    - Olof: part of the problem with graphics was that the first
generation of SoCs had insufficiently large TLBs
    - Anything that can do DMA is a problem



4:30p ARM memory features
Laura Abbott

- List of things that we can't specify yet in DT
    - And how to specify them

Software memory map
- The entire range of RAM is not completely set aside for the kernel
- How to specify this to the kernel?

Tradeoffs of complete removal of regions of memory via memblock_remove
vs. passing in regions of memory

Will: part of the problem is that one option is to instruct the kernel
not to map the memory at all -- not just "don't touch"
    - memblock_steal() is what you want

Grant: should we change how the DT memory reservation works such that
the memory isn't even mapped?

Does this even belong to the DT?
- it's software implemented

Kernel load address alignment issue?  Laurent, Magnus

Russell: got to draw a line somewhere between the number of bits that
are fixed and the number that aren't

Defining memory of different interleaving/speeds

Specification of 'software' memory maps with features such as CMA[1]
    - CMA is a specific type of memory

    - CMA bindings for DT
        - Grant: merged a set of patches, then Ben complained, and so
I reverted them

Grant: reserve map should work for some of this

Grant: PPC is using a recently-merged binding for this

Grant: the plan was to talk about this tomorrow

Defining hotpluggable/power-offable memory
    - PASR
    - Powering down memory chips completely
    * Will discuss this tomorrow with BenH when he's at the ARM mini-summit

NUMA or NUMA like behavior

Will: Steve Capper at ARM/Linaro looked at this

bootloader specification of memory features vs. devicetree
specification of memory features
- DT is for hardware & related specification, so it seems to apply

Paul: Do we need a separate discussion for DT data that's not strictly
hardware data?
    - e.g., CPUFreq/OPP data, device characterization data
    - we're using DT to probe non-hardware-device drivers - e.g. CPUFreq

"ConfigTree" data

Laura: Android ION memory manager
    - completely software data
    - is DT the right place for this?

Grant: is it something that the kernel can ever figure out on its own?
    - Laura: the kernel has to reserve memory

Grant: Is it something that can be provided from userspace?

Arnd: there's some software-specific data in the DT, e.g. the kernel
command line -- via the "chosen" node
Olof: but isn't "chosen" mostly for passing firmware environment over?
Arnd: the original idea for "chosen" is that it's for data passed from
Open Firmware

http://etherpad.osuosl.org/arm-ksummit-2013-day-2

The calendar:
http://goo.gl/ifLxHl

Device Tree Process is Broken:
Kumar: It's not a DT-specific problem, ACPI and other solutions would
run into the same issues.
Olof: DT misses a way to express Linux-only data. If we switch to
something else, we should use a Linux-specific solution.
Grant: Putting configuration data in DT isn't such a bad thing, but it
shouldn't contain Linux internal details (such as "load this driver"),
as those can change pretty dynamically.
DavidB: How much of the problem would be solved by splitting DT in
several trees (HW data, config, ...) ?
We have the chosen node that could be used for configuration purpose.
That would extend the traditional/historical use of the chosen node.
Kumar: This would replicate the SoC hierarchy under another node,
which would get messy.
Tony: Using initramfs we could switch to configuring the kernel from
userspace (MAC address, ...)
Grant: Forcing using specific command line parameters to boot on
production system isn't a good idea. The firmware should provide
enough information to find the boot device.
Kumar: Parameters could easily be passed in "linux,..." device DT
nodes. The real issue is whether we want DT to be a stable ABI. We
know we won't get it right the first time.
ThomasP: The other kernel stable ABI is the syscalls, which evolve
very slowly for that reason, even though they're much more limited in
scope.
Grant: "Not breaking things" might not mean a stable ABI.
LaurentP: Not having a stable ABI isn't a regression compared to the
board code situation. If the .dts is in mainline everything will work.
If it isn't, it's the same situation as out-of-tree board files.
Grant: We have a core set of properties that we can standardize as an
ABI (ranges, interrupts, GPIO, ...). Problems come from more complex
use cases such as DRM
Mark: The DRM problem is more a modularization issue than a DT issue.
DavidB: The solution might be to solve the problem with the
server/laptop market and leave embedded systems as-is without a stable
ABI.
Pawel: Problems don't come from adding properties but from removing or
changing the meaning of existing properties. There's no chance we'll
get the bindings right in the first place.
Grant: We should not break bindings needlessly.
Kumar: "compatible" should be what the hardware is compatible with,
not what the software is not compatible with.
If noone has every shipped a device with a given binding we can change
it. But how to know what has shipped ? Lots of people run out-of-tree
device trees, but we can have an educated guess.
MarkR: Xen and KVM generate and provide device trees to the kernel,
this needs to be taken into account.
Grant: For things that are under heavy development we need to let
bindings get merged without ABI requirements. Bindings could be marked
as stable 6 months later. Creating a spec without a working
implementation doesn't work anyway.
Kumar: New systems are more and more complex, putting all information
in DT might make the device tree too complex. The data-driven approach
is nice, but might not be the solution for everything.
Grant: SoC-specific code isn't a problem.
Magnus: For development it would help to use old-style platform devices.
Kumar: We can do that with stripped-down bindings (reg, interrupts,
...) and get the rest of the data from auxdata.
Arnd: That won't work for the long-term goal where we want no code for
a particular platform in arch/arm/. All data needs to go in DT in that
case.
Olof: When we started it was about whether we can support a board
without board code.
[...]
Grant: Maybe it is olay that we have these poor bindings with Linux
specific data in them? Okay, they're not *nice*, but thye do work
("perhaps we've been too hard-line on this")
Grant: We can't stall development for the next 6 or 12 months until we
get the toolings in place. The largest concern here is about bindings
that abuse core properties (reg, ...).
Pawel: There's a useful document for this written by Stephen
(http://www.spinics.net/lists/devicetree/msg03897.html)
ThomasP: The thing that causes the DT review stall isn't the basic
"should this be a boolean or integer" but is trying to find a generic
enough way to describe all use cases cleanly.
Olof: Why is noone reviewing that ?
Kuwar: There's too much noise on the list.
Grant: Don't post your entire series to the device-tree list.
MarkB: git-send-email doesn't help there.
DavidB: Can we get git-send-email and get-maintainers to cooperate ?
RobH: All we need for review is documentation (Grant: And the schema,
when we have it)
TomaszF: We need to define what a DT binding is.
Grant: Let's document that. Any code that has DT parsing in the commit
should either point to the bindings document, or has a DT bindings
document patch in the series. The DT bindings should be on their own
patches.
RobH: should the binding be merged separately?
Grant: If it is a patch series, this doesn't matter, it can all go together
Olof: We get enough conflicts already - can different people send
these tings to the different maintainers and then "when it all hits
linux-next your device works"
Grant: If we make a change that breaks the ABI, merge the dts and code
in the same branch.
Simon: That's only when we need to make an atomic change. The common
case is that things can be in separately.
DavidB: We need a tool that can parse a patch series and flags missing
DT documentation.
Kumar: What happens when we move bindings out of the kernel tree? Do
we need to take the code out of checkpatch? Does the the other tooling
need to change
Grant: I think we need to back away from that... Perhaps we can't pull
these things out
 -- Is Linus okay with that? Grant can ask him...
 Grant: We need to reach the point where we can say: What are the
simple rules to tell all maintainers so that we can break this
log-jam?
[...] more discussion on whether to send the whole series, does it
just create noise or is it valuable [...]
Grant: Possible conclusion: bindings in a simple patch, maintainers
must have an eye on that, and if bindings don't get reviewed in X
weeks they can be merged.
Arnd: Last time we talked about this we concluded we would have stable
and unstable bindings - that should probably be included in the
'conclusions' from today
DavidB: It should be *in* the schema to specify whether the binding is
stable or not
MarkR: These things *aren't* actually all in driver code - they touch
multiple systems that interact.
Grant: Those things are still very much in flux. We need to trust
subsystem maintainers
Pawel: We've been too specific about this in the past.
Kumar: Multi-subsystem bindings should have much more review.
Pawel: ... agree, but we should be having more faith in subsystem maintainers.
Wolfram: Is see things are stalled and I want to fix that, but the
concern is that we're also accepting things too easily sometimes.
Platform-specific bindings that should be subsystem-specific are often
accepted. One good side of DT is that it should push people to think
about whether something should be generic or driver-specific.
Grant: The process is still going to be "all bindings have to go to
the DT list, and the volume should decrease if we're only sending
bindings to that list. Hopefully the reviewers will be able to catch
up... All bindings *should* then get some review
Kumar: The responsibility of catching driver-specific properties that
should be subsystem-specific should be on subsystem maintainers.
Grant: subsystem maintainers are in a better place to catch certain
types of problems than the DT reviewers - subsytem maintainers still
need to be able to say "no, that's crap"
Stuart Yoder: Can we require that the binding go in first. If we say
"the binding has to go in first, before we accept the rest of the
driver" then it will force people to think hard about their binding in
the context of the driver
?: that would happen in a separate tree
Grant: We need to back off on splitting trees for at least 6 months,
we need to fix the block first.
WillD: I object - we're now saying "send us loads of crap code and
it'll go in to mainline" - so to avoid this we *have* to have things
go via the subsystem maintainer if things haven't been reviewed within
the two-week window
 -- there should be a way for subsystem maintainers to push back to
the DT people
 Grant: Should the policy be that the binding has to be ack'd by the
subsytem maintainers?
 many: yes, we should

 Draft policy:
Binding must be acked by subsy maintainer
Binding should be looked at by DT people *but* if they're 'sleepy' it
rests with the subsys maintainer

JonathanCameron: Is it the case then that subsystem maintainers are
welcome to say "DT people were too slow, I' ve merged that"
Grant: yep - that's okay

LinusW: Subsystem maintainers get forced to learn about all the
possible hardware description mechanisms to be able to review patches,
which is a problem.
[...]

Arnd: some people making bindings know exactly what they're doing and
just need an Ack, some people *don't* and need more handholding

Grant: What we need to do today
- Document policy
- Statement on what ABI actually means: What IS ABI and what is NOT
(What's stable and what's not)

Olof: We have not heard any dissenting voices in this room over [...]
stable bindings
rmk: If you put something into the kernel, and the kernel gets
released as a final version, this makes the thing ABI. Previously
we've said that to remove anything in this case you *need* to go
through a deprecation process. We seem to be adopting a new position
with DT here. We seem to be saying "even if we do put it in to the
kernel we can change it as much as we like" - and people are doing
bindings out of the tree. If we want to have unstable bindings we need
to have a way of documenting that they're unstable..
Grant: this adds a third thing for today - make a way to explicitly
state the stability.
Stephen: should default be unstable?
?: We need more than two classes: there's not just stable and
unstable, there's the time when you're reworking stuff.
rmk: Rather than using a directory to sort this out, can we use a
filename as the way to specify this [...]
Olof: we're adding 'tribal knowledge' here that people need before they do this
Grant: We should have a 'trivial' file of Docs - put the simple stuff in there.
Olof: Coming back to rmk's point of out-of-tree drivers, perhaps we
should ask people to put them in the tree?
Will/Marc: Hey! What about KVM/Qemu because they *generate* their trees


(Feel free to help taking notes, I won't be able to catch everything :-))


---------------

Clock framework


? Should the clock data go into the DT or into C source?
    - Mike/Magnus: it should be fairly readable in the DT
    - Mike: am planning to come up with a standard set of structures
for registering clocks from C code
        - The choice between C and DT data is probably best made on a
SoC-specific basis


? What about STI? Has clock registers scattered all over its SYSCON IP block
    - several hundred kilobytes of address space
    -> should just have one DT device for SYSCON and locate all of the
clocks underneath it with offsets

Mike: am more than happy for folks to put device-specific clocks into
individual drivers
    - model the hardware as it exists

Arnd: SOC_FPGA
    - parent node should own all of the registers
    - From the DT perspective, we try to avoid having multiple nodes
that all have the same numeric address after the @ sign

Mike: existing clock bindings are a problem - we wouldn't do it the
same way again
    - strings are used to link clocks in non-DT situations
    - Arnd: to change this, we'd have to change all of the existing DT data

Paul: what's the use-case for the top-level clock nodes?
    - Mike: not much of one
    - Arnd: intention is to use it for fixed-rate clocks supplied by the board
    - Magnus: we have several different senses of topology - clock
topology vs. bus topology

LinusW: ST-E PRCMU is a Cortex-M3, completely software defined

Mike: am wanting to put register-level data into DT
    - pretend we only have one clock per 32-bit reg
    - am OK with placing a bit-offset property into DT
    - Arnd: you have to give it the right name
        - like 'index' rather than 'bit-shift'
    - Mike: working on OMAP with Tero
        - have 16 specific clock types
        - OMAP doing a one node per clock approach
    - Maxime: already doing this with Allwinner

Mike: try to avoid gluing different clock types into a large macro clock
    - e.g. divider + gate

DT preprocessor macros: when to use it?

Maxime: has been requested to remove binding documentation
Thomas Petazzoni: that is not very nice because I use the binding documentation

Clock index numbers aren't an artifact of the hardware, unlike interrupt numbers

? Should we limit the number of ways to identify clocks in DT, across
different SoCs?
    - Mike: would like something that reduces the size in the DT
    - Arnd: would like Mike to specify a preference for guidance for others
        - Mike: will have to get back to folks on preference

Paul: >2GHz clock rates
    - rmk suggests 64 bit interfaces and I agree
    - modify clk_round_rate() to not return errors
    - Mike is fine with that
    - Some concern about 64 bit divide overhead




---------------

Power management

- standardize interface to microcontrollers for PM functionality
(remoteproc/rpmsg) (Kevin Hilman)

Should there be a standard interface?

LinusW: May not be under the control of the kernel guys
- At ST/E, we were inspired by rpmsg
    - So a good example can go a long way

Kevin: remoteproc/rpmsg is pretty heavyweight

Vincent: not so bad

LinusW: MIPI is looking into this

Kevin: thinking about the BeagleBone
    - has an M3 to handle low power transitions
    - TI moving functionality into firmware to avoid upstreaming problems
    - should we have a recommendation for others?

Vincent: common interface could come from the scheduler interface?

Kevin: we want the minimum possible done by the firmware

PSCI?
Should it be improved to understand things that are not just CPUs
    - Catalin: would like to keep PSCI scoped to CPUs & caches
Catalin: It was originally done for CPU power management specifically,
but now has 'system' bits too. (for reset and power off)

Catalin: TC2 has a power microcontroller also

Tony: for BeagleBone, it should be under drivers/
    - no reason to initialize it early and shouldn't be under arch/arm


[...]
Should we mandate using things like rpmessage?
Kevin: We should mandate remoteproc, but rpmessage looks heavy...

PaulW: Sometimes the firmware can be loaded super-early, before the
kernel starts, so it might be necessary to patch remoteproc to skip
firmware loading

Does switching to rpmessage mean changing the firmware?
    - we're likely to need a driver per firmware
    - we should make rpmessage nice enough that people will jump to use it.
Kevin: so should someone be working on rpmessage to make it nicer to use
LinusW: The bit people want is the data path, not really the control path
Kevin: if the control path is very simple, and rarely used, then it is
a lot of overhead for not much gain.

Tony: let's put this under drivers, initialise it with remoteproc.

Kevin: Beaglebone is broken! Mailbox doesn't actually work,  but it is
used to trigger an interrupt, the M3 side can't see it though so the
A-side has to read-back to stop the fifo filling up :/

Kevin: Russ Dill has proposed a general purpose system for compiling
position-independent C-code that gets run from SRAM
[RFC PATCH 00/11] Embeddable Position Independent Executable
(http://www.spinics.net/lists/arm-kernel/msg273855.html )


How  we plan to share things like platform_suspend_ops and hotplug
implementations across arm and arm64. Will we be moving that code to
 drivers/power? (Stephen Boyd)
    - Catalin: put it in firmware :-)
    - Mark Brown: pick a directory

[...] sharing platform power management code between V7/V8
PSCI
[...]
Sboyd: pm and cpu-hotplug are the things requiring the mach directory
to still exist

Should we have drivers/power then?
Kevin to sboyd: Just move your stuff into drivers/power and see what happens (!)

Automated power regression testing
MikeT: If there are specific tests that someone wants testing, then we
should let him know.

Runtime PM vs. suspend, the never-ending saga

Runtime-pm: We should be moving to this world, but so far there
doesn't seem to be a huge amount of adoption.
    - Adoption common where the subsystem abstracts it somewhat to
avoid splattering runtime-pm calls all over the code.
    - Reduce the amount of boilerplate required makes people more
likely to do this

LinusW: Mixing suspend and runtime-pm is difficult.
Kevin: With agreement from pm-core people should mean this moves on

DVFS

Mike's patches to automatically control regulators
- Kevin suggests merging them

Paul cares
Lee Jones cares

Upstream devfreq is completely broken
- Mike: only appropriate for non-CPU processors like GPU or bus
    - MMC controllers would never use devfreq
    - LinusW: typically IO devices are given specific rates

Moving away from OPPs to "P states"?

Mark Brown: what about PM QoS?

Mike: should there be a separate DVFS framework?
Paul: why should drivers care about what integration clocks need to be changed?

Mike: generic DVFS layer
    - should not be CPU-centric

PaulW: Constraints between voltage rails
MikeT: is it tied to frequency
PaulW: Yes, it is going to be tied to Freq. This is likely to be a
common problem.

Conclusion and Readouts
Device Tree Process
[...]
- Codify things to talk about on Friday with full KS
- Stable vs. unstable
  - Public shaming for breaking bindings
- More documentation for creating forward-compatible bindings
- Debate on the discussion that Stephen started
  - "Err on the side of simplicity"
* Grant to set up a conference call next month to discuss all this
- Two-week timeframe - if no DT-list review occurs, subsystem
maintainers should feel free to merge
More documentation required explaining how to write bindings
    - keep things simple, light to start with (standard, well defined
core properties)

Mark Rutland offered to write the docs - co-ordinate with Tim Bird/CELF(?)

Device Tree Tooling
Thomas
- considered both (Benoit's, Tomasz's) proposals for schema formats
- considered scope of validation required
- found out that can't really define a basic initial format of schema
first, without considering the full set of what we'll like to
validate, or we'd be left with a schema format that's too restrictive
to extend later.
- considered trade-offs of .dts -vs- C syntax for the schema
representation. No firm decision yet.
- haven't really got enough time to conclude this discussion so far.
Follow up session required. (a bit closer to a solution, but nothing
finally decided)
- Next step: look through existing bindings and enumerate the things
that we eventually want to be able to represent.

Power Management Discussions
Highlights: runtime-pm vs system-pm
    - over the last year the core pm maintainers seem to have reached
a conclusions that they like the runtime-pm view of the world
    - some disucssion about why runtime-pm hasn't really been adopted
        - better to do it in the subsystem level not the driver level
        - some level of laziness

    Some talk about the trend towards PM being done on microprocessors
        Can we standardize?
        - remoteproc seems useful
        - rpmessage seems perhaps too heavy
        Platforms doing things in homebrew ways at the moment.

    How can we share PM code between arm and arm64?
        - Catalin wants it all in firmware, but things that can't go
there should go in to drivers/power

    DVFS:
        Action item: MikeT to publish clock rate change notifier
series (so people can take a look!)

Clock Tree
bindings and configuration:
How to craft better/more acceptable clock/DT bindings
Two appraoches
    - lightweight clock controller binding.
        - declare bindings and make phandles available
    - more heavyweight version that required data in the DTS (MikeT to
go over this)
    [...]


Memory bindings
System for setting aside regions of memory (say for DMA) early in boot
that can subsequently be used by CMA/Ion etc

Laura to polish up what was decided, Grant to look at existing
patches. Code expected this week (!)

UEFI+SecureBoot
(Baby steps!)
What tools should we worry about/what do we need to do
- for initial use-cases we probably won't need to use shim.
- some concern about using non vfat file-systems as this might require shim
- we want to find simple ways to verify that the basics function on ARM

need to look into IPMI (especially as early platforms will be server platforms)

Wrap-up
Olof: This has been larger than past events - how has it worked? What
might we change next time?

- Splitting into two rooms makes it difficult to know where to be
(though, there's not a clear solution to this)

- Has there been too much talking? Some people hacked, and people seem
comfortable with the level of each activity

- Should we take the DT stuff out of ARM?

HPA: For 20 years, we've run on firmware designed for other operating
systems. We're moving in to a world where that can't be expected, and
this is a cross-architecture problem now.

Does it make sense to break embeded out from the server activity?
  - no! don't sweep the embedded stuff under the rug/keep it out of the light.
    - we should have an idea of what's going on across the ecosystem.
    Linux firmware summit!?

Was the 'fuzzy' scheduling good?
 - the only problem was co-ordinating between the rooms.
  - rooms being far apart wasn't planned, really
- would a more rigid 'unconference' system be useful?
- time-slots might help
- rooms being closer would help
(things were a little noisy at times)

Do it again next year!
 - or sooner?
 Linaro shouldn't be the centre of this, really.

 Grant's advice on making this practical: Look at the LF events - find
one that we can 'tag on to' and run in parallel with that.
  - ELC is a good candidate.
  - Co-location with ELC/ELC-E proposed by Olof.
  Grant claims boldly that it is a light load to organise these.
(one of the biggest difficulties is choosing attendees/making the
right decisions)

Grant to grab copies of all the notes tomorrow, so add them to the
Etherpad documents ASAP.

Evening Events
Core invite attendees: 6:30 at Cucina (6:15 bus departure)
Workshop attendees: LinuxCon + CloudOpen Reception, 7:00 National
Museum (6:45 bus departure)

TAB Elections: 9:00 at the National Museum in the Connect Gallery



UEFI Secure Boot on ARM Notes

Recommendations on policy
- Ideally ship everything in setup mode
- For locked devices, the Microsoft recommendations work well for us;
throw away the keys when the customer unlocks the device and end up in
setup mode

Implementation Details
- As far as we know, Tianocore is complete in its secure boot implementation
- The intel quark is supposed to be a fully open implementation of secure boot
- need to ensure variable updates will get updated correctly.

Shim:
- Provides a consistent way to manage keys
- Consistent interface is important for adding keys to the key database.

- Should try to influence ARM vendors to be consistent in key management.
-

Tools:
Do we have a signing tools for ARM PECOFF binaries? jk's sbsign tool
should be investigated
pesign uses the NSS key backend; harder to setup, but allows the use
of hw security smartcards, etc.
- Need to have ARM versions of those tools.

Grub loader
- Leif looked at it. Currently depends on shim.
Matthew:
