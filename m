From: ahs3@redhat.com (Al Stone)
Date: Tue, 13 Jan 2015 17:26:33 -0700
Subject: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
In-Reply-To: <CACxGe6t9Rbrr5166UDm8T7UVM_4k9jBFv=ozJB1zY=Kvi6F1LQ@mail.gmail.com>
References: <548F9668.6080900@linaro.org> <1636716.eAYJb6Z2AV@wuerfel>
 <CACxGe6tMv7jz9h7RziPMj5jV5_0GZCx=enEXTwuaKS1GTsOouw@mail.gmail.com>
 <1421113529.giGjG4IzLy@wuerfel>
 <CACxGe6t9Rbrr5166UDm8T7UVM_4k9jBFv=ozJB1zY=Kvi6F1LQ@mail.gmail.com>
Message-ID: <54B5B7B9.6090101@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2015 10:22 AM, Grant Likely wrote:
> On Mon, Jan 12, 2015 at 7:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Monday 12 January 2015 12:00:31 Grant Likely wrote:
>>> On Mon, Jan 12, 2015 at 10:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Saturday 10 January 2015 14:44:02 Grant Likely wrote:
>>>>> On Wed, Dec 17, 2014 at 10:26 PM, Grant Likely <grant.likely@linaro.org> wrote:
>>>> This seems like a great fit for AML indeed, but I wonder what exactly
>>>> we want to hotplug here, since everything I can think of wouldn't need
>>>> AML support for the specific use case of SBSA compliant servers:
>>>
>>> [...]
>>>
>>> I've trimmed the specific examples here because I think that misses
>>> the point. The point is that regardless of interface (either ACPI or
>>> DT) there are always going to be cases where the data needs to change
>>> at runtime. Not all platforms will need to change the CPU data, but
>>> some will (say for a machine that detects a failed CPU and removes
>>> it). Some PCI add-in boards will carry along with them additional data
>>> that needs to be inserted into the ACPI namespace or DT. Some
>>> platforms will have system level component (ie. non-PCI) that may not
>>> always be accessible.
>>
>> Just to be sure I get this right: do you mean runtime or boot-time
>> (re-)configuration for those?
> 
> Both are important.
> 
>>> ACPI has an interface baked in already for tying data changes to
>>> events. DT currently needs platform specific support (which we can
>>> improve on). I'm not even trying to argue for ACPI over DT in this
>>> section, but I included it this document because it is one of the
>>> reasons often given for choosing ACPI and I felt it required a more
>>> nuanced discussion.
>>
>> I can definitely see the need for an architected interface for
>> dynamic reconfiguration in cases like this, and I think the ACPI
>> model actually does this better than the IBM Power hypervisor
>> model, I just didn't see the need on servers as opposed to something
>> like a laptop docking station to give a more obvious example I know
>> from x86.

I know of at least one server product (non-ARM) that uses the
hot-plugging of CPUs and memory as a key feature, using the
ACPI OSPM model.  Essentially, the customer buys a system with
a number of slots and pays for filling one or more of them up
front.  As the need for capacity increases, CPUs and/or RAM gets
enabled; i.e., you have spare capacity that you buy as you need
it.  If you use up all the CPUs and RAM you have, you buy more
cards, fill the additional slots, and turn on what you need.  This
is very akin to the virtual machine model, but done with real hardware
instead.

Whether or not this product is still being sold, I do not know.  I
have not worked for that company for eight years, and they were just
coming out as I left.  Regardless, this sort of hot-plug does make
sense in the server world, and has been used in shipping products.

>>>>[snip....]
>>
>>>>> Reliability, Availability & Serviceability (RAS)
>>>>> ------------------------------------------------
>>>>> 7. Support RAS interfaces
>>>>>
>>>>> This isn't a question of whether or not DT can support RAS. Of course
>>>>> it can. Rather it is a matter of RAS bindings already existing for
>>>>> ACPI, including a usage model. We've barely begun to explore this on
>>>>> DT. This item doesn't make ACPI technically superior to DT, but it
>>>>> certainly makes it more mature.
>>>>
>>>> Unfortunately, RAS can mean a lot of things to different people.
>>>> Is there some high-level description of what the APCI idea of RAS
>>>> is? On systems I've worked on in the past, this was generally done
>>>> out of band (e.g. in an IPMI BMC) because you can't really trust
>>>> the running OS when you report errors that may impact data consistency
>>>> of that OS.
>>>
>>> RAS is also something where every company already has something that
>>> they are using on their x86 machines. Those interfaces are being
>>> ported over to the ARM platforms and will be equivalent to what they
>>> already do for x86. So, for example, an ARM server from DELL will use
>>> mostly the same RAS interfaces as an x86 server from DELL.
>>
>> Right, I'm still curious about what those are, in case we have to
>> add DT bindings for them as well.
> 
> Certainly.

In ACPI terms, the features used are called APEI (Advanced Platform
Error Interface), and defined in Section 18 of the specification.  The
tables describe what the possible error sources are, where details about
the error are stored, and what to do when the errors occur.  A lot of
the "RAS tools" out there that report and/or analyze error data rely on
this information being reported in the form given by the spec.

I only put "RAS tools" in quotes because it is indeed a very loosely
defined term -- I've had everything from webmin to SNMP to ganglia,
nagios and Tivoli described to me as a RAS tool.  In all of those cases,
however, the basic idea was to capture errors as they occur, and try to
manage them properly.  That is, replace disks that seem to be heading
down hill, or look for faults in RAM, or dropped packets on LANs --
anything that could help me avoid a catastrophic failure by doing some
preventive maintenance up front.

And indeed a BMC is often used for handling errors in servers, or to
report errors out to something like nagios or ganglia.  It could
also just be a log in a bit of NVRAM, too, with a little daemon that
reports back somewhere.  But, this is why APEI is used: it tries to
provide a well defined interface between those reporting the error
(firmware, hardware, OS, ...) and those that need to act on the error
(the BMC, the OS, or even other bits of firmware).

Does that help satisfy the curiosity a bit?

BTW, there are also some nice tools from ACPICA that, if enabled, allow
one to simulate the occurrence of an error and test out the response.
What you can do is define the error source and what response you want
the OSPM to take (HEST, or Hardware Error Source Table), then use the
EINJ (Error Injection) table to describe how to simulate the error
having occurred.  You then tell ACPICA to "run" the EINJ and test how
the system actually responds.  You can do this with many EINJ tables,
too, so you can experiment with or debug APEI tables as you develop
them.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
