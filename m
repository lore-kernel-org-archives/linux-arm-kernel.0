From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 15 Apr 2016 14:03:45 +0200
Subject: [PATCH RESEND] gpmi-nand: Handle ECC Errors in erased pages
In-Reply-To: <20160415113906.7f971cec@bbrezillon>
References: <1456059126-25469-1-git-send-email-mpa@pengutronix.de>
 <33206452.D8BR53ndXi@adelgunde> <20160415113906.7f971cec@bbrezillon>
Message-ID: <1733015.oJ2G1KSZLY@adelgunde>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Friday 15 April 2016 11:39:06 Boris Brezillon wrote:
> Hi Markus,
> 
> On Fri, 15 Apr 2016 11:35:07 +0200
> Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > Hi Boris,
> > 
> > On Friday 15 April 2016 10:35:08 Boris Brezillon wrote:
> > > Hi Markus,
> > > 
> > > On Fri, 15 Apr 2016 09:55:45 +0200
> > > Markus Pargmann <mpa@pengutronix.de> wrote:
> > > 
> > > > On Wednesday 13 April 2016 00:51:55 Boris Brezillon wrote:
> > > > > On Tue, 12 Apr 2016 22:39:08 +0000
> > > > > Han Xu <han.xu@nxp.com> wrote:
> > > > > 
> > > > > > > Thanks for the feedback. Talking with a coworker about this we may have found a
> > > > > > > better approach to this that is less complicated to implement. The hardware
> > > > > > > unit allows us to set a bitflip threshold for erased pages. The ECC unit
> > > > > > > creates an ECC error only if the number of bitflips exceeds this threshold, but
> > > > > > > it does not correct these. So the idea is to change the patch so that we set
> > > > > > > pages, that are signaled by the ECC as erased, to 0xff completely without
> > > > > > > checking. So the ECC will do all the work and we completely trust in its
> > > > > > > abilities to do it correctly.
> > > > > > 
> > > > > > Sounds good.
> > > > > > 
> > > > > > some new platforms with new gpmi controller could check the count of 0 bits in page,
> > > > > > refer to my patch https://patchwork.ozlabs.org/patch/587124/
> > > > > > 
> > > > > > But for all legacy platforms, IMO, considering bitflip is rare case, set threshold to 0 and
> > > > > > only check the uncorrectable branch and then correct data sounds better. Setting threshold
> > > > > > and correcting all erased page may highly impact the performance.
> > > > > 
> > > > > Indeed, bitflips in erased pages is not so common, and penalizing the
> > > > > likely case (erased pages without any bitflips) doesn't look like a good
> > > > > idea in the end.
> > > > 
> > > > Are erased pages really read that often?
> > > 
> > > Yes, it's not unusual to have those "empty pages?" checks (added Artem
> > > and Richard to get a confirmation). AFAIR, UBIFS check for empty pages
> > > in its journal heads after an unclean unmount (which happens quite
> > > often) to make sure there's no corruption.
> > > 
> > > > I am not sure how UBI handles
> > > > this, does it read every page before writing?
> > > 
> > > Nope, or maybe it does when you activate some extra checks.
> > > 
> > > > 
> > > > > 
> > > > > You can still implement this check in software. You can have a look at
> > > > > nand_check_erased_ecc_chunk() [1] if you need an example, but you'll
> > > > > have to adapt it because your controller does not guarantees that ECC
> > > > > bits for a given chunk are byte aligned :-/
> > > > 
> > > > Yes I used this function in the patch. The issue is that I am not quite
> > > > sure yet where to find the raw ECC data (without rereading the page).
> > > > The reference manual is not extremely clear about that, ecc data may be
> > > > in the 'auxilliary data' but I am not sure that it really is available
> > > > somewhere.
> > > 
> > > AFAIR (and I'm not sure since it was a long time ago), you don't have
> > > direct access to ECC bytes with the GPMI engine. If that's the case,
> > > you'll have to read the ECC bytes manually (moving the page pointer
> > > using ->cmdfunc(NAND_CMD_RNDOUT, column, -1)), which is a pain with
> > > this engine, because ECC bytes are not guaranteed to be byte aligned
> > > (see gpmi ->read_page_raw() implementation).
> > > Once you've retrieved ECC bytes (or bits in this case), for each ECC
> > > chunk, you can use the nand_check_erased_ecc_chunk() function (just make
> > > sure you're padding the last ECC byte of each chunk with ones so that
> > > bitflips cannot be reported on this section).
> > 
> > Thanks for the information. So I understand that this approach is the
> > preferred one to avoid any performance issues for normal operation.
> > 
> > I actually won't be able to fix this patch accordingly for some time. If
> > anyone else needs this earlier, feel free to implement it.
> 
> I just did [1] (it applies on top of your patch), but maybe you
> can test it (I don't have any imx platforms right now) ;).

Great, thank you :). I just tested the patch and it works for me. The
erased page bitflips are still detected and fixed. I will send a new
version then.

Best Regards,

Markus

> 
> If these changes work, feel free to squash them into your previous
> patch.
> 
> Thanks,
> 
> Boris
> 
> [1]http://code.bulix.org/bq6yyh-96549
> 
> 

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160415/1f739a1b/attachment.sig>
