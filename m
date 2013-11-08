From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 8 Nov 2013 13:20:46 +0000
Subject: Report from 2013 ARM kernel summit
Message-ID: <CACxGe6stYhZOc=MfGj8BgtG8zp6eh=jRFGUbFn1SSYRtw+zryA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is the plain text version. Reply and comment to your heart's content.

Once again, thanks to Olof Johannson, Kevin Hilman, Mark Brown and
Paul Walmsley for the help in preparing this report.
________

Over the last 3 years it has become a tradition to co-locate a meetup of
the ARM kernel maintainers and core developers with kernel summit. This
year 47 of us descended upon Edinburgh for two days of meetings before
ksummit. Here is a summary of the conversations over the two days, but
the raw notes are also available[1] and are worth a read for a great
deal more detail.

Day 1
-----
ARM Maintainership Trees

Wednesday morning kicked off with a largely uncontroversial review of
the ARM maintainership trees. Olof Johansson provided a status report of
the ARM-SoC tree. Generally he's pretty happy with how things have been
working, but he had some recommendations on what he would like to see in
pull requests. For one, it makes his life easier if pull requests are
based on the earliest -rc possible simply so that it doesn't pull in
mainline commits that he's not pulled into ARM-SoC yet. Russell King
agreed on this point saying it was easier when it didn't look like pull
requests contained loads of other stuff.

Olof is a little concerned about the flood of patches and pull requests
showing up at around -rc6 time. Typically the only time that changes are
not getting pulled into the arch and arm-soc trees is during the merge
window, immediately before -rc1. Outside of that, pull requests should
be sent as early as possible instead of "right before the next merge
window". If you miss the merge window, don't let that be a reason to
delay a pull request by another 10 weeks. Also, once you do sent a pull
request, don't change the tag. Russell said he will often pull a branch,
test it, but then not actually merge it until a few days later to see if
it has changed.

The conversation digressed slightly here to talk about testing. There
are several automated build systems testing the ARM tree at the moment,
including Fengguang Wu's 0-day build test and test runs maintained by
Olof, Kevin Hilman and Paul Walmsley. Pretty much everyone agreed about
the value of the tools, but some questions were asked about how the test
reports can be made more useful and what can be done to increase
coverage. Test reports from Olof's, Kevin's and Paul's systems are going
to kernel-build-reports at lists.linaro.org for those who are interested,
but there is not yet any automatic notification to maintainers when a
tree breaks. Kevin and Paul also boot test the kernel on the limited
selection of ARM boards they have access to. A few requests were voiced
include more boot tests on non-ARM boards, a web status dashboard front
end, and testing for power management regressions. However, as valuable
as any or all of these features would be, Olof, Kevin and Paul's time is
limited. Anyone volunteering to implement said features would be most
welcome.

Russell King and Catalin Marinas also got a turn to talk about how
things were working for arm and arm64 maintenance respectively. Again
there wasn't much to say. The current process is working well for
Russell, but he took the opportunity request folks to send him a
reminder about a week after sending him a pull request. With 8k-9k of
traffic on the list per month it is easy for things to get lost.
Similarly, the current process is working well for Catalin although he
doesn't yet have to deal with a multitude of individual SoC ports. Most
of it is core changes to fill out important features like ftrace and
kprobes.

Will Deacon (ARM64 co-maintainer) is currently concerned that people are
writing code, but not spending very much time reviewing. The sentiment
was repeated by others in the room, but without any concrete solutions
aside from continuing to encourage developers to review other patches.

Kernel Consolidation

The next topic was a review of the consolidation work on ARM
sub-architectures. Linus Walleij showed a spreadsheet[2] listing all of
the sub-architectures, and progress towards single zImage, device tree,
and other common infrastructure pieces. Of the 62 sub-architectures, 26
are mostly complete, 14 are in various states of progress, and 8 haven't
been started yet. The remaining 14 aren't expected to ever be converted
either because it is expected to be removed or because there is a
technical reason it will not be converted. When it was asked if the
unconverted platforms could be removed, Arnd Bergmann pointed out that a
lot of them are strongarm/xscale based which has an active hobbyist
community. It would be unfriendly to pull that out from under them.

