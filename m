From: sakoman@gmail.com (Steve Sakoman)
Date: Sat, 2 Jan 2010 07:02:36 -0800
Subject: Issue in oamp nand driver with 32-bit reads in prefetch mode
In-Reply-To: <ce9ab5790912310420h20beb04csba060b3f5cfeee92@mail.gmail.com>
References: <ce9ab5790912230133wae2c4dcw73051221b66cb40f@mail.gmail.com>
	<20091223174429.GD3512@atomide.com>
	<5e088bd90912291238t1f2aba64na94887b2f864454d@mail.gmail.com>
	<5e088bd90912291347j370ab30cid7c6cfc558c2ed18@mail.gmail.com>
	<ce9ab5790912310420h20beb04csba060b3f5cfeee92@mail.gmail.com>
Message-ID: <5e088bd91001020702q3021cea2ve5d71ffff7fc1c62@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 31, 2009 at 4:20 AM, Vimal Singh <vimal.newwork@gmail.com> wrote:
> On Wed, Dec 30, 2009 at 3:17 AM, Steve Sakoman <sakoman@gmail.com> wrote:
>> On Tue, Dec 29, 2009 at 12:38 PM, Steve Sakoman <sakoman@gmail.com> wrote:
>>
>>> I can confirm that this issue exists on Overo too. ?Sadly, switching
>>> to 16 bit reads does not fix the issue for me. ?I'll start digging to
>>> see if I can find what's broken.
>>
>> I can also confirm that there are days when I am not even capable of
>> applying a patch properly :-(
>>
>> Switching to 16 bit read accesses does indeed fix the ECC issue on Overo too.
>>
>> Which still leaves us needing to find the root cause of the breakage . . .
>
> There is a bug in nand prefetch read routine, which comes into effect
> only if nand device is a 16-bit device (as we have in zoom boards).
> This bug is effective only with below combination of conditions:
> 1. nand deivce, in use, is a 16 bit device
> 2. nand driver supports 'subpage' read
> 3. SW ECC is in use
>
> This was not seen old ?kernel (ex: .23), because when, in early days,
> we tested this (nand prefetch read in LDP boards) there was no
> 'subpage read' support.
> Later when we had subpage read in (.27) kernel, we had hw ecc enabled
> always in our internal tree. So, we missed this bug.
>
> Here is a patch to fix this issue:
>
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 1bb799f..75004fe 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -295,11 +295,14 @@ static void omap_read_buf_pref(struct
> ? ? ? ?u32 *p = (u32 *)buf;
>
> ? ? ? ?/* take care of subpage reads */
> - ? ? ? for (; len % 4 != 0; ) {
> - ? ? ? ? ? ? ? *buf++ = __raw_readb(info->nand.IO_ADDR_R);
> - ? ? ? ? ? ? ? len--;
> + ? ? ? if (len % 4) {
> + ? ? ? ? ? ? ? if (info->nand.options & NAND_BUSWIDTH_16)
> + ? ? ? ? ? ? ? ? ? ? ? omap_read_buf16(mtd, buf, len % 4);
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? omap_read_buf8(mtd, buf, len % 4);
> + ? ? ? ? ? ? ? p = (u32 *) (buf + len % 4);
> + ? ? ? ? ? ? ? len -= len % 4;
> ? ? ? ?}
> - ? ? ? p = (u32 *) buf;
>
> ? ? ? ?/* configure and start prefetch transfer */
> ? ? ? ?ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);

I tested this on Overo and can confirm that it fixes the issue.

Steve
