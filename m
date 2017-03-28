From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Mar 2017 12:09:55 +0100
Subject: [PATCH v6 08/11] drivers: perf: hisi: use poll method to avoid
 L3C counter overflow
In-Reply-To: <58D8B234.3020004@gmail.com>
References: <1489127325-112821-1-git-send-email-anurup.m@huawei.com>
 <20170321171605.GB29116@leverpostej> <58D4C006.2010907@gmail.com>
 <20170324114325.GC22771@leverpostej> <58D8B234.3020004@gmail.com>
Message-ID: <20170328110955.GD24221@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 12:03:24PM +0530, Anurup M wrote:
> On Friday 24 March 2017 05:13 PM, Mark Rutland wrote:
> >>>How do we ensure that we don't take the interrupt in the middle of a
> >>>> >sequence of accesses to the HW?
> >>>
> >>>The L3 cache and MN PMU does not use the overflow IRQ and it does
> >>>not occur here
> >>>as the interrupt Mask register is by default masked in hardware.
> >I was referring to the timer interrupt which backs the hrtimer.
> >
> >i.e. how do we guarantee that hisi_hrtimer_callback() is not called
> >while we are in the middle of a RMW sequence? Are interrupts disabled
> >for all of those seqeunces?
> 
> The HW access via djtag read and write are protected by spin_lock_irqsave.

Thanks for the explanation.

I mistakenly thought that there were sequences that would need to make
several hisi_djtag_{read,writel}() calls that might conflict with the
overflow handler, but that is not the case, so the spin_lock_irqsave()
does appear to be sufficient.

Thanks,
Mark.
