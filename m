From: charu@ti.com (Varadarajan, Charulatha)
Date: Fri, 1 Oct 2010 20:24:57 +0530
Subject: [PATCH v4 1/4] omap4 hsmmc: Adding card detect support for MMC1
In-Reply-To: <AANLkTikBcUZjMEAa1AuAdVohLkbVXki0nW4NpBOC-hJJ@mail.gmail.com>
References: <9408.10.24.255.18.1285348400.squirrel@dbdmail.itg.ti.com>
	<AANLkTi=YvtrfmUTc-YBAUjEXn1v3pPLmhb92J60AhU28@mail.gmail.com>
	<AANLkTim5d6XP0nuJLF2DxDGP2DuBK5VUajd=YhXQnT2C@mail.gmail.com>
	<AANLkTi=oX7CT8RF39kT-7niutF3PEeSeC1A_L5TcWuO4@mail.gmail.com>
	<AANLkTim1H=qam8Sjbv_EUXGtf09TObTViYMiN17uMFQ1@mail.gmail.com>
	<20101001112926.GC3064@sortiz-mobl>
	<AANLkTims1qZ_X9F4rzkJE9Gat_pwWZxO2nPkRTpa6Cc5@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE0BB@dbde02.ent.ti.com>
	<AANLkTikBcUZjMEAa1AuAdVohLkbVXki0nW4NpBOC-hJJ@mail.gmail.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE0C9@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: kishore kadiyala [mailto:kishorek.kadiyala at gmail.com]
> Sent: Friday, October 01, 2010 8:15 PM
> To: Varadarajan, Charulatha
> Cc: Samuel Ortiz; linux-mmc at vger.kernel.org; linux-omap at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; tony at atomide.com; akpm at linux-
> foundation.org; Chikkature Rajashekar, Madhusudhan;
> adrian.hunter at nokia.com
> Subject: Re: [PATCH v4 1/4] omap4 hsmmc: Adding card detect support for
> MMC1
> 
> On Fri, Oct 1, 2010 at 8:11 PM, Varadarajan, Charulatha <charu@ti.com>
> wrote:
> >
> > <<snip>>
> >
> >> >> >>>> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> >> >> >>>> index 6de90bf..e64894c 100644
> >> >> >>>> --- a/include/linux/i2c/twl.h
> >> >> >>>> +++ b/include/linux/i2c/twl.h
> >> >> >>>> @@ -141,6 +141,16 @@
> >> >> >>>> ?#define TWL6030_CHARGER_CTRL_INT_MASK ?0x10
> >> >> >>>> ?#define TWL6030_CHARGER_FAULT_INT_MASK ? ? ? ? 0x60
> >> >> >>>>
> >> >> >>>> +#define TWL6030_MMCCTRL ? ? ? ? ? ? ? ?0xEE
> >> >> >>>> +#define VMMC_AUTO_OFF ? ? ? ? ? ? ? ? ?(0x1 << 3)
> >> >> >>>> +#define SW_FC ? ? ? ? ? ? ? ? ? ? ? ? ?(0x1 << 2)
> >> >> >>>> +#define STS_MMC ? ? ? ? ? ? ? ? ? ? ? ?0x1
> >> >> >>>> +
> >> >> >>>> +#define TWL6030_CFG_INPUT_PUPD3 ? ? ? ?0xF2
> >> >> >>>> +#define MMC_PU ? ? ? ? ? ? ? ? ? ? ? ? (0x1 << 3)
> >> >> >>>> +#define MMC_PD ? ? ? ? ? ? ? ? ? ? ? ? (0x1 << 2)
> >> >> >>>> +
> >> >> >>>> +
> >> >> >>>>
> >> >> >>>> ?#define TWL4030_CLASS_ID ? ? ? ? ? ? ? 0x4030
> >> >> >>>> ?#define TWL6030_CLASS_ID ? ? ? ? ? ? ? 0x6030
> >> >> >>>> @@ -173,6 +183,27 @@ int twl_i2c_read(u8 mod_no, u8
> >> *value, u8 reg, unsigned num_bytes);
> >> >> >>>> ?int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
> >> >> >>>> ?int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
> >> >> >>>>
> >> >> >>>> +/* Card detect Configuration for MMC1 Controller on OMAP4 */
> >> >> >>>> +#ifdef CONFIG_TWL4030_CORE
> >> >> >>>> +int twl6030_mmc_card_detect_config(void);
> >> >> >>>> +#else
> >> >> >>>> +static inline int twl6030_mmc_card_detect_config(void)
> >> >> >>>> +{
> >> >> >>>> + ? ? ? pr_debug("twl6030_mmc_card_detect_config not
> >> supported\n");
> >> >> >>>> + ? ? ? return 0;
> >> >> >>>> +}
> >> >> >>>> +#endif
> >> >> >>>> +
> >> >> >>>> +/* MMC1 Controller on OMAP4 uses Phoenix irq for
> >> Card detect */
> >> >> >>>> +#ifdef CONFIG_TWL4030_CORE
> >> >> >>>> +int twl6030_mmc_card_detect(struct device *dev, int slot);
> >> >> >>>> +#else
> >> >> >>>> +static inline int twl6030_mmc_card_detect(struct
> >> device *dev, int slot)
> >> >> >>>> +{
> >> >> >>>> + ? ? ? pr_debug("Call back twl6030_mmc_card_detect
> >> not supported\n");
> >
> > Use dev_dbg() instead of pr_debug...
> > Same comment applies across this patch series whereever pr_err/pr_debug
> > APIs are used.
> 
> Couldn't get it  how it makes a difference ? could you explain
> 

device information gets added for debug prints which is very useful
while debugging

> Regards,
> Kishore
> >
> >> >> >>>> + ? ? ? return -EIO;
> >> >> >>>> +}
> >> >> >>>> +#endif
> >
> > <<snip>>
