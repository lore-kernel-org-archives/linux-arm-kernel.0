From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 6 Feb 2012 10:14:57 +0800
Subject: [PATCH v5] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
In-Reply-To: <20120205223757.GA10680@nekote.pengutronix.de>
References: <1327846668-3053-1-git-send-email-21cnbao@gmail.com>
 <20120205223757.GA10680@nekote.pengutronix.de>
Message-ID: <CAGsJ_4yHn1M3s6CPezaW_jwOcsX6NuaZRHcNWX0qnSfhx30AHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Wolfram,
thanks for reviewing.

2012/2/6 Wolfram Sang <ninja@nekote.pengutronix.de>:
> Hi,
> On Sun, Jan 29, 2012 at 10:17:48PM +0800, Barry Song wrote:
>> From: Zhiwu Song <Zhiwu.Song@csr.com>
>>
>> SiRFprimaII is the latest generation application processor from CSR?s
>> multi-function SoC product family.
>> The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
>> 3.0.
>> There are two I2C controllers on primaII, features include:
>> * Two I2C controller modules are on chip
>> * RISC I/O bus read write register
>> * Up to 16 bytes data buffer for issuing commands and writing data
>> ? at the same time
>> * Up to 16 commands, and receiving read data 16 bytes at a time
>> * Error INT report (ACK check)
>> * No-ACK bus protocols (SCCB bus protocols)
>>
>> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
>> Signed-off-by: Xiangzhen Ye <Xiangzhen.Ye@csr.com>
>> Signed-off-by: Yuping Luo <Yuping.Luo@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> Thanks for your contribution! Is there a free datasheet for this controller
> available?

sorry. not available to public yet.

>
>> ---
>> ?-v5: don't disable already disabled clock as pointed out by Russell
>>
>> ?drivers/i2c/busses/Kconfig ? ?| ? 10 +
>> ?drivers/i2c/busses/Makefile ? | ? ?1 +
>> ?drivers/i2c/busses/i2c-sirf.c | ?439 +++++++++++++++++++++++++++++++++++++++++
>> ?drivers/i2c/busses/i2c-sirf.h | ? 61 ++++++
>> ?4 files changed, 511 insertions(+), 0 deletions(-)
>> ?create mode 100644 drivers/i2c/busses/i2c-sirf.c
>> ?create mode 100644 drivers/i2c/busses/i2c-sirf.h
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 3101dd5..a3c43fc 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -618,6 +618,16 @@ config I2C_SH_MOBILE
>> ? ? ? ? This driver can also be built as a module. ?If so, the module
>> ? ? ? ? will be called i2c-sh_mobile.
>>
>> +config I2C_SIRF
>> + ? ? tristate "CSR SiRFprimaII I2C interface"
>> + ? ? depends on ARCH_PRIMA2
>> + ? ? help
>> + ? ? ? If you say yes to this option, support will be included for the
>> + ? ? ? CSR SiRFprimaII I2C interface.
>> +
>> + ? ? ? This driver can also be built as a module. ?If so, the module
>> + ? ? ? will be called i2c-sirf.
>> +
>
> Sorting is broken, same with Makefile.

sorry. i don't get this. I2C_SIRF have be placed in "I2C system bus
drivers (mostly embedded / system-on-chip)" submenu and placed between
"I2C_SH_MOBILE" and "I2C_SIMTEC".
what is the problem?

