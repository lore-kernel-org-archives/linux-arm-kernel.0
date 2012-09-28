From: hdk@igel.co.jp (Hideki EIRAKU)
Date: Fri, 28 Sep 2012 13:29:11 +0900 (JST)
Subject: [PATCH v3 1/2] iommu/shmobile: Add iommu driver for Renesas
 IPMMU modules
In-Reply-To: <CABMQnVKiZyKMy_T7iAArc48zKnwzHpEUZY9+iqTRzCf9v9tJ0g@mail.gmail.com>
References: <1347343814-32299-1-git-send-email-hdk@igel.co.jp>
 <1347343814-32299-2-git-send-email-hdk@igel.co.jp>
 <CABMQnVKiZyKMy_T7iAArc48zKnwzHpEUZY9+iqTRzCf9v9tJ0g@mail.gmail.com>
Message-ID: <20120928.132911.321770401.hdk@igel.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: Re: [PATCH v3 1/2] iommu/shmobile: Add iommu driver for Renesas IPMMU modules
Date: Wed, 12 Sep 2012 17:07:00 +0900

>> +static inline void ipmmu_add_device(struct device *dev)
>> +{
>> +}
> 
> Please use 'do { } while (0)'.

Do you mean using #define macro is better than this inline function?
I chose the inline function because:

- The function's argument type is checked by a compiler.
- Its output code should be exactly the same as a macro in this case.
- The Linux kernel coding style says "Generally, inline functions are
  preferable to macros resembling functions."

>> +       switch (size) {
>> +       default:
>> +               priv->tlb_enabled = 0;
>> +               break;
>> +       case 0x2000:
>> +               ipmmu_reg_write(priv, IMTTBCR, 1);
>> +               priv->tlb_enabled = 1;
>> +               break;
>> +       case 0x1000:
>> +               ipmmu_reg_write(priv, IMTTBCR, 2);
>> +               priv->tlb_enabled = 1;
>> +               break;
>> +       case 0x800:
>> +               ipmmu_reg_write(priv, IMTTBCR, 3);
>> +               priv->tlb_enabled = 1;
>> +               break;
>> +       case 0x400:
>> +               ipmmu_reg_write(priv, IMTTBCR, 4);
>> +               priv->tlb_enabled = 1;
>> +               break;
>> +       case 0x200:
>> +               ipmmu_reg_write(priv, IMTTBCR, 5);
>> +               priv->tlb_enabled = 1;
>> +               break;
>> +       case 0x100:
>> +               ipmmu_reg_write(priv, IMTTBCR, 6);
>> +               priv->tlb_enabled = 1;
>> +               break;
>> +       case 0x80:
>> +               ipmmu_reg_write(priv, IMTTBCR, 7);
>> +               priv->tlb_enabled = 1;
>> +               break;
>> +       }
> 
> I thought that you could describe more briefly if ffs() is used.

This is simply converted from a hardware manual.  ffs() can be used
like below:

	bit = ffs(size);
	if (bit >= 7 && bit <= 13 && (1 << bit) == size) {
		ipmmu_reg_write(priv, IMTTBCR, 14 - bit);
		priv->tlb_enabled = 1;
	} else {
		priv->tlb_enabled = 0;
	}

Checking size is still needed because only 7 sizes are allowed here.
I think using switch() is easier to understand.

>> +#ifdef CONFIG_SHMOBILE_IOMMU_L1SIZE_8192
>> +#define L1_SIZE 8192
>> +#endif
>> +#ifdef CONFIG_SHMOBILE_IOMMU_L1SIZE_4096
>> +#define L1_SIZE 4096
>> +#endif
>> +#ifdef CONFIG_SHMOBILE_IOMMU_L1SIZE_2048
>> +#define L1_SIZE 2048
>> +#endif
>> +#ifdef CONFIG_SHMOBILE_IOMMU_L1SIZE_1024
>> +#define L1_SIZE 1024
>> +#endif
>> +#ifdef CONFIG_SHMOBILE_IOMMU_L1SIZE_512
>> +#define L1_SIZE 512
>> +#endif
>> +#ifdef CONFIG_SHMOBILE_IOMMU_L1SIZE_256
>> +#define L1_SIZE 256
>> +#endif
>> +#ifdef CONFIG_SHMOBILE_IOMMU_L1SIZE_128
>> +#define L1_SIZE 128
>> +#endif
> 
> I think that it was better to define by kconfig.
> For example, following codes.
> 
> +config SHMOBILE_IOMMU_L1SIZE
> +       hex
> +       default "0x00002000" if SHMOBILE_IOMMU_L1SIZE_8192
> +       default "0x00001000" if SHMOBILE_IOMMU_L1SIZE_4096
> +       default "0x00000800" if SHMOBILE_IOMMU_L1SIZE_2048
> +       default "0x00000400" if SHMOBILE_IOMMU_L1SIZE_1024
> +       default "0x00000200" if SHMOBILE_IOMMU_L1SIZE_512
> +       default "0x00000100" if SHMOBILE_IOMMU_L1SIZE_256
> +       default "0x00000080" if SHMOBILE_IOMMU_L1SIZE_128

I did not know that way.  It looks good for me too.
Thank you.

-- 
Hideki EIRAKU <hdk@igel.co.jp>