Stephen Warren asked about defconfig policy. There are still a lot of
defconfig files and he was wondering if some of them need to be removed.
multi_v7_defconfig could be used instead. However, supporting a large
number of devices with one defconfig currently means a lot of drivers
must be built directly into the kernel. Tony Lindgren asked if most of
multi_v7_defconfig could be switched to using modules, but doing so is
inconvenient for a lot of kernel developers because it requires an
initrd. There was a brief discussion about putting a simple tool into
the kernel build scripts to generate a minimal initrd with just enough
to meet the needs of kernel developers. Tony and Kevin volunteered to
investigate further and Mike Turquette suggested looking at Dracut.[3]
For everything else, one defconfig per subarchitecture sounded
reasonable to the architecture maintainers.

It is also a concern that very few people are enabling the drivers as
modules and there are already known init order problems for some drivers
as modules (like interrupt and GPIO controllers). Grant and Tony both
expressed that init order problem is important to solve because it
forces better organization and separation between drivers. Kevin closed
the discussion by proposing that making multi_v7_defconfig use modules
be a long term goal after the above concerns are addressed.

Early Init, Deferred Probe and Init Order

Finally before breaking for lunch some time was spent discussing what to
do with devices that are being set up before initcall time and therefore
before the driver model is available. The early_platform infrastructure
is intended to support these devices by allowing a platform_device
structure to be created early and then registered into the driver model
at initcall time. Magnus Damm has said that early_platform has worked
well for SHMobile, but Russell is concerned that early_platform seems
like a hack, a concern seconded by Arnd and Grant. The problem is that
early_platform adds non-trivial complexity to the driver model for a
very small number of devices.

As an alternative, it was suggested that early running code shouldn't
try to use the driver model at all, but rather limit itself to only
essentials required to get to initcalls. For instance, would it be
possible to have SoC early setup code that enables clocks and
regulators, but doesn't attach a full driver until initcall time.
Getting to initcalls requires very little hardware and anything
unnecessary during early init really should be pushed out to that time.
Even initialization of secondary interrupt controllers can be delayed if
not required by the system timer. The examples of of_clk_init() and
of_irq_init() were mentioned as a way to do early initialization, but
only when deferring to initcalls is not possible. Kumar Gala made the
point that adding more of_<blah>_init() functions is not going to
scale.

The big problem with deferring to initcalls is that the kernel doesn?t
have any information about dependencies between devices and so doesn?t
know what order to call modules in. Right now driver probe order is
roughly determined by kernel link order first, and registration order
second for devices populated during or after initcalls. Olof commented
that the current driver model is based on the assumption that devices
live in a single hierarchy. There is no easy way to add in dependency
data with the current structure, and in most cases dependencies aren?t
specifically on other devices, but rather on the service provided by
another device (ie, a GPIO line).

Kumar is concerned that deferred probe won?t work in all situations. For
instance, what about a device that has an optional dependency? Does it
fail to probe in the hope that the dependency will show up later? It was
suggested by Mark Brown that if the resource is described in the device
tree then it is indeed the correct behaviour to defer until it arrives.
Or, if the driver really is able to proceed, then the driver should
assume responsibility for obtaining the resource at a later time.

The suggestion was made that it would be a really nice to have the core
kernel sort out probe order rather than using deferred probe. Grant
replied that deferred probe was designed as the simplest possible
solution to the problem, and by no means is he attached to it if someone
can come up with a better approach. He did consider other options that
put dependency resolution into the core, but it ended up pulling all
kinds of GPIO, IRQ, Clock and DMA details into the core which made it
quite complex.

Non-probeable System Architecture

Will Deacon raised the topic of how to deal with some of the more
complex details of system architecture. The architecture details that
are going to increase complexity include cache coherency domains (CCI),
endpoint-to-endpoint DMA, GIC MSI mapping and interconnects which lose
meta-data when translating. For example, he presented the problem of a
PCIe device attached through a PCIe bridge performing DMA access through
an SMMU. A requester ID (RID) is mapped onto a Stream ID (SID) which it
turn maps onto a Device ID (DID), but RIDs don?t necessarily map
directly onto an SID and the kernel needs to handle translating between
the ids in order to program the SMMU correctly. This is important to get
right, otherwise the SMMU will either block legitimate access or allow
devices to make invalid requests.