>
>> ?config I2C_SIMTEC
>> ? ? ? tristate "Simtec Generic I2C interface"
>> ? ? ? select I2C_ALGOBIT
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index fba6da6..c30db66 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -62,6 +62,7 @@ obj-$(CONFIG_I2C_S3C2410) ? += i2c-s3c2410.o
>> ?obj-$(CONFIG_I2C_S6000) ? ? ? ? ? ? ?+= i2c-s6000.o
>> ?obj-$(CONFIG_I2C_SH7760) ? ? += i2c-sh7760.o
>> ?obj-$(CONFIG_I2C_SH_MOBILE) ?+= i2c-sh_mobile.o
>> +obj-$(CONFIG_I2C_SIRF) ? ? ? ? ? ? ? += i2c-sirf.o
>> ?obj-$(CONFIG_I2C_SIMTEC) ? ? += i2c-simtec.o
>> ?obj-$(CONFIG_I2C_STU300) ? ? += i2c-stu300.o
>> ?obj-$(CONFIG_I2C_TEGRA) ? ? ? ? ? ? ?+= i2c-tegra.o
>> diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
>> new file mode 100644
>> index 0000000..6432d35
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-sirf.c
>> @@ -0,0 +1,439 @@
>> +/*
>> + * I2C bus driver for CSR SiRFprimaII
>> + *
>> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/i2c.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +
>> +#include "i2c-sirf.h"
>> +
>> +#define SIRFSOC_I2C_DEFAULT_SPEED ?100000
>> +
>> +struct sirfsoc_i2c {
>> + ? ? void __iomem *base;
>> + ? ? struct clk *clk;
>> + ? ? unsigned long speed; ? ?/* I2C SCL frequency */
>> + ? ? int irq;
>
> Do you really need those two?

irq can be deleted. speed is not really needed if you don't like.

>
>> + ? ? u32 cmd_ptr; ? ? ? ? ? ?/* Current position in CMD buffer */
>> + ? ? u8 *buf; ? ? ? ? ? ? ? ?/* Buffer passed by user */
>> + ? ? u32 msg_len; ? ? ? ? ? ?/* Message length */
>> + ? ? u32 finished_len; ? ? ? /* number of bytes read/written */
>> + ? ? u32 read_cmd_len; ? ? ? /* number of read cmd sent */
>> + ? ? int msg_read; ? ? ? ? ? /* 1 indicates a read message */
>> + ? ? int err_status; ? ? ? ? /* 1 indicates an error on bus */
>> +
>> + ? ? u32 sda_delay; ? ? ? ? ?/* For suspend/resume */
>> + ? ? u32 clk_div;
>> + ? ? int last; ? ? ? ? ? ? ? /* Last message in transfer, STOP cmd can be sent */
>> +
>> + ? ? struct completion done; /* indicates completion of message transfer */
>> + ? ? struct i2c_adapter *adapter;
>
> Why a pointer and not the struct itself?

looks like most people use a struct directly, ok, we can move too.

