From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Apr 2011 09:29:59 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <EDC1056430EF4DA8A0D850CE1DEA28FC@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-2-git-send-email-subhasish@mistralsolutions.com>
	<4DB1A603.2090208@pengutronix.de>
	<EDC1056430EF4DA8A0D850CE1DEA28FC@subhasishg>
Message-ID: <4DB7C5F7.3080103@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2011 08:39 AM, Subhasish Ghosh wrote:
> Hi Mark,

I'm Marc.

> - Is it ok to have u32 etc for __iomem cookie ?

no - "void __iomem *" is "void __iomem *"


>> +s32 pruss_disable(struct device *dev, u8 pruss_num)
> make it a int function
> 
> SG -- Ok will do
> 
>> +
>> +    /* Reset PRU */
>> +    iowrite32(PRUCORE_CONTROL_RESETVAL,
>> +                &h_pruss->control);
>> +    spin_unlock(&pruss->lock);
>> +
>> +    return 0;
> 
> make it a void function?
> 
> SG -- This should be int, in case of invalid pru num, we ret an error.

Yes - Sorry.

>> +}
>> +EXPORT_SYMBOL_GPL(pruss_disable);
>> +
>> +s32 pruss_enable(struct device *dev, u8 pruss_num)
> int?
> 
> SG -- Ok will do
> 
> 
>> +
>> +    if ((pruss_num != PRUCORE_0) && (pruss_num != PRUCORE_1))
>> +        return -EINVAL;
>> +
>> +    h_pruss = &pruss_mmap->core[pruss_num];
>> +
>> +    /* Reset PRU  */
>> +    spin_lock(&pruss->lock);
>> +    iowrite32(PRUCORE_CONTROL_RESETVAL, &h_pruss->control);
> 
> no need to lock the ram reset below?
> 
> SG -- I don't think its required. We just reset the RAM during init and
> since each pru can only be attached to only one device, the access
>        will be already serialized based upon the pru num.

In the other function you lock the access to the ram, but not here.

>> +    /* Reset any garbage in the ram */
>> +    if (pruss_num == PRUCORE_0)
>> +        for (i = 0; i < PRUSS_PRU0_RAM_SZ; i++)
>> +            iowrite32(0x0, &pruss_mmap->dram0[i]);
>> +    else if (pruss_num == PRUCORE_1)
>> +        for (i = 0; i < PRUSS_PRU1_RAM_SZ; i++)
>> +            iowrite32(0x0, &pruss_mmap->dram1[i]);
> if you make a array for these
> +struct pruss_map {
> +    u8 dram0[512];
> +    u8 res1[7680];
> 
> +    u8 dram1[512];
> +    u8 res2[7680];
> ..}
> you don't need the if..else..
> 
> SG - The dram/iram is not contiguous, there is a reserved space in
> between, how do I declare an array for it.

This is the struct you have:

struct pruss_map {
	u8 dram0[512];
	u8 res1[7680];

	u8 dram1[512];
	u8 res2[7680];
...
}

If you want to describe the ram with an array it translates to:

struct pruss_dram {
	u8 dram[512];
	u8 res[7680];
};

struct pruss_map {
	struct pruss_dram[2];
...
};

BTW: Why do you declare the dram as "u8" "u32" seems more natural to me.

>> +/* Load the specified PRU with code */
>> +s32 pruss_load(struct device *dev, u8 pruss_num,
>> +            u32 *pruss_code, u32 code_size_in_words)
>> +{
>> +    struct pruss_priv *pruss = dev_get_drvdata(dev->parent);
>> +    struct pruss_map __iomem *pruss_mmap = pruss->ioaddr;
>> +    u32 __iomem *pruss_iram;
>> +    u32 i;
>> +
>> +    if (pruss_num == PRUCORE_0)
>> +        pruss_iram = (u32 __iomem *)&pruss_mmap->iram0;
>> +    else if (pruss_num == PRUCORE_1)
>> +        pruss_iram = (u32 __iomem *)&pruss_mmap->iram1;
>> +    else
> same here
> 
> SG - same here.

same here :)