Greg Kroah-Hartman made the point that PCIe is supposed to be completely
probable and that on x86 firmware takes care of any mapping required by
the hardware. Having to do this in the kernel is just crazy. Will
responded that this isn?t actually a PCIe problem, but rather how the
PCIe bridge is attached to the SMMU. Also, unlike on x86, most ARM
platform builders don?t expect firmware to abstract away the hardware
mapping so the kernel needs to know the mechanism for translating IDs.
For v8, ARM is pushing for a common firmware interface in the form of
trusted firmware[4] running in the secure world (EL3) and PSCI[5] for
the interface. However, the mapping problems described by Will fall
outside of the current scope for trusted firmware.

No firm conclusions were reached in this session other than to continue
on the approach of encoding the data into the device tree.

ARMv8 Secure Firmware requirements

ARM has introduced the Power State Coordination Interface (PSCI)[6] in
an attempt to standardize the interaction between Linux (or any OS) and
supervisory software running at the different privilege levels in order
to manage power state transitions. Before ARMv8, there was no standard
for managing SoC power states. Since the use of privilege levels was not
standard across SoCs or not used at all, every SoC had their own way of
managing power state transitions.

With the introduction of ARMv8, there is now an attempt to standardize
using PSCI, which provides a standard for arm32 and arm64.  However,
while ARM encourages use of the new standards, the ARM ecosystem does
not have a reputation of following standards.  Also, since ARMv8
hardware is not widely available, it?s not clear how broadly PSCI will
be used.

In theory, PSCI would simplify the core kernel code by hiding much of
the complexity in firmware. This is the ideal world, and the one ARM is
encouraging. In the real world however, there are several complexities
that were raised: non-PSCI based systems, firmware vendors wanting to
have minimal firmware for audit reasons, buggy/broken firmware, errata
workarounds requiring secure privileges, etc.

Unfortunately, there is not yet a one-size-fits-all solution to this, so
it?s likely the kernel will have to handle both PSCI and some SoC
specific stuff. The goal of the arm64 maintainers though is to keep SoC
specifics to an absolute minimum.

ARMv8 Board Support

Catalin Marinas led the next session on the status of ARMv8 board
support. The executive summary is: there will be no board support in
arch/arm64. Everything should live under the appropriate
subsystem/driver dir now. The reality is that this isn?t quite ready
yet, but that is the direction we?re headed.

Exploit Mitigation

Kees Cook lead an afternoon session giving an overview of the exploit
mitigation work he is doing. His slides are available at
http://outflux.net/slides/2013/arm/mitigation.pdf. Kees first used the
time to review how kernel bugs can get exploited as a security
vulnerability. There are no shortage of kernel bugs to be found, so
Kees? focus is on how to makes those bugs harder to translate into
exploits.

Kees first covered the tools available for fuzzing and static analysis.
Fuzzing, or subjecting the software to random or otherwise invalid
input, is a great way to look for unexpected cases in the kernel. Kees
has high praise for the Trinity project[7] and he recommends running
Trinity for 10 minutes as part of automated tests. Fuzz testing can also
be driven by external hardware if available. For example, Facedancer[8]
is a hardware USB device which can generate arbitrary USB traffic and is
driven by Python scripts. Kees was able to find 12 bugs in the USB HID
using Facedancer.

Kees also recommends using static analysis tools such as smatch and
coccinelle to look for common patterns of bugs before they can be turned
into exploits. However, while both static analysis and fuzzing are great
for finding bugs, they don?t make it any harder to exploit as-yet
undiscovered bugs. For that, hardening the kernel is needed.

The low hanging fruit for hardening is using page permissions to protect
against certain classes of attacks. For instance, enforcing RO data to
be in read-only pages, disabling execution from data pages, and prevent
userspace execution and read/write from the kernel. On ARM, most of
these protections are implemented, but protecting against kernel
read/write of userspace pages is proving difficult. Kees would
appreciate help getting it to work. He also would like to identify
write-seldom data and explicitly mark those pages as read-only, but that
approach is largely unexplored in the upstream kernel.