>
>> +};
>> +
>> +static void i2c_sirfsoc_read_data(struct sirfsoc_i2c *siic)
>> +{
>> + ? ? u32 data = 0;
>> + ? ? int i = 0;
>
> it doesn't need to be initialized. data neither, but compilers fail on that sometimes.
ok.

>
>> +
>> + ? ? for (i = 0; i < siic->read_cmd_len; i++) {
>> + ? ? ? ? ? ? if (!(i & 0x3))
>> + ? ? ? ? ? ? ? ? ? ? data = readl(siic->base + SIRFSOC_I2C_DATA_BUF + i);
>> + ? ? ? ? ? ? siic->buf[siic->finished_len++] =
>> + ? ? ? ? ? ? ? ? ? ? (unsigned char)((data & SIRFSOC_I2C_DATA_MASK(i)) >>
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? SIRFSOC_I2C_DATA_SHIFT(i));
>
> buf is declared u8.

ok.
siic->buf[siic->finished_len++] =
                        (u8)((data & SIRFSOC_I2C_DATA_MASK(i)) >>
                                SIRFSOC_I2C_DATA_SHIFT(i));

>
>> +
>> + ? ? ? ? ? ? BUG_ON(siic->finished_len > siic->msg_len);
>
> BUG? Can't we handle this more gracefully?

this should not have happened. if it happens, there is something wrong
in SW. actually, i can totally delete it.

>
>> + ? ? }
>> +}
>> +
>> +static void i2c_sirfsoc_queue_cmd(struct sirfsoc_i2c *siic)
>> +{
>> + ? ? u32 regval;
>> + ? ? int i = 0;
>> +
>> + ? ? if (siic->msg_read) {
>> + ? ? ? ? ? ? while (((siic->finished_len + i) < siic->msg_len)
>> + ? ? ? ? ? ? ? ? ? ? && (siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)) {
>
> Either use a different indentation for the above line or add a newline below.
> It is hard to see where the while() ends and the code block starts.

i just want to make sure what you want is:

             while (((siic->finished_len + i) < siic->msg_len)
                     &&(siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)
                     ) {
?
or something else?

>
>> + ? ? ? ? ? ? ? ? ? ? regval = SIRFSOC_I2C_READ | SIRFSOC_I2C_CMD_RP(0);
>> + ? ? ? ? ? ? ? ? ? ? if (((siic->finished_len + i) ==
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (siic->msg_len - 1)) && siic->last)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? regval |= SIRFSOC_I2C_STOP | SIRFSOC_I2C_NACK;
>> + ? ? ? ? ? ? ? ? ? ? writel(regval,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
>> + ? ? ? ? ? ? ? ? ? ? i++;
>> + ? ? ? ? ? ? }
>> +
>> + ? ? ? ? ? ? siic->read_cmd_len = i;
>> + ? ? } else {
>> + ? ? ? ? ? ? while ((siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX - 1)
>> + ? ? ? ? ? ? ? ? ? ? && (siic->finished_len < siic->msg_len)) {
>> + ? ? ? ? ? ? ? ? ? ? regval = SIRFSOC_I2C_WRITE | SIRFSOC_I2C_CMD_RP(0);
>> + ? ? ? ? ? ? ? ? ? ? if ((siic->finished_len == (siic->msg_len - 1))
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? && siic->last)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? regval |= SIRFSOC_I2C_STOP;
>> + ? ? ? ? ? ? ? ? ? ? writel(regval,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
>> + ? ? ? ? ? ? ? ? ? ? writel(siic->buf[siic->finished_len++],
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
>> + ? ? ? ? ? ? }
>> + ? ? }
>> + ? ? siic->cmd_ptr = 0;
>> +
>> + ? ? /* Trigger the transfer */
>> + ? ? writel(SIRFSOC_I2C_START_CMD, siic->base + SIRFSOC_I2C_CMD_START);
>> +}
>> +
>> +static irqreturn_t i2c_sirfsoc_irq(int irq, void *dev_id)
>> +{
>> + ? ? struct sirfsoc_i2c *siic = (struct sirfsoc_i2c *)dev_id;
>
> No need to cast.

ok.

>
>> + ? ? u32 i2c_stat = readl(siic->base + SIRFSOC_I2C_STATUS);
>> +
>> + ? ? if (i2c_stat & SIRFSOC_I2C_STAT_ERR) {
>> + ? ? ? ? ? ? /* Error conditions */
>> + ? ? ? ? ? ? siic->err_status = 1;
>> + ? ? ? ? ? ? writel(SIRFSOC_I2C_STAT_ERR, siic->base + SIRFSOC_I2C_STATUS);
>> +
>> + ? ? ? ? ? ? if (i2c_stat & SIRFSOC_I2C_STAT_NACK)
>> + ? ? ? ? ? ? ? ? ? ? dev_err(&siic->adapter->dev, "ACK not received\n");
>> + ? ? ? ? ? ? else
>> + ? ? ? ? ? ? ? ? ? ? dev_err(&siic->adapter->dev, "I2C error\n");
>> +
>> + ? ? ? ? ? ? complete(&siic->done);
>> + ? ? } else if (i2c_stat & SIRFSOC_I2C_STAT_CMD_DONE) {
>> + ? ? ? ? ? ? /* CMD buffer execution complete */
>> + ? ? ? ? ? ? if (siic->msg_read)
>> + ? ? ? ? ? ? ? ? ? ? i2c_sirfsoc_read_data(siic);
>> + ? ? ? ? ? ? if (siic->finished_len == siic->msg_len)
>> + ? ? ? ? ? ? ? ? ? ? complete(&siic->done);
>> + ? ? ? ? ? ? else /* Fill a new CMD buffer for left data */
>> + ? ? ? ? ? ? ? ? ? ? i2c_sirfsoc_queue_cmd(siic);
>> +
>> + ? ? ? ? ? ? writel(SIRFSOC_I2C_STAT_CMD_DONE, siic->base + SIRFSOC_I2C_STATUS);
>> + ? ? }
>> +
>> + ? ? return IRQ_HANDLED;
>> +}
>> +
>> +static void i2c_sirfsoc_set_address(struct sirfsoc_i2c *siic,
>> + ? ? struct i2c_msg *msg)
>> +{
>> + ? ? unsigned char addr;
>> + ? ? u32 regval = SIRFSOC_I2C_START | SIRFSOC_I2C_CMD_RP(0) | SIRFSOC_I2C_WRITE;
>> +
>> + ? ? /* no data and last message -> add STOP */
>> + ? ? if (siic->last && (msg->len == 0))
>> + ? ? ? ? ? ? regval |= SIRFSOC_I2C_STOP;
>> +
>> + ? ? writel(regval, siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
>> +
>> + ? ? addr = msg->addr << 1; ?/* Generate address */
>> + ? ? if (msg->flags & I2C_M_RD)
>> + ? ? ? ? ? ? addr |= 1;
>> + ? ? if (msg->flags & I2C_M_REV_DIR_ADDR) ? ?/* Reverse direction bit */
>> + ? ? ? ? ? ? addr ^= 1;
>
> You don't support MANGLING according to .functionality().

ok.

>
>> +
>> + ? ? writel(addr, siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
>> +}
>> +
>> +static int i2c_sirfsoc_xfer_msg(struct sirfsoc_i2c *siic, struct i2c_msg *msg)
>> +{
>> + ? ? u32 regval = readl(siic->base + SIRFSOC_I2C_CTRL);
>> + ? ? int timeout = (msg->len + 1) * 50;
>
> That looks broken. What is 50 here?

just multiple of xfer bytes for defining a timeout. i might have a comment here.

>
>> + ? ? int ret = 0;
>> +
>> + ? ? i2c_sirfsoc_set_address(siic, msg);
>> +
>> + ? ? writel(regval | SIRFSOC_I2C_CMD_DONE_EN | SIRFSOC_I2C_ERR_INT_EN,
>> + ? ? ? ? ? ? siic->base + SIRFSOC_I2C_CTRL);
>> + ? ? i2c_sirfsoc_queue_cmd(siic);
>> +
>> + ? ? if (wait_for_completion_timeout(&siic->done, timeout) == 0) {
>> + ? ? ? ? ? ? siic->err_status = 1;
>> + ? ? ? ? ? ? dev_err(&siic->adapter->dev, "Transfer timeout\n");
>> + ? ? }
>> +
>> + ? ? writel(regval & ~(SIRFSOC_I2C_CMD_DONE_EN | SIRFSOC_I2C_ERR_INT_EN),
>> + ? ? ? ? ? ? siic->base + SIRFSOC_I2C_CTRL);
>> + ? ? writel(0, siic->base + SIRFSOC_I2C_CMD_START);
>> +
>> + ? ? if (siic->err_status) {
>> + ? ? ? ? ? ? writel(readl(siic->base + SIRFSOC_I2C_CTRL) | SIRFSOC_I2C_RESET,
>> + ? ? ? ? ? ? ? ? ? ? siic->base + SIRFSOC_I2C_CTRL);
>> + ? ? ? ? ? ? while (readl(siic->base + SIRFSOC_I2C_CTRL) & SIRFSOC_I2C_RESET)
>> + ? ? ? ? ? ? ? ? ? ? cpu_relax();
>> +
>> + ? ? ? ? ? ? ret = -EIO;
>> + ? ? }
>> +
>> + ? ? return ret;
>> +}
>> +
>> +static u32 i2c_sirfsoc_func(struct i2c_adapter *adap)
>> +{
>> + ? ? return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>> +}
>> +
>> +static int i2c_sirfsoc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>> + ? ? int num)
>> +{
>> + ? ? struct sirfsoc_i2c *siic = adap->algo_data;
>> + ? ? int i, ret;
>> +
>> + ? ? clk_enable(siic->clk);
>> +
>> + ? ? for (i = 0; i < num; i++) {
>> + ? ? ? ? ? ? siic->buf = msgs[i].buf;
>> + ? ? ? ? ? ? siic->msg_len = msgs[i].len;
>> +
>> + ? ? ? ? ? ? if (msgs[i].flags & I2C_M_RD)
>> + ? ? ? ? ? ? ? ? ? ? siic->msg_read = 1;
>> + ? ? ? ? ? ? else
>> + ? ? ? ? ? ? ? ? ? ? siic->msg_read = 0;
>
> siic->msg_read = !!(flag & mask)?
>
>> +
>> + ? ? ? ? ? ? siic->err_status = 0;
>> + ? ? ? ? ? ? siic->cmd_ptr = 0;
>> + ? ? ? ? ? ? siic->finished_len = 0;
>> + ? ? ? ? ? ? if (i == (num - 1))
>> + ? ? ? ? ? ? ? ? ? ? siic->last = 1;
>> + ? ? ? ? ? ? else
>> + ? ? ? ? ? ? ? ? ? ? siic->last = 0;
>> +
>
> siic->last = i == (num - 1)?

ok.

>
>> + ? ? ? ? ? ? ret = i2c_sirfsoc_xfer_msg(siic, &msgs[i]);
>> + ? ? ? ? ? ? if (ret) {
>> + ? ? ? ? ? ? ? ? ? ? clk_disable(siic->clk);
>> + ? ? ? ? ? ? ? ? ? ? return ret;
>> + ? ? ? ? ? ? }
>> + ? ? }
>> +
>> + ? ? clk_disable(siic->clk);
>> + ? ? return num;
>> +}
>> +
>> +/* I2C algorithms associated with this master controller driver */
>> +static const struct i2c_algorithm i2c_sirfsoc_algo = {
>> + ? ? .master_xfer = i2c_sirfsoc_xfer,
>> + ? ? .functionality = i2c_sirfsoc_func,
>> +};
>> +
>> +static int __devinit i2c_sirfsoc_probe(struct platform_device *pdev)
>> +{
>> + ? ? struct sirfsoc_i2c *siic;
>> + ? ? struct i2c_adapter *new_adapter;
>> + ? ? struct resource *mem_res;
>> + ? ? struct clk *clk;
>> + ? ? int ctrl_speed;
>> +
>> + ? ? int err;
>> + ? ? u32 regval;
>> +
>> + ? ? clk = clk_get(&pdev->dev, NULL);
>> + ? ? if (IS_ERR(clk)) {
>> + ? ? ? ? ? ? err = PTR_ERR(clk);
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "Clock get failed\n");
>> + ? ? ? ? ? ? goto err_get_clk;
>> + ? ? }
>> +
>> + ? ? err = clk_prepare(clk);
>> + ? ? if (err) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "Clock prepare failed\n");
>> + ? ? ? ? ? ? goto ?err_clk_prep;
>
> Double space. Not only here.

ok. fix.

>
>> + ? ? }
>> +
>> + ? ? err = clk_enable(clk);
>> + ? ? if (err) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "Clock enable failed\n");
>> + ? ? ? ? ? ? goto ?err_clk_en;
>> + ? ? }
>> +
>> + ? ? ctrl_speed = clk_get_rate(clk);
>> +
>> + ? ? new_adapter = devm_kzalloc(&pdev->dev, sizeof(*new_adapter), GFP_KERNEL);
>> + ? ? if (!new_adapter) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev,
>> + ? ? ? ? ? ? ? ? ? ? "Can't allocate new i2c adapter!\n");
>> + ? ? ? ? ? ? err = -ENOMEM;
>> + ? ? ? ? ? ? goto out;
>> + ? ? }
>> +
>> + ? ? siic = devm_kzalloc(&pdev->dev, sizeof(*siic), GFP_KERNEL);
>> + ? ? if (!siic) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "Can't allocate driver data\n");
>> + ? ? ? ? ? ? err = -ENOMEM;
>> + ? ? ? ? ? ? goto out;
>> + ? ? }
>> + ? ? new_adapter->class = I2C_CLASS_HWMON | I2C_CLASS_DDC | I2C_CLASS_SPD;
>
> Do you really need the class?
>
>> + ? ? siic->adapter = new_adapter;
>> +
>> + ? ? mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + ? ? if (mem_res == NULL) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "Unable to get MEM resource\n");
>> + ? ? ? ? ? ? err = -EINVAL;
>> + ? ? ? ? ? ? goto out;
>> + ? ? }
>> +
>> + ? ? siic->base = devm_request_and_ioremap(&pdev->dev, mem_res);
>> + ? ? if (siic->base == NULL) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "IO remap failed!\n");
>> + ? ? ? ? ? ? err = -ENOMEM;
>> + ? ? ? ? ? ? goto out;
>> + ? ? }
>> +
>> + ? ? siic->irq = platform_get_irq(pdev, 0);
>> + ? ? if (siic->irq < 0) {
>> + ? ? ? ? ? ? err = -EINVAL;
>> + ? ? ? ? ? ? goto out;
>> + ? ? }
>
> return the error code here?

