From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Mon, 19 Sep 2016 10:00:27 +0200
Subject: [PATCH v2 1/3] ipmi: add an Aspeed BT IPMI BMC driver
In-Reply-To: <08e9b30f-6c35-8418-a8b0-0b63639dd36d@acm.org>
References: <1474022367-21029-1-git-send-email-clg@kaod.org>
 <1474022367-21029-2-git-send-email-clg@kaod.org>
 <08e9b30f-6c35-8418-a8b0-0b63639dd36d@acm.org>
Message-ID: <9ce54c4c-e8ae-7ac2-de9c-71402dfa4c39@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2016 09:41 PM, Corey Minyard wrote:
> On 09/16/2016 05:39 AM, C?dric Le Goater wrote:
>> From: Alistair Popple <alistair@popple.id.au>
>>
>> This patch adds a simple device driver to expose the iBT interface on
>> Aspeed SOCs (AST2400 and AST2500) as a character device. Such SOCs are
>> commonly used as BMCs (BaseBoard Management Controllers) and this
>> driver implements the BMC side of the BT interface.
>>
>> The BT (Block Transfer) interface is used to perform in-band IPMI
>> communication between a host and its BMC. Entire messages are buffered
>> before sending a notification to the other end, host or BMC, that
>> there is data to be read. Usually, the host emits requests and the BMC
>> responses but the specification provides a mean for the BMC to send
>> SMS Attention (BMC-to-Host attention or System Management Software
>> attention) messages.
>>
>> For this purpose, the driver introduces a specific ioctl on the
>> device: 'BT_BMC_IOCTL_SMS_ATN' that can be used by the system running
>> on the BMC to signal the host of such an event.
>>
>> The device name defaults to '/dev/ipmi-bt-host'
> 
> Others have reviewed this for style and such, and I have looked
> at it from a protocol point of view.  it looks to be sound for the
> most part.  I have some higher level concerns:
> 
> There appears to be no handling for multiple simultaneous users.
> This interface can only be used by one task at a time, so you should
> probably only allow one opener.  Well, I guess the BMC could be split
> into a reader and a writer task, so I'm not really sure about that, but
> I would think in most situations having more than one opener is a
> bug.  You do call clr_b_busy() on open, for instance, which might be
> an issue for multiple openers.  Maybe a module parameter for
> maximum number of openers? Just want to make sure this was
> thought about, at least.

yes but not implemented ... The open_count in the bt_bmc structure 
is unused. In v3, I will replace it with a global atomic_t tracked 
in the open and release operations. 

> There is also no mutex protecting reading or writing.  If multiple
> threads call read or write at the same time, it probably wouldn't
> work correctly.  I think you need a read and a write mutex on the
> interface to protect against this.

yes. I will add a mutex also in v3.

> The spec says:
> 
>    The BMC must not return a given response once the corresponding
>    Request-to-Response interval has passed. The BMC can ensure this
>    by maintaining its own internal list of outstanding requests through
>    the interface. The BMC could age and expire the entries in the list
>    by expiring the entries at an interval that is somewhat shorter than
>    the specified Request-to-Response interval....

This is clearly not handled in the driver. 

For this purpose, we could maintain a request expiry list using the seq 
field of the BT message. Update the list in the read and write operations 
and arm a timer to garbage collect any left overs. As for the errno in
the write when a response had timeout'ed, may be ETIMEDOUT ? 

For configuration of the maximum response time, a sysfs file would do
I think.

Do you want that in v3 also ? I have some experimental patches for it,
that I can send as follow ups.

Thanks,

C. 

