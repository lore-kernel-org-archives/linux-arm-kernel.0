From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Jan 2015 11:21:34 +0100
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <CACxGe6sbGu53x5rsx2sWVVVVCnnFvmkQAk3Se9ZGNOXCkqpi=A@mail.gmail.com>
References: <548F9668.6080900@linaro.org>
 <CACxGe6vRN2Tc97=Sx05gri02goxBaHnZm30hR37q=002agFLAA@mail.gmail.com>
 <CACxGe6sbGu53x5rsx2sWVVVVCnnFvmkQAk3Se9ZGNOXCkqpi=A@mail.gmail.com>
Message-ID: <1636716.eAYJb6Z2AV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 10 January 2015 14:44:02 Grant Likely wrote:
> On Wed, Dec 17, 2014 at 10:26 PM, Grant Likely <grant.likely@linaro.org> wrote:

> I've posted an article on my blog, but I'm reposting it here because
> the mailing list is more conducive to discussion...
> 
> http://www.secretlab.ca/archives/151
> 
> Why ACPI on ARM?
> ----------------
> 
> Why are we doing ACPI on ARM? That question has been asked many times,
> but we haven't yet had a good summary of the most important reasons
> for wanting ACPI on ARM. This article is an attempt to state the
> rationale clearly.

Thanks for writing this up, much appreciated. I'd like to comment
on some of the points here, which seems easier than commenting on the
blog post.

> Device Configurations
> ---------------------
> 2. Support device configurations
> 3. Support dynamic device configurations (hot add/removal)
>
... 
>
> DT platforms have also supported dynamic configuration and hotplug for
> years. There isn't a lot here that differentiates between ACPI and DT.
> The biggest difference is that dynamic changes to the ACPI namespace
> can be triggered by ACPI methods, whereas for DT changes are received
> as messages from firmware and have been very much platform specific
> (e.g. IBM pSeries does this)

This seems like a great fit for AML indeed, but I wonder what exactly
we want to hotplug here, since everything I can think of wouldn't need
AML support for the specific use case of SBSA compliant servers:

- CPU: I don't think a lot of people outside mainframes consider
  CPUs to be runtime-serviceable parts, so for practical purposes
  this would be for power-management purposes triggered by the OS,
  and we have PSCI for managing the CPUs here. In case of virtual
  machines, we will actually need hotplugging CPUs into the guest,
  but this can be done through the existing hypervisor based interfaces
  for KVM and Xen.

- memory: quite similar, I don't have runtime memory replacement on
  my radar for normal servers yet, and in virtual machines, we'd use
  the existing balloon drivers. Memory power management (per-bank
  self-refresh or powerdown) would be a good use-case but the Linux
  patches we had for this 5 years ago were never merged and I don't
  think anybody is working on them any more.

- standard AHCI/OHCI/EHCI/XHCI/PCIe-port/...: these all have register
  level support for hotplugging and don't need SoC-specific driver
  support or ACPI, as can easily be verified by hotplugging devices on
  x86 machines with ACPI turned off.
  
- nonstandard SATA/USB/PCI-X/PCI-e/...: These are common on embedded
  ARM SoCs and could to a certain extent be handled using AML, but for
  good reasons are not allowed by SBSA.

- anything else?

> Power Management Model
> ----------------------
> 4. Support hardware abstraction through control methods
> 5. Support power management
> 6. Support thermal management
> 
> Power, thermal, and clock management can all be dealt with as a group.
> ACPI defines a power management model (OSPM) that both the platform
> and the OS conform to. The OS implements the OSPM state machine, but
> the platform can provide state change behaviour in the form of
> bytecode methods. Methods can access hardware directly or hand off PM
> operations to a coprocessor. The OS really doesn't have to care about
> the details as long as the platform obeys the rules of the OSPM model.
>
> With DT, the kernel has device drivers for each and every component in
> the platform, and configures them using DT data. DT itself doesn't
> have a PM model. Rather the PM model is an implementation detail of
> the kernel. Device drivers use DT data to decide how to handle PM
> state changes. We have clock, pinctrl, and regulator frameworks in the
> kernel for working out runtime PM. However, this only works when all
> the drivers and support code have been merged into the kernel. When
> the kernel's PM model doesn't work for new hardware, then we change
> the model. This works very well for mobile/embedded because the vendor
> controls the kernel. We can change things when we need to, but we also
> struggle with getting board support mainlined.

