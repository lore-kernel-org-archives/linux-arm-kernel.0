From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 12 Oct 2009 00:07:57 +0200
Subject: [PATCH v1 1/2] arm: a driver for on-chip ETM and ETB
In-Reply-To: <1255279286-8904-1-git-send-email-virtuoso@slind.org>
References: <1255279286-8904-1-git-send-email-virtuoso@slind.org>
Message-ID: <63386a3d0910111507r681e69c4ka843cac9ad0e8b40@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/10/11 Alexander Shishkin <virtuoso@slind.org>:

> This driver implements support for on-chip Embedded Tracing Macrocell and
> Embedded Trace Buffer. It allows to trigger tracing of kernel execution flow
> and exporting trace output to userspace via character device and a sysrq
> combo.

Cool, can it at all be interfaced to kernel tracing mechanisms like
ftrace, LTTng...? Or is this entirely orthogonal?

First, these are registered as platform devices, should they not be AMBA
devices (i.e. PrimeCells?) I think that's what they are, and they probably
have device ID:s to be matched in the last words of their 4K pages
do they not?

> (...)
> diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
> new file mode 100644
> index 0000000..3e7b431
> --- /dev/null
> +++ b/arch/arm/kernel/etm.c
> @@ -0,0 +1,588 @@
> +/*
> + * linux/arch/arm/kernel/etm.c
> + *
> + * Driver for ARM's Embedded Trace Macrocell and Embedded Trace Buffer.
> + *
> + * Copyright (C) 2009 Nokia Corporation.
> + * Alexander Shishkin
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/sysrq.h>
> +#include <linux/platform_device.h>
> +#include <linux/fs.h>
> +#include <linux/uaccess.h>
> +#include <linux/miscdevice.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mutex.h>
> +#include <asm/hardware/coresight.h>
> +#include <asm/sections.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Alexander Shishkin");
> +
> +static struct tracectx tracer;
> +
> +static inline bool trace_isrunning(struct tracectx *t)
> +{
> + ? ? ? return !!(t->flags & TRACER_RUNNING);
> +}
> +
> +static int etm_setup_address_range(struct tracectx *t, int n,
> + ? ? ? ? ? ? ? unsigned long start, unsigned long end, int exclude, int data)
> +{
> + ? ? ? u32 flags = ETMAAT_ARM | ETMAAT_IGNCONTEXTID | ETMAAT_NSONLY | \
> + ? ? ? ? ? ? ? ? ? ETMAAT_NOVALCMP;
> +
> + ? ? ? if (n < 1 || n > t->ncmppairs)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? /* comparators and ranges are numbered starting with 1 as opposed
> + ? ? ? ?* to bits in a word */
> + ? ? ? n--;
> +
> + ? ? ? if (data)
> + ? ? ? ? ? ? ? flags |= ETMAAT_DLOADSTORE;
> + ? ? ? else
> + ? ? ? ? ? ? ? flags |= ETMAAT_IEXEC;
> +
> + ? ? ? /* first comparator for the range */
> + ? ? ? etm_writel(t, flags, ETMR_COMP_ACC_TYPE(n * 2));
> + ? ? ? etm_writel(t, start, ETMR_COMP_VAL(n * 2));
> +
> + ? ? ? /* second comparator is right next to it */
> + ? ? ? etm_writel(t, flags, ETMR_COMP_ACC_TYPE(n * 2 + 1));
> + ? ? ? etm_writel(t, end, ETMR_COMP_VAL(n * 2 + 1));
> +
> + ? ? ? flags = exclude ? ETMTE_INCLEXCL : 0;
> + ? ? ? etm_writel(t, flags | (1 << n), ETMR_TRACEENCTRL);
> +
> + ? ? ? return 0;
> +}
> +
> +static int trace_start(struct tracectx *t)
> +{
> + ? ? ? u32 v;
> + ? ? ? unsigned long timeout = TRACER_TIMEOUT;
> +
> + ? ? ? etb_unlock(t);
> +
> + ? ? ? etb_writel(t, 0, ETBR_FORMATTERCTRL);
> + ? ? ? etb_writel(t, 1, ETBR_CTRL);
> +
> + ? ? ? etb_lock(t);
> +
> + ? ? ? /* configure etm */
> + ? ? ? v = ETMCTRL_OPTS | ETMCTRL_PROGRAM | ETMCTRL_PORTSIZE(t->etm_portsz);
> +
> + ? ? ? if (t->flags & TRACER_CYCLE_ACC)
> + ? ? ? ? ? ? ? v |= ETMCTRL_CYCLEACCURATE;
> +
> + ? ? ? etm_unlock(t);
> +
> + ? ? ? etm_writel(t, v, ETMR_CTRL);
> +
> + ? ? ? while (!(etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM) && --timeout)
> + ? ? ? ? ? ? ? ;
> + ? ? ? if (!timeout) {
> + ? ? ? ? ? ? ? dev_dbg(t->dev, "Waiting for progbit to assert timed out\n");
> + ? ? ? ? ? ? ? etm_lock(t);
> + ? ? ? ? ? ? ? return -EFAULT;
> + ? ? ? }
> +
> + ? ? ? etm_setup_address_range(t, 1, (unsigned long)_stext,
> + ? ? ? ? ? ? ? ? ? ? ? (unsigned long)_etext, 0, 0);
> + ? ? ? etm_writel(t, 0, ETMR_TRACEENCTRL2);
> + ? ? ? etm_writel(t, 0, ETMR_TRACESSCTRL);
> + ? ? ? etm_writel(t, 0x6f, ETMR_TRACEENEVT);
> +
> + ? ? ? v &= ~ETMCTRL_PROGRAM;
> + ? ? ? v |= ETMCTRL_PORTSEL;
> +
> + ? ? ? etm_writel(t, v, ETMR_CTRL);
> +
> + ? ? ? timeout = TRACER_TIMEOUT;
> + ? ? ? while (etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM && --timeout)
> + ? ? ? ? ? ? ? ;
> + ? ? ? if (!timeout) {
> + ? ? ? ? ? ? ? dev_dbg(t->dev, "Waiting for progbit to deassert timed out\n");
> + ? ? ? ? ? ? ? etm_lock(t);
> + ? ? ? ? ? ? ? return -EFAULT;
> + ? ? ? }
> +
> + ? ? ? etm_lock(t);
> +
> + ? ? ? t->flags |= TRACER_RUNNING;
> +
> + ? ? ? return 0;
> +}
> +
> +static int trace_stop(struct tracectx *t)
> +{
> + ? ? ? unsigned long timeout = TRACER_TIMEOUT;
> +
> + ? ? ? etm_unlock(t);
> +
> + ? ? ? etm_writel(t, 0x440, ETMR_CTRL);
> + ? ? ? while (!(etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM) && --timeout)
> + ? ? ? ? ? ? ? ;
> + ? ? ? if (!timeout) {
> + ? ? ? ? ? ? ? dev_dbg(t->dev, "Waiting for progbit to assert timed out\n");
> + ? ? ? ? ? ? ? etm_lock(t);
> + ? ? ? ? ? ? ? return -EFAULT;
> + ? ? ? }
> +
> + ? ? ? etm_lock(t);
> +
> + ? ? ? etb_unlock(t);
> + ? ? ? etb_writel(t, ETBFF_MANUAL_FLUSH, ETBR_FORMATTERCTRL);
> +
> + ? ? ? timeout = TRACER_TIMEOUT;
> + ? ? ? while (etb_readl(t, ETBR_FORMATTERCTRL) &
> + ? ? ? ? ? ? ? ? ? ? ? ETBFF_MANUAL_FLUSH && --timeout)
> + ? ? ? ? ? ? ? ;
> + ? ? ? if (!timeout) {
> + ? ? ? ? ? ? ? dev_dbg(t->dev, "Waiting for formatter flush to commence "
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "timed out\n");
> + ? ? ? ? ? ? ? etb_lock(t);
> + ? ? ? ? ? ? ? return -EFAULT;
> + ? ? ? }
> +
> + ? ? ? etb_writel(t, 0, ETBR_CTRL);
> +
> + ? ? ? etb_lock(t);
> +
> + ? ? ? t->flags &= ~TRACER_RUNNING;
> +
> + ? ? ? return 0;
> +}
> +
> +static int etb_getdatalen(struct tracectx *t)
> +{
> + ? ? ? u32 v;
> + ? ? ? int rp, wp;
> +
> + ? ? ? v = etb_readl(t, ETBR_STATUS);
> +
> + ? ? ? if (v & 1)
> + ? ? ? ? ? ? ? return t->etb_bufsz;
> +
> + ? ? ? rp = etb_readl(t, ETBR_READADDR);
> + ? ? ? wp = etb_readl(t, ETBR_WRITEADDR);
> +
> + ? ? ? if (rp > wp) {
> + ? ? ? ? ? ? ? etb_writel(t, 0, ETBR_READADDR);
> + ? ? ? ? ? ? ? etb_writel(t, 0, ETBR_WRITEADDR);
> +
> + ? ? ? ? ? ? ? return 0;
> + ? ? ? }
> +
> + ? ? ? return wp - rp;
> +}
> +
> +/* sysrq+v will always stop the running trace and leave it at that */
> +static void etm_dump(void)
> +{
> + ? ? ? struct tracectx *t = &tracer;
> + ? ? ? u32 first = 0;
> + ? ? ? int length;
> +
> + ? ? ? if (!t->etb_regs) {
> + ? ? ? ? ? ? ? printk(KERN_INFO "No tracing hardware found\n");
> + ? ? ? ? ? ? ? return;
> + ? ? ? }
> +
> + ? ? ? if (!mutex_trylock(&t->mutex))
> + ? ? ? ? ? ? ? return;
> +
> + ? ? ? if (trace_isrunning(t))
> + ? ? ? ? ? ? ? trace_stop(t);
> +
> + ? ? ? etb_unlock(t);
> +
> + ? ? ? length = etb_getdatalen(t);
> +
> + ? ? ? if (length == t->etb_bufsz)
> + ? ? ? ? ? ? ? first = etb_readl(t, ETBR_WRITEADDR);
> +
> + ? ? ? etb_writel(t, first, ETBR_READADDR);
> +
> + ? ? ? printk(KERN_INFO "Trace buffer contents length: %d\n", length);
> + ? ? ? printk(KERN_INFO "--- ETB buffer begin ---\n");
> + ? ? ? for (; length; length--)
> + ? ? ? ? ? ? ? printk("%08x", cpu_to_be32(etb_readl(t, ETBR_READMEM)));
> + ? ? ? printk(KERN_INFO "\n--- ETB buffer end ---\n");
> +
> + ? ? ? etb_writel(t, 0, ETBR_TRIGGERCOUNT);
> + ? ? ? etb_writel(t, 0, ETBR_READADDR);
> + ? ? ? etb_writel(t, 0, ETBR_WRITEADDR);
> +
> + ? ? ? etb_lock(t);
> +
> + ? ? ? mutex_unlock(&t->mutex);
> +}
> +
> +static void sysrq_etm_dump(int key, struct tty_struct *tty)
> +{
> + ? ? ? dev_dbg(tracer.dev, "Dumping ETB buffer\n");
> + ? ? ? etm_dump();
> +}
> +
> +static struct sysrq_key_op sysrq_etm_op = {
> + ? ? ? .handler = sysrq_etm_dump,
> + ? ? ? .help_msg = "ETM buffer dump",
> + ? ? ? .action_msg = "etm",
> +};
> +
> +static int etb_open(struct inode *inode, struct file *file)
> +{
> + ? ? ? if (!tracer.etb_regs)
> + ? ? ? ? ? ? ? return -ENODEV;
> +
> + ? ? ? file->private_data = &tracer;
> +
> + ? ? ? return nonseekable_open(inode, file);
> +}
> +
> +static ssize_t etb_read(struct file *file, char __user *data,
> + ? ? ? ? ? ? ? size_t len, loff_t *ppos)
> +{
> + ? ? ? int total, i;
> + ? ? ? long length;
> + ? ? ? struct tracectx *t = file->private_data;
> + ? ? ? u32 first = 0;
> + ? ? ? u32 *buf;
> +
> + ? ? ? mutex_lock(&t->mutex);
> +
> + ? ? ? if (trace_isrunning(t)) {
> + ? ? ? ? ? ? ? length = 0;
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? etb_unlock(t);
> +
> + ? ? ? total = etb_getdatalen(t);
> + ? ? ? if (total == t->etb_bufsz)
> + ? ? ? ? ? ? ? first = etb_readl(t, ETBR_WRITEADDR);
> +
> + ? ? ? etb_writel(t, first, ETBR_READADDR);
> +
> + ? ? ? length = min(total * 4, (int)len);
> + ? ? ? buf = vmalloc(length);
> +
> + ? ? ? dev_dbg(t->dev, "ETB buffer length: %d\n", total);
> + ? ? ? dev_dbg(t->dev, "ETB status reg: %x\n", etb_readl(t, ETBR_STATUS));
> + ? ? ? for (i = 0; i < length / 4; i++)
> + ? ? ? ? ? ? ? buf[i] = etb_readl(t, ETBR_READMEM);
> +
> + ? ? ? /* the only way to deassert overflow bit in ETB status is this */
> + ? ? ? etb_writel(t, 1, ETBR_CTRL);
> + ? ? ? etb_writel(t, 0, ETBR_CTRL);
> +
> + ? ? ? etb_writel(t, 0, ETBR_WRITEADDR);
> + ? ? ? etb_writel(t, 0, ETBR_READADDR);
> + ? ? ? etb_writel(t, 0, ETBR_TRIGGERCOUNT);
> +
> + ? ? ? etb_lock(t);
> +
> + ? ? ? length = copy_to_user(data, buf, length);
> + ? ? ? vfree(buf);
> +
> +out:
> + ? ? ? mutex_unlock(&t->mutex);
> +
> + ? ? ? return length;
> +}
> +
> +static int etb_release(struct inode *inode, struct file *file)
> +{
> + ? ? ? /* there's nothing to do here, actually */
> + ? ? ? return 0;
> +}
> +
> +static struct file_operations etb_fops = {
> + ? ? ? .owner = THIS_MODULE,
> + ? ? ? .read = etb_read,
> + ? ? ? .open = etb_open,
> + ? ? ? .release = etb_release,
> +};
> +
> +static struct miscdevice etb_miscdev = {
> + ? ? ? .name = "tracebuf",
> + ? ? ? .minor = 0,
> + ? ? ? .fops = &etb_fops,
> +};
> +
> +static int __devinit etb_drv_probe(struct platform_device *pdev)
> +{
> + ? ? ? struct tracectx *t = platform_get_drvdata(pdev);
> + ? ? ? struct resource *res;
> + ? ? ? struct clk *clk;
> + ? ? ? int ret = 0;
> +
> + ? ? ? if (t && t->etb_regs) {
> + ? ? ? ? ? ? ? dev_dbg(&pdev->dev, "ETB already initialized\n");
> + ? ? ? ? ? ? ? ret = -EBUSY;
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + ? ? ? if (!res) {
> + ? ? ? ? ? ? ? ret = -ENODEV;
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? if (!request_mem_region(res->start, SZ_4K, "etb")) {

request_mem_region(res->start, resource_size(res), "etb")
And I think it is perfectly legal with larger buffers so should
really be like that.

> + ? ? ? ? ? ? ? ret = -EBUSY;
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? if (!t) {
> + ? ? ? ? ? ? ? t = &tracer;
> + ? ? ? ? ? ? ? platform_set_drvdata(pdev, t);
> + ? ? ? }
> +
> + ? ? ? t->etb_regs = ioremap_nocache(res->start, SZ_4K);

ioremap_nocache(res->start, resource_size(res))

> + ? ? ? if (!t->etb_regs) {
> + ? ? ? ? ? ? ? ret = -ENOMEM;
> + ? ? ? ? ? ? ? platform_set_drvdata(pdev, NULL);
> + ? ? ? ? ? ? ? release_mem_region(res->start, SZ_4K);

release_mem_region(res->start. resource_size(res))

> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? etb_miscdev.parent = &pdev->dev;
> +
> + ? ? ? ret = misc_register(&etb_miscdev);
> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? platform_set_drvdata(pdev, NULL);
> + ? ? ? ? ? ? ? iounmap(t->etb_regs);
> + ? ? ? ? ? ? ? release_mem_region(res->start, SZ_4K);

release_mem_region(res->start, resource_size(res))

Note: you're starting to duplicate code here, perhaps you
can move it into the error path below out_foo: labels?

> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? clk = clk_get(&pdev->dev, "emu_core_alwon_ck");
> + ? ? ? clk_enable(clk);
> +
> + ? ? ? clk = clk_get(&pdev->dev, "emu_per_alwon_ck");
> + ? ? ? clk_enable(clk);
> +
> + ? ? ? clk = clk_get(&pdev->dev, "emu_mpu_alwon_ck");
> + ? ? ? clk_enable(clk);
> +
> + ? ? ? clk = clk_get(&pdev->dev, "emu_src_ck");
> + ? ? ? clk_enable(clk);

Are these clocks really generic? It looks a lot like OMAP-specific
stuff. Is it possible to hide these behind a single clock inside the
platform? like "etbclock" or so that increase refcount of the others
by 1?

> +
> + ? ? ? etb_unlock(t);
> + ? ? ? t->etb_bufsz = etb_readl(t, ETBR_DEPTH);
> + ? ? ? dev_dbg(&pdev->dev, "Size: %x\n", t->etb_bufsz);
> +
> + ? ? ? /* make sure trace capture is disabled */
> + ? ? ? etb_writel(t, 0, ETBR_CTRL);
> + ? ? ? etb_writel(t, 0x1000, ETBR_FORMATTERCTRL);
> + ? ? ? etb_lock(t);
> +
> + ? ? ? dev_dbg(&pdev->dev, "ETB platform driver initialized.\n");
> +
> + ? ? ? ret = 0;
> +out:
> + ? ? ? return ret;
> +}
> +
> +static struct platform_driver etb_driver = {
> + ? ? ? .probe ? ? ? ? ? = etb_drv_probe,
> + ? ? ? .driver ?= {
> + ? ? ? ? ? ? ? .name ? ?= "etb",
> + ? ? ? ? ? ? ? .owner ?= THIS_MODULE,
> + ? ? ? },
> +};
> +
> +/* use a sysfs file "trace_running" to start/stop tracing */
> +static ssize_t trace_running_show(struct kobject *kobj,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct kobj_attribute *attr,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? char *buf)
> +{
> + ? ? ? return sprintf(buf, "%x\n", trace_isrunning(&tracer));
> +}
> +
> +static ssize_t trace_running_store(struct kobject *kobj,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct kobj_attribute *attr,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?const char *buf, size_t n)
> +{
> + ? ? ? unsigned int value;
> + ? ? ? int ret;
> +
> + ? ? ? if (sscanf(buf, "%u", &value) != 1)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? mutex_lock(&tracer.mutex);
> + ? ? ? ret = value ? trace_start(&tracer) : trace_stop(&tracer);
> + ? ? ? mutex_unlock(&tracer.mutex);
> +
> + ? ? ? return ret ? : n;
> +}
> +
> +static struct kobj_attribute trace_running_attr =
> + ? ? ? __ATTR(trace_running, 0644, trace_running_show, trace_running_store);
> +
> +static ssize_t trace_info_show(struct kobject *kobj,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct kobj_attribute *attr,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? char *buf)
> +{
> + ? ? ? u32 etb_wa, etb_ra, etb_st, etb_fc, etm_ctrl, etm_st;
> + ? ? ? int datalen;
> +
> + ? ? ? etb_unlock(&tracer);
> + ? ? ? datalen = etb_getdatalen(&tracer);
> + ? ? ? etb_wa = etb_readl(&tracer, ETBR_WRITEADDR);
> + ? ? ? etb_ra = etb_readl(&tracer, ETBR_READADDR);
> + ? ? ? etb_st = etb_readl(&tracer, ETBR_STATUS);
> + ? ? ? etb_fc = etb_readl(&tracer, ETBR_FORMATTERCTRL);
> + ? ? ? etb_lock(&tracer);
> +
> + ? ? ? etm_unlock(&tracer);
> + ? ? ? etm_ctrl = etm_readl(&tracer, ETMR_CTRL);
> + ? ? ? etm_st = etm_readl(&tracer, ETMR_STATUS);
> + ? ? ? etm_lock(&tracer);
> +
> + ? ? ? return sprintf(buf, "Trace buffer len: %d\nComparator pairs: %d\n"
> + ? ? ? ? ? ? ? ? ? ? ? "ETBR_WRITEADDR:\t%08x\n"
> + ? ? ? ? ? ? ? ? ? ? ? "ETBR_READADDR:\t%08x\n"
> + ? ? ? ? ? ? ? ? ? ? ? "ETBR_STATUS:\t%08x\n"
> + ? ? ? ? ? ? ? ? ? ? ? "ETBR_FORMATTERCTRL:\t%08x\n"
> + ? ? ? ? ? ? ? ? ? ? ? "ETMR_CTRL:\t%08x\n"
> + ? ? ? ? ? ? ? ? ? ? ? "ETMR_STATUS:\t%08x\n",
> + ? ? ? ? ? ? ? ? ? ? ? datalen,
> + ? ? ? ? ? ? ? ? ? ? ? tracer.ncmppairs,
> + ? ? ? ? ? ? ? ? ? ? ? etb_wa,
> + ? ? ? ? ? ? ? ? ? ? ? etb_ra,
> + ? ? ? ? ? ? ? ? ? ? ? etb_st,
> + ? ? ? ? ? ? ? ? ? ? ? etb_fc,
> + ? ? ? ? ? ? ? ? ? ? ? etm_ctrl,
> + ? ? ? ? ? ? ? ? ? ? ? etm_st
> + ? ? ? ? ? ? ? ? ? ? ? );
> +}
> +
> +static struct kobj_attribute trace_info_attr =
> + ? ? ? __ATTR(trace_info, 0444, trace_info_show, NULL);
> +
> +static ssize_t trace_mode_show(struct kobject *kobj,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct kobj_attribute *attr,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? char *buf)
> +{
> + ? ? ? return sprintf(buf, "%d %d\n",
> + ? ? ? ? ? ? ? ? ? ? ? !!(tracer.flags & TRACER_CYCLE_ACC),
> + ? ? ? ? ? ? ? ? ? ? ? tracer.etm_portsz);
> +}
> +
> +static ssize_t trace_mode_store(struct kobject *kobj,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct kobj_attribute *attr,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?const char *buf, size_t n)
> +{
> + ? ? ? unsigned int cycacc, portsz;
> +
> + ? ? ? if (sscanf(buf, "%u %u", &cycacc, &portsz) != 2)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? mutex_lock(&tracer.mutex);
> + ? ? ? if (cycacc)
> + ? ? ? ? ? ? ? tracer.flags |= TRACER_CYCLE_ACC;
> + ? ? ? else
> + ? ? ? ? ? ? ? tracer.flags &= ~TRACER_CYCLE_ACC;
> +
> + ? ? ? tracer.etm_portsz = portsz & 0x0f;
> + ? ? ? mutex_unlock(&tracer.mutex);
> +
> + ? ? ? return n;
> +}
> +
> +static struct kobj_attribute trace_mode_attr =
> + ? ? ? __ATTR(trace_mode, 0644, trace_mode_show, trace_mode_store);
> +
> +static int __devinit etm_drv_probe(struct platform_device *pdev)
> +{
> + ? ? ? struct tracectx *t = platform_get_drvdata(pdev);
> + ? ? ? struct resource *res;
> + ? ? ? int ret = 0;
> +
> + ? ? ? if (t && t->etm_regs) {
> + ? ? ? ? ? ? ? dev_dbg(&pdev->dev, "ETM already initialized\n");
> + ? ? ? ? ? ? ? ret = -EBUSY;
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + ? ? ? if (!res) {
> + ? ? ? ? ? ? ? ret = -ENODEV;
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? if (!request_mem_region(res->start, SZ_4K, "etm")) {

request_mem_region(res->start, resource_size(res), "etm")

> + ? ? ? ? ? ? ? ret = -EBUSY;
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? if (!t) {
> + ? ? ? ? ? ? ? t = &tracer;
> + ? ? ? ? ? ? ? platform_set_drvdata(pdev, t);
> + ? ? ? }
> +
> + ? ? ? t->etm_regs = ioremap_nocache(res->start, SZ_4K);

resource_size(res)

> + ? ? ? if (!t->etm_regs) {
> + ? ? ? ? ? ? ? ret = -ENOMEM;
> + ? ? ? ? ? ? ? release_mem_region(res->start, SZ_4K);

resource_size(res)

> + ? ? ? ? ? ? ? platform_set_drvdata(pdev, NULL);
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? mutex_init(&t->mutex);
> + ? ? ? t->dev = &pdev->dev;
> + ? ? ? t->flags = TRACER_CYCLE_ACC;
> + ? ? ? t->etm_portsz = 1;
> +
> + ? ? ? etm_unlock(t);
> + ? ? ? ret = etm_readl(t, CSCR_PRSR);
> +
> + ? ? ? t->ncmppairs = etm_readl(t, ETMR_CONFCODE) & 0xf;
> + ? ? ? etm_writel(t, 0x440, ETMR_CTRL);
> + ? ? ? etm_lock(t);
> +
> + ? ? ? ret = sysfs_create_file(&pdev->dev.kobj,
> + ? ? ? ? ? ? ? ? ? ? ? &trace_running_attr.attr);
> + ? ? ? ret = sysfs_create_file(&pdev->dev.kobj,
> + ? ? ? ? ? ? ? ? ? ? ? &trace_info_attr.attr);
> + ? ? ? ret = sysfs_create_file(&pdev->dev.kobj,
> + ? ? ? ? ? ? ? ? ? ? ? &trace_mode_attr.attr);
> + ? ? ? dev_dbg(t->dev, "ETM platform driver initialized.\n");
> +
> +out:
> + ? ? ? return ret;
> +}
> +
> +static struct platform_driver etm_driver = {
> + ? ? ? .probe ? ? ? ? ? = etm_drv_probe,
> + ? ? ? .driver ?= {
> + ? ? ? ? ? ? ? .name ? ?= "etm",
> + ? ? ? ? ? ? ? .owner ? = THIS_MODULE,
> + ? ? ? },
> +};
> +
> +static int __init etm_init(void)
> +{
> + ? ? ? platform_driver_register(&etb_driver);
> + ? ? ? platform_driver_register(&etm_driver);

You're not checking the return values.

I think this calls for using platform_driver_probe(&etm_driver, etm_drv_probe);
and removing the .probe part of the driver and tag the probe functions
as __init as well.

> + ? ? ? register_sysrq_key('v', &sysrq_etm_op);
> +
> + ? ? ? return 0;
> +}
> +
> +module_init(etm_init);
> +
> --
> 1.6.3.3

Yours,
Linus Walleij
