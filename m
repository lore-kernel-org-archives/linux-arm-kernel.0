From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 8 Jan 2014 12:13:39 -0700
Subject: [RFC PATCH 3/9] of: mtd: add NAND timings retrieval support
In-Reply-To: <52CDA032.3010804@overkiz.com>
References: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
 <1389190924-26226-4-git-send-email-b.brezillon@overkiz.com>
 <20140108183418.GA12358@obsidianresearch.com>
 <52CDA032.3010804@overkiz.com>
Message-ID: <20140108191339.GB12358@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 08:00:02PM +0100, boris brezillon wrote:
> Hello Jason,
> 
> Le 08/01/2014 19:34, Jason Gunthorpe a ?crit :
> >On Wed, Jan 08, 2014 at 03:21:58PM +0100, Boris BREZILLON wrote:
> >
> >>+int of_get_nand_timings(struct device_node *np, struct nand_timings *timings)
> >>+{
> >>+	memset(timings, 0, sizeof(*timings));
> >>+	of_property_read_u32(np, "tCLS-min", &timings->tCLS_min);
> >>+	of_property_read_u32(np, "tCLH-min", &timings->tCLH_min);
> >>+	of_property_read_u32(np, "tCS-min", &timings->tCS_min);
> >[..]
> >
> >A while ago when discussing another controller it was pointed out
> >these values are all auto-probable directly from the NAND via a ONFI
> >defined GET FEATURE @0x01 query, and adding these timings to the DT
> >was NAK'd..
> >
> >Basically you set the interface to the slowest ONFI timing mode, do
> >the GET FEATURE to the NAND chip and then increase the interface speed
> >to the highest mutually supported ONFI mode.
> 
> >Is there some reason you need to encode this in the DT?
> 
> What if the NAND does not support the ONFI interface (and this is
> exactly the case for the NAND available on the cubietruck board:
> H27UCG8T2ATR).

Sounds like a good reason to me! 

You might want to check if you can boil down the DT timings from the
huge list to just an ONFI mode number..

I'd echo Rob's comments, the property needs to include the units
in the name, and I strongly recommend picoseconds for these
values.

Also, you might want to check that the ONFI names for these parameters
are used, not a vendor specific name to try and avoid confusion.

Jason
