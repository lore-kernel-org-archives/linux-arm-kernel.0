From: wufan@codeaurora.org (wufan)
Date: Fri, 24 Aug 2018 08:30:13 -0600
Subject: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
In-Reply-To: <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
 <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
 <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
Message-ID: <000b01d43bb6$f9419b20$ebc4d160$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James, 
 
> Why get avoid the layer stuff? Isn't counting DIMM/memory-devices what
> EDAC_MC_LAYER_SLOT is for?

Borislav has explained it in his response. Here let me elaborate a little more. To use the layer information you need an accurate way to pinpoint each component in the layer and the parent components in the layers above. For example, to use EDAC_MC_LAYER_SLOT you also need information for the parent layer say EDAC_MC_LAYER_CHANNEL, or another layer on top say EDAC_MC_LAYER_BRANCH. There are no clear ways to get the information from SMBIOS table. In the case of "memory channel" we looked at type 37 which has the exact spelling but it was introduced to support RamBus and Synclink. Not sure we can readily use it for modern architecture concept of "channel/slot". 

 I think it is good enough if we can pin each error to the corresponding DIMM. At the end of the day DIMMs are what customer can replace in the memory system and that's all that they care about. For the manufacturers of the board/chips they have the knowledge to map the specific DIMMs to the upper layer components, so they can easily collect error counter data for upper layers. 

> CPER's "Memory Error Record 2" thinks that "NODE, CARD and MODULE
> should provide the information necessary to identify the failing FRU". As
> EDAC has three 'levels', these are what they should correspond to for ghes-
> edac.
> 
> I assume NODE means rack/chassis in some distributed system. Lets ignore it
> as it doesn't seem to map to anything in the SMBIOS table.

How about type 4 "Processor Information"?

> 'Card' doesn't mean much to me, but it maps to SMBIOS:17 "Memory Array
> Structure", which the Memory Device structure also points to.
> Card then must mean "a collection of memory devices (DIMMs) that operate
> together to form an address space".
> 
> This might be what I think of as a memory-controller, or it might be
> something more complicated. Regardless, the CPER records think its relevant.

Originally I thought "Card" were memory channel. But looking at the definition of "Card Handle" in CPER: "... this field contains the SMBIOS handle for the Type 16 Memory Array Structure that represents the memory card". So Card is memory controller or something similar to that. Right now ghes-edac assumes one mc. We probably need to map mc(s) to the type 16 instances in SMBIOS table. 

Thanks,
Fan
 
