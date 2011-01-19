From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 19 Jan 2011 10:09:35 +0530
Subject: [PATCH V4 32/62] ST SPEAr 13xx : Adding support for SPEAr1310
In-Reply-To: <20110119000919.GB2209@gallagher>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<24e7a018145fb94f298ac620919ec4f0a1bf7517.1295333958.git.viresh.kumar@st.com>
	<20110119000919.GB2209@gallagher>
Message-ID: <4D366B07.5040509@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2011 05:39 AM, Jamie Iles wrote:
> On Tue, Jan 18, 2011 at 12:41:59PM +0530, Viresh Kumar wrote:
>> +static struct spi_board_info __initdata spi_board_info[] = {
>> +};
> 
> AFAICT spi_register_board_info() doesn't do anything when passed this empty 
> array so both the array and call could be removed.
> 

Actually we don't have free gpio's in evb boards to use as chip select for ssp.
So didn't add any spi devices here in this array. It is just added here so that
anybody who needs to test it can simply come here, add a device and test.
Can we keep it as it is?

>> +
>> +#ifdef CONFIG_PCIEPORTBUS
>> +/* this function is needed for PCIE host and device driver. Same
>> + * controller can not be programmed as host as well as device. So host
>> + * driver must call this function and if this function returns 1 then
>> + * only host should add that particular port as RC.
>> + * A port to be added as device, one must also add device's information
>> + * in plat_devs array defined in this file.
>> + * it is the responsibility of calling function to not send port number
>> + * greter than max no of controller(3)
>> + */
>> +int spear1310_pcie_port_is_host(int port)
>> +{
>> +	switch (port) {
>> +	case 0:
>> +		return 0;
>> +	case 1:
>> +		return 1;
>> +	case 2:
>> +		return 1;
>> +	}
>> +	return -EINVAL;
>> +}
>> +#endif
> 
> It looks like this can be made static.  Also, given the comment, is it worth 
> adding a BUG_ON(port > 3)?
> 

will be done. BUG_ON() can be added here.

>> +static void __init spear1310_evb_init(void)
>> +{
>> +	unsigned int i;
>> +
>> +	/* set keyboard plat data */
>> +	kbd_set_plat_data(&spear13xx_kbd_device, &kbd_data);
>> +
>> +	/* set nand device's plat data */
>> +	fsmc_nand_set_plat_data(&spear13xx_nand_device, NULL, 0,
>> +			NAND_SKIP_BBTSCAN, FSMC_NAND_BW8);
>> +	nand_mach_init(FSMC_NAND_BW8);
>> +
>> +	/* call spear1310 machine init function */
>> +	spear1310_init();
>> +
>> +	/* Register slave devices on the I2C buses */
>> +	i2c_register_default_devices();
>> +
>> +#ifdef CONFIG_PCIEPORTBUS
>> +	/* Enable PCIE0 clk */
>> +	enable_pcie0_clk();
>> +	pcie_init(&spear1310_pcie_port_is_host);
> 
> No '&' needed before function name.
> 

Ok.

-- 
viresh
