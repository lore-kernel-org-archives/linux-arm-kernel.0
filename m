From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 6 Sep 2010 19:26:19 +0800
Subject: [PATCH] pxa168fb: fix clear operation
In-Reply-To: <AANLkTimqMGC=sRM0uzK61ceUdZd=DdvSi4Vi-W=ybgN7@mail.gmail.com>
References: <1283128337-4605-1-git-send-email-haojian.zhuang@marvell.com>
	<1283128337-4605-2-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTimqMGC=sRM0uzK61ceUdZd=DdvSi4Vi-W=ybgN7@mail.gmail.com>
Message-ID: <AANLkTi=6gEbWcG5Dq4SZsfdpDCEmxPZzkvonPqc1TcH8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 5, 2010 at 7:56 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Mon, Aug 30, 2010 at 8:32 AM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> While fb isn't active, we should clear CFG_GRA_ENA bit. The existing code
>> can't clear this bit.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>> ?drivers/video/pxa168fb.c | ? ?4 ++--
>> ?1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
>> index ec2ddb2..3f112c9 100644
>> --- a/drivers/video/pxa168fb.c
>> +++ b/drivers/video/pxa168fb.c
>> @@ -298,8 +298,8 @@ static void set_dma_control0(struct pxa168fb_info *fbi)
>> ? ? ? ? * Set bit to enable graphics DMA.
>> ? ? ? ? */
>> ? ? ? ?x = readl(fbi->reg_base + LCD_SPU_DMA_CTRL0);
>> - ? ? ? x |= fbi->active ? 0x00000100 : 0;
>> - ? ? ? fbi->active = 0;
>> + ? ? ? x &= ~CFG_GRA_ENA_MASK;
>> + ? ? ? x |= CFG_GRA_ENA(!!fbi->active);
>
> This isn't very readable. And since CFG_GRA_ENA is actually a 1-bit
> field, I'd recommend to change it to something like below:
>
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index 5d786bd..59fa751 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -298,8 +298,11 @@ static void set_dma_control0(struct pxa168fb_info *fbi)
> ? ? ? ? * Set bit to enable graphics DMA.
> ? ? ? ? */
> ? ? ? ?x = readl(fbi->reg_base + LCD_SPU_DMA_CTRL0);
> - ? ? ? x |= fbi->active ? 0x00000100 : 0;
> - ? ? ? fbi->active = 0;
> +
> + ? ? ? if (fbi->active)
> + ? ? ? ? ? ? ? x &= ~CFG_GRA_ENA;
> + ? ? ? else
> + ? ? ? ? ? ? ? x |= CFG_GRA_ENA;
>
> ? ? ? ?/*
> ? ? ? ? * If we are in a pseudo-color mode, we need to enable
> diff --git a/drivers/video/pxa168fb.h b/drivers/video/pxa168fb.h
> index eee0927..e5c34a5 100644
> --- a/drivers/video/pxa168fb.h
> +++ b/drivers/video/pxa168fb.h
> @@ -240,8 +240,7 @@
> ?#define ? ? CFG_GRA_SWAPYU_MASK ? ? ? ? ? ? ? ? ? ? ? ?0x00000400
> ?#define ? ? CFG_YUV2RGB_GRA(cvrt) ? ? ? ? ? ? ?((cvrt) << 9)
> ?#define ? ? CFG_YUV2RGB_GRA_MASK ? ? ? ? ? ? ? 0x00000200
> -#define ? ? CFG_GRA_ENA(gra) ? ? ? ? ? ? ? ? ? ((gra) << 8)
> -#define ? ? CFG_GRA_ENA_MASK ? ? ? ? ? ? ? ? ? 0x00000100
> +#define ? ? CFG_GRA_ENA ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?0x10000100
> ?/* for video part */
> ?#define ? ? CFG_DMA_FTOGGLE(toggle) ? ? ? ? ? ?((toggle) << 7)
> ?#define ? ? CFG_DMA_FTOGGLE_MASK ? ? ? ? ? ? ? 0x00000080
>>
>> ? ? ? ?/*
>> ? ? ? ? * If we are in a pseudo-color mode, we need to enable
>> --
>> 1.5.6.5
>>
>>
>

I'm OK. Should I submit this patch again?

Thanks
Haojian