Moving toward the more experimental efforts, there is work right now in
bringing Address Space Randomization (ASR) to kernel space. The idea of
ASR is to make it difficult to predict where a function actually exists
in memory on a running system and therefore difficult to craft a stack
smash attack that exploits it. ASR is well established in userspace, but
it is difficult to implement for the kernel. There is support available
now on x86 for the text sections and patches are coming soon to add
randomization for modules, kmalloc and vmalloc. ARM however has some
extra problems related to memory not always being based at address 0
which makes it tricky to work out physical to virtual translations.

Arnd also raised the concern that the number of locations to which the
kernel can be relocated is constrained to a small number of
possibilities. Fewer than 1024 in a typical 32-bit system. Even if an
attacker can only succeed one out of 1024 attempts, that is still a huge
number of systems if the pool of systems is in the millions.

Finally, Kees covered some core Linux features useful for Linux that
aren?t fully implemented on ARM. x86 and s390 have CONFIG_DEBUG_RODATA
and CONFIG_DEBUG_SET_MODULE_RONX, both of which are used to mark
read-only or non-executable memory as write-protected and optionally
no-execute in the page tables. CONFIG_X86_PTDUMP provides details of the
page tables in debugfs which is useful for debugging page table
permission changes. Kees would like to see all of the above implemented
on ARM. Russell took interest in the second option and had a draft patch
posted before the end of the week.[9] There is some existing work
ongoing for ARM security providing CONFIG_STRICT_MEMORY_RWX[10] and
grsecurity/PaX[11] which Kees highlighted on his final slide.

Memory features and Config data in Device Tree

The final sessions of the day touched on a couple of device tree related
issues. The first was how to describe memory features in the device tree
and the second was what to do with platform configuration data. Laura
Abbott brought up the memory features topic to discuss the handling of
memory that should not or must not get mapped as normal memory. Some
examples of why a memory region would be set aside are, to be used by
the contiguous memory allocator (CMA), to describe
hot-pluggable/power-managed memory, or to describe NUMA behaviour. The
topic was discussed briefly and then deferred to the second day because
it overlapped with the reserved memory binding discussion scheduled for
the 2nd day, with a recommendation to consult with Benjamin
Herrenschmidt and Steve Capper about how to model NUMA platforms.

The discussion did lead into a question about what to do with purely
software configuration data that is needed at boot time. For example,
Laura used the example of the ION memory manager which is entirely a
software construct. The kernel needs to set aside memory to be used by
ION at boot time, but the amount of memory isn?t a property of the
physical hardware, nor can the kernel determine the correct size
automatically and nor can userspace provide the right size. The natural
thing to do is put the data into the device tree, but device tree policy
is to avoid putting Linux-specific details into the tree since it is
supposed to describe hardware independent of the operating system. This
discussion was also tabled for the next day, but not before Grant made
the statement that a lot of configuration data is really about intended
operational configuration, even if it isn?t strictly a hardware
description. It is perfectly reasonable to put that information into the
device tree.

Day 2
-----

Device Tree Process is Broken

Day 2 turned into the device tree day starting off with the big problem
that the process for creating new bindings is completely broken. The
original plan was to split into two rooms right from the beginning of
the second day, but when it was realized that the DT process problem
affects everyone[12], the decision was made to keep the entire group
together to discuss the issue.

Several major problems have been identified with the device tree process,
1. There is disagreement on whether or not the DT should be treated as
a stable ABI,
2. subsystem maintainers don?t know what to do with device tree changes,
3. developers feel they need to lock down the perfect binding before
DT bindings will get merged, and
4. traffic on the devicetree mailing list is overwhelming. Reviewers
are burning out.

