From: b32955@freescale.com (Huang Shijie)
Date: Fri, 8 Apr 2011 10:42:07 +0800
Subject: [PATCH V4 0/4] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <19869.40520.368078.270732@ipc1.ka-ro>
References: <19869.40520.368078.270732@ipc1.ka-ro>
Message-ID: <4D9E75FF.6090603@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar:
> Hi,
>
> Huang Shijie writes:
>> Does some one have any comments about this driver?
>>
> I'm still not happy with the rom-helper code that IMO does not belong
> in this driver.
Could you tell me which part of the rom-helper code is not belong the 
driver?


> You could enable CONFIG_MTD_CMDLINE_PARTS and add something like:
> "mtdparts=gpmi-nfc-main:2m(gpmi-nfc-0-boot)ro,-(gpmi-nfc-general-use)"
> to the kernel cmdline to achieve the same without any special code
> inside the chip driver.
>
The original code does have the command-line-partition parsing code,

I removed it. I think I did a wrong thing.

I found the code is needed yesterday. The android system needs a different
partition layout. I had to revert the code back.



> Also, I would integrate the code from the hal-*.c files into the main
> file and remove all the function hooks, since the functions are the
thanks for your advice.

This driver will serve for many platforms, not only the imx23 and imx28.
I am merging the imx508 code to the driver.
I feel lucky that i did not merge all the code into the main file, which 
will
make the code mess.

But still thanks for your advice.

> same for all the current variants anyway. You might hook the 'begin()'
> and 'is_ready()' functions which are the only ones that are different
> in the current variants so that the distinction can be made once upon
> initialization rather than on every function call:
> +static int mx23_is_ready(struct gpmi_nfc_data *this, unsigned chip)
> +{
> +	struct resources  *resources =&this->resources;
> +	uint32_t          mask;
> +	uint32_t          reg;
> +
> +	mask = MX23_BM_GPMI_DEBUG_READY0<<  chip;
> +	reg = __raw_readl(resources->gpmi_regs + HW_GPMI_DEBUG);
> +
> +	return !!(reg&  mask);
> +}
> +
> +static void mx28_begin(struct gpmi_nfc_data *this)
> +{
> +	struct resources                 *resources =&this->resources;
> {...]
> +}
> +
> +static int mx28_is_ready(struct gpmi_nfc_data *this, unsigned chip)
> +{
> +	struct resources  *resources =&this->resources;
> +	uint32_t          mask;
> +	uint32_t          reg;
> +
> +	mask = MX28_BF_GPMI_STAT_READY_BUSY(1<<  chip);
> +	reg = __raw_readl(resources->gpmi_regs + HW_GPMI_STAT);
> +
> +	return !!(reg&  mask);
> +}
> [...]
> +static int gpmi_nfc_probe(struct platform_device *pdev)
> [...]
> +	if (CPU_IS_MX23()) {
> +		this->is_ready = mx23_is_ready;
> +	} else if (CPU_IS_MX28()) {
> +		this->is_ready = mx28_is_ready;
> +		this->begin = mx28_begin;
> +	}
> Since the begin() function is a NOP for i.MX23, the function pointer
> could be left unassigned and the function only be called if the
> pointer is not NULL or an empty function could be assigned.
>
> Further I wouldn't name the macro for distinguishing the different
> controller variants CPU_IS_... but something like GPMI_IS
ok. This is a small change. I will do it in the next version. thanks

Huang Shijie
>
> Lothar Wa?mann
