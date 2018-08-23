From: baicar.tyler@gmail.com (Tyler Baicar)
Date: Thu, 23 Aug 2018 11:46:59 -0400
Subject: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
In-Reply-To: <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
 <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
Message-ID: <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello James,

On Thu, Aug 23, 2018 at 5:29 AM James Morse <james.morse@arm.com> wrote:
> On 19/07/18 19:36, Tyler Baicar wrote:
> > On 7/19/2018 10:46 AM, James Morse wrote:
> >> On 19/07/18 15:01, Borislav Petkov wrote:
> >>> On Mon, Jul 16, 2018 at 01:26:49PM -0400, Tyler Baicar wrote:
> >>>> Enable per-layer error reporting for ARM systems so that the error
> >>>> counters are incremented per-DIMM.
>
> This 'layer' term seems to be EDAC's artificial view of memory.
>

Yes, it's just the terminology that EDAC uses for locating a DIMM.

"Layer" can mean several things here:

https://elixir.bootlin.com/linux/latest/source/include/linux/edac.h#L318

We should be able to avoid the layer definitions with the SMBIOS handles.

>
> >> Does this work on x86, and its just the dmi/cper fields have a subtle difference?
>
> > There are CPU specific EDAC drivers for a lot of x86 folks and those drivers
> > populate the layer information in a custom way.
>
> Not for GHES surely?
>

Correct, the x86 drivers that properly increment the DIMM error counters are not
tied to the ghes_edac driver.

>
> (DPC == DIMM per Channel?)
>

Yes.

> > The goal is to be able to enable the per layer error reporting in the ghes_edac
> > driver so that the per dimm counters exposed in the EDAC sysfs nodes are properly
> > updated.
>
> What do you mean by layer? I can't find anything in the ACPI/UEFI/SMBIOS specs
> that uses this term...
>
> If its just 'per dimm counters' you're after, this looks straightforward.
>

Yes, we just need a way to increment the per DIMM counters that are
exposed by the
EDAC sysfs nodes.

> [re-ordered hunk:]
> > This seems pretty hacky to me, so if anyone has other suggestions please share
> > them.
>
> CPER's "Memory Error Record 2" thinks that "NODE, CARD and MODULE should provide
> the information necessary to identify the failing FRU". As EDAC has three
> 'levels', these are what they should correspond to for ghes-edac.
>
> I assume NODE means rack/chassis in some distributed system. Lets ignore it as
> it doesn't seem to map to anything in the SMBIOS table.

I believe NODE should map to socket number for multi-socket systems.

> The CPER record's card and module numbers are useless to us, as we need to know
> how many there will be in advance. (does this version of firmware count from 0
> or 1?)
>
> ... but CPER also gives us a 'Card Handle' and 'Module Handle'.
> 'Module Handle' maps to SMBIOS:17 Memory Device (aka, a DIMM). The Handle is a
> word-value in the structure, so it doesn't depend on the layout/parse-order of
> the SMBIOS tables. When we count the DIMMs in edac-ghes we can give them some
> level-idx, then use the handle to find which level-idx to use for this DIMM.
>
> ghes_edac_report_mem_error() already picks up the module-handle, but only uses
> it to print the bank/device.
>
> 'Card' doesn't mean much to me, but it maps to SMBIOS:17 "Memory Array
> Structure", which the Memory Device structure also points to.
> Card then must mean "a collection of memory devices (DIMMs) that operate
> together to form an address space".
>
> This might be what I think of as a memory-controller, or it might be something
> more complicated. Regardless, the CPER records think its relevant.
>
> For the edac:layers, we could walk the DMI table to find these structures, and
> build the layers from them. If the Memory-array-structures are missing, we can
> use the existing 1:NUM_DIMMS approach.
>

I think the proper way to get this working would be to use these handles. We can
avoid populating this layer information and instead have a mapping of type 17
index number (how edac is numbering the DIMMs today) to the handle number.
Then we will need a new function to increment the counter based on the handle
number rather than this layer information. Is that how you are envisioning it?

Thanks,
Tyler
