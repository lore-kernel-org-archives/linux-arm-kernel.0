From: b42378@freescale.com (Nicolin Chen)
Date: Wed, 30 Oct 2013 17:32:18 +0800
Subject: [b42378@freescale.com: Re: [PATCH 1/3] dma: imx-sdma: Add ssi dual
 fifo script support]
Message-ID: <20131030093218.GF9605@MrMyself>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just found that I missed Sascha's mail address in my TO list of last reply.
So resend it. And sorry for the duplicated mails.

----- Forwarded message from Nicolin Chen <b42378@freescale.com> -----

Date: Wed, 30 Oct 2013 12:48:48 +0800
From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH 1/3] dma: imx-sdma: Add ssi dual fifo script support
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Sascha,

On Tue, Oct 29, 2013 at 02:51:43PM +0100, Sascha Hauer wrote:
> Look at drivers/dma/imx-sdma.c:
> 
> > /**
> >  * struct sdma_firmware_header - Layout of the firmware image
> >  *
> >  * @magic		"SDMA"
> >  * @version_major	increased whenever layout of struct
> >  * sdma_script_start_addrs
> >  *			changes.
> 
> Can you image why this firmware has a version field? Right, it's because
> it encodes the layout of struct sdma_script_start_addrs.
> 
> As the comment clearly states you have to *increase this field* when you
> add scripts.
> 
> Obviously you missed that, as the firmware on lkml posted recently
> shows:
> 
> > 00000000: 414d4453 00000001 00000001 0000001c SDMA............
>                      ^^^^^^^^
>                      Still '1'
> 
> > 00000010: 00000026 000000b4 0000067a 00000282 &.......z.......
> > 00000020: ffffffff 00000000 ffffffff ffffffff ................
> > 00000030: ffffffff ffffffff ffffffff ffffffff ................
> > 00000040: ffffffff ffffffff 00001a6a ffffffff ........j.......
> > 00000050: 000002eb 000018bb ffffffff 00000408 ................
> > 00000060: ffffffff 000003c0 ffffffff ffffffff ................
> > 00000070: ffffffff 000002ab ffffffff 0000037b ............{...
> > 00000080: ffffffff ffffffff 0000044c 0000046e ........L...n...
> > 00000090: ffffffff 00001800 ffffffff ffffffff ................
> > 000000a0: 00000000 00001800 00001862 00001a16 ........b.......
>                               ^^^^^^^^^^^^^^^^^
>                               new script addresses introduced
> 
> 
> > -#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
> > +#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	37
> 
> And no, this is not a bug. It's your firmware header that is buggy.
> 

I wasn't aware that the problem is far more complicated than I thought.
And thank you for telling me all this.

> What you need is:
> 
> #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2      37
> 
> You (you as a company, not you as a person) knew that it was me who
> created this firmware format. So it was absolutely unnecessary to create
> an incompatible firmware instead of dropping me a short note.
> 
> Please add a version check to the driver as necessary and provide a proper
> firmware.
> 

Just currently it's not easy for me to create a new proper firmware,
and I's been told that besides this version number, it also lacks a
decent license info. So may I just refine this patch as you suggested
to add a version check and add those new scripts first?

Thank you,
Nicolin Chen

> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 

----- End forwarded message -----