out lable will free resources and return error code.
out:
        clk_disable(clk);
err_clk_en:
        clk_unprepare(clk);
err_clk_prep:
        clk_put(clk);
err_get_clk:
        return err;

>
>> + ? ? err = devm_request_irq(&pdev->dev, siic->irq, i2c_sirfsoc_irq, 0,
>> + ? ? ? ? ? ? dev_name(&pdev->dev), siic);
>> + ? ? if (err)
>> + ? ? ? ? ? ? goto out;
>> +
>> + ? ? new_adapter->algo = &i2c_sirfsoc_algo;
>> + ? ? new_adapter->algo_data = siic;
>> +
>> + ? ? new_adapter->dev.parent = &pdev->dev;
>> + ? ? new_adapter->nr = pdev->id;
>> +
>> + ? ? strlcpy(new_adapter->name, "sirfsoc-i2c", sizeof(new_adapter->name));
>> +
>> + ? ? platform_set_drvdata(pdev, new_adapter);
>> + ? ? init_completion(&siic->done);
>> +
>> + ? ? /* Controller Initalisation */
>> +
>> + ? ? writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
>> + ? ? while (readl(siic->base + SIRFSOC_I2C_CTRL) & SIRFSOC_I2C_RESET)
>> + ? ? ? ? ? ? cpu_relax();
>> + ? ? writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MASTER_MODE,
>> + ? ? ? ? ? ? siic->base + SIRFSOC_I2C_CTRL);
>> +
>> + ? ? siic->clk = clk;
>> + ? ? siic->speed = SIRFSOC_I2C_DEFAULT_SPEED;
>> + ? ? if (siic->speed < 100000)
>> + ? ? ? ? ? ? regval =
>> + ? ? ? ? ? ? ? ? ? ? (2 * ctrl_speed) / (2 * siic->speed * 11);
>> + ? ? else
>> + ? ? ? ? ? ? regval = ctrl_speed / (siic->speed * 5);
>> +
>> + ? ? writel(regval, siic->base + SIRFSOC_I2C_CLK_CTRL);
>> + ? ? if (regval > 0xFF)
>> + ? ? ? ? ? ? writel(0xFF, siic->base + SIRFSOC_I2C_SDA_DELAY);
>> + ? ? else
>> + ? ? ? ? ? ? writel(regval, siic->base + SIRFSOC_I2C_SDA_DELAY);
>> +
>> + ? ? err = i2c_add_numbered_adapter(new_adapter);
>> + ? ? if (err < 0) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "Can't add new i2c adapter\n");
>> + ? ? ? ? ? ? goto out;
>> + ? ? }
>> +
>> + ? ? clk_disable(clk);
>> +
>> + ? ? dev_info(&pdev->dev, " I2C adapter ready to operate\n");
>> +
>> + ? ? return 0;
>> +
>> +out:
>> + ? ? clk_disable(clk);
>> +err_clk_en:
>> + ? ? clk_unprepare(clk);
>> +err_clk_prep:
>> + ? ? clk_put(clk);
>> +err_get_clk:
>> + ? ? return err;
>> +}
>> +
>> +static int __devexit i2c_sirfsoc_remove(struct platform_device *pdev)
>> +{
>> + ? ? struct i2c_adapter *adapter = platform_get_drvdata(pdev);
>> + ? ? struct sirfsoc_i2c *siic = adapter->algo_data;
>> +
>> + ? ? writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
>> + ? ? i2c_del_adapter(adapter);
>> + ? ? clk_unprepare(siic->clk);
>> + ? ? clk_put(siic->clk);
>> + ? ? return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int i2c_sirfsoc_suspend(struct device *dev)
>> +{
>> + ? ? struct platform_device *pdev = to_platform_device(dev);
>> + ? ? struct i2c_adapter *adapter = platform_get_drvdata(pdev);
>> + ? ? struct sirfsoc_i2c *siic = adapter->algo_data;
>> +
>> + ? ? clk_enable(siic->clk);
>> + ? ? siic->sda_delay = readl(siic->base + SIRFSOC_I2C_SDA_DELAY);
>> + ? ? siic->clk_div = readl(siic->base + SIRFSOC_I2C_CLK_CTRL);
>> + ? ? clk_disable(siic->clk);
>> + ? ? return 0;
>> +}
>> +
>> +static int i2c_sirfsoc_resume(struct device *dev)
>> +{
>> + ? ? struct platform_device *pdev = to_platform_device(dev);
>> + ? ? struct i2c_adapter *adapter = platform_get_drvdata(pdev);
>> + ? ? struct sirfsoc_i2c *siic = adapter->algo_data;
>> +
>> + ? ? clk_enable(siic->clk);
>> + ? ? writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
>> + ? ? writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MASTER_MODE,
>> + ? ? ? ? ? ? siic->base + SIRFSOC_I2C_CTRL);
>> + ? ? writel(siic->clk_div, siic->base + SIRFSOC_I2C_CLK_CTRL);
>> + ? ? writel(siic->sda_delay, siic->base + SIRFSOC_I2C_SDA_DELAY);
>> + ? ? clk_disable(siic->clk);
>> + ? ? return 0;
>> +}
>> +
>> +static const struct dev_pm_ops i2c_sirfsoc_pm_ops = {
>> + ? ? .suspend = i2c_sirfsoc_suspend,
>> + ? ? .resume = i2c_sirfsoc_resume,
>> +};
>> +#endif
>> +
>> +static const struct of_device_id sirfsoc_i2c_of_match[] __devinitconst = {
>> + ? ? { .compatible = "sirf,prima2-i2c", },
>> + ? ? {},
>> +};
>
> Is the binding documented?

