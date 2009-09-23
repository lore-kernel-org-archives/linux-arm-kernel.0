From: pierre@ossman.eu (Pierre Ossman)
Date: Wed, 23 Sep 2009 08:06:52 +0200
Subject: [PATCH  RFC] MMC card of Size > 4GB support in Linu
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B02F64D8199@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B02F64D8199@dbde02.ent.ti.com>
Message-ID: <20090923080652.0fffadad@mjolnir.ossman.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 19 Sep 2009 17:52:23 +0530
"Ghorai, Sukumar" <s-ghorai@ti.com> wrote:

> 
> IV). And what I understood from MMCA specification is that - 
> EXT_CSD[EXT_CSD_REV]: Defines the fixed parameters and related to the EXT_CSD register, according to its revision. And it's nothing to do with MMCA specification version or to support > 4GB card.
> 
> V). But in current Linux MMC code it's expecting EXT_CSD_REV should be >=2; 
> And if any card of size >= 4GB and EXT_CSD_REV field value is <2, 
> And MMC card won't work.
> 
> I have seen cards which having EXT_CSD_REV is <2 and working in other OS.
> So, Here I am sending the possible solution. `
> 

We've been over this already. Your card is broken. Making the stack
misbehave for not only your card, but every card, is not a good
solution.

The SEC_COUNT field wasn't added until MMC v4.2, and they changed the
EXT_CSD_REV to 1.2 to indicate this new format. You're suggesting that
we ignore the revision field and just read undefined bits, hoping that
they are meaningful. Nobody can consider that a reliable system.

> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 14b81f3..c4e97a9 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -252,6 +252,7 @@ struct _mmc_csd {
>  #define EXT_CSD_BUS_WIDTH      183     /* R/W */
>  #define EXT_CSD_HS_TIMING      185     /* R/W */
>  #define EXT_CSD_CARD_TYPE      196     /* RO */
> +#define EXT_CSD_STRUCT_REV 194     /* RO */
>  #define EXT_CSD_REV            192     /* RO */
>  #define EXT_CSD_SEC_CNT                212     /* RO, 4 bytes */
> 

And this is just even more wrong. You're telling the stack to check the
revision of the CSD, a completely different structure, for what fields
are valid in the EXT_CSD.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090923/d838e051/attachment-0001.sig>
