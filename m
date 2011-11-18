From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 18 Nov 2011 14:04:33 +0800
Subject: [PATCH v3] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
In-Reply-To: <CAM=Q2ct4AKfYSHSu1KwYcW4YZ20QAJsOuHc9fg=oD5Rj7StB7g@mail.gmail.com>
References: <1321544354-3084-1-git-send-email-21cnbao@gmail.com>
 <CAM=Q2ct4AKfYSHSu1KwYcW4YZ20QAJsOuHc9fg=oD5Rj7StB7g@mail.gmail.com>
Message-ID: <CAGsJ_4wedp6rqM0HuTEZHQ9D77drTp92Sbft10L6OWYg6sS=wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shubhrajyoti,
Thanks for reviewing

2011/11/18 Shubhrajyoti Datta <omaplinuxkernel@gmail.com>:
> Hi Zhiwu,
>
> On Thu, Nov 17, 2011 at 9:09 PM, Barry Song <21cnbao@gmail.com> wrote:
>>
>> From: Zhiwu Song <Zhiwu.Song@csr.com>
>>
>> SiRFprimaII is the latest generation application processor from CSR?s
>> multi-function SoC product family.
>> The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
>> 3.0.
>> There are two I2C controllers on primaII, features include:
>> ? Two I2C controller modules are on chip
>> ? RISC I/O bus read write register
>> ? Up to 16 bytes data buffer for issuing commands and writing data
>> ?at the same time
>> ? Up to 16 commands, and receiving read data 16 bytes at a time
>> ? Error INT report (ACK check)
>> ? No-ACK bus protocols (SCCB bus protocols)
>>
>> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
>> Signed-off-by: Xiangzhen Ye <Xiangzhen.Ye@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>> ?-v3:
>> ?add lost clk_enable/disable in suspend/resume function while reading/
>> ?writing i2c controller registers.
>> ?without this, suspend will hang.

forgot this fix was done by Yuping Luo <Yuping.Luo@csr.com>. so he
should get a Signed-off-by.

>>
>> ?arch/arm/mach-prima2/pm.c ? ? | ? ?1 +
>> ?arch/arm/mach-prima2/prima2.c | ? ?1 +
>> ?drivers/i2c/busses/Kconfig ? ?| ? ?7 +
>> ?drivers/i2c/busses/Makefile ? | ? ?1 +
>> ?drivers/i2c/busses/i2c-sirf.c | ?438
>> +++++++++++++++++++++++++++++++++++++++++
>> ?drivers/i2c/busses/i2c-sirf.h | ? 61 ++++++
>> ?6 files changed, 509 insertions(+), 0 deletions(-)
>> ?create mode 100644 drivers/i2c/busses/i2c-sirf.c
>> ?create mode 100644 drivers/i2c/busses/i2c-sirf.h
>>
>> diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
>> index cb53160..26ebb57 100644
>> --- a/arch/arm/mach-prima2/pm.c
>> +++ b/arch/arm/mach-prima2/pm.c
>> @@ -9,6 +9,7 @@
>> ?#include <linux/kernel.h>
>> ?#include <linux/suspend.h>
>> ?#include <linux/slab.h>
>> +#include <linux/module.h>
>> ?#include <linux/of.h>
>> ?#include <linux/of_address.h>
>> ?#include <linux/of_device.h>
>> diff --git a/arch/arm/mach-prima2/prima2.c b/arch/arm/mach-prima2/prima2.c

>> +config I2C_SIRF
>> + ? ? ? tristate "CSR SiRFprimaII I2C interface"
>> + ? ? ? depends on ARCH_PRIMA2
>> + ? ? ? help
>> + ? ? ? ? If you say yes to this option, support will be included for the
>> + ? ? ? ? CSR SiRFprimaII I2C interface.
>
> Since it is tristate the module ..

this is just a minor issue, if you like some changes, i can make it better.

