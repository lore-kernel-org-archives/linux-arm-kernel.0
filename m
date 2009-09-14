From: pierre@ossman.eu (Pierre Ossman)
Date: Mon, 14 Sep 2009 21:51:40 +0200
Subject: EXT_CSD  Register : CSD_STRUCTURE vs CSD_CSD_REV
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333@dbde02.ent.ti.com>
Message-ID: <20090914215140.7efe4671@mjolnir.ossman.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Sep 2009 20:34:35 +0530
"Ghorai, Sukumar" <s-ghorai@ti.com> wrote:

> Hello,
> 
> I am working in Linux MMC driver.
> Recently I came across one 16GB MMC card where EXT_CSD Register having EXT_CSD_REV[192] field as ZERO, which is valid according to Specification. But card is not working due to following reason -
> 
>  1.  As we know there are two fields in Extended CSD Register -  CSD_STRUCTURE Version[194] & EXT_CSD_REV Revision [192].
> 
> 
>  1.  In mmc.c/ mmc_read_ext_csd ()
>     *   Implementation expecting EXT_CSD_REV non zero (e.g. >3 in current code)
>     *   I think it could be checking for CSD_STRUCTURE version.
>     *   Because EXT_CSD_REV having Zero is the valid Field.
>     *   This is the way it's done in other OS too.

The opposite, it expects the version to be below 3 as those are the
only ones it knows about. Checking the CSD version for the EXT_CSD
would just be silly.

> 
> 
>  1.  To check the high capacity card.
>     *   We could check in access mode from OCR.  This is not in Linux exactly and steps to check the EXT_CSD_REV.
>     *   This is done in some other OS too.
> 

Checking the OCR is insufficient if I remember the spec correctly, so
we ignore it completely. The EXT_CSD needs to be correct for high
capacity to work anyway.

> So do you think we can update the code to check the CSD_STRUCTURE Version? Please let us know your opinion.

No, as that would violate the spec and possibly misinterpret some cards
as high-capacity.

To handle your card you would have to build some kind of quirks system
so that the kernel can identify that this card is buggy and compensate
for it.

Rgds
-- 
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090914/ff3cf783/attachment.sig>
