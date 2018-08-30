From: bp@alien8.de (Borislav Petkov)
Date: Thu, 30 Aug 2018 12:28:15 +0200
Subject: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
In-Reply-To: <2e7b984a-8f8f-dad7-4ee5-043dd236a9b1@arm.com>
References: <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
 <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
 <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
 <20180824120102.GB29751@nazgul.tnic>
 <0a94db2a-2569-ac46-1a79-a05f46a4ea6f@arm.com>
 <20180829073804.GA6843@nazgul.tnic>
 <2e7b984a-8f8f-dad7-4ee5-043dd236a9b1@arm.com>
Message-ID: <20180830102815.GB20005@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 11:20:48AM +0100, James Morse wrote:
> Right. I'd like ghes-edac to work in the same way for both architectures.
> 
> I think this is best done by stuffing the dmi-handle in struct dimm_info during
> ghes_edac_dmidecode(), then populating the struct edac_raw_error_desc layers
> from the matching mci->dimms 'location'.
> 
> For EDAC_MC_LAYER_ALL_MEM this boils down to a flat index, so pointer arithmetic
> on mci->dimms is an appropriate short cut.

It all sounds nice on paper but you should try it on a couple of
machines first. See whether/how it actually works there.

Also, this probably would need to not change x86 unless you wanna fix it
there too. I'd think twice before I attempt such a thing though :)

> (We should probably 'FIXME: It shouldn't be hard to also fill the DIMM labels'
> at the same time so that no-one is tempted to interpret the edac:dimm-idx)

See above.

> > In an ideal world, I'd like to be able to query the SPD chips on the
> 
> (oh, that can be done?)

There was some talk initially and I've seen BIOS read SPD chips and
showing DIMM info but I've heard the word "proprietary" a couple of
times. Haven't dug any deeper though.

> I got educated by the people who look after specifications last time I touched
> this [0]. SMBIOS tables are required by Arm's 'Server Base Boot Requirements',
> It lists the memory-device and physical-memory-array as required.

It is always better to have certification on your side. Should make ARM
vendors dance.

> I will drop them a note that we will be depending on the handle, and it should
> go on the list too... if its not populated on today's systems we can fall back
> to !e->enable_per_layer_report as we do today.

Right.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
