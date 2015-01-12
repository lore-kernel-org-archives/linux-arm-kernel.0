From: grant.likely@linaro.org (Grant Likely)
Date: Mon, 12 Jan 2015 12:00:31 +0000
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <1636716.eAYJb6Z2AV@wuerfel>
References: <548F9668.6080900@linaro.org>
 <CACxGe6vRN2Tc97=Sx05gri02goxBaHnZm30hR37q=002agFLAA@mail.gmail.com>
 <CACxGe6sbGu53x5rsx2sWVVVVCnnFvmkQAk3Se9ZGNOXCkqpi=A@mail.gmail.com>
 <1636716.eAYJb6Z2AV@wuerfel>
Message-ID: <CACxGe6tMv7jz9h7RziPMj5jV5_0GZCx=enEXTwuaKS1GTsOouw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 10:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 10 January 2015 14:44:02 Grant Likely wrote:
>> On Wed, Dec 17, 2014 at 10:26 PM, Grant Likely <grant.likely@linaro.org> wrote:
>
>> I've posted an article on my blog, but I'm reposting it here because
>> the mailing list is more conducive to discussion...
>>
>> http://www.secretlab.ca/archives/151
>>
>> Why ACPI on ARM?
>> ----------------
>>
>> Why are we doing ACPI on ARM? That question has been asked many times,
>> but we haven't yet had a good summary of the most important reasons
>> for wanting ACPI on ARM. This article is an attempt to state the
>> rationale clearly.
>
> Thanks for writing this up, much appreciated. I'd like to comment
> on some of the points here, which seems easier than commenting on the
> blog post.

Thanks for reading through it. Replies below...

>
>> Device Configurations
>> ---------------------
>> 2. Support device configurations
>> 3. Support dynamic device configurations (hot add/removal)
>>
> ...
>>
>> DT platforms have also supported dynamic configuration and hotplug for
>> years. There isn't a lot here that differentiates between ACPI and DT.
>> The biggest difference is that dynamic changes to the ACPI namespace
>> can be triggered by ACPI methods, whereas for DT changes are received
>> as messages from firmware and have been very much platform specific
>> (e.g. IBM pSeries does this)
>
> This seems like a great fit for AML indeed, but I wonder what exactly
> we want to hotplug here, since everything I can think of wouldn't need
> AML support for the specific use case of SBSA compliant servers:

[...]

I've trimmed the specific examples here because I think that misses
the point. The point is that regardless of interface (either ACPI or
DT) there are always going to be cases where the data needs to change
at runtime. Not all platforms will need to change the CPU data, but
some will (say for a machine that detects a failed CPU and removes
it). Some PCI add-in boards will carry along with them additional data
that needs to be inserted into the ACPI namespace or DT. Some
platforms will have system level component (ie. non-PCI) that may not
always be accessible.

ACPI has an interface baked in already for tying data changes to
events. DT currently needs platform specific support (which we can
improve on). I'm not even trying to argue for ACPI over DT in this
section, but I included it this document because it is one of the
reasons often given for choosing ACPI and I felt it required a more
nuanced discussion.

>> Power Management Model
>> ----------------------
>> 4. Support hardware abstraction through control methods
>> 5. Support power management
>> 6. Support thermal management
>>
>> Power, thermal, and clock management can all be dealt with as a group.
>> ACPI defines a power management model (OSPM) that both the platform
>> and the OS conform to. The OS implements the OSPM state machine, but
>> the platform can provide state change behaviour in the form of
>> bytecode methods. Methods can access hardware directly or hand off PM
>> operations to a coprocessor. The OS really doesn't have to care about
>> the details as long as the platform obeys the rules of the OSPM model.
>>
>> With DT, the kernel has device drivers for each and every component in
>> the platform, and configures them using DT data. DT itself doesn't
>> have a PM model. Rather the PM model is an implementation detail of
>> the kernel. Device drivers use DT data to decide how to handle PM
>> state changes. We have clock, pinctrl, and regulator frameworks in the
>> kernel for working out runtime PM. However, this only works when all
>> the drivers and support code have been merged into the kernel. When
>> the kernel's PM model doesn't work for new hardware, then we change
>> the model. This works very well for mobile/embedded because the vendor
>> controls the kernel. We can change things when we need to, but we also
>> struggle with getting board support mainlined.
>
> I can definitely see this point, but I can also see two important
> downsides to the ACPI model that need to be considered for an
> individual implementor:
>
> * As a high-level abstraction, there are limits to how fine-grained
>   the power management can be done, or is implemented in a particular
>   BIOS. The thinner the abstraction, the better the power savings can
>   get when implemented right.

Agreed. That is the tradeoff. OSPM defines a power model, and the
machine must restrict any PM behaviour to fit within that power model.
This is important for interoperability, but it also leaves performance
on the table. ACPI at least gives us the option to pick that
performance back up by adding better power management to the drivers,
without sacrificing the interoperability provided by OSPM.

In other words, OSPM gets us going, but we can add specific
optimizations when required.

