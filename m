From: al.stone@linaro.org (Al Stone)
Date: Tue, 16 Dec 2014 15:55:50 -0700
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <9355623.14GfrLxEB0@wuerfel>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel>
Message-ID: <5490B876.50101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/2014 04:27 AM, Arnd Bergmann wrote:
> On Monday 15 December 2014 19:18:16 Al Stone wrote:
> 
>> Below is what we currently know about; very brief notes on status are
>> included.  The TL;DR versions of the TODO list and the current status
>> can be found at:
>>
>>    https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI/CoreUpstreamNotes
>>
[snip...]
>>
>> TODO List for ACPI on arm64:
>> ============================
>> 1. Define how Aarch64 OS identifies itself to firmware.
>>    * Problem:
>>      * _OSI method is demonstrably unreliable. On x86 Linux claims to
>>        be Windows
>>      * Proposal to use _OSC method as replacement is complicated and
>>        creates an explosion of combinations
>>    * Solution:
>>      * Draft and propose OS identification rules to ABST and ASWG for
>>        inclusion in ACPI spec.
>>      * Draft and propose recommended practice for current ACPI 5.1 spec
>>        platforms.
>>    * Status: Little progress, still under investigation
> 
> I must have missed the problem with _OSC, it sounded like it was good
> enough, but I have no clue about the details.

The _OSC object has two flavors: a global version (aka, \_SB._OSC) and a
per device version.  In a way, these are similar to _DSD.  In both of
these cases, when the object is invoked, it returns a data packet that
starts with a UUID, and some data blob.  The UUID is associated with a
specific documented data format that tells the end user of the data
packet what the structure of the data is and how it is to be used.

So, for _OSC, we currently have two data formats -- i.e., two UUIDs --
defined.  One format is a series of bit fields letting the OS and the
firmware communicate what global ACPI features are available and who
controls them; this is the global _OSC.  The second format describes
PCI host bridges and are only to be used for specific devices (and has
been around for some time).

The first question is: is the global _OSC sufficient?  What it has today
is currently necessary, but does it have everything ARM needs?  I think
the answer is yes, but it needs some more thinking yet.

The second question is: how do we keep _OSC UUIDs from proliferating?
Or should we?  If we do, how to we keep them from getting out of hand
and keep them usable across OSs?  Again, this is much like _DSD and
we need to think that through.

>> 2. Linux must choose DT booting by default when offered both ACPI and
>>    DT on arm64
>>    * DONE

I've asked Hanjun to re-examine the patch we have.  If the setup_arch()
code for arm64 goes something like this:

   If acpi=force (or =on?)
      If ACPI tables exist
         use ACPI
      Else if a DT exists
         use DT, but issue a warning that ACPI tables are missing
      Else
         panic, 'cause we got nothin'
      Endif
   Else
      If a DT exists
         use DT
      Else if ACPI tables exist
         use ACPI, but issue a warning that the DT is missing
      Else
         panic, 'cause we got nothin'
      Endif
   Endif

...is that better?  Or worse?  Or just far too kind to people trying
to boot a kernel :)?

>> 4. Set clear expectations for those providing ACPI for use with Linux
>>    * Problem:
>>      * Hardware/Firmware vendors can and will create ACPI tables that
>>        cannot be used by Linux without some guidance
>>      * Kernel developers cannot determine whether the kernel or firmware
>>        is broken without knowing what the firmware should do
>>    * Solution: document the expectations, and iterate as needed.
>>      Enforce when we must.
>>    * Status: initial kernel text available; AMD has offered to make
>>      their guidance document generic; firmware summit planned for
>>      deeper discussions.
> 
> After seeing the AMD patches, I would add to this point that we need to
> find a way to come up with shared bindings for common hardware such as
> the ARM pl011/pl022/pl061/pl330 IP blocks or the designware
> i2c/spi/usb3/ahci blocks.

Agreed.  Discussions with ARM (started by AMD) are underway to settle
this out.

