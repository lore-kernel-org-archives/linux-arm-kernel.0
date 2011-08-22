From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Aug 2011 09:11:57 +0200
Subject: [PATCH v4] amba: consolidate PrimeCell magic
In-Reply-To: <001d01cc6085$cd836900$688a3b00$%kim@samsung.com>
References: <1313649828-27642-1-git-send-email-boojin.kim@samsung.com>
	<000601cc5e30$3a38bda0$aeaa38e0$%kim@samsung.com>
	<001c01cc6082$123cef20$36b6cd60$%kim@samsung.com>
	<001d01cc6085$cd836900$688a3b00$%kim@samsung.com>
Message-ID: <CACRpkdat3-CRbMBsis=fTGcu61zhVvfXMqG_S_CRjBwCo2vTsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 6:41 AM, Boojin Kim <boojin.kim@samsung.com> wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>

>> Since two drivers use the PrimeCell scheme without using the
>> amba_bus driver logic, let's break the magic lookups out as
>> static inlines in the <linux/amba/bus.h> header so we get
>> some consolidation anyway. Delete the primecell ID check in
>> common/pl330.c since it is only used from the amba_bus driver
>> in drivers/dma, which is already doing the same check when
>> probing in drivers/amba/bus.c.
>
> I think PCELL_SIZE definition is missed.
> V1 had the definition of 'PCELL_SIZE' as following. But, it was gone from
> V2.
> +/* Used as end offset to retrieve PrimeCell ID registers */
> +#define PCELL_SIZE ? ? 0x1000

I must have slipped something :-(

I fixed it by simply switching PCELL_SIZE to SZ_4K in the patch
like this:
-       pi->pcfg.periph_id = get_id(pi, PERIPH_ID);
-       pi->pcfg.pcell_id = get_id(pi, PCELL_ID);
+       pi->pcfg.periph_id = amba_get_pid(pi->base, SZ_4K);
+       pi->pcfg.pcell_id = amba_get_cid(pi->base, SZ_4K);

Which defconfig shall I use to regressiontest this actually?
I was trying to locate one but failed.

I'll update the patch in the patch tracker too.

Yours,
Linus Walleij
