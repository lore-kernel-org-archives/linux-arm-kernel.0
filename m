From: virtuoso@slind.org (Alexander Shishkin)
Date: Mon, 12 Oct 2009 11:50:21 +0300
Subject: [PATCH v1 1/2] arm: a driver for on-chip ETM and ETB
In-Reply-To: <63386a3d0910111507r681e69c4ka843cac9ad0e8b40@mail.gmail.com>
References: <1255279286-8904-1-git-send-email-virtuoso@slind.org>
	<63386a3d0910111507r681e69c4ka843cac9ad0e8b40@mail.gmail.com>
Message-ID: <71a0d6ff0910120150w1409b625ye4c587bc964a1790@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/10/12 Linus Walleij <linus.ml.walleij@gmail.com>:
> 2009/10/11 Alexander Shishkin <virtuoso@slind.org>:
>
>> This driver implements support for on-chip Embedded Tracing Macrocell and
>> Embedded Trace Buffer. It allows to trigger tracing of kernel execution flow
>> and exporting trace output to userspace via character device and a sysrq
>> combo.
>
> Cool, can it at all be interfaced to kernel tracing mechanisms like
> ftrace, LTTng...? Or is this entirely orthogonal?
I'll have to check on that.

> First, these are registered as platform devices, should they not be AMBA
> devices (i.e. PrimeCells?) I think that's what they are, and they probably
> have device ID:s to be matched in the last words of their 4K pages
> do they not?
Only ETMv3.2 and are said to comply with AMBA with regards to
peripheral id and component id registers and I'm not quite sure how
useful those are. Whereas having those as platform devices provides
the possibility to have them defined per platform for most of ETM
versions.