> On the write side, though, there doesn't seem to be a way to handle a
> situation where the host side doesn't respond for a while and the
> pending message would need to be discarded.
> 
> The spec doesn't mention much about error recovery on this interface,
> but the way this is written should be fine, I think.
> 
> I'm copying Rocky Craig, who wrote the host side driver for Linux, in
> case he wants to comment on this.
> 
> This is easy to read and understand, so I think v3 should be good.
> 
> Thanks,
> 
> -corey
> 
>> Signed-off-by: Alistair Popple <alistair@popple.id.au>
>> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> [clg: - checkpatch fixes
>>        - added a devicetree binding documentation
>>        - replace 'bt_host' by 'bt_bmc' to reflect that the driver is
>>          the BMC side of the IPMI BT interface
>>        - renamed the device to 'ipmi-bt-host'
>>        - introduced a temporary buffer to copy_{to,from}_user
>>        - used platform_get_irq()
>>        - moved the driver under drivers/char/ipmi/ but kept it as a misc
>>          device
>>        - changed the compatible cell to "aspeed,ast2400-bt-bmc"
>> ]
>> Signed-off-by: C?dric Le Goater <clg@kaod.org>
>> ---
>>
>>   Changes since v1:
>>
>>   - replace 'bt_host' by 'bt_bmc' to reflect that the driver is
>>     the BMC side of the IPMI BT interface
>>   - renamed the device to 'ipmi-bt-host'
>>   - introduced a temporary buffer to copy_{to,from}_user
>>   - used platform_get_irq()
>>   - moved the driver under drivers/char/ipmi/ but kept it as a misc
>>     device
>>   - changed the compatible cell to "aspeed,ast2400-bt-bmc"
>>
>>   .../bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt   |  23 +
>>   drivers/Makefile                                   |   2 +-
>>   drivers/char/ipmi/Kconfig                          |   7 +
>>   drivers/char/ipmi/Makefile                         |   1 +
>>   drivers/char/ipmi/bt-bmc.c                         | 486 +++++++++++++++++++++
>>   include/uapi/linux/Kbuild                          |   1 +
>>   include/uapi/linux/bt-bmc.h                        |  18 +
>>   7 files changed, 537 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/devicetree/bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt
>>   create mode 100644 drivers/char/ipmi/bt-bmc.c
>>   create mode 100644 include/uapi/linux/bt-bmc.h
>>
>> diff --git a/Documentation/devicetree/bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt b/Documentation/devicetree/bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt
>> new file mode 100644
>> index 000000000000..fbbacd958240
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt
>> @@ -0,0 +1,23 @@
>> +* Aspeed BT (Block Transfer) IPMI interface
>> +
>> +The Aspeed SOCs (AST2400 and AST2500) are commonly used as BMCs
>> +(BaseBoard Management Controllers) and the BT interface can be used to
>> +perform in-band IPMI communication with their host.
>> +
>> +Required properties:
>> +
>> +- compatible : should be "aspeed,ast2400-bt-bmc"
>> +- reg: physical address and size of the registers
>> +
>> +Optional properties:
>> +
>> +- interrupts: interrupt generated by the BT interface. without an
>> +  interrupt, the driver will operate in poll mode.
>> +
>> +Example:
>> +
>> +    ibt at 1e789140 {
>> +        compatible = "aspeed,ast2400-bt-bmc";
>> +        reg = <0x1e789140 0x18>;
>> +        interrupts = <8>;
>> +    };
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index 53abb4a5f736..5a9e7b6b7928 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -21,7 +21,7 @@ obj-y                += video/
>>   obj-y                += idle/
>>     # IPMI must come before ACPI in order to provide IPMI opregion support
>> -obj-$(CONFIG_IPMI_HANDLER)    += char/ipmi/
>> +obj-y                += char/ipmi/
>>     obj-$(CONFIG_ACPI)        += acpi/
>>   obj-$(CONFIG_SFI)        += sfi/
>> diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
>> index 5a9350b1069a..2c234e3e7513 100644
>> --- a/drivers/char/ipmi/Kconfig
>> +++ b/drivers/char/ipmi/Kconfig
>> @@ -76,3 +76,10 @@ config IPMI_POWEROFF
>>        the IPMI management controller is capable of this.
>>     endif # IPMI_HANDLER
>> +
>> +config ASPEED_BT_IPMI_BMC
>> +    tristate "BT IPMI bmc driver"
>> +    help
>> +      Provides a driver for the BT (Block Transfer) IPMI interface
>> +      found on Aspeed SOCs (AST2400 and AST2500). The driver
>> +      implements the BMC side of the BT interface.
>> diff --git a/drivers/char/ipmi/Makefile b/drivers/char/ipmi/Makefile
>> index f3ffde1f5f1f..0d98cd91def1 100644
>> --- a/drivers/char/ipmi/Makefile
>> +++ b/drivers/char/ipmi/Makefile
>> @@ -11,3 +11,4 @@ obj-$(CONFIG_IPMI_SSIF) += ipmi_ssif.o
>>   obj-$(CONFIG_IPMI_POWERNV) += ipmi_powernv.o
>>   obj-$(CONFIG_IPMI_WATCHDOG) += ipmi_watchdog.o
>>   obj-$(CONFIG_IPMI_POWEROFF) += ipmi_poweroff.o
>> +obj-$(CONFIG_ASPEED_BT_IPMI_BMC) += bt-bmc.o
>> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
>> new file mode 100644
>> index 000000000000..b96cb421e1c2
>> --- /dev/null
>> +++ b/drivers/char/ipmi/bt-bmc.c
>> @@ -0,0 +1,486 @@
>> +/*
>> + * Copyright (c) 2015-2016, IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/errno.h>
>> +#include <linux/poll.h>
>> +#include <linux/sched.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/slab.h>
>> +#include <linux/init.h>
>> +#include <linux/device.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/timer.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/bt-bmc.h>
>> +
>> +/*
>> + * This is a BMC device used to communicate to the host
>> + */
>> +#define DEVICE_NAME    "ipmi-bt-host"
>> +
>> +#define BT_IO_BASE    0xe4
>> +#define BT_IRQ        10
>> +
>> +#define BT_CR0        0x0
>> +#define   BT_CR0_IO_BASE        16
>> +#define   BT_CR0_IRQ            12
>> +#define   BT_CR0_EN_CLR_SLV_RDP        0x8
>> +#define   BT_CR0_EN_CLR_SLV_WRP        0x4
>> +#define   BT_CR0_ENABLE_IBT        0x1
>> +#define BT_CR1        0x4
>> +#define   BT_CR1_IRQ_H2B    0x01
>> +#define   BT_CR1_IRQ_HBUSY    0x40
>> +#define BT_CR2        0x8
>> +#define   BT_CR2_IRQ_H2B    0x01
>> +#define   BT_CR2_IRQ_HBUSY    0x40
>> +#define BT_CR3        0xc
>> +#define BT_CTRL        0x10
>> +#define   BT_CTRL_B_BUSY        0x80
>> +#define   BT_CTRL_H_BUSY        0x40
>> +#define   BT_CTRL_OEM0            0x20
>> +#define   BT_CTRL_SMS_ATN        0x10
>> +#define   BT_CTRL_B2H_ATN        0x08
>> +#define   BT_CTRL_H2B_ATN        0x04
>> +#define   BT_CTRL_CLR_RD_PTR        0x02
>> +#define   BT_CTRL_CLR_WR_PTR        0x01
>> +#define BT_BMC2HOST    0x14
>> +#define BT_INTMASK    0x18
>> +#define   BT_INTMASK_B2H_IRQEN        0x01
>> +#define   BT_INTMASK_B2H_IRQ        0x02
>> +#define   BT_INTMASK_BMC_HWRST        0x80
>> +
>> +struct bt_bmc {
>> +    struct device        dev;
>> +    struct miscdevice    miscdev;
>> +    void __iomem        *base;
>> +    int            open_count;
>> +    int            irq;
>> +    wait_queue_head_t    queue;
>> +    struct timer_list    poll_timer;
>> +};
>> +
>> +static u8 bt_inb(struct bt_bmc *bt_bmc, int reg)
>> +{
>> +    return ioread8(bt_bmc->base + reg);
>> +}
>> +
>> +static void bt_outb(struct bt_bmc *bt_bmc, u8 data, int reg)
>> +{
>> +    iowrite8(data, bt_bmc->base + reg);
>> +}
>> +
>> +static void clr_rd_ptr(struct bt_bmc *bt_bmc)
>> +{
>> +    bt_outb(bt_bmc, BT_CTRL_CLR_RD_PTR, BT_CTRL);
>> +}
>> +
>> +static void clr_wr_ptr(struct bt_bmc *bt_bmc)
>> +{
>> +    bt_outb(bt_bmc, BT_CTRL_CLR_WR_PTR, BT_CTRL);
>> +}
>> +
>> +static void clr_h2b_atn(struct bt_bmc *bt_bmc)
>> +{
>> +    bt_outb(bt_bmc, BT_CTRL_H2B_ATN, BT_CTRL);
>> +}
>> +
>> +static void set_b_busy(struct bt_bmc *bt_bmc)
>> +{
>> +    if (!(bt_inb(bt_bmc, BT_CTRL) & BT_CTRL_B_BUSY))
>> +        bt_outb(bt_bmc, BT_CTRL_B_BUSY, BT_CTRL);
>> +}
>> +
>> +static void clr_b_busy(struct bt_bmc *bt_bmc)
>> +{
>> +    if (bt_inb(bt_bmc, BT_CTRL) & BT_CTRL_B_BUSY)
>> +        bt_outb(bt_bmc, BT_CTRL_B_BUSY, BT_CTRL);
>> +}
>> +
>> +static void set_b2h_atn(struct bt_bmc *bt_bmc)
>> +{
>> +    bt_outb(bt_bmc, BT_CTRL_B2H_ATN, BT_CTRL);
>> +}
>> +
>> +static u8 bt_read(struct bt_bmc *bt_bmc)
>> +{
>> +    return bt_inb(bt_bmc, BT_BMC2HOST);
>> +}
>> +
>> +static ssize_t bt_readn(struct bt_bmc *bt_bmc, u8 *buf, size_t n)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < n; i++)
>> +        buf[i] = bt_read(bt_bmc);
>> +    return n;
>> +}
>> +
>> +static void bt_write(struct bt_bmc *bt_bmc, u8 c)
>> +{
>> +    bt_outb(bt_bmc, c, BT_BMC2HOST);
>> +}
>> +
>> +static ssize_t bt_writen(struct bt_bmc *bt_bmc, u8 *buf, size_t n)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < n; i++)
>> +        bt_write(bt_bmc, buf[i]);
>> +    return n;
>> +}
>> +
>> +static void set_sms_atn(struct bt_bmc *bt_bmc)
>> +{
>> +    bt_outb(bt_bmc, BT_CTRL_SMS_ATN, BT_CTRL);
>> +}
>> +
>> +static struct bt_bmc *file_bt_bmc(struct file *file)
>> +{
>> +    return container_of(file->private_data, struct bt_bmc, miscdev);
>> +}
>> +
>> +static int bt_bmc_open(struct inode *inode, struct file *file)
>> +{
>> +    struct bt_bmc *bt_bmc = file_bt_bmc(file);
>> +
>> +    clr_b_busy(bt_bmc);
>> +
>> +    return 0;
>> +}
>> +
>> +#define BT_BMC_BUFFER_SIZE 256
>> +
>> +/*
>> + * The BT (Block Transfer) interface means that entire messages are
>> + * buffered by the host before a notification is sent to the BMC that
>> + * there is data to be read. The first byte is the length and the
>> + * message data follows. The read operation just tries to capture the
>> + * whole before returning it to userspace.
>> + */
>> +static ssize_t bt_bmc_read(struct file *file, char __user *buf,
>> +                size_t count, loff_t *ppos)
>> +{
>> +    struct bt_bmc *bt_bmc = file_bt_bmc(file);
>> +    u8 len;
>> +    int len_byte = 1;
>> +    u8 kbuffer[BT_BMC_BUFFER_SIZE];
>> +    ssize_t ret = 0;
>> +    ssize_t nread;
>> +
>> +    if (!access_ok(VERIFY_WRITE, buf, count))
>> +        return -EFAULT;
>> +
>> +    WARN_ON(*ppos);
>> +
>> +    if (wait_event_interruptible(bt_bmc->queue,
>> +                bt_inb(bt_bmc, BT_CTRL) & BT_CTRL_H2B_ATN))
>> +        return -ERESTARTSYS;
>> +
>> +    set_b_busy(bt_bmc);
>> +    clr_h2b_atn(bt_bmc);
>> +    clr_rd_ptr(bt_bmc);
>> +
>> +    /*
>> +     * The BT frames start with the message length, which does not
>> +     * include the length byte.
>> +     */
>> +    kbuffer[0] = bt_read(bt_bmc);
>> +    len = kbuffer[0];
>> +
>> +    /* We pass the length back to userspace as well */
>> +    if (len + 1 > count)
>> +        len = count - 1;
>> +
>> +    while (len) {
>> +        nread = min_t(ssize_t, len, sizeof(kbuffer) - len_byte);
>> +
>> +        bt_readn(bt_bmc, kbuffer + len_byte, nread);
>> +
>> +        if (copy_to_user(buf, kbuffer, nread + len_byte)) {
>> +            ret = -EFAULT;
>> +            break;
>> +        }
>> +        len -= nread;
>> +        buf += nread + len_byte;
>> +        ret += nread + len_byte;
>> +        len_byte = 0;
>> +    }
>> +
>> +    clr_b_busy(bt_bmc);
>> +
>> +    return ret;
>> +}
>> +
>> +static ssize_t bt_bmc_write(struct file *file, const char __user *buf,
>> +                size_t count, loff_t *ppos)
>> +{
>> +    struct bt_bmc *bt_bmc = file_bt_bmc(file);
>> +    u8 kbuffer[BT_BMC_BUFFER_SIZE];
>> +    ssize_t ret = 0;
>> +    ssize_t nwritten;
>> +
>> +    if (!access_ok(VERIFY_READ, buf, count))
>> +        return -EFAULT;
>> +
>> +    WARN_ON(*ppos);
>> +
>> +    /* There's no interrupt for clearing bmc busy so we have to
>> +     * poll
>> +     */
>> +    if (wait_event_interruptible(bt_bmc->queue,
>> +                !(bt_inb(bt_bmc, BT_CTRL) &
>> +                    (BT_CTRL_H_BUSY | BT_CTRL_B2H_ATN))))
>> +        return -ERESTARTSYS;
>> +
>> +    clr_wr_ptr(bt_bmc);
>> +
>> +    while (count) {
>> +        nwritten = min_t(ssize_t, count, sizeof(kbuffer));
>> +        if (copy_from_user(&kbuffer, buf, nwritten)) {
>> +            ret = -EFAULT;
>> +            break;
>> +        }
>> +
>> +        bt_writen(bt_bmc, kbuffer, nwritten);
>> +
>> +        count -= nwritten;
>> +        buf += nwritten;
>> +        ret += nwritten;
>> +    }
>> +
>> +    set_b2h_atn(bt_bmc);
>> +
>> +    return ret;
>> +}
>> +
>> +static long bt_bmc_ioctl(struct file *file, unsigned int cmd,
>> +        unsigned long param)
>> +{
>> +    struct bt_bmc *bt_bmc = file_bt_bmc(file);
>> +
>> +    switch (cmd) {
>> +    case BT_BMC_IOCTL_SMS_ATN:
>> +        set_sms_atn(bt_bmc);
>> +        return 0;
>> +    }
>> +    return -EINVAL;
>> +}
>> +
>> +static int bt_bmc_release(struct inode *inode, struct file *file)
>> +{
>> +    struct bt_bmc *bt_bmc = file_bt_bmc(file);
>> +
>> +    set_b_busy(bt_bmc);
>> +    return 0;
>> +}
>> +
>> +static unsigned int bt_bmc_poll(struct file *file, poll_table *wait)
>> +{
>> +    struct bt_bmc *bt_bmc = file_bt_bmc(file);
>> +    unsigned int mask = 0;
>> +    uint8_t ctrl;
>> +
>> +    poll_wait(file, &bt_bmc->queue, wait);
>> +
>> +    ctrl = bt_inb(bt_bmc, BT_CTRL);
>> +
>> +    if (ctrl & BT_CTRL_H2B_ATN)
>> +        mask |= POLLIN;
>> +
>> +    if (!(ctrl & (BT_CTRL_H_BUSY | BT_CTRL_B2H_ATN)))
>> +        mask |= POLLOUT;
>> +
>> +    return mask;
>> +}
>> +
>> +static const struct file_operations bt_bmc_fops = {
>> +    .owner        = THIS_MODULE,
>> +    .open        = bt_bmc_open,
>> +    .read        = bt_bmc_read,
>> +    .write        = bt_bmc_write,
>> +    .release    = bt_bmc_release,
>> +    .poll        = bt_bmc_poll,
>> +    .unlocked_ioctl    = bt_bmc_ioctl,
>> +};
>> +
>> +static void poll_timer(unsigned long data)
>> +{
>> +    struct bt_bmc *bt_bmc = (void *)data;
>> +
>> +    bt_bmc->poll_timer.expires += msecs_to_jiffies(500);
>> +    wake_up(&bt_bmc->queue);
>> +    add_timer(&bt_bmc->poll_timer);
>> +}
>> +
>> +static irqreturn_t bt_bmc_irq(int irq, void *arg)
>> +{
>> +    struct bt_bmc *bt_bmc = arg;
>> +    uint32_t reg;
>> +
>> +    reg = ioread32(bt_bmc->base + BT_CR2);
>> +    reg &= BT_CR2_IRQ_H2B | BT_CR2_IRQ_HBUSY;
>> +    if (!reg)
>> +        return IRQ_NONE;
>> +
>> +    /* ack pending IRQs */
>> +    iowrite32(reg, bt_bmc->base + BT_CR2);
>> +
>> +    wake_up(&bt_bmc->queue);
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
>> +        struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    uint32_t reg;
>> +    int rc;
>> +
>> +    bt_bmc->irq = platform_get_irq(pdev, 0);
>> +    if (!bt_bmc->irq)
>> +        return -ENODEV;
>> +
>> +    rc = devm_request_irq(dev, bt_bmc->irq, bt_bmc_irq, IRQF_SHARED,
>> +            DEVICE_NAME, bt_bmc);
>> +    if (rc < 0) {
>> +        dev_warn(dev, "Unable to request IRQ %d\n", bt_bmc->irq);
>> +        bt_bmc->irq = 0;
>> +        return rc;
>> +    }
>> +
>> +    /* Configure IRQs on the bmc clearing the H2B and HBUSY bits;
>> +     * H2B will be asserted when the bmc has data for us; HBUSY
>> +     * will be cleared (along with B2H) when we can write the next
>> +     * message to the BT buffer
>> +     */
>> +    reg = ioread32(bt_bmc->base + BT_CR1);
>> +    reg |= BT_CR1_IRQ_H2B | BT_CR1_IRQ_HBUSY;
>> +    iowrite32(reg, bt_bmc->base + BT_CR1);
>> +
>> +    return 0;
>> +}
>> +
>> +static int bt_bmc_probe(struct platform_device *pdev)
>> +{
>> +    struct bt_bmc *bt_bmc;
>> +    struct device *dev;
>> +    struct resource *res;
>> +    int rc;
>> +
>> +    if (!pdev || !pdev->dev.of_node)
>> +        return -ENODEV;
>> +
>> +    dev = &pdev->dev;
>> +    dev_info(dev, "Found bt bmc device\n");
>> +
>> +    bt_bmc = devm_kzalloc(dev, sizeof(*bt_bmc), GFP_KERNEL);
>> +    if (!bt_bmc)
>> +        return -ENOMEM;
>> +
>> +    dev_set_drvdata(&pdev->dev, bt_bmc);
>> +
>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    if (!res) {
>> +        dev_err(dev, "Unable to find resources\n");
>> +        rc = -ENXIO;
>> +        goto out_free;
>> +    }
>> +
>> +    bt_bmc->base = devm_ioremap_resource(&pdev->dev, res);
>> +    if (!bt_bmc->base) {
>> +        rc = -ENOMEM;
>> +        goto out_free;
>> +    }
>> +
>> +    init_waitqueue_head(&bt_bmc->queue);
>> +
>> +    bt_bmc->miscdev.minor    = MISC_DYNAMIC_MINOR,
>> +    bt_bmc->miscdev.name    = DEVICE_NAME,
>> +    bt_bmc->miscdev.fops    = &bt_bmc_fops,
>> +    bt_bmc->miscdev.parent = dev;
>> +    rc = misc_register(&bt_bmc->miscdev);
>> +    if (rc) {
>> +        dev_err(dev, "Unable to register device\n");
>> +        goto out_unmap;
>> +    }
>> +
>> +    bt_bmc_config_irq(bt_bmc, pdev);
>> +
>> +    if (bt_bmc->irq) {
>> +        dev_info(dev, "Using IRQ %d\n", bt_bmc->irq);
>> +    } else {
>> +        dev_info(dev, "No IRQ; using timer\n");
>> +        setup_timer(&bt_bmc->poll_timer, poll_timer,
>> +                (unsigned long)bt_bmc);
>> +        bt_bmc->poll_timer.expires = jiffies + msecs_to_jiffies(10);
>> +        add_timer(&bt_bmc->poll_timer);
>> +    }
>> +
>> +    iowrite32((BT_IO_BASE << BT_CR0_IO_BASE) |
>> +          (BT_IRQ << BT_CR0_IRQ) |
>> +          BT_CR0_EN_CLR_SLV_RDP |
>> +          BT_CR0_EN_CLR_SLV_WRP |
>> +          BT_CR0_ENABLE_IBT,
>> +          bt_bmc->base + BT_CR0);
>> +
>> +    clr_b_busy(bt_bmc);
>> +
>> +    return 0;
>> +
>> +out_unmap:
>> +    devm_iounmap(&pdev->dev, bt_bmc->base);
>> +
>> +out_free:
>> +    devm_kfree(dev, bt_bmc);
>> +    return rc;
>> +
>> +}
>> +
>> +static int bt_bmc_remove(struct platform_device *pdev)
>> +{
>> +    struct bt_bmc *bt_bmc = dev_get_drvdata(&pdev->dev);
>> +
>> +    misc_deregister(&bt_bmc->miscdev);
>> +    if (!bt_bmc->irq)
>> +        del_timer_sync(&bt_bmc->poll_timer);
>> +    devm_iounmap(&pdev->dev, bt_bmc->base);
>> +    devm_kfree(&pdev->dev, bt_bmc);
>> +    bt_bmc = NULL;
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct of_device_id bt_bmc_match[] = {
>> +    { .compatible = "aspeed,ast2400-bt-bmc" },
>> +    { },
>> +};
>> +
>> +static struct platform_driver bt_bmc_driver = {
>> +    .driver = {
>> +        .name        = DEVICE_NAME,
>> +        .of_match_table = bt_bmc_match,
>> +    },
>> +    .probe = bt_bmc_probe,
>> +    .remove = bt_bmc_remove,
>> +};
>> +
>> +module_platform_driver(bt_bmc_driver);
>> +
>> +MODULE_DEVICE_TABLE(of, bt_bmc_match);
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Alistair Popple <alistair@popple.id.au>");
>> +MODULE_DESCRIPTION("Linux device interface to the BT interface");
>> diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
>> index 185f8ea2702f..17b12942c67d 100644
>> --- a/include/uapi/linux/Kbuild
>> +++ b/include/uapi/linux/Kbuild
>> @@ -74,6 +74,7 @@ header-y += bpf_common.h
>>   header-y += bpf.h
>>   header-y += bpqether.h
>>   header-y += bsg.h
>> +header-y += bt-bmc.h
>>   header-y += btrfs.h
>>   header-y += can.h
>>   header-y += capability.h
>> diff --git a/include/uapi/linux/bt-bmc.h b/include/uapi/linux/bt-bmc.h
>> new file mode 100644
>> index 000000000000..d9ec766a63d0
>> --- /dev/null
>> +++ b/include/uapi/linux/bt-bmc.h
>> @@ -0,0 +1,18 @@
>> +/*
>> + * Copyright (c) 2015-2016, IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#ifndef _UAPI_LINUX_BT_BMC_H
>> +#define _UAPI_LINUX_BT_BMC_H
>> +
>> +#include <linux/ioctl.h>
>> +
>> +#define __BT_BMC_IOCTL_MAGIC    0xb1
>> +#define BT_BMC_IOCTL_SMS_ATN    _IO(__BT_BMC_IOCTL_MAGIC, 0x00)
>> +
>> +#endif /* _UAPI_LINUX_BT_BMC_H */
> 
> 
