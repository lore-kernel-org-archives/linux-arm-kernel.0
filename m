From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 13 Jan 2015 17:22:02 +0000
Subject: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
In-Reply-To: <1421113529.giGjG4IzLy@wuerfel>
References: <548F9668.6080900@linaro.org> <1636716.eAYJb6Z2AV@wuerfel>
 <CACxGe6tMv7jz9h7RziPMj5jV5_0GZCx=enEXTwuaKS1GTsOouw@mail.gmail.com>
 <1421113529.giGjG4IzLy@wuerfel>
Message-ID: <CACxGe6t9Rbrr5166UDm8T7UVM_4k9jBFv=ozJB1zY=Kvi6F1LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 7:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 12 January 2015 12:00:31 Grant Likely wrote:
>> On Mon, Jan 12, 2015 at 10:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Saturday 10 January 2015 14:44:02 Grant Likely wrote:
>> >> On Wed, Dec 17, 2014 at 10:26 PM, Grant Likely <grant.likely@linaro.org> wrote:
>> > This seems like a great fit for AML indeed, but I wonder what exactly
>> > we want to hotplug here, since everything I can think of wouldn't need
>> > AML support for the specific use case of SBSA compliant servers:
>>
>> [...]
>>
>> I've trimmed the specific examples here because I think that misses
>> the point. The point is that regardless of interface (either ACPI or
>> DT) there are always going to be cases where the data needs to change
>> at runtime. Not all platforms will need to change the CPU data, but
>> some will (say for a machine that detects a failed CPU and removes
>> it). Some PCI add-in boards will carry along with them additional data
>> that needs to be inserted into the ACPI namespace or DT. Some
>> platforms will have system level component (ie. non-PCI) that may not
>> always be accessible.
>
> Just to be sure I get this right: do you mean runtime or boot-time
> (re-)configuration for those?

Both are important.

>> ACPI has an interface baked in already for tying data changes to
>> events. DT currently needs platform specific support (which we can
>> improve on). I'm not even trying to argue for ACPI over DT in this
>> section, but I included it this document because it is one of the
>> reasons often given for choosing ACPI and I felt it required a more
>> nuanced discussion.
>
> I can definitely see the need for an architected interface for
> dynamic reconfiguration in cases like this, and I think the ACPI
> model actually does this better than the IBM Power hypervisor
> model, I just didn't see the need on servers as opposed to something
> like a laptop docking station to give a more obvious example I know
> from x86.
>
>> > * From the experience with x86, Linux tends to prefer using drivers
>> >   for hardware registers over the AML based drivers when both are
>> >   implemented, because of efficiency and correctness.
>> >
>> > We should probably discuss at some point how to get the best of
>> > both. I really don't like the idea of putting the low-level
>> > details that we tend to have DT into ACPI, but there are two
>> > things we can do: For systems that have a high-level abstraction
>> > for their PM in hardware (e.g. talking to an embedded controller
>> > that does the actual work), the ACPI description should contain
>> > enough information to implement a kernel-level driver for it as
>> > we have on Intel machines. For more traditional SoCs that do everything
>> > themselves, I would recommend to always have a working DT for
>> > those people wanting to get the most of their hardware. This will
>> > also enable any other SoC features that cannot be represented in
>> > ACPI.
>>
>> The nice thing about ACPI is that we always have the option of
>> ignoring it when the driver knows better since it is always executed
>> under the control of the kernel interpreter. There is no ACPI going
>> off and doing something behind the kernel's back. To start with we
>> have the OSPM state model and devices can use additional ACPI methods
>> as needed, but as an optimization, the driver can do those operations
>> directly if the driver author has enough knowledge about the device.
>
> Ok, makes sense.
>
>> >> Reliability, Availability & Serviceability (RAS)
>> >> ------------------------------------------------
>> >> 7. Support RAS interfaces
>> >>
>> >> This isn't a question of whether or not DT can support RAS. Of course
>> >> it can. Rather it is a matter of RAS bindings already existing for
>> >> ACPI, including a usage model. We've barely begun to explore this on
>> >> DT. This item doesn't make ACPI technically superior to DT, but it
>> >> certainly makes it more mature.
>> >
>> > Unfortunately, RAS can mean a lot of things to different people.
>> > Is there some high-level description of what the APCI idea of RAS
>> > is? On systems I've worked on in the past, this was generally done
>> > out of band (e.g. in an IPMI BMC) because you can't really trust
>> > the running OS when you report errors that may impact data consistency
>> > of that OS.
>>
>> RAS is also something where every company already has something that
>> they are using on their x86 machines. Those interfaces are being
>> ported over to the ARM platforms and will be equivalent to what they
>> already do for x86. So, for example, an ARM server from DELL will use
>> mostly the same RAS interfaces as an x86 server from DELL.
>
> Right, I'm still curious about what those are, in case we have to
> add DT bindings for them as well.