miss this. will add.

>
>> +MODULE_DEVICE_TABLE(of, sirfsoc_i2c_of_match);
>> +
>> +static struct platform_driver i2c_sirfsoc_driver = {
>> + ? ? .driver = {
>> + ? ? ? ? ? ? .name = "sirfsoc_i2c",
>> + ? ? ? ? ? ? .owner = THIS_MODULE,
>> +#ifdef CONFIG_PM
>> + ? ? ? ? ? ? .pm = &i2c_sirfsoc_pm_ops,
>> +#endif
>> + ? ? ? ? ? ? .of_match_table = sirfsoc_i2c_of_match,
>> + ? ? },
>> + ? ? .probe = i2c_sirfsoc_probe,
>> + ? ? .remove = __devexit_p(i2c_sirfsoc_remove),
>> +};
>> +
>> +static int __init i2c_sirfsoc_init(void)
>> +{
>> + ? ? return platform_driver_register(&i2c_sirfsoc_driver);
>> +}
>> +arch_initcall(i2c_sirfsoc_init);
>> +
>> +static void __exit i2c_sirfsoc_exit(void)
>> +{
>> + ? ? platform_driver_unregister(&i2c_sirfsoc_driver);
>> +}
>> +module_exit(i2c_sirfsoc_exit);
>
> module_platform_driver()

