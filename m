From: aleksey.makarov@cavium.com (Aleksey Makarov)
Date: Tue, 12 Dec 2017 12:41:35 +0300
Subject: [PATCH net-next v5 1/2] net: add support for Cavium PTP
 coprocessor
In-Reply-To: <20171211225954.ezqut6jvfg65rg4w@localhost>
References: <20171211141435.2915-1-aleksey.makarov@cavium.com>
 <20171211141435.2915-2-aleksey.makarov@cavium.com>
 <20171211225954.ezqut6jvfg65rg4w@localhost>
Message-ID: <d1e2faeb-ba5e-f324-efb5-da64e4b3ced3@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On 12/12/2017 01:59 AM, Richard Cochran wrote:
> 
> Sorry I didn't finish reviewing before...
> 
> On Mon, Dec 11, 2017 at 05:14:30PM +0300, Aleksey Makarov wrote:

[ ... ]

>> +static int cavium_ptp_probe(struct pci_dev *pdev,
>> +			    const struct pci_device_id *ent)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct cavium_ptp *clock;
>> +	struct cyclecounter *cc;
>> +	u64 clock_cfg;
>> +	u64 clock_comp;
>> +	int err;
>> +
>> +	clock = devm_kzalloc(dev, sizeof(*clock), GFP_KERNEL);
>> +	if (!clock)
>> +		return -ENOMEM;
>> +
>> +	clock->pdev = pdev;
>> +
>> +	err = pcim_enable_device(pdev);
>> +	if (err)
>> +		return err;
>> +
>> +	err = pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO, pci_name(pdev));
>> +	if (err)
>> +		return err;
>> +
>> +	clock->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
>> +
>> +	spin_lock_init(&clock->spin_lock);
>> +
>> +	cc = &clock->cycle_counter;
>> +	cc->read = cavium_ptp_cc_read;
>> +	cc->mask = CYCLECOUNTER_MASK(64);
>> +	cc->mult = 1;
>> +	cc->shift = 0;
>> +
>> +	timecounter_init(&clock->time_counter, &clock->cycle_counter,
>> +			 ktime_to_ns(ktime_get_real()));
>> +
>> +	clock->clock_rate = ptp_cavium_clock_get();
>> +
>> +	clock->ptp_info = (struct ptp_clock_info) {
>> +		.owner		= THIS_MODULE,
>> +		.name		= "ThunderX PTP",
>> +		.max_adj	= 1000000000ull,
>> +		.n_ext_ts	= 0,
>> +		.n_pins		= 0,
>> +		.pps		= 0,
>> +		.adjfreq	= cavium_ptp_adjfreq,
>> +		.adjtime	= cavium_ptp_adjtime,
>> +		.gettime64	= cavium_ptp_gettime,
>> +		.settime64	= cavium_ptp_settime,
>> +		.enable		= cavium_ptp_enable,
>> +	};
>> +
>> +	clock_cfg = readq(clock->reg_base + PTP_CLOCK_CFG);
>> +	clock_cfg |= PTP_CLOCK_CFG_PTP_EN;
>> +	writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
>> +
>> +	clock_comp = ((u64)1000000000ull << 32) / clock->clock_rate;
>> +	writeq(clock_comp, clock->reg_base + PTP_CLOCK_COMP);
>> +
>> +	clock->ptp_clock = ptp_clock_register(&clock->ptp_info, dev);
>> +	if (IS_ERR(clock->ptp_clock)) {
> 
> You need to handle the case when ptp_clock_register() returns NULL.
> 
> from ptp_clock_kernel.h:
> 
> /**
>   * ptp_clock_register() - register a PTP hardware clock driver
>   *
>   * @info:   Structure describing the new clock.
>   * @parent: Pointer to the parent device of the new clock.
>   *
>   * Returns a valid pointer on success or PTR_ERR on failure.  If PHC
>   * support is missing at the configuration level, this function
>   * returns NULL, and drivers are expected to gracefully handle that
>   * case separately.
>   */

If ptp_clock_register() returns NULL, the device is still paired with the driver,
but the driver is not registered in the PTP core.  When ethernet driver needs
the reference to this cavium PTP driver, it calls cavium_ptp_get() that checks
if ptp->ptp_clock is NULL and, if so, returns -ENODEV.

I need this behavior because I need to differentiate between two cases:

- the state when the driver is not initialized for the device because of PTP core
   has not registered it.  In this case function cavium_ptp_get() returns -ENODEV
   and ethernet driver proceeds without PTP device.

- the state when the driver is not initialized because kernel has not tired
   to initialize it yet.  In this case function cavium_ptp_get() returns -EPROBE_DEFER
   that is used in ethernet driver to defer initialization.

If you know how to do the same in more smoothly please share it.  Or else I would
prefer to insert a comment about it and leave it as is.

Richard, thank you for review.  I am going to address your comments in my next series.

Thank you
Aleksey Makarov
  
>> +		clock_cfg = readq(clock->reg_base + PTP_CLOCK_CFG);
>> +		clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
>> +		writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
>> +		return PTR_ERR(clock->ptp_clock);
>> +	}
>> +
>> +	pci_set_drvdata(pdev, clock);
>> +	return 0;
>> +}
> 
> Thanks,
> Richard
> 