Also important: Vendors can choose to not implement any PM into their
ACPI tables at all. In this case the the machine would be left running
at full tilt. It will be compatible with everything, but it won't be
optimized. Then they have the option of loading a PM driver at runtime
to optimize the system with the caveat that the PM driver must not be
required for the machine to be operational. In this case, as far as
the OS is concerned, it is still applying the OSPM state machine, but
the OSPM behaviour never changes the state of the hardware.

> * From the experience with x86, Linux tends to prefer using drivers
>   for hardware registers over the AML based drivers when both are
>   implemented, because of efficiency and correctness.
>
> We should probably discuss at some point how to get the best of
> both. I really don't like the idea of putting the low-level
> details that we tend to have DT into ACPI, but there are two
> things we can do: For systems that have a high-level abstraction
> for their PM in hardware (e.g. talking to an embedded controller
> that does the actual work), the ACPI description should contain
> enough information to implement a kernel-level driver for it as
> we have on Intel machines. For more traditional SoCs that do everything
> themselves, I would recommend to always have a working DT for
> those people wanting to get the most of their hardware. This will
> also enable any other SoC features that cannot be represented in
> ACPI.

The nice thing about ACPI is that we always have the option of
ignoring it when the driver knows better since it is always executed
under the control of the kernel interpreter. There is no ACPI going
off and doing something behind the kernel's back. To start with we
have the OSPM state model and devices can use additional ACPI methods
as needed, but as an optimization, the driver can do those operations
directly if the driver author has enough knowledge about the device.

>> Reliability, Availability & Serviceability (RAS)
>> ------------------------------------------------
>> 7. Support RAS interfaces
>>
>> This isn't a question of whether or not DT can support RAS. Of course
>> it can. Rather it is a matter of RAS bindings already existing for
>> ACPI, including a usage model. We've barely begun to explore this on
>> DT. This item doesn't make ACPI technically superior to DT, but it
>> certainly makes it more mature.
>
> Unfortunately, RAS can mean a lot of things to different people.
> Is there some high-level description of what the APCI idea of RAS
> is? On systems I've worked on in the past, this was generally done
> out of band (e.g. in an IPMI BMC) because you can't really trust
> the running OS when you report errors that may impact data consistency
> of that OS.

RAS is also something where every company already has something that
they are using on their x86 machines. Those interfaces are being
ported over to the ARM platforms and will be equivalent to what they
already do for x86. So, for example, an ARM server from DELL will use
mostly the same RAS interfaces as an x86 server from DELL.

>
>> Multiplatform support
>> ---------------------
>> 1. Support multiple OSes, including Linux and Windows
>>
>> I'm tackling this item last because I think it is the most contentious
>> for those of us in the Linux world. I wanted to get the other issues
>> out of the way before addressing it.
>>
>> I know that this line of thought is more about market forces rather
>> than a hard technical argument between ACPI and DT, but it is an
>> equally significant one. Agreeing on a single way of doing things is
>> important. The ARM server ecosystem is better for the agreement to use
>> the same interface for all operating systems. This is what is meant by
>> standards compliant. The standard is a codification of the mutually
>> agreed interface. It provides confidence that all vendors are using
>> the same rules for interoperability.
>
> I do think that this is in fact the most important argument in favor
> of doing ACPI on Linux, because a number of companies are betting on
> Windows (or some in-house OS that uses ACPI) support. At the same time,
> I don't think talking of a single 'ARM server ecosystem' that needs to
> agree on one interface is helpful here. Each server company has their
> own business plan and their own constraints. I absolutely think that
> getting as many companies as possible to agree on SBSA and UEFI is
> helpful here because it reduces the the differences between the platforms
> as seen by a distro. For companies that want to support Windows, it's
> obvious they want to have ACPI on their machines, for others the
> factors you mention above can be enough to justify the move to ACPI
> even without Windows support. Then there are other companies for
> which the tradeoffs are different, and I see no reason for forcing
> it on them. Finally there are and will likely always be chips that
> are not built around SBSA and someone will use the chips in creative
> ways to build servers from them, so we already don't have a homogeneous
> ecosystem.

Allow me to clarify my position here. This entire document is about
why ACPI was chosen for the ARM SBBR specification. The SBBR and the
SBSA are important because they document the agreements and
compromises made by vendors and industry representatives to get
interoperability. It is a tool for vendors to say that they are aiming
for compatibility with a particularly hardware/software ecosystem.

*Nobody* is forced to implement these specifications. Any company is
free to ignore them and go their own way. The tradeoff in doing so is
it means they are on their own for support. Non-compliant hardware
vendors have to convince OS vendors to support them, and similarly,
non-compliant OS vendors need to convince hardware vendors of the
same. Red Had has stated very clearly that they won't support any
hardware that isn't SBSA/SBBR compliant. So has Microsoft. Canonical
on the other hand has said they will support whatever if there is a
business case. This certainly is a business decision and each company
needs to make its own choices.

As far as we (Linux maintainers) are concerned, we've also been really
clear that DT is not a second class citizen to ACPI. Mainline cannot
and should not force certain classes of machines to use ACPI and other
classes of machines to use DT. As long as the code is well written and
conforms to our rules for what ACPI or DT code is allowed to do, then
we should be happy to take the patches.

g.
