From: baicar.tyler@gmail.com (Tyler Baicar)
Date: Tue, 28 Aug 2018 16:04:41 -0400
Subject: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
In-Reply-To: <bcb1b461-76ee-7d9b-2b35-d575ec608027@arm.com>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
 <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
 <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
 <CABo9ajAvo-bskhrM8h95Y9D4U88zFUZfVW_HTMLK3o_5Q1VSUw@mail.gmail.com>
 <bcb1b461-76ee-7d9b-2b35-d575ec608027@arm.com>
Message-ID: <CABo9ajA3Bs0ibcNXumFLzdaaCTDSBVpCc5UaBRHsw-1pzBuAkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 1:11 PM, James Morse <james.morse@arm.com> wrote:
> On 24/08/18 16:14, Tyler Baicar wrote:
>> On Fri, Aug 24, 2018 at 5:48 AM, James Morse <james.morse@arm.com> wrote:
>>> On 23/08/18 16:46, Tyler Baicar wrote:
>>> so edac_raw_mc_handle_error() has no clue where the error happened. (I haven't
>>> read what it does with this information yet).
>>>
>>> ghes_edac_report_mem_error() does check CPER_MEM_VALID_MODULE_HANDLE, and if its
>>> set, it uses the handle to find the bank/device strings and prints them out.
>>
>> Yes, I think this is where we need to add support to increment the
>> count based on that module handle.
>
> If layer[0] is EDAC_MC_LAYER_ALL_MEM, sized for num_dimm, don't we just put the
> dimm number in e->top_layer and flip e->enable_per_layer_report?

Yes, that is all we would need to do. Figuring out that DIMM number is
the issue, but that can be done with the map of module handles to DIMM
index.

>>> Naively I thought we could generate some index during ghes_edac_count_dimms(),
>>> and use this as e->${whichever}_layer. I hoped there would be something we could
>>> already use as the index, but I can't spot it, so this will be more than the
>>> one-liner I was hoping for!
>>
>> We could use what ghes_edac_register does by setting up a single layer
>> with all memory and
>> then keep a map of which module handle maps to which index into that
>> layer. From that it would
>> be easy to increment the proper sysfs exposed DIMM counters using the
>> single layer
>
> Yes, I think this is what we should do!

Sounds good, I'll start working on this!

Thanks,
Tyler
