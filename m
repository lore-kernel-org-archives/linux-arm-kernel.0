From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 8 Feb 2010 01:45:31 -0500
Subject: [PATCH 3/5] mfd: use genirq in 88pm860x
In-Reply-To: <20100205153938.GB3448@sortiz.org>
References: <771cded01002030503w15f5394fwd226a26e4deadc6d@mail.gmail.com>
	<20100205153938.GB3448@sortiz.org>
Message-ID: <771cded01002072245j385cc3b5xc63e99009149650b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 5, 2010 at 10:39 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Haojian,
>
> On Wed, Feb 03, 2010 at 08:03:13AM -0500, Haojian Zhuang wrote:
>> From 1c49d1bf59a1ec2c59dc093899e6b2d0991bd676 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Wed, 3 Feb 2010 15:39:28 -0500
>> Subject: [PATCH] mfd: use genirq in 88pm860x
> The patch looks fine to me but:
>
> - Please add some more verbose changelog
> - It doesnt build on x86, you need to apply this:
>
> diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
> index 0b1eba0..6a14d2b 100644
> --- a/drivers/mfd/88pm860x-core.c
> +++ b/drivers/mfd/88pm860x-core.c
> @@ -544,7 +544,11 @@ static int __devinit device_irq_init(struct pm860x_chip
> *ch
> ? ? ? ? ? ? ? ?set_irq_chip_and_handler(__irq, &pm860x_irq_chip,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? handle_edge_irq);
> ? ? ? ? ? ? ? ?set_irq_nested_thread(__irq, 1);
> +#ifdef CONFIG_ARM
> ? ? ? ? ? ? ? ?set_irq_flags(__irq, IRQF_VALID);
> +#else
> + ? ? ? ? ? ? ? set_irq_noprobe(__irq);
> +#endif
> ? ? ? ?}
>
> ? ? ? ?ret = request_threaded_irq(chip->core_irq, NULL, pm860x_irq, flags,
>
> - After applying this patch, 88pm860x-ts.c fails to build. You need to merge
> patches 3 and 4 into one single patch to prevent build failure.
>
> Cheers,
> Samuel.
>

Great thanks. Now the patch is updated. The modification is in below.
1. Merge patch of IRQ handling and touchscreen driver.
2. Add CONFIG_ARM in 88pm860x driver.
3. Add more comments in changelog.

Best Regards
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mfd-use-genirq-in-88pm860x.patch
Type: text/x-patch
Size: 18895 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100208/fd51edee/attachment-0001.bin>
