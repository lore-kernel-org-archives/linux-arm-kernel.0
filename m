From: james.morse@arm.com (James Morse)
Date: Wed, 29 Aug 2018 11:20:48 +0100
Subject: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
In-Reply-To: <20180829073804.GA6843@nazgul.tnic>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
 <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
 <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
 <20180824120102.GB29751@nazgul.tnic>
 <0a94db2a-2569-ac46-1a79-a05f46a4ea6f@arm.com>
 <20180829073804.GA6843@nazgul.tnic>
Message-ID: <2e7b984a-8f8f-dad7-4ee5-043dd236a9b1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 29/08/18 08:38, Borislav Petkov wrote:
> On Tue, Aug 28, 2018 at 06:09:24PM +0100, James Morse wrote:
>> Does x86 have another source of memory-topology information it needs to
>> correlate smbios with?
> 
> Bah, pinpointing the DIMM on x86 is a mess. There's no reliable way to
> say which DIMM it is in certain cases (interleaving, mirrorring, ...)
> and it is all platform-dependent. So we do the layers to dump a memory
> location (node, memory controller, ....) so that we can at least limit
> the number of DIMMs the user needs to replace/try.

Right. I'd like ghes-edac to work in the same way for both architectures.

I think this is best done by stuffing the dmi-handle in struct dimm_info during
ghes_edac_dmidecode(), then populating the struct edac_raw_error_desc layers
from the matching mci->dimms 'location'.

For EDAC_MC_LAYER_ALL_MEM this boils down to a flat index, so pointer arithmetic
on mci->dimms is an appropriate short cut.

(We should probably 'FIXME: It shouldn't be hard to also fill the DIMM labels'
at the same time so that no-one is tempted to interpret the edac:dimm-idx)


> In an ideal world, I'd like to be able to query the SPD chips on the

(oh, that can be done?)


> DIMMs and build the topology and then when an error happens to say,
> "error in DIMM <silkscreen>" where silkscreen is what is written on the
> motherboard under the DIMM socket.
> 
> But I don't see that happening any time soon...

>> For arm there is nothing else describing the memory-topology, so as long as we
>> can correlate the smbios table and ghes:cper records through the handles, we can
>> get this working for all systems.
> 
> And then make sure vendors fill in the proper info in smbios. Because that's
> also a mess on x86.

I got educated by the people who look after specifications last time I touched
this [0]. SMBIOS tables are required by Arm's 'Server Base Boot Requirements',
It lists the memory-device and physical-memory-array as required.

I will drop them a note that we will be depending on the handle, and it should
go on the list too... if its not populated on today's systems we can fall back
to !e->enable_per_layer_report as we do today.


Thanks,

James

[0] https://www.spinics.net/lists/arm-kernel/msg653133.html
