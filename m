From: james.morse@arm.com (James Morse)
Date: Thu, 23 Aug 2018 10:28:32 +0100
Subject: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
In-Reply-To: <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
Message-ID: <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

(CC: +Fan Wu)

On 19/07/18 19:36, Tyler Baicar wrote:
> On 7/19/2018 10:46 AM, James Morse wrote:
>> On 19/07/18 15:01, Borislav Petkov wrote:
>>> On Mon, Jul 16, 2018 at 01:26:49PM -0400, Tyler Baicar wrote:
>>>> Enable per-layer error reporting for ARM systems so that the error
>>>> counters are incremented per-DIMM.

This 'layer' term seems to be EDAC's artificial view of memory.


>> I'm guessing this is the mapping between CPER records and the DMItable data.

> Unfortunately the DMI table doesn't actually have channel and DIMM number values
> which makes this more complicated than I originally thought...

>>>> information and enable per layer error reporting for ARM systems so that
>>>> the EDAC error counters are incremented based on DIMM number as per the
>>>> SMBIOS table rather than just incrementing the noinfo counters on the
>>>> memory controller.

>> Does this work on x86, and its just the dmi/cper fields have a subtle difference?

> There are CPU specific EDAC drivers for a lot of x86 folks and those drivers
> populate the layer information in a custom way.

Not for GHES surely?


> With more investigation and testing it turns out a simple patch like this is not
> going to work. This worked for
> me on a 1DPC board since the card number turned out to always be the same as the
> index into the DMI table
> to find the proper DIMM. On a 2DPC board this fails completely. The ghes_edac
> driver only sets up a single
> layer so it is only using the card number with this patch.

(DPC == DIMM per Channel?)


> So it is only setting up a single layer with all the DIMMs on that layer. In
> order to properly enable the layers
> to represent channel and DIMM number on that channel, we would need to have a
> way of determining the
> number of channels (which would be layers[0].size) and the number of DIMMs each
> channel supported
> (layers[1].size). There doesn't appear to be a way to determine that information
> at this point.

So, we're after a mapping for EDAC:layers that includes 'channel'?

What would you do with a channel counter? Isn't that part of the SoC? (it can't
be replaced!)


> The goal is to be able to enable the per layer error reporting in the ghes_edac
> driver so that the per dimm counters exposed in the EDAC sysfs nodes are properly
> updated.

What do you mean by layer? I can't find anything in the ACPI/UEFI/SMBIOS specs
that uses this term...

If its just 'per dimm counters' you're after, this looks straightforward.


> The other obvious but more messy way would be to have notifiers register to be called
> by ghes_edac and have a custom EDAC driver for each CPU to properly populate their layer
> information.

Yuck. This isn't platform specific, its firmware specific. You're hooking the
driver to say "my firmware thinks 'card' means this".

Where would this information come from? We don't want
per-soc,per-firmware-version code mangling what was supposed to be a standard
interface.

... we can't be the first people to try and do this ...

[re-ordered hunk:]
> This seems pretty hacky to me, so if anyone has other suggestions please share
> them.

CPER's "Memory Error Record 2" thinks that "NODE, CARD and MODULE should provide
the information necessary to identify the failing FRU". As EDAC has three
'levels', these are what they should correspond to for ghes-edac.

I assume NODE means rack/chassis in some distributed system. Lets ignore it as
it doesn't seem to map to anything in the SMBIOS table.

The CPER record's card and module numbers are useless to us, as we need to know
how many there will be in advance. (does this version of firmware count from 0
or 1?)

... but CPER also gives us a 'Card Handle' and 'Module Handle'.
'Module Handle' maps to SMBIOS:17 Memory Device (aka, a DIMM). The Handle is a
word-value in the structure, so it doesn't depend on the layout/parse-order of
the SMBIOS tables. When we count the DIMMs in edac-ghes we can give them some
level-idx, then use the handle to find which level-idx to use for this DIMM.

ghes_edac_report_mem_error() already picks up the module-handle, but only uses
it to print the bank/device.


'Card' doesn't mean much to me, but it maps to SMBIOS:17 "Memory Array
Structure", which the Memory Device structure also points to.
Card then must mean "a collection of memory devices (DIMMs) that operate
together to form an address space".

This might be what I think of as a memory-controller, or it might be something
more complicated. Regardless, the CPER records think its relevant.

For the edac:layers, we could walk the DMI table to find these structures, and
build the layers from them. If the Memory-array-structures are missing, we can
use the existing 1:NUM_DIMMS approach.


Hope this makes sense!


Thanks,

James