In addition, the mailing list thread raised the meta question, ?Is DT on
ARM the solution, or is there something better??[13] Grant Likely chimed
in on this last question with the thought that right now we?ve basically
got four options; go back to board files, stick with the DT approach,
switch to ACPI, or invent something entirely new. There is no problem
with investigating alternatives, but development cannot stop in the mean
time. The immediate DT problems still need to be solved. Kumar Gala also
pointed out that the problems aren?t DT-specific. Exactly the same set
of problems would need to be solved if we were using something else,
like ACPI.

Hardware Configuration Data

The configuration data question was sorted out quickly after a brief
discussion. General agreement was that configuration data relating to
how the hardware should be used is okay. Linux specific data should
still be avoided. For example, how much contiguous buffer memory to set
aside, and preferred clock rates are reasonable, but names of Linux
modules to load are not. However, this can only be a guideline and
sometimes Linux specific details need to be there. When that happens,
the Linux-specific properties should be prefixed with ?linux,?.
Regardless, the DT should always provide enough information for the
system to boot into an operational state without resorting to extra
parameters on the kernel command line.

Where that data should be put was also discussed. David Brown suggested
that perhaps the DT should split into separate trees, one for hardware
and one for configuration, but Kumar pointed out that doing so would
replicate the SoC hierarchy under a different node which increases the
complexity. Putting all configuration data under the /chosen node was
one suggestion. Historically the /chosen node was created to pass data
from OpenFirmware to the kernel, so it is a reasonable choice. However,
if the configuration is related to a specific device and isn?t likely to
be changed by the user then it is better to keep the data in a device
node.

Device Tree as Stable ABI

The big question of the day was whether or not device tree should be
considered a stable ABI. One side of the debate suggests that once a
binding is set, it should never change because doing so would break
booting on boards using the older device tree. The other side asserts
that enabling new features and new hardware requires binding changes, so
insisting on a stable ABI forces binding authors to write a ?perfect?
binding on the first try before they understand the hardware.

Setting the context for the problem, Thomas Petazzoni compared the
device tree to the kernel?s other stable API, syscalls. Compared to what
is being done with device tree, the syscall ABI evolves very slowly
because it has to be stable, but it is also much more limited in scope.
Additionally, syscalls to a large extent attempt to abstract the
hardware, whereas device tree attempts to describe it in detail.

The first issue to deal with was what does it actually mean to have a
stable ABI? From the user perspective, it means that upgrading the
kernel should not cause breakage. How that works out in real life
depends on how the kernel is upgraded. Laurent Pinchard pointed out that
if DT is in mainline and always upgraded with the kernel then there will
never be any breakage. However, shipping the DT with the kernel
increases the burden on the distribution vendor to provide DTs for all
known hardware. It is preferable in that case for firmware to provide a
DT. David Brown suggested the solution may be to stabilize the ABI for
general purpose server/client systems, but don?t burden embedded
developers with the same requirement.

>From Russell King?s perspective, if a binding has been released in a
mainline kernel, then by default it needs to be considered a stable ABI.
If there are unstable bindings, then there must be a way to mark them as
unstable. David Woodhouse agreed with the addition that it needs to be
enforced by the DT tools at build time. A staging tree was proposed for
bindings with some rules about their lifecycle. If a staging binding is
accepted, then it needs to either become stable within a fixed period of
time (perhaps 6 months), show forward progress, or be removed from the
tree for inactivity. Again the tooling issue was raised and the goal is
to make the DT tools perform binding validation.

That still leaves the question of, what does a stable binding look like?
Certainly a stable binding means that a newer kernel will not break on
an older device tree, but that doesn?t mean the binding is frozen for
all time. Grant said there are ways to change bindings that don?t result
in breakage. For instance, if a new property is added, then default to
the previous behaviour if it is missing. It is perfectly acceptable for
a binding author to start simple and extend the binding as needed. If a
binding truly needs an incompatible change, then change the compatible
string at the same time. The driver can bind against both the old and
the new. These guidelines aren?t new, but they desperately need to be
documented.

Also, if a binding changes, and nobody notices, has anything been
broken? There was a fair bit of discussion about how bindings develop
organically and, especially for new hardware, require some time to sort
out. Allowing some grace for new hardware support is appropriate.