>
>>
>> +
>> ?config I2C_SIMTEC
>> ? ? ? ?tristate "Simtec Generic I2C interface"
>> ? ? ? ?select I2C_ALGOBIT
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index fba6da6..c30db66 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -62,6 +62,7 @@ obj-$(CONFIG_I2C_S3C2410) ? ? += i2c-s3c2410.o
>> ?obj-$(CONFIG_I2C_S6000) ? ? ? ? ? ? ? ?+= i2c-s6000.o
>> ?obj-$(CONFIG_I2C_SH7760) ? ? ? += i2c-sh7760.o
>> ?obj-$(CONFIG_I2C_SH_MOBILE) ? ?+= i2c-sh_mobile.o
>> +obj-$(CONFIG_I2C_SIRF) ? ? ? ? += i2c-sirf.o
>> ?obj-$(CONFIG_I2C_SIMTEC) ? ? ? += i2c-simtec.o
>> ?obj-$(CONFIG_I2C_STU300) ? ? ? += i2c-stu300.o
>> ?obj-$(CONFIG_I2C_TEGRA) ? ? ? ? ? ? ? ?+= i2c-tegra.o
>> diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
>> new file mode 100644
>> index 0000000..2988124
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-sirf.c
>> @@ -0,0 +1,438 @@
>> +/*
>> + * I2C bus driver for CSR SiRFprimaII
>> + *
>> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group
>> company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/init.h>
>> +#include <linux/sched.h>
>
> Are all these files needed?

-#include <linux/init.h>
-#include <linux/sched.h>

>> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "Unable to get MEM resource\n");
>> + ? ? ? ? ? ? ? err = -EINVAL;
>> + ? ? ? ? ? ? ? goto out;
>> + ? ? ? }
>> +
>> + ? ? ? siic->base =
>> + ? ? ? ? ? ? ? devm_ioremap(&pdev->dev, mem_res->start, (mem_res->end -
>> mem_res->start + 1));
>> + ? ? ? if (siic->base == NULL) {
>> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "IO remap failed!\n");
>> + ? ? ? ? ? ? ? err = -ENOMEM;
>> + ? ? ? ? ? ? ? goto out;
>> + ? ? ? }
>> +
>> + ? ? ? siic->irq = platform_get_irq(pdev, 0);
>> + ? ? ? if (!siic->irq) {
>> + ? ? ? ? ? ? ? err = -EINVAL;
>> + ? ? ? ? ? ? ? goto out;
>> + ? ? ? }
>> + ? ? ? err = devm_request_irq(&pdev->dev, siic->irq, i2c_sirfsoc_irq, 0,
>> + ? ? ? ? ? ? ? dev_name(&pdev->dev), siic);
>> + ? ? ? if (err)
>> + ? ? ? ? ? ? ? goto out;
>> +
>> + ? ? ? new_adapter->algo = &i2c_sirfsoc_algo;
>> + ? ? ? new_adapter->algo_data = siic;
>> +
>> + ? ? ? new_adapter->dev.parent = &pdev->dev;
>> + ? ? ? new_adapter->nr = pdev->id;
>> +
>> + ? ? ? strlcpy(new_adapter->name, "sirfsoc-i2c",
>> sizeof(new_adapter->name));
>> +
>> + ? ? ? platform_set_drvdata(pdev, new_adapter);
>> + ? ? ? init_completion(&siic->done);
>> +
>> + ? ? ? /* Controller Initalisation */
>> +
>> + ? ? ? writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
>> + ? ? ? while (readl(siic->base + SIRFSOC_I2C_CTRL) & SIRFSOC_I2C_RESET)
>> + ? ? ? ? ? ? ? cpu_relax();
>> + ? ? ? writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MASTER_MODE,
>> + ? ? ? ? ? ? ? siic->base + SIRFSOC_I2C_CTRL);
>> +
>> + ? ? ? siic->clk = clk;
>> + ? ? ? siic->speed = SIRFSOC_I2C_DEFAULT_SPEED;
>> + ? ? ? if (siic->speed < 100000)
>> + ? ? ? ? ? ? ? regval =
>> + ? ? ? ? ? ? ? ? ? ? ? (2 * ctrl_speed) / (2 * siic->speed * 11);
>> + ? ? ? else
>> + ? ? ? ? ? ? ? regval = ctrl_speed / (siic->speed * 5);
>> +
>> + ? ? ? writel(regval, siic->base + SIRFSOC_I2C_CLK_CTRL);
>> + ? ? ? if (regval > 0xFF)
>> + ? ? ? ? ? ? ? writel(0xFF, siic->base + SIRFSOC_I2C_SDA_DELAY);
>> + ? ? ? else
>> + ? ? ? ? ? ? ? writel(regval, siic->base + SIRFSOC_I2C_SDA_DELAY);
>> +
>> + ? ? ? err = i2c_add_numbered_adapter(new_adapter);
>> + ? ? ? if (err < 0) {
>> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "Can't add new i2c adapter\n");
>> + ? ? ? ? ? ? ? goto out;
>> + ? ? ? }
>> +
>> + ? ? ? clk_disable(clk);
>> +
>> + ? ? ? dev_info(&pdev->dev, " I2C adapter ready to operate\n");
>> +
>> + ? ? ? return 0;
>> +
>> +out:
>> + ? ? ? clk_disable(clk);
>> +err_clk_en:
>> + ? ? ? clk_unprepare(clk);
>> +err_clk_prep:
>> + ? ? ? clk_put(clk);
>> +err_get_clk:
>
> We are not freeing any allocated memories?

