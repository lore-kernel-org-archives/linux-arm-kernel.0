From: shiraz.hashim@st.com (Shiraz HASHIM)
Date: Mon, 05 Apr 2010 12:45:56 +0530
Subject: [PATCH V2 Resend 12/12] ST SPEAr: Adding gpio pad multiplexing
	support
In-Reply-To: <4BB9661B.6060002@st.com>
References: <1269506455-15173-1-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-2-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-3-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-4-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-5-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-6-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-7-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-8-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-9-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-10-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-11-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-12-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-13-git-send-email-viresh.kumar@st.com>
	<4BB77785.7060709@st.com> <4BB9661B.6060002@st.com>
Message-ID: <4BB98E2C.8050604@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Viresh,

On 4/5/2010 9:54 AM, Viresh KUMAR wrote:
> On 4/3/2010 10:44 PM, Shiraz HASHIM wrote:
>>>  /* Add spear3xx family function declarations here */
>>> +void __init clk_init(void);
>>>  void __init spear3xx_map_io(void);
>>>  void __init spear3xx_init_irq(void);
>>>  void __init spear3xx_init(void);
>>> -void __init spear300_init(void);
>>> -void __init spear310_init(void);
>>> -void __init spear320_init(void);
>>> -void __init clk_init(void);
>>> +void spear_pmx_init(struct pmx_driver *pmx_driver, uint base, uint size);
>>>  
>>> -/* Add spear300 machine device structure declarations here */
>>> +/* pad mux declarations */
>> These are spear300 soecific declarations, isn't it?
> 
> No. I have added few spear3xx specific declarations here and moved spear300 
> declarations later in the list.

OK

>>
>>> +#define PMX_FIRDA_MASK		(1 << 14)
>>> +#define PMX_I2C_MASK		(1 << 13)
>>> +#define PMX_SSP_CS_MASK		(1 << 12)
>>> +#define PMX_SSP_MASK		(1 << 11)
>>> +#define PMX_MII_MASK		(1 << 10)
>>> +#define PMX_GPIO_PIN0_MASK	(1 << 9)
>>> +#define PMX_GPIO_PIN1_MASK	(1 << 8)
>>> +#define PMX_GPIO_PIN2_MASK	(1 << 7)
>>> +#define PMX_GPIO_PIN3_MASK	(1 << 6)
>>> +#define PMX_GPIO_PIN4_MASK	(1 << 5)
>>> +#define PMX_GPIO_PIN5_MASK	(1 << 4)
>>> +#define PMX_UART0_MODEM_MASK	(1 << 3)
>>> +#define PMX_UART0_MASK		(1 << 2)
>>> +#define PMX_TIMER_3_4_MASK	(1 << 1)
>>> +#define PMX_TIMER_1_2_MASK	(1 << 0)
>>> +
>>> +extern struct pmx_driver pmx_driver;
>>> +
>>> +/* spear300 declarations */
>>>  #ifdef CONFIG_MACH_SPEAR300
>>
>> see above comment 
> 
> explained above
>>
>>> +/* Add spear300 machine device structure declarations here */
>>>  extern struct amba_device gpio1_device;
>>> +
>>> +/* pad mux modes */
>>> +extern struct pmx_mode nand_mode;
>>> +extern struct pmx_mode nor_mode;
>>> +extern struct pmx_mode photo_frame_mode;
>>> +extern struct pmx_mode lend_ip_phone_mode;
>>> +extern struct pmx_mode hend_ip_phone_mode;
>>> +extern struct pmx_mode lend_wifi_phone_mode;
>>> +extern struct pmx_mode hend_wifi_phone_mode;
>>> +extern struct pmx_mode ata_pabx_wi2s_mode;
>>> +extern struct pmx_mode ata_pabx_i2s_mode;
>>> +extern struct pmx_mode caml_lcdw_mode;
>>> +extern struct pmx_mode camu_lcd_mode;
>>> +extern struct pmx_mode camu_wlcd_mode;
>>> +extern struct pmx_mode caml_lcd_mode;
>>> +
>>> +
>>> +struct pmx_dev pmx_gpio1 = {
>>> +	.name = "arm gpio1",
>>> +	.modes = pmx_gpio1_modes,
>>> +	.mode_count = ARRAY_SIZE(pmx_gpio1_modes),
>>> +	.enb_on_reset = 1,
>>> +};
>>
>> We have generalized pmx_dev in mode and mask attributes. Is it generic enough?
>> What if we have several mux register in same mode?
>>
> 
> This layer is spear specific and as far as our socs are concerned it is okay.
> In later socs if we have something which doesn't suit this framework then we
> can do minor modifications here with little effort.

OK. I think it is fine.

>>> +
>>> +/* pmx driver structure */
>>> +struct pmx_driver pmx_driver = {
>>> +	.mode_reg = {.offset = MODE_CONFIG_REG, .mask = 0x0000000f},
>>> +	.mux_reg = {.offset = PAD_MUX_CONFIG_REG, .mask = 0x00007fff},
>>> +};
>>
>> We assume that all SoCs would either have a mode register or a mux register or
>> both. Is this assumption generic enough. What if we have
>>  - more than 1 mux register
>>  - more than 1 mode register
>>  - may be a submode register in some new silicon.
> 
> Same as above.
> 
>>
>>> +
>>> +	/* padmux initialization */
>>> +	pmx_driver.mode = &photo_frame_mode;
>>> +	pmx_driver.devs = pmx_devs;
>>> +	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
>>> +	spear300_pmx_init();
>>
>> Intializing pmx_driver and not using it directly obstructs readability.
>> Better to pass pmx_driver and other info in spear300_pmx_init itself.
>> What is your opinion?
>>
> 
> Explained below.
> 
>>> +
>>> +	/* padmux initialization */
>>> +	pmx_driver.mode = NULL;
>>> +	pmx_driver.devs = pmx_devs;
>>> +	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
>>> +	spear310_pmx_init();
>>
>> I see your point in not passing pmx_driver here. It is due to initialization of
>> pmx_driver.mux fields. This field is specific to mach so may not be defined in
>> board file. Any other idea to overcome this little readability issue?
> 
> There are few things divided between mach and board. Now this situation will 
> always have some readability issue. I feel it is just fine.
> 
>>
>>> +	val = readl(pmx->base + pmx->mux_reg.offset);
>>> +	for (i = 0; i < count; i++) {
>>> +		u8 j = 0;
>>> +
>>> +		if (!devs[i]->name || !devs[i]->modes) {
>>> +			printk(KERN_ERR "padmux: dev name or modes is null\n");
>>> +			continue;
>>> +		}
>>> +		/* check if peripheral exists in active mode */
>>> +		if (pmx->active_mode) {
>>> +			bool found = false;
>>> +			for (j = 0; j < devs[i]->mode_count; j++) {
>>> +				if (devs[i]->modes[j].ids &
>>> +						pmx->active_mode->id) {
>>> +					found = true;
>>> +					break;
>>> +				}
>>> +			}
>>> +			if (found == false) {
>>> +				printk(KERN_ERR "%s device not available in %s"\
>>> +						"mode\n", devs[i]->name,
>>> +						pmx->active_mode->name);
>>> +				continue;
>>> +			}
>>> +		}
>>> +
>>> +		/* enable peripheral */
>>> +		mask = devs[i]->modes[j].mask & pmx->mux_reg.mask;
>>
>> Didn't understand this line.
>>
> 
> Here we are preparing mask to be written for enabling a peripheral in a specific
> mode. devs[i]->modes[j].mask will give mask of dev[i] for mode[j], this must be
> & with valid mask of mux register.

OK. Understood.

regards
Shiraz
