From: bp@alien8.de (Borislav Petkov)
Date: Fri, 24 Aug 2018 14:01:02 +0200
Subject: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
In-Reply-To: <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
 <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
 <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
Message-ID: <20180824120102.GB29751@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2018 at 10:48:24AM +0100, James Morse wrote:
> Why get avoid the layer stuff? Isn't counting DIMM/memory-devices what
> EDAC_MC_LAYER_SLOT is for?

Yap.

> so edac_raw_mc_handle_error() has no clue where the error happened. (I haven't
> read what it does with this information yet).

See edac_inc_ce_error(), for example - it uses the layers which are not
negative (-1) to increment the error counts of the respective layer. It
all depends on what granularity of the hardware part you're reporting
the error for: is it a DIMM rank, a whole DIMM or for a channel which
can span multiple DIMM ranks. And so on...

Look at some of the drivers and how they're doing that layering. It all
depends on whether you can get the precise info from the hw.

> ghes_edac_report_mem_error() does check CPER_MEM_VALID_MODULE_HANDLE, and if its
> set, it uses the handle to find the bank/device strings and prints them out.

Yap, and the error counts are lumped together into

  /sys/devices/system/edac/mc/mc*/ce_noinfo_count

> Naively I thought we could generate some index during ghes_edac_count_dimms(),
> and use this as e->${whichever}_layer. I hoped there would be something we could
> already use as the index, but I can't spot it, so this will be more than the
> one-liner I was hoping for!

If you can get that info from the hardware and injecting an error into
a DIMM gives you the correct DIMM number so that we can increment the
proper counter, then you're golden. I don't think that works reliably on
x86, though, therefore the lumping together.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