> What I remember from this item on your list is actually a different
> problem: We need to define more clearly what kinds of machines we
> would expect ACPI support for and which machines we would not.

Right.  I need to think through some text to add that sets out a sort
of vision, if you will, of such machines.

> Fine-grained clock support is one such example: if anybody needs
> to expose that through a clock driver in the kernel, we need to be
> very clear that we will not support that kind of machine through
> ACPI, so we don't get developers building BIOS images that will
> never be supported. Other examples would be non-compliant PCI
> hosts or machines that are not covered by SBSA.

Yup.  More text needed, I reckon.  I know we've talked about such
things in the past, but I need to make sure it is written down
somewhere proper.

>> 5. Demonstrate the ACPI core patches work
>>    * Problem: how can we be sure the patches work?
>>    * Solution: verify the patches on arm64 server platforms
>>    * Status:
>>      * ACPI core works on at least the Foundation model, Juno, APM
>>        Mustang, and AMD Seattle
>>      * FWTS results will be published as soon as possible
> 
> I think the problem is to a lesser degree the verification of the
> patches, but to have a patch set that demonstrates /how/ everything
> can work, and what the possible limitations are. I would not worry
> about any bugs that might keep the system from working properly, as
> long as you can show that there is a plan to make that work.

Indeed.  Perhaps the item above needs to be folded together with the
platform item at the end, where that's exactly the idea -- work out
the _how_ for the platform.

> Out of the four platforms you list, I think we have concluded that
> three of them are not appropriate for use with ACPI, but in order
> to do that, we needed to review the patches and pinpoint specific
> issues so we could avoid just exchanging different opinions on the
> matter of it "works" or not.
> 
>> 6. How does the kernel handle_DSD usage?
>>    * Problem:
>>      * _DSD defines key-value properties in the DT style. How do we
>>        ensure _DSD bindings are well defined?
>>      * How do we ensure DT and _DSD bindings remain consistent with
>>        each other?
>>    * Solution: public documentation for all bindings, and a process
>>      for defining them
>>    * Status: proposal to require patch authors to point at public
>>      binding documentation; kernel Documentation/devicetree/bindings
>>      remains the default if no other location exists; UEFI forum has
>>      set up a binding repository.
> 
> I think we also need to make a decision here on whether we want to use
> PRP0001 devices on ARM64 servers, and to what degree. I would prefer
> if we could either make them required for any devices that already have
> a DT binding and that are not part of the official ACPI spec, or we
> decide to not use them at all and make any PRP0001 usage a testcase
> failure.

Right.  _DSD is a whole long discussion by itself, I think.  There are
those who do not want to use it all, those who want to just replicate
everything in DT in _DSD, and a whole range in between.

There are really two issues, though, and I want to be clear on that:

   1) _DSD when used with the device properties UUID -- this is where
      we have to figure out how consistent we stay with DT

   2) _DSD and other UUIDs that define different data structures (see
      the notes above on _OSC)

How and when to use both needs to be clearly stated.

>> 7. Why is ACPI required?
>>    * Problem:
>>      * arm64 maintainers still haven't been convinced that ACPI is
>>        necessary.
>>      * Why do hardware and OS vendors say ACPI is required?
>>    * Status: Al & Grant collecting statements from OEMs to be posted
>>      publicly early in the new year; firmware summit for broader
>>      discussion planned.
> 
> I was particularly hoping to see better progress on this item. It
> really shouldn't be that hard to explain why someone wants this feature.

I don't think that it is that hard, but it is complicated.  Part of it
is that it just seems self-evident to those that use it (true of both DT
and ACPI, I suspect), and it can be hard to explain something that seems
obvious to you.  I think the other part is the business aspects of any
sort of public statements for companies that have not had to be very
public about anything in the past.  But, that's just my USD$0.02 worth.
I'm not trying to justify how things have gone so far, but figure out
how to make them better.  So, I just keep whittling away at this for
now, making whatever progress I can.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
