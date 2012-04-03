From: viresh.linux@gmail.com (viresh kumar)
Date: Tue, 3 Apr 2012 22:39:32 +0530
Subject: [PATCH] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <CAOh2x=mk3PeozELWNGrJzjTjF6_T4f0uWgwP9rALD9xOHd=9zQ@mail.gmail.com>
References: <a1b7f612544a09989cec80a0318f35b6e48eb1d3.1333453148.git.viresh.kumar@st.com>
 <201204031347.35256.arnd@arndb.de>
 <CAOh2x=mk3PeozELWNGrJzjTjF6_T4f0uWgwP9rALD9xOHd=9zQ@mail.gmail.com>
Message-ID: <CAOh2x==ZbB5L=susFvsjmDRVKtfDiXd4Bq+MPnPVegnPAPmGsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/3/12, viresh kumar <viresh.linux@gmail.com> wrote:
> On 4/3/12, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 03 April 2012, Viresh Kumar wrote:
>>> +static struct of_device_id spear_pinctrl_of_match[] __devinitdata = {
>>> +#ifdef CONFIG_PINCTRL_SPEAR300
>>> +	{
>>> +		.compatible = "st,spear300-pinmux",
>>> +		.data = spear300_mach_init,
>>> +	},
>>> +#endif
>>> +#ifdef CONFIG_PINCTRL_SPEAR310
>>> +	{
>>> +		.compatible = "st,spear310-pinmux",
>>> +		.data = spear310_mach_init,
>>> +	},
>>> +#endif
>>> +#ifdef CONFIG_PINCTRL_SPEAR320
>>> +	{
>>> +		.compatible = "st,spear320-pinmux",
>>> +		.data = spear320_mach_init,
>>> +	},
>>> +#endif
>>> +	{},
>>> +};
>>
>> I would recommend turning the logic around here: instead of having
>> a common driver that calls into the soc specific drivers, make the
>> common code a library that just exports a few symbols, and move
>> each of the socs into its own module with one init function
>> that calls the generic spear_pinctrl_probe, passing the appropriate
>> arguments on the code that that differs.
>
> Sure.

I tried doing this, but it didn't looked convincing to me. Lot of code
that is currently present in pinctrl-spear.c is getting duplicated per
SoC registered: 5 (3 - spear3xx, 2 - spear13xx). Almost all SoC's will
need exactly the same probe routine. So, i would like to retain the original
code posted.

>>> +static struct spear_pmx_mode pmx_mode_nand = {
>>> +	.name = "nand",
>>> +	.mode = NAND_MODE,
>>> +	.reg = MODE_CONFIG_REG,
>>> +	.mask = 0x0000000F,
>>> +	.val = 0x00,
>>> +};
>>> +
>>
>> These all look like they can easily get transformed into
>> device nodes in the device tree.
>
> Any example driver doing this would be helpful. Can you
> give me a link. :)

With Stephen's mail, i believe i don't really have to do it, for now
atleast.

>>> +/* pingroups */
>>> +static struct spear_pingroup *spear310_pingroups[] = {
>>> +	SPEAR3XX_COMMON_PINGROUPS,
>>> +	&emi_cs_0_to_5_pingroup,
>>> +	&uart1_pingroup,
>>> +	&uart2_pingroup,
>>> +	&uart3_pingroup,
>>> +	&uart4_pingroup,
>>> +	&uart5_pingroup,
>>> +	&fsmc_pingroup,
>>> +	&rs485_0_pingroup,
>>> +	&rs485_1_pingroup,
>>> +	&tdm_pingroup,
>>> +};
>>> +
>>> +/* functions */
>>> +static struct spear_function *spear310_functions[] = {
>>> +	SPEAR3XX_COMMON_FUNCTIONS,
>>> +	&emi_cs_0_to_5_function,
>>> +	&uart1_function,
>>> +	&uart2_function,
>>> +	&uart3_function,
>>> +	&uart4_function,
>>> +	&uart5_function,
>>> +	&fsmc_function,
>>> +	&rs485_0_function,
>>> +	&rs485_1_function,
>>> +	&tdm_function,
>>> +};
>>
>> I believe the macros like SPEAR3XX_COMMON_FUNCTIONS are not
>> needed any more, you can simply register multiple sets of pingroups
>> and functions.
>
> You mean to say, we can do multiple pinctrl_register() and define multiple
> struct pinctrl_desc?

Again, with Stephen's comment, it is clear we can't register multiple
groups/functions
here, as they correspond to same set of pins and pinctrl. Would keep it as is.

--
Viresh
