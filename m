From: sakoman@gmail.com (Steve Sakoman)
Date: Tue, 29 Dec 2009 12:38:48 -0800
Subject: Issue in oamp nand driver with 32-bit reads in prefetch mode
In-Reply-To: <20091223174429.GD3512@atomide.com>
References: <ce9ab5790912230133wae2c4dcw73051221b66cb40f@mail.gmail.com>
	<20091223174429.GD3512@atomide.com>
Message-ID: <5e088bd90912291238t1f2aba64na94887b2f864454d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2009 at 9:44 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Vimal Singh <vimal.newwork@gmail.com> [091223 01:32]:
>> In omap nand driver we used to do 32-bit reads (in function
>> omap_read_buf_pref, using 'ioread32_rep' i.e.: __raw_readsl), and it
>> was working fine till some time back. But now, somehow, this has got
>> some problem. Reads are not being done successfully, and driver gives
>> lots for error reprot like below:
>>
>> td->read(0x604 bytes from 0x1fc) returned ECC error
>> uncorrectable error :
>> uncorrectable error :
>> uncorrectable error :
>> uncorrectable error :
>> uncorrectable error :
>> uncorrectable error :
>> mtd->read(0x520 bytes from 0x2e0) returned ECC error
>>
>> While if we change 32-bit reads to 16-bit reads (using 'ioread16_rep'
>> i.e.: __raw_readwl) makes it working fine. (A patch to do this is
>> listed below at the bottom of this mail.)
>>
>> I have not seen any change in routine '__raw_readsl'.
>> So, could someone help me find out the root cause the issue?
>>
>> Thanks for any input.
>
> Maybe an issue with the GPMC timings?

I can confirm that this issue exists on Overo too.  Sadly, switching
to 16 bit reads does not fix the issue for me.  I'll start digging to
see if I can find what's broken.

Steve


> Regards,
>
> Tony
>
>>
>> --
>> Regards,
>> Vimal Singh
>>
>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>> index aaef170..dc493f5 100644
>> --- a/drivers/mtd/nand/omap2.c
>> +++ b/drivers/mtd/nand/omap2.c
>> @@ -288,14 +288,14 @@ static void omap_read_buf_pref(struct mtd_info
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct omap_nand_info, mtd);
>> ? ? ? uint32_t pfpw_status = 0, r_count = 0;
>> ? ? ? int ret = 0;
>> - ? ? u32 *p = (u32 *)buf;
>> + ? ? u16 *p = (u16 *)buf;
>>
>> ? ? ? /* take care of subpage reads */
>> - ? ? for (; len % 4 != 0; ) {
>> + ? ? for (; len % 2 != 0; ) {
>> ? ? ? ? ? ? ? *buf++ = __raw_readb(info->nand.IO_ADDR_R);
>> ? ? ? ? ? ? ? len--;
>> ? ? ? }
>> - ? ? p = (u32 *) buf;
>> + ? ? p = (u16 *) buf;
>>
>> ? ? ? /* configure and start prefetch transfer */
>> ? ? ? ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);
>> @@ -308,10 +308,10 @@ static void omap_read_buf_pref(struct mtd_info
>> *mtd, u_char *buf, int len)
>> ? ? ? } else {
>> ? ? ? ? ? ? ? do {
>> ? ? ? ? ? ? ? ? ? ? ? pfpw_status = gpmc_prefetch_status();
>> - ? ? ? ? ? ? ? ? ? ? r_count = ((pfpw_status >> 24) & 0x7F) >> 2;
>> - ? ? ? ? ? ? ? ? ? ? ioread32_rep(info->nand_pref_fifo_add, p, r_count);
>> + ? ? ? ? ? ? ? ? ? ? r_count = ((pfpw_status >> 24) & 0x7F) >> 1;
>> + ? ? ? ? ? ? ? ? ? ? ioread16_rep(info->nand_pref_fifo_add, p, r_count);
>> ? ? ? ? ? ? ? ? ? ? ? p += r_count;
>> - ? ? ? ? ? ? ? ? ? ? len -= r_count << 2;
>> + ? ? ? ? ? ? ? ? ? ? len -= r_count << 1;
>> ? ? ? ? ? ? ? } while (len);
>>
>> ? ? ? ? ? ? ? /* disable and stop the PFPW engine */
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
