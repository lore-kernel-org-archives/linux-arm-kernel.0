From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Jan 2012 16:35:21 -0800
Subject: [PATCH 9/9] arm/tegra: emc: device tree support
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17761F15B3@HQMAIL01.nvidia.com>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
 <1324599468-12845-10-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F15B3@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMgq7g9-CEiC0E-hWKeLpGXSQ76bQ94-pkCaZYnRk+B+NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2012 at 4:27 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Thursday, December 22, 2011 5:18 PM:
>> Add device tree support to the emc driver, filling in the platform data
>> based on the DT bindings.
>
>> diff --git a/arch/arm/mach-tegra/apbio.c b/arch/arm/mach-tegra/apbio.c
> ...
>> ?out_fail:
>> ? ? ? mutex_unlock(&tegra_apb_dma_lock);
>> - ? ? return true;
>> + ? ? return false;
>
> There's the Easter egg;-)

Yep, will move.

>
>> diff --git a/arch/arm/mach-tegra/tegra2_emc.c b/arch/arm/mach-tegra/tegra2_emc.c
>
>> +#ifdef CONFIG_OF
>> +static struct device_node *tegra_emc_ramcode_devnode(struct device_node *np)
>> +{
>> + ? ? struct device_node *iter;
>> + ? ? u32 reg;
>> +
>> + ? ? for_each_child_of_node(np, iter) {
>> + ? ? ? ? ? ? if (!of_property_read_u32(np, "nvidia,ram-code", &reg))
>> + ? ? ? ? ? ? ? ? ? ? continue;
>
> I think that test is inverted; it returns 0 on success.

D'oh, thanks.

>
>> +static struct tegra_emc_pdata *tegra_emc_dt_parse_pdata(
>> + ? ? ? ? ? ? struct platform_device *pdev)
> ...
>> + ? ? pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>> + ? ? pdata->tables = devm_kzalloc(&pdev->dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?sizeof(struct tegra_emc_table) * num_tables,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?GFP_KERNEL);
>
> May as well use sizeof(*pdata->tables) there too for consistency?

Sure, can change it.

>
>> +
>> + ? ? i = 0;
>> + ? ? for_each_child_of_node(tnp, iter) {
>> + ? ? ? ? ? ? u32 prop;
>> +
>> + ? ? ? ? ? ? ret = of_property_read_u32(iter, "clock-frequency", &prop);
>> + ? ? ? ? ? ? if (ret) {
>> + ? ? ? ? ? ? ? ? ? ? dev_err(&pdev->dev, "no clock-frequency in %s\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? iter->full_name);
>> + ? ? ? ? ? ? ? ? ? ? continue;
>
> Not goto out?

If there's ever another child-node added by someone (by mistake or
otherwise), this would start to fail. I'd rather try to survive it and
just not use the malformed entries.

>> + ? ? ? ? ? ? }
>> + ? ? ? ? ? ? pdata->tables[i].rate = prop;
>> +
>> + ? ? ? ? ? ? ret = of_property_read_u32_array(iter, "nvidia,emc-registers",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?pdata->tables[i].regs,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?TEGRA_EMC_NUM_REGS);
>> + ? ? ? ? ? ? if (ret) {
>> + ? ? ? ? ? ? ? ? ? ? dev_err(&pdev->dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? "malformed emc-registers property in %s\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? iter->full_name);
>> + ? ? ? ? ? ? ? ? ? ? continue;
>> + ? ? ? ? ? ? }
>> +
>> + ? ? ? ? ? ? i++;
>> + ? ? }
>> + ? ? pdata->num_tables = i;
>
> Or here, "if (i != num_tables) error"?

Same, I'd rather try to use what we got.


>> +
>> +out:
>> + ? ? of_node_put(tnp);
>> + ? ? return pdata;
>> +}
>
> +static struct tegra_emc_pdata __devinit *tegra_emc_fill_pdata(struct platform_device *pdev)
> +{
> ...
> + ? ? ? pdata->tables[0].rate = clk_get_rate(c);
> ...
> + ? ? ? dev_info(&pdev->dev, "no tables provided, using settings for %ld kHz\n",
> + ? ? ? ? ? ? ? ?pdata->tables[0].rate / 2000);
>
> Is that right; I'm not sure if the /2 should be applied to what's stored
> in .rate, or to the EMC clock value from clk_get_rate(). Similarly, is
> the DT frequency the /2 version; there's no /2 in the DT parsing, but I
> think I expect there to be.

The EMC clock is 2x the memory speed (on T20), so the above will print
out the actual speed of memory, not of the EMC block. The DT binding
is based on the EMC clock. I guess that could be considered
inconsistent, I can update the message to clarify.


-Olof
