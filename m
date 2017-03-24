From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Mar 2017 11:36:11 +0000
Subject: [PATCH v6 06/11] drivers: perf: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <58D4F901.5070503@gmail.com>
References: <1489127302-112735-1-git-send-email-anurup.m@huawei.com>
 <20170321155119.GF22188@leverpostej> <58D4F901.5070503@gmail.com>
Message-ID: <20170324113610.GB22771@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 04:16:25PM +0530, Anurup M wrote:
> Thanks for the review.
> 
> On Tuesday 21 March 2017 09:21 PM, Mark Rutland wrote:
> >On Fri, Mar 10, 2017 at 01:28:22AM -0500, Anurup M wrote:

> >>+#define SC_DJTAG_TIMEOUT_US    (100 * USEC_PER_MSEC) /* 100ms */
> >How was this value chosen?
> >
> >How likely is a timeout?
> 
> As explained in PATCH 7,
> 
> The djtag -EBUSY in hardware is a very rare scenario, and by design
> of hardware, does not occur unless there is a Chip hung situation.
> The maximum timeout possible in djtag is 30us, and hardware logic
> shall reset it, if djtag is unavailable for more than 30us.
> The timeout used in driver is 100ms to ensure that it does not fail
> in any case.

I couldn't find such an explanation in patch 7.

So that this doesn't get lost, please place a comment to this effect
above the definition of SC_DJTAG_TIMEOUT_US.

We can drop the existing "100ms" comment at the same time.

What exactly does a "chip hung situation" imply? Does that just mean
that only the djtag HW is hung, or that other parts of the chip are hung
too, such taht other things are likely to go wrong?

[...]

> >static int djtag_do_operation_v1(void __iomem *regs_base)
> >{
> >	int ret;
> >	u32 val;
> >
> >	/* start to write to djtag register */
> >	writel(DJTAG_MSTR_START_EN, regs_base + SC_DJTAG_MSTR_START_EN);
> >
> >	/* wait for the operation to complete */
> >	ret = readl_poll_timout(regs_base + SC_DJTAG_MSTR_START_EN,
> >				val, !(val & DJTAG_MSTR_EN),
> >				1, SC_DJTAG_TIMEOUT_US);
> >	
> >	if (ret)
> >		pr_warn("djtag operation timed out.\n");
> >
> >	return ret;
> >}
> >
> >Depending on how serious a timeout is, this might want to be some kind
> >of WARN variant.

>From the above, I take that a hang indicates a very serious problem, so
this whould be a WARN, with a comment:

	/* 
	 * A timeout should never occur on a working system. See the
	 * definition of SC_DJTAG_TIMEOUT_US.
	 */
	WARN(ret, "djtag operation timed out.\n");

... or, if this really should never happen, and other things are likely
to go wrong were we to see this, we can BUG_ON(ret) instead, remove the
error code, and simplify all the callers.

Likewise for djtag_do_operation_v2().

Thanks,
Mark.
