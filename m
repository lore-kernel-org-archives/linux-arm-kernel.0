From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 15 Apr 2016 09:55:45 +0200
Subject: [PATCH RESEND] gpmi-nand: Handle ECC Errors in erased pages
In-Reply-To: <20160413005155.03cb7bc6@bbrezillon>
References: <1456059126-25469-1-git-send-email-mpa@pengutronix.de>
 <DB5PR0401MB1845DD983AF9195311DEB20F97950@DB5PR0401MB1845.eurprd04.prod.outlook.com>
 <20160413005155.03cb7bc6@bbrezillon>
Message-ID: <7168760.YSQBa3GsdA@adelgunde>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 April 2016 00:51:55 Boris Brezillon wrote:
> On Tue, 12 Apr 2016 22:39:08 +0000
> Han Xu <han.xu@nxp.com> wrote:
> 
> > > Thanks for the feedback. Talking with a coworker about this we may have found a
> > > better approach to this that is less complicated to implement. The hardware
> > > unit allows us to set a bitflip threshold for erased pages. The ECC unit
> > > creates an ECC error only if the number of bitflips exceeds this threshold, but
> > > it does not correct these. So the idea is to change the patch so that we set
> > > pages, that are signaled by the ECC as erased, to 0xff completely without
> > > checking. So the ECC will do all the work and we completely trust in its
> > > abilities to do it correctly.
> > 
> > Sounds good.
> > 
> > some new platforms with new gpmi controller could check the count of 0 bits in page,
> > refer to my patch https://patchwork.ozlabs.org/patch/587124/
> > 
> > But for all legacy platforms, IMO, considering bitflip is rare case, set threshold to 0 and
> > only check the uncorrectable branch and then correct data sounds better. Setting threshold
> > and correcting all erased page may highly impact the performance.
> 
> Indeed, bitflips in erased pages is not so common, and penalizing the
> likely case (erased pages without any bitflips) doesn't look like a good
> idea in the end.

Are erased pages really read that often? I am not sure how UBI handles
this, does it read every page before writing?

> 
> You can still implement this check in software. You can have a look at
> nand_check_erased_ecc_chunk() [1] if you need an example, but you'll
> have to adapt it because your controller does not guarantees that ECC
> bits for a given chunk are byte aligned :-/

Yes I used this function in the patch. The issue is that I am not quite
sure yet where to find the raw ECC data (without rereading the page).
The reference manual is not extremely clear about that, ecc data may be
in the 'auxilliary data' but I am not sure that it really is available
somewhere.

Best Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160415/4a32d055/attachment.sig>
