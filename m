From: james.morse@arm.com (James Morse)
Date: Tue, 28 Aug 2018 18:09:24 +0100
Subject: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
In-Reply-To: <20180824120102.GB29751@nazgul.tnic>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
 <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
 <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
 <20180824120102.GB29751@nazgul.tnic>
Message-ID: <0a94db2a-2569-ac46-1a79-a05f46a4ea6f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 24/08/18 13:01, Borislav Petkov wrote:
> On Fri, Aug 24, 2018 at 10:48:24AM +0100, James Morse wrote:
>> so edac_raw_mc_handle_error() has no clue where the error happened. (I haven't
>> read what it does with this information yet).
> 
> See edac_inc_ce_error(), for example - it uses the layers which are not
> negative (-1) to increment the error counts of the respective layer. It
> all depends on what granularity of the hardware part you're reporting
> the error for: is it a DIMM rank, a whole DIMM or for a channel which
> can span multiple DIMM ranks. And so on...
> 
> Look at some of the drivers and how they're doing that layering. It all
> depends on whether you can get the precise info from the hw.

Hmmm, in this example we need the information from firmware, as that is where
ghes-edac gets its information from.

We already count the module/device/dimms in the smbios table, memory is
described as 'EDAC_MC_LAYER_ALL_MEM' with num_dimms. I think all we're missing
is which dimm in ghes_edac_report_mem_error(). We have the handle, we just need
a number between 1 and num_dimms.

If it turns out firmware doesn't populate the handles in its cper records, then
we can keep e->enable_per_layer_report false when calling
edac_raw_mc_handle_error().

(I suggest we ignore 'card', and just do this for the device/dimms).


>> Naively I thought we could generate some index during ghes_edac_count_dimms(),
>> and use this as e->${whichever}_layer. I hoped there would be something we could
>> already use as the index, but I can't spot it, so this will be more than the
>> one-liner I was hoping for!
> 
> If you can get that info from the hardware and injecting an error into
> a DIMM gives you the correct DIMM number so that we can increment the
> proper counter, then you're golden. I don't think that works reliably on
> x86, though, therefore the lumping together.

... 'correct DIMM number' ...

Does x86 have another source of memory-topology information it needs to
correlate smbios with?

For arm there is nothing else describing the memory-topology, so as long as we
can correlate the smbios table and ghes:cper records through the handles, we can
get this working for all systems.


Thanks,

James
