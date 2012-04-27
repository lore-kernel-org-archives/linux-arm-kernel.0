From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 27 Apr 2012 11:30:00 +0200
Subject: [RESEND PATCH 1/2] ARM: OMAP2+: nand: Make board_onenand_init()
 visible to board code
In-Reply-To: <CAFqH_52aiDvR_xHY6TUN7igMiq6EqB-Nx9D=sPMCUeUaKLiuQg@mail.gmail.com>
References: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
 <CAFqH_52aiDvR_xHY6TUN7igMiq6EqB-Nx9D=sPMCUeUaKLiuQg@mail.gmail.com>
Message-ID: <CABxcv=kXukrVYOzjrMGoWzi=GTefh8EsXnTwzcahsfLa1a6Kaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 9:59 AM, Enric Balletb? i Serra
<eballetbo@gmail.com> wrote:
> 2012/4/4 Javier Martinez Canillas <javier@dowhile0.org>:
>> board_onenand_init() and board_nand_init() initialization functions are
>> used to initialize OneNAND and NAND memories respectively. But only
>> board_nand_init() was visible to be used from board code. This patch makes
>> possible to initialize a OneNAND flash memory within platform code.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>> ---
>> ?arch/arm/mach-omap2/board-flash.c | ? ?4 ++--
>> ?arch/arm/mach-omap2/board-flash.h | ? 11 +++++++++++
>> ?2 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
>> index 0349fd2..70a81f9 100644
>> --- a/arch/arm/mach-omap2/board-flash.c
>> +++ b/arch/arm/mach-omap2/board-flash.c
>> @@ -87,7 +87,7 @@ static struct omap_onenand_platform_data board_onenand_data = {
>> ? ? ? ?.dma_channel ? ?= -1, ? /* disable DMA in OMAP OneNAND driver */
>> ?};
>>
>> -static void
>> +void
>> ?__init board_onenand_init(struct mtd_partition *onenand_parts,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?u8 nr_parts, u8 cs)
>> ?{
>> @@ -98,7 +98,7 @@ __init board_onenand_init(struct mtd_partition *onenand_parts,
>> ? ? ? ?gpmc_onenand_init(&board_onenand_data);
>> ?}
>> ?#else
>> -static void
>> +void
>> ?__init board_onenand_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
>> ?{
>> ?}
>> diff --git a/arch/arm/mach-omap2/board-flash.h b/arch/arm/mach-omap2/board-flash.h
>> index d25503a..c44b70d 100644
>> --- a/arch/arm/mach-omap2/board-flash.h
>> +++ b/arch/arm/mach-omap2/board-flash.h
>> @@ -47,3 +47,14 @@ static inline void board_nand_init(struct mtd_partition *nand_parts,
>> ?{
>> ?}
>> ?#endif
>> +
>> +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
>> + ? ? ? ? ? ? ? defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
>> +extern void board_onenand_init(struct mtd_partition *nand_parts,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? u8 nr_parts, u8 cs);
>> +#else
>> +static inline void board_onenand_init(struct mtd_partition *nand_parts,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? u8 nr_parts, u8 cs)
>> +{
>> +}
>> +#endif
>> --
>> 1.7.7.6
>>
>
> Seems good to me.
>
> Tony, as this is a fix ,may be included ?
>
> Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>
> Cheers,
> ? ?Enric

Hi Tony, Russel:

This patch is a requirement for patch:

[RESEND PATCH 2/2] OMAP3: igep0020: Add support for Micron NAND Flash
storage memory

which is really important since newer IGEPv2 boards have changed their
flash memory from OneNAND to NAND.

This patch-set is necessary to make the board work, otherwise it
doesn't even boot.

Could we please include these patches?

Thanks a lot and best regards,
Javier