>> (...)
>> diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
>> new file mode 100644
>> index 0000000..3e7b431
>> --- /dev/null
>> +++ b/arch/arm/kernel/etm.c
>> @@ -0,0 +1,588 @@
>> +/*
>> + * linux/arch/arm/kernel/etm.c
>> + *
>> + * Driver for ARM's Embedded Trace Macrocell and Embedded Trace Buffer.
>> + *
>> + * Copyright (C) 2009 Nokia Corporation.
>> + * Alexander Shishkin
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/types.h>
>> +#include <linux/io.h>
>> +#include <linux/clk.h>
>> +#include <linux/sysrq.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/fs.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/mutex.h>
>> +#include <asm/hardware/coresight.h>
>> +#include <asm/sections.h>
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Alexander Shishkin");
>> +
>> +static struct tracectx tracer;
>> +
>> +static inline bool trace_isrunning(struct tracectx *t)
>> +{
>> + ? ? ? return !!(t->flags & TRACER_RUNNING);
>> +}
>> +
>> +static int etm_setup_address_range(struct tracectx *t, int n,
>> + ? ? ? ? ? ? ? unsigned long start, unsigned long end, int exclude, int data)
>> +{
>> + ? ? ? u32 flags = ETMAAT_ARM | ETMAAT_IGNCONTEXTID | ETMAAT_NSONLY | \
>> + ? ? ? ? ? ? ? ? ? ETMAAT_NOVALCMP;
>> +
>> + ? ? ? if (n < 1 || n > t->ncmppairs)
>> + ? ? ? ? ? ? ? return -EINVAL;
>> +
>> + ? ? ? /* comparators and ranges are numbered starting with 1 as opposed
>> + ? ? ? ?* to bits in a word */
>> + ? ? ? n--;
>> +
>> + ? ? ? if (data)
>> + ? ? ? ? ? ? ? flags |= ETMAAT_DLOADSTORE;
>> + ? ? ? else
>> + ? ? ? ? ? ? ? flags |= ETMAAT_IEXEC;
>> +
>> + ? ? ? /* first comparator for the range */
>> + ? ? ? etm_writel(t, flags, ETMR_COMP_ACC_TYPE(n * 2));
>> + ? ? ? etm_writel(t, start, ETMR_COMP_VAL(n * 2));
>> +
>> + ? ? ? /* second comparator is right next to it */
>> + ? ? ? etm_writel(t, flags, ETMR_COMP_ACC_TYPE(n * 2 + 1));
>> + ? ? ? etm_writel(t, end, ETMR_COMP_VAL(n * 2 + 1));
>> +
>> + ? ? ? flags = exclude ? ETMTE_INCLEXCL : 0;
>> + ? ? ? etm_writel(t, flags | (1 << n), ETMR_TRACEENCTRL);
>> +
>> + ? ? ? return 0;
>> +}
>> +
>> +static int trace_start(struct tracectx *t)
>> +{
>> + ? ? ? u32 v;
>> + ? ? ? unsigned long timeout = TRACER_TIMEOUT;
>> +
>> + ? ? ? etb_unlock(t);
>> +
>> + ? ? ? etb_writel(t, 0, ETBR_FORMATTERCTRL);
>> + ? ? ? etb_writel(t, 1, ETBR_CTRL);
>> +
>> + ? ? ? etb_lock(t);
>> +
>> + ? ? ? /* configure etm */
>> + ? ? ? v = ETMCTRL_OPTS | ETMCTRL_PROGRAM | ETMCTRL_PORTSIZE(t->etm_portsz);
>> +
>> + ? ? ? if (t->flags & TRACER_CYCLE_ACC)
>> + ? ? ? ? ? ? ? v |= ETMCTRL_CYCLEACCURATE;
>> +
>> + ? ? ? etm_unlock(t);
>> +
>> + ? ? ? etm_writel(t, v, ETMR_CTRL);
>> +
>> + ? ? ? while (!(etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM) && --timeout)
>> + ? ? ? ? ? ? ? ;
>> + ? ? ? if (!timeout) {
>> + ? ? ? ? ? ? ? dev_dbg(t->dev, "Waiting for progbit to assert timed out\n");
>> + ? ? ? ? ? ? ? etm_lock(t);
>> + ? ? ? ? ? ? ? return -EFAULT;
>> + ? ? ? }
>> +
>> + ? ? ? etm_setup_address_range(t, 1, (unsigned long)_stext,
>> + ? ? ? ? ? ? ? ? ? ? ? (unsigned long)_etext, 0, 0);
>> + ? ? ? etm_writel(t, 0, ETMR_TRACEENCTRL2);
>> + ? ? ? etm_writel(t, 0, ETMR_TRACESSCTRL);
>> + ? ? ? etm_writel(t, 0x6f, ETMR_TRACEENEVT);
>> +
>> + ? ? ? v &= ~ETMCTRL_PROGRAM;
>> + ? ? ? v |= ETMCTRL_PORTSEL;
>> +
>> + ? ? ? etm_writel(t, v, ETMR_CTRL);
>> +
>> + ? ? ? timeout = TRACER_TIMEOUT;
>> + ? ? ? while (etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM && --timeout)
>> + ? ? ? ? ? ? ? ;
>> + ? ? ? if (!timeout) {
>> + ? ? ? ? ? ? ? dev_dbg(t->dev, "Waiting for progbit to deassert timed out\n");
>> + ? ? ? ? ? ? ? etm_lock(t);
>> + ? ? ? ? ? ? ? return -EFAULT;
>> + ? ? ? }
>> +
>> + ? ? ? etm_lock(t);
>> +
>> + ? ? ? t->flags |= TRACER_RUNNING;
>> +
>> + ? ? ? return 0;
>> +}
>> +
>> +static int trace_stop(struct tracectx *t)
>> +{
>> + ? ? ? unsigned long timeout = TRACER_TIMEOUT;
>> +
>> + ? ? ? etm_unlock(t);
>> +
>> + ? ? ? etm_writel(t, 0x440, ETMR_CTRL);
>> + ? ? ? while (!(etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM) && --timeout)
>> + ? ? ? ? ? ? ? ;
>> + ? ? ? if (!timeout) {
>> + ? ? ? ? ? ? ? dev_dbg(t->dev, "Waiting for progbit to assert timed out\n");
>> + ? ? ? ? ? ? ? etm_lock(t);
>> + ? ? ? ? ? ? ? return -EFAULT;
>> + ? ? ? }
>> +
>> + ? ? ? etm_lock(t);
>> +
>> + ? ? ? etb_unlock(t);
>> + ? ? ? etb_writel(t, ETBFF_MANUAL_FLUSH, ETBR_FORMATTERCTRL);
>> +
>> + ? ? ? timeout = TRACER_TIMEOUT;
>> + ? ? ? while (etb_readl(t, ETBR_FORMATTERCTRL) &
>> + ? ? ? ? ? ? ? ? ? ? ? ETBFF_MANUAL_FLUSH && --timeout)
>> + ? ? ? ? ? ? ? ;
>> + ? ? ? if (!timeout) {
>> + ? ? ? ? ? ? ? dev_dbg(t->dev, "Waiting for formatter flush to commence "
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "timed out\n");
>> + ? ? ? ? ? ? ? etb_lock(t);
>> + ? ? ? ? ? ? ? return -EFAULT;
>> + ? ? ? }
>> +
>> + ? ? ? etb_writel(t, 0, ETBR_CTRL);
>> +
>> + ? ? ? etb_lock(t);
>> +
>> + ? ? ? t->flags &= ~TRACER_RUNNING;
>> +
>> + ? ? ? return 0;
>> +}
>> +
>> +static int etb_getdatalen(struct tracectx *t)
>> +{
>> + ? ? ? u32 v;
>> + ? ? ? int rp, wp;
>> +
>> + ? ? ? v = etb_readl(t, ETBR_STATUS);
>> +
>> + ? ? ? if (v & 1)
>> + ? ? ? ? ? ? ? return t->etb_bufsz;
>> +
>> + ? ? ? rp = etb_readl(t, ETBR_READADDR);
>> + ? ? ? wp = etb_readl(t, ETBR_WRITEADDR);
>> +
>> + ? ? ? if (rp > wp) {
>> + ? ? ? ? ? ? ? etb_writel(t, 0, ETBR_READADDR);
>> + ? ? ? ? ? ? ? etb_writel(t, 0, ETBR_WRITEADDR);
>> +
>> + ? ? ? ? ? ? ? return 0;
>> + ? ? ? }
>> +
>> + ? ? ? return wp - rp;
>> +}
>> +
>> +/* sysrq+v will always stop the running trace and leave it at that */
>> +static void etm_dump(void)
>> +{
>> + ? ? ? struct tracectx *t = &tracer;
>> + ? ? ? u32 first = 0;
>> + ? ? ? int length;
>> +
>> + ? ? ? if (!t->etb_regs) {
>> + ? ? ? ? ? ? ? printk(KERN_INFO "No tracing hardware found\n");
>> + ? ? ? ? ? ? ? return;
>> + ? ? ? }
>> +
>> + ? ? ? if (!mutex_trylock(&t->mutex))
>> + ? ? ? ? ? ? ? return;
>> +
>> + ? ? ? if (trace_isrunning(t))
>> + ? ? ? ? ? ? ? trace_stop(t);
>> +
>> + ? ? ? etb_unlock(t);
>> +
>> + ? ? ? length = etb_getdatalen(t);
>> +
>> + ? ? ? if (length == t->etb_bufsz)
>> + ? ? ? ? ? ? ? first = etb_readl(t, ETBR_WRITEADDR);
>> +
>> + ? ? ? etb_writel(t, first, ETBR_READADDR);
>> +
>> + ? ? ? printk(KERN_INFO "Trace buffer contents length: %d\n", length);
>> + ? ? ? printk(KERN_INFO "--- ETB buffer begin ---\n");
>> + ? ? ? for (; length; length--)
>> + ? ? ? ? ? ? ? printk("%08x", cpu_to_be32(etb_readl(t, ETBR_READMEM)));
>> + ? ? ? printk(KERN_INFO "\n--- ETB buffer end ---\n");
>> +
>> + ? ? ? etb_writel(t, 0, ETBR_TRIGGERCOUNT);
>> + ? ? ? etb_writel(t, 0, ETBR_READADDR);
>> + ? ? ? etb_writel(t, 0, ETBR_WRITEADDR);
>> +
>> + ? ? ? etb_lock(t);
>> +
>> + ? ? ? mutex_unlock(&t->mutex);
>> +}
>> +
>> +static void sysrq_etm_dump(int key, struct tty_struct *tty)
>> +{
>> + ? ? ? dev_dbg(tracer.dev, "Dumping ETB buffer\n");
>> + ? ? ? etm_dump();
>> +}
>> +
>> +static struct sysrq_key_op sysrq_etm_op = {
>> + ? ? ? .handler = sysrq_etm_dump,
>> + ? ? ? .help_msg = "ETM buffer dump",
>> + ? ? ? .action_msg = "etm",
>> +};
>> +
>> +static int etb_open(struct inode *inode, struct file *file)
>> +{
>> + ? ? ? if (!tracer.etb_regs)
>> + ? ? ? ? ? ? ? return -ENODEV;
>> +
>> + ? ? ? file->private_data = &tracer;
>> +
>> + ? ? ? return nonseekable_open(inode, file);
>> +}
>> +
>> +static ssize_t etb_read(struct file *file, char __user *data,
>> + ? ? ? ? ? ? ? size_t len, loff_t *ppos)
>> +{
>> + ? ? ? int total, i;
>> + ? ? ? long length;
>> + ? ? ? struct tracectx *t = file->private_data;
>> + ? ? ? u32 first = 0;
>> + ? ? ? u32 *buf;
>> +
>> + ? ? ? mutex_lock(&t->mutex);
>> +
>> + ? ? ? if (trace_isrunning(t)) {
>> + ? ? ? ? ? ? ? length = 0;
>> + ? ? ? ? ? ? ? goto out;
>> + ? ? ? }
>> +
>> + ? ? ? etb_unlock(t);
>> +
>> + ? ? ? total = etb_getdatalen(t);
>> + ? ? ? if (total == t->etb_bufsz)
>> + ? ? ? ? ? ? ? first = etb_readl(t, ETBR_WRITEADDR);
>> +
>> + ? ? ? etb_writel(t, first, ETBR_READADDR);
>> +
>> + ? ? ? length = min(total * 4, (int)len);
>> + ? ? ? buf = vmalloc(length);
>> +
>> + ? ? ? dev_dbg(t->dev, "ETB buffer length: %d\n", total);
>> + ? ? ? dev_dbg(t->dev, "ETB status reg: %x\n", etb_readl(t, ETBR_STATUS));
>> + ? ? ? for (i = 0; i < length / 4; i++)
>> + ? ? ? ? ? ? ? buf[i] = etb_readl(t, ETBR_READMEM);
>> +
>> + ? ? ? /* the only way to deassert overflow bit in ETB status is this */
>> + ? ? ? etb_writel(t, 1, ETBR_CTRL);
>> + ? ? ? etb_writel(t, 0, ETBR_CTRL);
>> +
>> + ? ? ? etb_writel(t, 0, ETBR_WRITEADDR);
>> + ? ? ? etb_writel(t, 0, ETBR_READADDR);
>> + ? ? ? etb_writel(t, 0, ETBR_TRIGGERCOUNT);
>> +
>> + ? ? ? etb_lock(t);
>> +
>> + ? ? ? length = copy_to_user(data, buf, length);
>> + ? ? ? vfree(buf);
>> +
>> +out:
>> + ? ? ? mutex_unlock(&t->mutex);
>> +
>> + ? ? ? return length;
>> +}
>> +
>> +static int etb_release(struct inode *inode, struct file *file)
>> +{
>> + ? ? ? /* there's nothing to do here, actually */
>> + ? ? ? return 0;
>> +}
>> +
>> +static struct file_operations etb_fops = {
>> + ? ? ? .owner = THIS_MODULE,
>> + ? ? ? .read = etb_read,
>> + ? ? ? .open = etb_open,
>> + ? ? ? .release = etb_release,
>> +};
>> +
>> +static struct miscdevice etb_miscdev = {
>> + ? ? ? .name = "tracebuf",
>> + ? ? ? .minor = 0,
>> + ? ? ? .fops = &etb_fops,
>> +};
>> +
>> +static int __devinit etb_drv_probe(struct platform_device *pdev)
>> +{
>> + ? ? ? struct tracectx *t = platform_get_drvdata(pdev);
>> + ? ? ? struct resource *res;
>> + ? ? ? struct clk *clk;
>> + ? ? ? int ret = 0;
>> +
>> + ? ? ? if (t && t->etb_regs) {
>> + ? ? ? ? ? ? ? dev_dbg(&pdev->dev, "ETB already initialized\n");
>> + ? ? ? ? ? ? ? ret = -EBUSY;
>> + ? ? ? ? ? ? ? goto out;
>> + ? ? ? }
>> +
>> + ? ? ? res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + ? ? ? if (!res) {
>> + ? ? ? ? ? ? ? ret = -ENODEV;
>> + ? ? ? ? ? ? ? goto out;
>> + ? ? ? }
>> +
>> + ? ? ? if (!request_mem_region(res->start, SZ_4K, "etb")) {
>
> request_mem_region(res->start, resource_size(res), "etb")
> And I think it is perfectly legal with larger buffers so should
> really be like that.
Thanks for pointing this out.

> Note: you're starting to duplicate code here, perhaps you
> can move it into the error path below out_foo: labels?
One for unsetting platform data, one got releasing mem region and one
for iounmapping? I'll try that. :)

>
>> + ? ? ? ? ? ? ? goto out;
>> + ? ? ? }
>> +
>> + ? ? ? clk = clk_get(&pdev->dev, "emu_core_alwon_ck");
>> + ? ? ? clk_enable(clk);
>> +
>> + ? ? ? clk = clk_get(&pdev->dev, "emu_per_alwon_ck");
>> + ? ? ? clk_enable(clk);
>> +
>> + ? ? ? clk = clk_get(&pdev->dev, "emu_mpu_alwon_ck");
>> + ? ? ? clk_enable(clk);
>> +
>> + ? ? ? clk = clk_get(&pdev->dev, "emu_src_ck");
>> + ? ? ? clk_enable(clk);
>
> Are these clocks really generic? It looks a lot like OMAP-specific
> stuff. Is it possible to hide these behind a single clock inside the
That's right. These are probably better off to the platform device part.

> platform? like "etbclock" or so that increase refcount of the others
> by 1?
I'll look into that.

>> +static int __init etm_init(void)
>> +{
>> + ? ? ? platform_driver_register(&etb_driver);
>> + ? ? ? platform_driver_register(&etm_driver);
>
> You're not checking the return values.
>
> I think this calls for using platform_driver_probe(&etm_driver, etm_drv_probe);
> and removing the .probe part of the driver and tag the probe functions
> as __init as well.
Yes, this seems fair.

Thanks for comments!
--
Alex
