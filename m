From: anurupvasu@gmail.com (Anurup M)
Date: Mon, 27 Mar 2017 12:06:30 +0530
Subject: [PATCH v6 06/11] drivers: perf: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <20170324113610.GB22771@leverpostej>
References: <1489127302-112735-1-git-send-email-anurup.m@huawei.com>
 <20170321155119.GF22188@leverpostej> <58D4F901.5070503@gmail.com>
 <20170324113610.GB22771@leverpostej>
Message-ID: <58D8B2EE.1030206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 24 March 2017 05:06 PM, Mark Rutland wrote:
>>>> +#define SC_DJTAG_TIMEOUT_US    (100 * USEC_PER_MSEC) /* 100ms */
>>> > >How was this value chosen?
>>> > >
>>> > >How likely is a timeout?
>> >
>> >As explained in PATCH 7,
>> >
>> >The djtag -EBUSY in hardware is a very rare scenario, and by design
>> >of hardware, does not occur unless there is a Chip hung situation.
>> >The maximum timeout possible in djtag is 30us, and hardware logic
>> >shall reset it, if djtag is unavailable for more than 30us.
>> >The timeout used in driver is 100ms to ensure that it does not fail
>> >in any case.
> I couldn't find such an explanation in patch 7.

Sorry, I intent to mean that it was explained in the reply to PATCH 7 
comments.

> So that this doesn't get lost, please place a comment to this effect
> above the definition of SC_DJTAG_TIMEOUT_US.
>
> We can drop the existing "100ms" comment at the same time.
>
> What exactly does a "chip hung situation" imply? Does that just mean
> that only the djtag HW is hung, or that other parts of the chip are hung
> too, such taht other things are likely to go wrong?

Yes it is not that only djtag HW is hung, but it means there is some 
serious irrecoverable
condition in chip, where other things are also likely to go wrong.
Shall add comments above definition of SC_DJTAG_TIMEOUT_US.

> [...]
>
>>> 	/* wait for the operation to complete */
>>> > >	ret = readl_poll_timout(regs_base + SC_DJTAG_MSTR_START_EN,
>>> > >				val, !(val & DJTAG_MSTR_EN),
>>> > >				1, SC_DJTAG_TIMEOUT_US);
>>> > >	
>>> > >	if (ret)
>>> > >		pr_warn("djtag operation timed out.\n");
>>> > >
>>> > >	return ret;
>>> > >}
>>> > >
>>> > >Depending on how serious a timeout is, this might want to be some kind
>>> > >of WARN variant.
>  From the above, I take that a hang indicates a very serious problem, so
> this whould be a WARN, with a comment:
>
> 	/*
> 	 * A timeout should never occur on a working system. See the
> 	 * definition of SC_DJTAG_TIMEOUT_US.
> 	 */
> 	WARN(ret, "djtag operation timed out.\n");
>
> ... or, if this really should never happen, and other things are likely
> to go wrong were we to see this, we can BUG_ON(ret) instead, remove the
> error code, and simplify all the callers.
>
> Likewise for djtag_do_operation_v2().

Ok. As this should never happen by design of hardware, it is a serious 
problem. So shall
add BUG_ON and simplify all callers.

Thanks,
Anurup

> Thanks,
> Mark.