Certainly.

>> > I do think that this is in fact the most important argument in favor
>> > of doing ACPI on Linux, because a number of companies are betting on
>> > Windows (or some in-house OS that uses ACPI) support. At the same time,
>> > I don't think talking of a single 'ARM server ecosystem' that needs to
>> > agree on one interface is helpful here. Each server company has their
>> > own business plan and their own constraints. I absolutely think that
>> > getting as many companies as possible to agree on SBSA and UEFI is
>> > helpful here because it reduces the the differences between the platforms
>> > as seen by a distro. For companies that want to support Windows, it's
>> > obvious they want to have ACPI on their machines, for others the
>> > factors you mention above can be enough to justify the move to ACPI
>> > even without Windows support. Then there are other companies for
>> > which the tradeoffs are different, and I see no reason for forcing
>> > it on them. Finally there are and will likely always be chips that
>> > are not built around SBSA and someone will use the chips in creative
>> > ways to build servers from them, so we already don't have a homogeneous
>> > ecosystem.
>>
>> Allow me to clarify my position here. This entire document is about
>> why ACPI was chosen for the ARM SBBR specification.
>
> I thought it was about why we should merge ACPI support into the kernel,
> which seems to me like a different thing.

Nope! I'm not trying to make that argument here. This document is
primarily to document the rationale for choosing ACPI in the ARM
server SBBR document (from a Linux developer's perspective, granted).

I'll make arguments about actually merging the patches in a different email. :-)

>> As far as we (Linux maintainers) are concerned, we've also been really
>> clear that DT is not a second class citizen to ACPI. Mainline cannot
>> and should not force certain classes of machines to use ACPI and other
>> classes of machines to use DT. As long as the code is well written and
>> conforms to our rules for what ACPI or DT code is allowed to do, then
>> we should be happy to take the patches.
>
> What we are still missing though is a recommendation for a boot protocol.
> The UEFI bits in SBBR are generally useful for having compatibility
> across machines that we support in the kernel regardless of the device
> description, and we also need to have guidelines along the lines of
> "if you do ACPI, then do it like this" that are in SBBR. However, the
> way that these two are coupled into "you have to use ACPI and UEFI
> this way to build a compliant server" really does make the document
> much less useful for Linux.

I don't follow your argument. Exactly what problem do you have with
"You have to use ACPI and UEFI" to be compliant with the SBBR
document? Vendors absolutely have the choice to ignore those
documents, but doing so means they are explicitly rejecting the
platform that ARM has defined for server machines, and by extension,
explicitly rejecting the ecosystem and interoperability that goes with
it.

On the UEFI front, I don't see a problem. Linux mainline has the UEFI
stub on ARM, and that is the boot protocol.

For UEFI providing DT, the interface is set. We defined it, and it
works, but that is not part of the ARM server ecosystem as defined by
ARM. Why would the SBBR cover it?

My perspective is that Linux should support the SBSA+SBBR ecosystem,
but we don't need to be exclusive about it. We'll happily support
UEFI+DT platforms as well as UEFI+ACPI.

g.
