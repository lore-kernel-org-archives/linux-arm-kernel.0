From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 18 Apr 2016 17:10:36 +0200
Subject: [PATCH RESEND] gpmi-nand: Handle ECC Errors in erased pages
In-Reply-To: <20160418144720.GA2674@lws-christ>
References: <1456059126-25469-1-git-send-email-mpa@pengutronix.de>
 <7168760.YSQBa3GsdA@adelgunde> <20160415103508.5f6bc8c8@bbrezillon>
 <33206452.D8BR53ndXi@adelgunde>
 <20160415113906.7f971cec@bbrezillon>
 <20160418144720.GA2674@lws-christ>
Message-ID: <20160418171036.77615004@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Apr 2016 16:47:20 +0200
Stefan Christ <s.christ@phytec.de> wrote:

> Hi Boris,
> 
> On Fri, Apr 15, 2016 at 11:39:06AM +0200, Boris Brezillon wrote:
> > Hi Markus,
> > 
> > On Fri, 15 Apr 2016 11:35:07 +0200
> > Markus Pargmann <mpa@pengutronix.de> wrote:
> > 
> > > Hi Boris,
> > > 
> > > On Friday 15 April 2016 10:35:08 Boris Brezillon wrote:
> > > > Hi Markus,
> > > > 
> > > > On Fri, 15 Apr 2016 09:55:45 +0200
> > > > Markus Pargmann <mpa@pengutronix.de> wrote:
> > > > 
> > > > > On Wednesday 13 April 2016 00:51:55 Boris Brezillon wrote:
> > > > > > On Tue, 12 Apr 2016 22:39:08 +0000
> > > > > > Han Xu <han.xu@nxp.com> wrote:
> > > > > > 
> > > > > > > > Thanks for the feedback. Talking with a coworker about this we may have found a
> > > > > > > > better approach to this that is less complicated to implement. The hardware
> > > > > > > > unit allows us to set a bitflip threshold for erased pages. The ECC unit
> > > > > > > > creates an ECC error only if the number of bitflips exceeds this threshold, but
> > > > > > > > it does not correct these. So the idea is to change the patch so that we set
> > > > > > > > pages, that are signaled by the ECC as erased, to 0xff completely without
> > > > > > > > checking. So the ECC will do all the work and we completely trust in its
> > > > > > > > abilities to do it correctly.
> > > > > > > 
> > > > > > > Sounds good.
> > > > > > > 
> > > > > > > some new platforms with new gpmi controller could check the count of 0 bits in page,
> > > > > > > refer to my patch https://patchwork.ozlabs.org/patch/587124/
> > > > > > > 
> > > > > > > But for all legacy platforms, IMO, considering bitflip is rare case, set threshold to 0 and
> > > > > > > only check the uncorrectable branch and then correct data sounds better. Setting threshold
> > > > > > > and correcting all erased page may highly impact the performance.
> > > > > > 
> > > > > > Indeed, bitflips in erased pages is not so common, and penalizing the
> > > > > > likely case (erased pages without any bitflips) doesn't look like a good
> > > > > > idea in the end.
> > > > > 
> > > > > Are erased pages really read that often?
> > > > 
> > > > Yes, it's not unusual to have those "empty pages?" checks (added Artem
> > > > and Richard to get a confirmation). AFAIR, UBIFS check for empty pages
> > > > in its journal heads after an unclean unmount (which happens quite
> > > > often) to make sure there's no corruption.
> > > > 
> > > > > I am not sure how UBI handles
> > > > > this, does it read every page before writing?
> > > > 
> > > > Nope, or maybe it does when you activate some extra checks.
> > > > 
> > > > > 
> > > > > > 
> > > > > > You can still implement this check in software. You can have a look at
> > > > > > nand_check_erased_ecc_chunk() [1] if you need an example, but you'll
> > > > > > have to adapt it because your controller does not guarantees that ECC
> > > > > > bits for a given chunk are byte aligned :-/
> > > > > 
> > > > > Yes I used this function in the patch. The issue is that I am not quite
> > > > > sure yet where to find the raw ECC data (without rereading the page).
> > > > > The reference manual is not extremely clear about that, ecc data may be
> > > > > in the 'auxilliary data' but I am not sure that it really is available
> > > > > somewhere.
> > > > 
> > > > AFAIR (and I'm not sure since it was a long time ago), you don't have
> > > > direct access to ECC bytes with the GPMI engine. If that's the case,
> > > > you'll have to read the ECC bytes manually (moving the page pointer
> > > > using ->cmdfunc(NAND_CMD_RNDOUT, column, -1)), which is a pain with
> > > > this engine, because ECC bytes are not guaranteed to be byte aligned
> > > > (see gpmi ->read_page_raw() implementation).
> > > > Once you've retrieved ECC bytes (or bits in this case), for each ECC
> > > > chunk, you can use the nand_check_erased_ecc_chunk() function (just make
> > > > sure you're padding the last ECC byte of each chunk with ones so that
> > > > bitflips cannot be reported on this section).
> > > 
> > > Thanks for the information. So I understand that this approach is the
> > > preferred one to avoid any performance issues for normal operation.
> > > 
> > > I actually won't be able to fix this patch accordingly for some time. If
> > > anyone else needs this earlier, feel free to implement it.
> > 
> > I just did [1] (it applies on top of your patch), but maybe you
> > can test it (I don't have any imx platforms right now) ;).
> > 
> > If these changes work, feel free to squash them into your previous
> > patch.
> 
> I've tested your diff onto Markus Pargmann's patch. It looks promising.
> 
> However I've noticed that the calculation of the ECC parity bits position is
> wrong.  It doesn't consider the extra metadata bytes at the beginning of the
> raw page and that the ECC parity bits are at the end of the ECC chunk.

Oh, you're right. Thanks for fixing that.

> My test
> platform is the i.MX6 with two NAND flashes
> 
>     nand: Samsung NAND 1GiB 3,3V 8-bit
>     nand: 1024 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
>     (-> 104 Bits ECC )
> 
> and
>  
>     nand: AMD/Spansion S34ML08G2
>     nand: 1024 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 128
>     (-> 234 Bits ECC )
> 
> I've also tested the bit alignment code. It works correctly for the Spansion
> NAND, as the 234 Bits of ECC are 29.25 Bytes on the NAND flash. So there the
> parity bits are not byte aligned.

And thanks for testing.

Markus, if you resubmit your patch, please take Stefan's changes.

> 
> Mit freundlichen Gr??en / Kind regards,
>         Stefan Christ
> 
> The corrected ECC parity bit code is:
> 
> ---->8----
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> index 2f16d7f..ccae6e6 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> @@ -1054,7 +1054,9 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
>  			int flips;
>  
>  			/* Read ECC bytes into our internal raw_buffer */
> -			offset = ((8 * nfc_geo->ecc_chunk_size) + eccbits) * i;
> +			offset = nfc_geo->metadata_size * 8;
> +			offset += ((8 * nfc_geo->ecc_chunk_size) + eccbits) * (i + 1);
> +			offset -= eccbits;
>  			bitoffset = offset % 8;
>  			eccbytes = DIV_ROUND_UP(offset + eccbits, 8);
>  			offset /= 8;



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