you might want to read Jamie's earlier feedback in v1. that is why we
move to devm_alloc in v2.

>>
>> + ? ? ? return err;
>> +}
>> +
>> +static int __devexit i2c_sirfsoc_remove(struct platform_device *pdev)
>> +{
>> + ? ? ? struct i2c_adapter *adapter = platform_get_drvdata(pdev);
>> + ? ? ? struct sirfsoc_i2c *siic = adapter->algo_data;
>> +
>> + ? ? ? writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
>> + ? ? ? i2c_del_adapter(adapter);
>> + ? ? ? clk_disable(siic->clk);
>> + ? ? ? clk_unprepare(siic->clk);
>> + ? ? ? clk_put(siic->clk);
>> + ? ? ? return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int i2c_sirfsoc_suspend(struct platform_device *pdev, pm_message_t
>> msg)
>> +{
>> + ? ? ? struct i2c_adapter *adapter = platform_get_drvdata(pdev);
>> + ? ? ? struct sirfsoc_i2c *siic = adapter->algo_data;
>> +
>> + ? ? ? clk_enable(siic->clk);
>> + ? ? ? siic->sda_delay = readl(siic->base + SIRFSOC_I2C_SDA_DELAY);
>> + ? ? ? siic->clk_div = readl(siic->base + SIRFSOC_I2C_CLK_CTRL);
>> + ? ? ? clk_disable(siic->clk);
>> + ? ? ? return 0;
>> +}
>> +
>> +static int i2c_sirfsoc_resume(struct platform_device *pdev)
>> +{
>> + ? ? ? struct i2c_adapter *adapter = platform_get_drvdata(pdev);
>> + ? ? ? struct sirfsoc_i2c *siic = adapter->algo_data;
>> +
>> + ? ? ? clk_enable(siic->clk);
>> + ? ? ? writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
>> + ? ? ? writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MASTER_MODE,
>> + ? ? ? ? ? ? ? siic->base + SIRFSOC_I2C_CTRL);
>> + ? ? ? writel(siic->clk_div, siic->base + SIRFSOC_I2C_CLK_CTRL);
>> + ? ? ? writel(siic->sda_delay, siic->base + SIRFSOC_I2C_SDA_DELAY);
>> + ? ? ? clk_disable(siic->clk);
>> + ? ? ? return 0;
>> +}
>> +#else
>> +#define i2c_sirfsoc_suspend ? ?NULL
>> +#define i2c_sirfsoc_resume ? ? NULL
>> +#endif
>> +
>> +static const struct of_device_id sirfsoc_i2c_of_match[] __devinitconst =
>> {
>> + ? ? ? { .compatible = "sirf,prima2-i2c", },
>> + ? ? ? {},
>> +};
>> +MODULE_DEVICE_TABLE(of, sirfsoc_i2c_of_match);
>> +
>> +static struct platform_driver i2c_sirfsoc_driver = {
>> + ? ? ? .driver = {
>> + ? ? ? ? ? ? ? .name = "sirfsoc_i2c",
>> + ? ? ? ? ? ? ? .owner = THIS_MODULE,
>> + ? ? ? ? ? ? ? .of_match_table = sirfsoc_i2c_of_match,
>> + ? ? ? },
>> + ? ? ? .probe = i2c_sirfsoc_probe,
>> + ? ? ? .remove = __devexit_p(i2c_sirfsoc_remove),
>
> Could we move to pm ops ?

i prefer to keep the current way as most people are doing.

-barry
