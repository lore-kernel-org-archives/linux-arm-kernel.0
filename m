From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 6 Jun 2017 09:51:20 +0530
Subject: [PATCH v6 03/11] clk: bcm: Add clocks for Stingray SOC
In-Reply-To: <20170602221052.GT20170@codeaurora.org>
References: <1496385275-6899-1-git-send-email-anup.patel@broadcom.com>
 <1496385275-6899-4-git-send-email-anup.patel@broadcom.com>
 <20170602221052.GT20170@codeaurora.org>
Message-ID: <CAALAos8cEc8KN4PE-WUQKNmRzV=GB6YsBJ-4p9mNjs-KduU0Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 3, 2017 at 3:40 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/02, Anup Patel wrote:
>> diff --git a/drivers/clk/bcm/clk-sr.c b/drivers/clk/bcm/clk-sr.c
>> new file mode 100644
>> index 0000000..342f702
>> --- /dev/null
>> +++ b/drivers/clk/bcm/clk-sr.c
>> @@ -0,0 +1,320 @@
>> +
>> +static const struct iproc_clk_ctrl lcpll_pcie_clk[] = {
>> +     [BCM_SR_LCPLL_PCIE_PHY_REF_CLK] = {
>> +             .channel = BCM_SR_LCPLL_PCIE_PHY_REF_CLK,
>> +             .flags = IPROC_CLK_AON,
>> +             .enable = ENABLE_VAL(0x0, 7, 1, 13),
>> +             .mdiv = REG_VAL(0x14, 0, 9),
>> +     },
>> +};
>> +
>> +static void __init sr_lcpll_pcie_clk_init(struct device_node *node)
>
> Drop __init usage throughout this patch please.

Sure, will do.

>
>> +{
>> +     iproc_pll_clk_setup(node, &lcpll_pcie, NULL, 0, lcpll_pcie_clk,
>> +             ARRAY_SIZE(lcpll_pcie_clk));
>> +}
>> +
>> +static const struct of_device_id sr_clk_dt_ids[] = {
>> +{ .compatible = "brcm,sr-genpll0", .data = sr_genpll0_clk_init, },
>> +{ .compatible = "brcm,sr-genpll4", .data = sr_genpll4_clk_init, },
>> +{ .compatible = "brcm,sr-genpll5", .data = sr_genpll5_clk_init, },
>> +{ .compatible = "brcm,sr-lcpll0", .data = sr_lcpll0_clk_init, },
>> +{ .compatible = "brcm,sr-lcpll1", .data = sr_lcpll1_clk_init, },
>> +{ .compatible = "brcm,sr-lcpll-pcie", .data = sr_lcpll_pcie_clk_init, },
>> +{ /* sentinel */ }
>
> Please tab these out properly And also leave off the , after the
> init function.

Sure, will do.

>
>> +};
>> +
>> +static int sr_clk_probe(struct platform_device *pdev)
>> +{
>> +     const struct of_device_id *device;
>> +     void (*init_func)(struct device_node *);
>
> Let's keep this taking the platform device pointer. That way in
> the future devm could be used as well as other platform device
> APIs without having to change all init signatures.

Sounds good, I will make init_func prototype similar to
platform driver probe function.

>
>> +
>> +     device = of_match_device(sr_clk_dt_ids, &pdev->dev);
>> +     if (!device)
>> +             return -ENODEV;
>> +     init_func = device->data;
>
> Can use of_device_get_match_data() instead
>
>> +
>> +     init_func(pdev->dev.of_node);
>> +
>> +     return 0;
>> +}
>
> It would be pretty nice if we could have some platform driver
> common function for this where we want to call different probe
> functions for different compatible ids and put them all in the
> same driver file. Like platform_driver_of_probe() or something
> that then calls a int (*init_func)(struct platform_device *pdev)
> directly from the of match table for you.

Yes, in-future we can have some API in OF
such as:
int of_platform_nested_probe(struct platform_device *pdev)

This API can be directly set a probe function of
some platform driver. It will expect that match data
is another platform driver probe function and will
call that.

IMHO, having nested probe API for OF will certainly
help simplify probe functions of quite a few drivers.

>
>> +
>> +static struct platform_driver sr_clk_driver = {
>
> iproc_sr_* throughout this file?

Actually, clk drivers for other iProc SOCs (namely,
ns2 and nsp) have only "<soc_name>_" prefix
so we are trying to be consistent with these
drivers by using "sr_" prefix.

Regards,
A nup