It is clear from the discussion that a lot of details and expectations
need to be documented. However, as a starting point the following broad
statements were proposed to the general agreement of the room:
1. By default, bindings released with the kernel shall be considered stable
   1. Breaking end users should be avoided.
   2. Unstable bindings will be marked as unstable with a timeline for
      stabilization
   3. However, if nobody complains, has anything been broken?
   4. Bindings can be changed in incompatible ways if it can be
      reasonably argued that nobody will be affected by the change
1. Policy documentation is desperately need. Action on Grant to organize
   doc writing.
2. Statement to be written on what is stable ABI and what is not.

Some of the above work has been started. A smaller group split off to
hammer out a statement on DT binding policy which is available in the
form of presentation slides[14], and will be written up as a document in
the coming weeks. Also, Stephen Warren had already written a good
guidance document for crafting device tree bindings.[15]

List overload

The other major problem faced by device tree users is that patches are
getting stalled in the review process. The traffic on the device tree
mailing list is so high that it overwhelms the device tree binding
reviewers. A suggestion was made that perhaps only the binding changes
should be posted to the mailing list, excluding the code change, but it
was pointed out that sometimes the code provides useful context about
why the binding is designed the way it was, so it is helpful to have it
in the same series. Regardless, from this point forward, the DT
reviewers are going to focus primarily on the binding documentation. Any
review of implementation will be somewhat incidental.

In addition, many subsystem maintainers have little knowledge about what
device tree bindings are supposed to look like, and so some avoid
merging patches which haven?t been acked by a DT reviewer. Grant
suggested that rules should be provided for what to do with unreviewed
DT bindings, and provide the guidance that if a binding hasn?t been
reviewed in a reasonable period of time (two weeks was suggested) then
the subsystem maintainer can use their own discretion. Will Deacon and
Olof strongly objected with the concern that it will be a free pass to
get anything into the kernel. After further discussion the tentative
agreement in the case of sleepy DT reviewers was to leave the decision
to the subsystem maintainer, provided that it is contained to within a
single device driver and the maintainer is satisfied that the patch
looks reasonable. Common subsystem bindings that affect multiple drivers
still need DT review since the impact is far greater.

The output of this discussion can also be found in the DT binding policy
slide deck.[16]

Device Tree Schema and Tooling

Several of the issues regarding device tree that have been causing
problems have been attributed to limitations in the tooling, especially
its ability to automatically identify errors. Proposals for defining
schemas to allow validation of device tree bindings from Tomasz Figa and
Benoit Cousson were discussed but no firm conclusions were drawn since
it is not yet clear exactly what needs to be validated.

The next step to progress this will be to do a review of the existing
bindings in order to scope out the features that will need to be checked
so that a format for defining schema can be developed.

Device Tree Reserved Memory

There was a small group discussion to hammer out a binding for reserved
memory regions. Using the binding proposed by Marek Szyprowski[17] it
was reworked to properly support platforms with multiple memory nodes
and generalize the usage model. The results of the discussion with a new
proposal have already been posted to the mailing list[18].

Power management

The power management breakout started with Kevin Hilman highlighting
that the power management core maintainers have recently moved towards
favouring a runtime PM centric view of the world. This is good news as
this has been popular with much of the embedded world. There was some
discussion of the limited current adoption of runtime PM, laziness was
blamed for much of this - providing standard runtime PM integration in
subsystems has been one way of making this easier.

There followed a discussion of standardising the interfaces for
interacting with controllers with PM functionality, such as the M3 found
in the TI processor in the BeagleBone Black. Concerns were raised that
too much functionality is being moved into these processors, often
limited to specific use cases like system suspend which caused problems
when implementing runtime PM, and that often it is hard for upstream to
influence.

PSCI was covered but since it focuses on CPU complexes it isn?t
sufficient for many of the use cases where the entire SoC is involved.

remoteproc and rpmsg were discussed, remoteproc did not seem problematic
but there were concerns that rpmsg may be too heavyweight for the
microcontrollers used for power management. Linus Walleij observed that
these had been a good inspiration for interfaces to modems at ST/E.
There was agreement that providing strong examples of good practice and
reusable code is one of the best ways for upstream to influence firmware
design.