I can definitely see this point, but I can also see two important
downsides to the ACPI model that need to be considered for an
individual implementor:

* As a high-level abstraction, there are limits to how fine-grained
  the power management can be done, or is implemented in a particular
  BIOS. The thinner the abstraction, the better the power savings can
  get when implemented right.

* From the experience with x86, Linux tends to prefer using drivers
  for hardware registers over the AML based drivers when both are
  implemented, because of efficiency and correctness.

We should probably discuss at some point how to get the best of
both. I really don't like the idea of putting the low-level
details that we tend to have DT into ACPI, but there are two
things we can do: For systems that have a high-level abstraction
for their PM in hardware (e.g. talking to an embedded controller
that does the actual work), the ACPI description should contain
enough information to implement a kernel-level driver for it as
we have on Intel machines. For more traditional SoCs that do everything
themselves, I would recommend to always have a working DT for
those people wanting to get the most of their hardware. This will
also enable any other SoC features that cannot be represented in
ACPI.

> What remains is sorting out how we make sure everything works. How do
> we make sure there is enough cross platform testing to ensure new
> hardware doesn't ship broken and that new OS releases don't break on
> old hardware? Those are the reasons why a UEFI/ACPI firmware summit is
> being organized, it's why the UEFI forum holds plugfests 3 times a
> year, and it is why we're working on FWTS and LuvOS.

Right.

> Reliability, Availability & Serviceability (RAS)
> ------------------------------------------------
> 7. Support RAS interfaces
> 
> This isn't a question of whether or not DT can support RAS. Of course
> it can. Rather it is a matter of RAS bindings already existing for
> ACPI, including a usage model. We've barely begun to explore this on
> DT. This item doesn't make ACPI technically superior to DT, but it
> certainly makes it more mature.

Unfortunately, RAS can mean a lot of things to different people.
Is there some high-level description of what the APCI idea of RAS
is? On systems I've worked on in the past, this was generally done
out of band (e.g. in an IPMI BMC) because you can't really trust
the running OS when you report errors that may impact data consistency
of that OS.

> Multiplatform support
> ---------------------
> 1. Support multiple OSes, including Linux and Windows
> 
> I'm tackling this item last because I think it is the most contentious
> for those of us in the Linux world. I wanted to get the other issues
> out of the way before addressing it.
>
> I know that this line of thought is more about market forces rather
> than a hard technical argument between ACPI and DT, but it is an
> equally significant one. Agreeing on a single way of doing things is
> important. The ARM server ecosystem is better for the agreement to use
> the same interface for all operating systems. This is what is meant by
> standards compliant. The standard is a codification of the mutually
> agreed interface. It provides confidence that all vendors are using
> the same rules for interoperability.

I do think that this is in fact the most important argument in favor
of doing ACPI on Linux, because a number of companies are betting on
Windows (or some in-house OS that uses ACPI) support. At the same time,
I don't think talking of a single 'ARM server ecosystem' that needs to
agree on one interface is helpful here. Each server company has their
own business plan and their own constraints. I absolutely think that
getting as many companies as possible to agree on SBSA and UEFI is
helpful here because it reduces the the differences between the platforms
as seen by a distro. For companies that want to support Windows, it's
obvious they want to have ACPI on their machines, for others the
factors you mention above can be enough to justify the move to ACPI
even without Windows support. Then there are other companies for
which the tradeoffs are different, and I see no reason for forcing
it on them. Finally there are and will likely always be chips that
are not built around SBSA and someone will use the chips in creative
ways to build servers from them, so we already don't have a homogeneous
ecosystem. 

	Arnd