ok.

>
>> +
>> +MODULE_DESCRIPTION("SiRF SoC I2C master controller driver");
>> +MODULE_AUTHOR("Zhiwu Song <Zhiwu.Song@csr.com>, "
>> + ? ? "Xiangzhen Ye <Xiangzhen.Ye@csr.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/i2c/busses/i2c-sirf.h b/drivers/i2c/busses/i2c-sirf.h
>> new file mode 100644
>> index 0000000..28f4ada
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-sirf.h
>> @@ -0,0 +1,61 @@
>> +/*
>> + * I2C bus drivers for CSR SiRFprimaII
>> + *
>> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#ifndef _SIRFSOC_I2C_BUS_H_
>> +#define _SIRFSOC_I2C_BUS_H_
>> +
>> +#include <linux/bitops.h>
>> +
>> +#define SIRFSOC_I2C_CLK_CTRL ? ? ? ? 0x00
>> +#define SIRFSOC_I2C_STATUS ? ? ? ? ? 0x0C
>> +#define SIRFSOC_I2C_CTRL ? ? ? ? ? ? 0x10
>> +#define SIRFSOC_I2C_IO_CTRL ? ? ? ? ?0x14
>> +#define SIRFSOC_I2C_SDA_DELAY ? ? ? ? ? ? ? ?0x18
>> +#define SIRFSOC_I2C_CMD_START ? ? ? ? ? ? ? ?0x1C
>> +#define SIRFSOC_I2C_CMD_BUF ? ? ? ? ?0x30
>> +#define SIRFSOC_I2C_DATA_BUF ? ? ? ? 0x80
>> +
>> +#define SIRFSOC_I2C_CMD_BUF_MAX ? ? ? ? ? ? ?16
>> +#define SIRFSOC_I2C_DATA_BUF_MAX ? ? 16
>> +
>> +#define SIRFSOC_I2C_CMD(x) ? ? ? ? ? (SIRFSOC_I2C_CMD_BUF + (x)*0x04)
>> +#define SIRFSOC_I2C_DATA_MASK(x) ? ? ? ?(0xFF<<(((x)&3)*8))
>> +#define SIRFSOC_I2C_DATA_SHIFT(x) ? ? ? (((x)&3)*8)
>> +
>> +#define SIRFSOC_I2C_DIV_MASK ? ? ? ? (0xFFFF)
>> +
>> +/* I2C status flags */
>> +#define SIRFSOC_I2C_STAT_BUSY ? ? ? ? ? ? ? ?BIT(0)
>> +#define SIRFSOC_I2C_STAT_TIP ? ? ? ? BIT(1)
>> +#define SIRFSOC_I2C_STAT_NACK ? ? ? ? ? ? ? ?BIT(2)
>> +#define SIRFSOC_I2C_STAT_TR_INT ? ? ? ? ? ? ?BIT(4)
>> +#define SIRFSOC_I2C_STAT_STOP ? ? ? ? ? ? ? ?BIT(6)
>> +#define SIRFSOC_I2C_STAT_CMD_DONE ? ?BIT(8)
>> +#define SIRFSOC_I2C_STAT_ERR ? ? ? ? BIT(9)
>> +#define SIRFSOC_I2C_CMD_INDEX ? ? ? ? ? ? ? ?(0x1F<<16)
>> +
>> +/* I2C control flags */
>> +#define SIRFSOC_I2C_RESET ? ? ? ? ? ?BIT(0)
>> +#define SIRFSOC_I2C_CORE_EN ? ? ? ? ?BIT(1)
>> +#define SIRFSOC_I2C_MASTER_MODE ? ? ? ? ? ? ?BIT(2)
>> +#define SIRFSOC_I2C_CMD_DONE_EN ? ? ? ? ? ? ?BIT(11)
>> +#define SIRFSOC_I2C_ERR_INT_EN ? ? ? ? ? ? ? BIT(12)
>> +
>> +#define SIRFSOC_I2C_SDA_DELAY_MASK ? (0xFF)
>> +#define SIRFSOC_I2C_SCLF_FILTER ? ? ? ? ? ? ?(3<<8)
>> +
>> +#define SIRFSOC_I2C_START_CMD ? ? ? ? ? ? ? ?BIT(0)
>> +
>> +#define SIRFSOC_I2C_CMD_RP(x) ? ? ? ? ? ? ? ?((x)&0x7)
>> +#define SIRFSOC_I2C_NACK ? ? ? ? ? ? BIT(3)
>> +#define SIRFSOC_I2C_WRITE ? ? ? ? ? ?BIT(4)
>> +#define SIRFSOC_I2C_READ ? ? ? ? ? ? BIT(5)
>> +#define SIRFSOC_I2C_STOP ? ? ? ? ? ? BIT(6)
>> +#define SIRFSOC_I2C_START ? ? ? ? ? ?BIT(7)
>> +
>> +#endif
>
> Regards,
>
> ? Wolfram

-barry