The immediate conclusion was that we should place what?s there at the
minute under a single directory in drivers and then work on
standardising the interfaces to the rest of the system and providing
high quality references.

UEFI secure boot on ARM
In the last slot of the day, Matthew Garrett and James Bottomley joined
the group to spend some time talking about the lessons learned working
on UEFI secure boot. Some ARM vendors intend to use Secure Boot on ARM
devices and it would be good to have some influence on implementation so
that it is in a form that works well with Linux.

In James? ideal world, ARM device would ship in setup mode so the users
are always able to install their own keys, but failing that it would be
best to have a standard mechanism to unlock the bootloader and re-enter
setup mode. On devices intended to run Windows, Microsoft is the signing
authority.

The Shim[19] bootloader and the Linux Foundation secure boot system[20]
are both designed to be signed by a third party (Microsoft) and then
allow Linux to be booted without a signature from said third party. Shim
also provides a consistent method for managing keys which wouldn?t be
necessary if vendors can be convinced to implement a consistent method
in UEFI.

In the ARM world, it is highly likely that systems will be designed only
to run Linux and probably won?t have any need to use Microsoft as a
signing authority. Without a central authority (and setting up an
authority is expensive) it is most likely that vendors will need to be
their own root of trust. However, if vendors can be convinced that
allowing the firmware to be unlocked and put into setup mode, then there
should be no need to use Shim.

As for implementation, as far as James and Matthew know, the upstream
Tianocore project has everything needed to work with secure boot. There
are details of course about platform secure variable storage, but that
should not prevent getting the tools and signing working.

Finally, the tools for signing ARM PECOFF binaries need work. Jeremy
Kerr?s sbsign and Peter Jones? pesign tools both should be investigated.
It is believed that they don?t currently work on 32-bit.

Next Steps and Conclusion

Wrapping up the event, Olof asked the question about how this event
worked, what can be done differently, and should another gathering be
organized. This year the summit was split into two rooms on the second
day which was good for deep dive discussions. Time was split about 60%
discussions with the whole group and 40% smaller groups and hacking
time. Everyone seemed happy with the level of activity and would do the
same thing.

Scheduling this year was coordinated on a shared Google calendar, and
could best be described as fuzzy. Topics were moved around or
added/removed as needed. Some expressed that it was difficult to know
where to be at times, partially because the rooms were quite far apart,
but in general the format worked. Suggestions were made for using strict
time-slots or an ?unconference? system next time.

For doing it again, the consensus was a resounding yes, hopefully more
frequently than once a year. Possible venues were discussed including
co-location with Linaro Connect or ELC. Co-locating with Linaro is a
concern for some since Linaro is a membership organization and not all
ARM maintainers work for member companies. Linux Foundation events like
ELC is a good fit since the LF team has been very supportive in hosting
Linux development summits like this one. Olof and Kevin will investigate
organizing a new summit.
________________
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/209580.html
[2] http://goo.gl/GD9MAO
[3] https://dracut.wiki.kernel.org/index.php/Main_Page
[4] http://goo.gl/FqQ4YI
[5] http://goo.gl/zrXE39 (behind registration wall)
[6] Ibid.
[7] http://codemonkey.org.uk/projects/trinity
[8] http://goodfet.sourceforge.net/hardware/facedancer11
[9] http://comments.gmane.org/gmane.linux.kernel.cross-arch/19992
[10] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/203261.html
[11] http://forums.grsecurity.net/viewtopic.php?f=7&t=3292
[12] Quite possibly influenced by the long running thread on the
ksummit-2013-discuss mailing list.
http://thread.gmane.org/gmane.linux.drivers.devicetree/48898
[13] Ibid
[14] http://goo.gl/pXtY2b
[15] http://www.spinics.net/lists/devicetree/msg03897.html
[16] Ibid
[17] http://permalink.gmane.org/gmane.linux.ports.arm.kernel/263219
[18] http://permalink.gmane.org/gmane.linux.drivers.devicetree/50160
[19] https://github.com/mjg59/shim
[20] http://blog.hansenpartnership.com/linux-foundation-secure-boot-system-released