>> +s32 pruss_run(struct device *dev, u8 pruss_num)
> int?
> 
> SG - Ok, Will do.
> 
> 
>> +    while (cnt--) {
>> +        temp_reg = ioread32(&h_pruss->control);
>> +        if (((temp_reg & PRUCORE_CONTROL_RUNSTATE_MASK) >>
>> +                PRUCORE_CONTROL_RUNSTATE_SHIFT) ==
>> +                PRUCORE_CONTROL_RUNSTATE_HALT)
>> +            break;
> how long might this take? what about some delay, sleep, or reschedule?
> 
> SG - This does not take more than 10 to 20 counts,

Does it make sense, that the timeout is a parameter to that function?

> 
> 
>> +s32 pruss_writeb(struct device *dev, u32 offset, u8 pdatatowrite)
>> +{
>> +    struct pruss_priv *pruss = dev_get_drvdata(dev->parent);
>> +    void __iomem *paddresstowrite;
> we usually don't use "p" variable names for pointers
> 
> SG - Ok, will remove.
> 
> 
>> +s32 pruss_rmwb(struct device *dev, u32 offset, u8 mask, u8 val)
> void function?
> 
> SG - Ok, will do.
> 
>> +
>> +s32 pruss_readb(struct device *dev, u32 offset, u8 *pdatatoread)
> void?
> 
> SG - Ok, will do.
> 
>> +{
>> +    struct pruss_priv *pruss = dev_get_drvdata(dev->parent);
>> +    void __iomem *paddresstoread;
>> +
>> +    paddresstoread = pruss->ioaddr + offset ;
>> +    *pdatatoread = ioread8(paddresstoread);
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pruss_readb);
>> +
>> +s32 pruss_readb_multi(struct device *dev, u32 offset,
>> +        u8 *pdatatoread, u16 bytestoread)
> viod?
> 
> SG - Ok, will do.
> 
>> +{
>> +    struct pruss_priv *pruss = dev_get_drvdata(dev->parent);
>> +    u8 __iomem *paddresstoread;
>> +    u16 i;
> int?
> 
> SG - Ok, will do.
> 
> 
> 
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pruss_readb_multi);
>> +
>> +s32 pruss_writel(struct device *dev, u32 offset,
>> +        u32 pdatatowrite)
> void?
> 
> SG - Ok, will do.
> 
> 
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pruss_writel);
>> +
>> +s32 pruss_writel_multi(struct device *dev, u32 offset,
>> +        u32 *pdatatowrite, u16 wordstowrite)
> void?
> 
> SG - Ok, will do.
> 
>> +{
>> +    struct pruss_priv *pruss = dev_get_drvdata(dev->parent);
>> +    u32 __iomem *paddresstowrite;
>> +    u16 i;
>> +
>> +    paddresstowrite = pruss->ioaddr + offset;
>> +
>> +    for (i = 0; i < wordstowrite; i++)
>> +        iowrite32(*pdatatowrite++, paddresstowrite++);
> memcopy_to_iomem?
> 
> SG -- I did not understand, could you please elaborate.

You could use memcpy_toio() - although it seems it does copy bytes
internally.

http://lxr.linux.no/linux+v2.6.38/arch/arm/include/asm/io.h#L222
> 
> 
>> +
>> +s32 pruss_rmwl(struct device *dev, u32 offset, u32 mask, u32 val)
> void?
> 
> SG - Ok, will do.
> 
> 
>> +}
>> +EXPORT_SYMBOL_GPL(pruss_rmwl);
>> +
>> +s32 pruss_readl(struct device *dev, u32 offset, u32 *pdatatoread)
> void? or return the read value
> 
> SG - Ok, will do.
> 
> 
> 

regards,
Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110427/0ddba555/attachment-0001.sig>
