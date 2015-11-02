From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 2 Nov 2015 17:06:08 +0000
Subject: [PATCH v5 2/3] mtd: brcmnand: Force 8bit mode before doing
 nand_scan_ident()
In-Reply-To: <20151030194744.GJ13239@google.com>
References: <1446188361-15146-1-git-send-email-anup.patel@broadcom.com>
 <1446188361-15146-3-git-send-email-anup.patel@broadcom.com>
 <20151030194744.GJ13239@google.com>
Message-ID: <39063E8F96E11742B35A201CC5D095B7B063F0@SJEXCHMB10.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Brian Norris [mailto:computersforpeace at gmail.com]
> Sent: 31 October 2015 01:18
> To: Anup Patel
> Cc: David Woodhouse; Linux MTD; Rob Herring; Pawel Moll; Mark Rutland;
> Catalin Marinas; Will Deacon; Sudeep Holla; Ian Campbell; Kumar Gala; Ray Jui;
> Scott Branden; Florian Fainelli; Pramod Kumar; Vikram Prakash; Sandeep
> Tripathy; Linux ARM Kernel; Device Tree; Linux Kernel; bcm-kernel-feedback-list
> Subject: Re: [PATCH v5 2/3] mtd: brcmnand: Force 8bit mode before doing
> nand_scan_ident()
> 
> On Fri, Oct 30, 2015 at 12:29:20PM +0530, Anup Patel wrote:
> > Just like other NAND controllers,
> 
> ^^ That part isn't strictly true. While READ ID data only comes out on the lower 8
> bits, that doesn't *actually* mean you can't get valid data from a 16-bit bus in
> general; you just have to drop the upper 8 bits. That's what these two commits
> did for read ID and parameter page read commands:
> 
> commit 3dad2344e92c6e1aeae42df1c4824f307c51bcc7
> Author: Brian Norris <computersforpeace@gmail.com>
> Date:   Wed Jan 29 14:08:12 2014 -0800
> 
>     mtd: nand: force NAND_CMD_READID onto 8-bit bus
> 
> commit bd9c6e99b58255b9de1982711ac9487c9a2f18be
> Author: Brian Norris <computersforpeace@gmail.com>
> Date:   Fri Nov 29 22:04:28 2013 -0800
> 
>     mtd: nand: don't use read_buf for 8-bit ONFI transfers
> 
> > the NAND READID command only works
> > in 8bit mode for all versions of BRCMNAND controller.
> 
> But I presume *this* statement is actually true. This NAND controller doesn't
> exactly give us a fully-flexible READID / read_byte / read_word command, as it
> works at a higher level than that (although LOW_LEVEL_OP gives us this
> flexibility now). I could imagine (though I never tested 16-bit NAND) that 16-bit
> READID is broken.
> 
> BTW, did you ask the HW designer about this? It'd be nice to be 100% sure.

Yes, we had a discussed with HW designers and they confirmed
that READID command will only work in 8bit mode.

Regards,
Anup
