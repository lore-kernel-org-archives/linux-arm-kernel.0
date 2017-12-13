From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 13 Dec 2017 14:23:55 +0300
Subject: [PATCH] IPI performance benchmark
In-Reply-To: <ef696fb0-612c-aee7-319e-eb12f8692ac3@de.ibm.com>
References: <20171211141600.24401-1-ynorov@caviumnetworks.com>
 <27744344-f4f3-0952-94e2-d80071a137a7@de.ibm.com>
 <20171211145557.mooeknrcdfw53qpz@yury-thinkpad>
 <ef696fb0-612c-aee7-319e-eb12f8692ac3@de.ibm.com>
Message-ID: <20171213112355.s3ubggurwx4v3r53@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 05:30:25PM +0100, Christian Borntraeger wrote:
> 
> 
> On 12/11/2017 03:55 PM, Yury Norov wrote:
> > On Mon, Dec 11, 2017 at 03:35:02PM +0100, Christian Borntraeger wrote:
> >>
> >>
> >> On 12/11/2017 03:16 PM, Yury Norov wrote:
> >>> This benchmark sends many IPIs in different modes and measures
> >>> time for IPI delivery (first column), and total time, ie including
> >>> time to acknowledge the receive by sender (second column).
> >>>
> >>> The scenarios are:
> >>> Dry-run:	do everything except actually sending IPI. Useful
> >>> 		to estimate system overhead.
> >>> Self-IPI:	Send IPI to self CPU.
> >>> Normal IPI:	Send IPI to some other CPU.
> >>> Broadcast IPI:	Send broadcast IPI to all online CPUs.
> >>>
> >>> For virtualized guests, sending and reveiving IPIs causes guest exit.
> >>> I used this test to measure performance impact on KVM subsystem of
> >>> Christoffer Dall's series "Optimize KVM/ARM for VHE systems".
> >>>
> >>> https://www.spinics.net/lists/kvm/msg156755.html
> >>>
> >>> Test machine is ThunderX2, 112 online CPUs. Below the results normalized
> >>> to host dry-run time. Smaller - better.
> >>>
> >>> Host, v4.14:
> >>> Dry-run:	  0	    1
> >>> Self-IPI:         9	   18
> >>> Normal IPI:      81	  110
> >>> Broadcast IPI:    0	 2106
> >>>
> >>> Guest, v4.14:
> >>> Dry-run:          0	    1
> >>> Self-IPI:        10	   18
> >>> Normal IPI:     305	  525
> >>> Broadcast IPI:    0    	 9729
> >>>
> >>> Guest, v4.14 + VHE:
> >>> Dry-run:          0	    1
> >>> Self-IPI:         9	   18
> >>> Normal IPI:     176	  343
> >>> Broadcast IPI:    0	 9885
> [...]
> >>> +static int __init init_bench_ipi(void)
> >>> +{
> >>> +	ktime_t ipi, total;
> >>> +	int ret;
> >>> +
> >>> +	ret = bench_ipi(NTIMES, DRY_RUN, &ipi, &total);
> >>> +	if (ret)
> >>> +		pr_err("Dry-run FAILED: %d\n", ret);
> >>> +	else
> >>> +		pr_err("Dry-run:       %18llu, %18llu ns\n", ipi, total);
> >>
> >> you do not use NTIMES here to calculate the average value. Is that intended?
> > 
> > I think, it's more visually to represent all results in number of dry-run
> > times, like I did in patch description. So on kernel side I expose raw data
> > and calculate final values after finishing tests.
> 
> I think it is highly confusing that the output from the patch description does not
> match the output from the real module. So can you make that match at least?

I think so. That's why I noticed that results are normalized to host dry-run
time, even more, they are small and better for human perception.

I was recommended not to public raw data, you'd understand. If this is
the blocker, I can post results from QEMU-hosted kernel.

> > If you think that average values are preferable, I can do that in v2.
> 
> The raw numbers a propably fine, but then you might want to print the number of 
> loop iterations in the output.

It's easy to do. But this number is the same for all tests, and what
really interesting is relative numbers, so I decided not to trash output.
If you insist on printing iterations number, just let me know and I'll add it.

> If we want to do something fancy, we could do a combination of a smaller inner
> loop doing the test, then an outer loops redoing the inner loop and then you 
> can do some min/max/average  calculation. Not s
