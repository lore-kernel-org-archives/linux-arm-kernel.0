From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 21 Jan 2014 15:57:40 -0700
Subject: [RFC PATCH 3/9] of: mtd: add NAND timings retrieval support
In-Reply-To: <52D6BF45.80407@overkiz.com>
References: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
 <1389190924-26226-4-git-send-email-b.brezillon@overkiz.com>
 <20140108183418.GA12358@obsidianresearch.com>
 <52CDA032.3010804@overkiz.com>
 <20140108191339.GB12358@obsidianresearch.com>
 <52CE5F82.6070802@overkiz.com>
 <20140109173505.GB8899@obsidianresearch.com>
 <52D6A48D.4080302@overkiz.com> <52D6BF45.80407@overkiz.com>
Message-ID: <20140121225740.GP18269@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 06:03:01PM +0100, boris brezillon wrote:

> >>Pick a mode value that fits all the parameters of the connected
> >>non-ONFI flash.
> >>
> >>This would be instead of defining each parameter
> >>individually.. Provide some helpers to convert from a onfi mode number
> >>to all the onfi defined timing parameters so that drivers can
> >>configure the HW..
> >
> >Are you suggesting we should provide a function that converts these
> >modes into a nand_timings struct, or just use the timing modes and
> >let the NAND controller drivers configure its IP accordingly ?

Either seems reasonable to me, but passing the ONFI mode directly from
the NAND core to the driver seems a little safer..

The NAND core can provide a helper function to xlate the mode number
to the timing struct to help drivers that need broken out timing.

> >I found the ONFI timing tables in this document:
> >
> >www.*onfi*.org/~/media/*ONFI*/specs/*onfi*_3_1_spec.pdf? (chapter 4.16).
> >
> >I suppose my nand_timings struct should use the names described
> >page 110-111 (at least if we decide to use nand_timings and not
> >nand_timing_modes), right ?

Yah, I think follow the standard. The standard has timing diagrams
that show what all these parameters actually are.

> After taking a closer look at this document, the only parameter
> available in my nand_timings struct that is not defined in the
> standard is tR_max (data transfer from cell to register).

Maybe it can be derived from the other parameters? The ONFI values
seemed pretty comprehensive to me.

I think the mvebu driver was similar, not all of the ONFI values were
used and some translation was needed.

Jason
