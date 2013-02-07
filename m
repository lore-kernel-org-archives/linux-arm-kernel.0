From: xiechao.mail@gmail.com (Chao Xie)
Date: Thu, 7 Feb 2013 10:00:41 +0800
Subject: [V6 PATCH 01/16] usb: phy: mv_usb2: add PHY driver for marvell
 usb2 controller
In-Reply-To: <20130206144216.GJ26842@e106331-lin.cambridge.arm.com>
References: <1360135431-27280-1-git-send-email-chao.xie@marvell.com>
 <1360135431-27280-2-git-send-email-chao.xie@marvell.com>
 <20130206144216.GJ26842@e106331-lin.cambridge.arm.com>
Message-ID: <CADApbei4wg7UhAYagmCmajWr6=5k2hR_2h7zMc2pjUNL-=yqgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 6, 2013 at 10:42 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> I have a few comments on the devicetree binding and the way it's parsed.
>
> I note many are similar to those I commented on for the mv_udc and ehci-mv
> devicetree code.
>
> On Wed, Feb 06, 2013 at 07:23:36AM +0000, Chao Xie wrote:
>> The PHY is seperated from usb controller.
>> The usb controller used in marvell pxa168/pxa910/mmp2 are same,
>> but PHY initialization may be different.
>> the usb controller can support udc/otg/ehci, and for each of
>> the mode, it need PHY to initialized before use the controller.
>> Direclty writing the phy driver will make the usb controller
>> driver to be simple and portable.
>> The PHY driver will be used by marvell udc/otg/ehci.
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> ---
>>  drivers/usb/phy/Kconfig              |    7 +
>>  drivers/usb/phy/Makefile             |    1 +
>>  drivers/usb/phy/mv_usb2_phy.c        |  454 ++++++++++++++++++++++++++++++++++
>>  include/linux/platform_data/mv_usb.h |    9 +-
>>  include/linux/usb/mv_usb2.h          |   43 ++++
>>  5 files changed, 511 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/usb/phy/mv_usb2_phy.c
>>  create mode 100644 include/linux/usb/mv_usb2.h
>
>
> [...]
>
>> +static struct of_device_id usb_phy_dt_ids[] = {
>> +       { .compatible = "mrvl,pxa168-usb-phy",  .data = (void *)PXA168_USB},
>> +       { .compatible = "mrvl,pxa910-usb-phy",  .data = (void *)PXA910_USB},
>> +       { .compatible = "mrvl,mmp2-usb-phy",    .data = (void *)MMP2_USB},
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(of, usb_phy_dt_ids);
>
> The binding (including these compatible string) needs to be documented.
>
>> +
>> +static int usb_phy_parse_dt(struct platform_device *pdev,
>> +                               struct mv_usb2_phy *mv_phy)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +       const struct of_device_id *of_id =
>> +                       of_match_device(usb_phy_dt_ids, &pdev->dev);
>> +       unsigned int clks_num;
>> +       int i, ret;
>> +       const char *clk_name;
>> +
>> +       if (!np)
>> +               return 1;
>
> An actual error code please.
>
> -ENODEV? -EINVAL?
>
>> +
>> +       clks_num = of_property_count_strings(np, "clocks");
>> +       if (clks_num < 0) {
>> +               dev_err(&pdev->dev, "failed to get clock number\n");
>> +               return clks_num;
>> +       }
>
> The common clock bindings use "clocks" as a list of phandle and clock-specifier
> pairs. It seems bad to reuse that name in a different sense for this binding.
>
> I'd recommend you use the common clock binding. There doesn't seem to be an
> of_clk_count, but it should be a relatively simple addition, and it'd make this
> code clearer and more consistent with other drivers.
>
> See Documentation/devicetree/bindings/clock/clock-bindings.txt
>
>> +
>> +       mv_phy->clks = devm_kzalloc(&pdev->dev,
>> +               sizeof(struct clk *) * clks_num, GFP_KERNEL);
>> +       if (mv_phy->clks == NULL) {
>> +               dev_err(&pdev->dev,
>> +                       "failed to allocate mempory for clocks");
>
> s/mempory/memory/
>
>> +               return -ENOMEM;
>> +       }
>> +
>> +       for (i = 0; i < clks_num; i++) {
>> +               ret = of_property_read_string_index(np, "clocks", i,
>> +                       &clk_name);
>> +               if (ret) {
>> +                       dev_err(&pdev->dev, "failed to read clocks\n");
>> +                       return ret;
>> +               }
>> +               mv_phy->clks[i] = devm_clk_get(&pdev->dev, clk_name);
>> +               if (IS_ERR(mv_phy->clks[i])) {
>> +                       dev_err(&pdev->dev, "failed to get clock %s\n",
>> +                               clk_name);
>> +                       return PTR_ERR(mv_phy->clks[i]);
>> +               }
>> +       }
>> +
>> +       mv_phy->clks_num = clks_num;
>> +       mv_phy->type = (enum mv_usb2_phy_type)(of_id->data);
>> +
>> +       return 0;
>> +}
>
> There's probably a need for something like devm_of_clk_get to make it easier to
> write of-backed drivers.
>
>> +
>> +static int usb_phy_probe(struct platform_device *pdev)
>> +{
>> +       struct mv_usb2_phy *mv_phy;
>> +       struct resource *r;
>> +       int ret, i;
>> +
>> +       mv_phy = devm_kzalloc(&pdev->dev, sizeof(*mv_phy), GFP_KERNEL);
>> +       if (mv_phy == NULL) {
>> +               dev_err(&pdev->dev, "failed to allocate memory\n");
>> +               return -ENOMEM;
>> +       }
>> +       mutex_init(&mv_phy->phy_lock);
>> +
>> +       ret = usb_phy_parse_dt(pdev, mv_phy);
>> +       /* no CONFIG_OF */
>> +       if (ret > 0) {
>
> Reorganise this so you test for pdev->dev.of_node, and based of that you either
> call usb_phy_parse_dt or do this stuff in the block below. That way you don't need
> the positive return code from usb_phy_parse_dt.
>
>> +               struct mv_usb_phy_platform_data *pdata
>> +                               = pdev->dev.platform_data;
>> +               const struct platform_device_id *id
>> +                               = platform_get_device_id(pdev);
>> +
>> +               if (pdata == NULL || id == NULL) {
>> +                       dev_err(&pdev->dev,
>> +                               "missing platform_data or id_entry\n");
>> +                       return -ENODEV;
>> +               }
>> +               mv_phy->type = (unsigned int)(id->driver_data);
>> +               mv_phy->clks_num = pdata->clknum;
>> +               mv_phy->clks = devm_kzalloc(&pdev->dev,
>> +                       sizeof(struct clk *) * mv_phy->clks_num, GFP_KERNEL);
>> +               if (mv_phy->clks == NULL) {
>> +                       dev_err(&pdev->dev,
>> +                               "failed to allocate mempory for clocks");
>
> s/mempory/memory/
>
>> +                       return -ENOMEM;
>> +               }
>> +               for (i = 0; i < mv_phy->clks_num; i++)
>> +                       mv_phy->clks[i] = devm_clk_get(&pdev->dev,
>> +                                                       pdata->clkname[i]);
>> +                       if (IS_ERR(mv_phy->clks[i])) {
>> +                               dev_err(&pdev->dev, "failed to get clock %s\n",
>> +                                       pdata->clkname[i]);
>> +                               return PTR_ERR(mv_phy->clks[i]);
>> +                       }
>> +       } else if (ret < 0) {
>> +               dev_err(&pdev->dev, "error parse dt\n");
>
> s/parse/parsing/
>
>> +               return ret;
>> +       }
>> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (r == NULL) {
>> +               dev_err(&pdev->dev, "no phy I/O memory resource defined\n");
>> +               return -ENODEV;
>> +       }
>> +       mv_phy->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
>> +       if (mv_phy->base == NULL) {
>> +               dev_err(&pdev->dev, "error map register base\n");
>
> s/map/mapping/
>
>> +               return -EBUSY;
>> +       }
>> +       platform_set_drvdata(pdev, mv_phy);
>> +       mv_phy->pdev = pdev;
>> +       mv_phy->init = usb_phy_init;
>> +       mv_phy->shutdown = usb_phy_shutdown;
>> +
>> +       platform_set_drvdata(pdev, mv_phy);
>> +
>> +       the_phy = mv_phy;
>> +
>> +       dev_info(&pdev->dev, "mv usb2 phy initialized\n");
>> +
>> +       return 0;
>> +}
>> +
>> +static int usb_phy_remove(struct platform_device *pdev)
>> +{
>> +       the_phy = NULL;
>> +
>> +       return 0;
>> +}
>
> Is mv_usb2_phy large? Why does it need to be dynamically allocated / freed at
> all given it's treated as a singleton?
>
First i am sorry about the device tree support.
I will remove the device tree support and make it in another series
together with the patches for device tree support
for client/otg/host driver.

the mv_usb2_phy is bound it to the usb phy device, as a usually way we
will allocate it when probe the usb phy device, and
make it as a private data structure to usb phy device.


> [...]
>
> Thanks,
> Mark.
>
>
