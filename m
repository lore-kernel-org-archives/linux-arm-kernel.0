From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 12 Dec 2017 09:12:36 -0800
Subject: [PATCH net-next v5 1/2] net: add support for Cavium PTP
 coprocessor
In-Reply-To: <d1e2faeb-ba5e-f324-efb5-da64e4b3ced3@cavium.com>
References: <20171211141435.2915-1-aleksey.makarov@cavium.com>
 <20171211141435.2915-2-aleksey.makarov@cavium.com>
 <20171211225954.ezqut6jvfg65rg4w@localhost>
 <d1e2faeb-ba5e-f324-efb5-da64e4b3ced3@cavium.com>
Message-ID: <20171212171236.36yn4ljbnm2c2zqf@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 12:41:35PM +0300, Aleksey Makarov wrote:
> If ptp_clock_register() returns NULL, the device is still paired with the driver,
> but the driver is not registered in the PTP core.  When ethernet driver needs
> the reference to this cavium PTP driver, it calls cavium_ptp_get() that checks
> if ptp->ptp_clock is NULL and, if so, returns -ENODEV.

The pointer clock->ptp_clock can be NULL.

Yet you de-reference it here:

> +static void cavium_ptp_remove(struct pci_dev *pdev)
> +{
> +	struct cavium_ptp *clock = pci_get_drvdata(pdev);
> +	u64 clock_cfg;
> +
> +	pci_set_drvdata(pdev, NULL);
> +
> +	ptp_clock_unregister(clock->ptp_clock);
> +
> +	clock_cfg = readq(clock->reg_base + PTP_CLOCK_CFG);
> +	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
> +	writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
> +}

and here:

> +static inline int cavium_ptp_clock_index(struct cavium_ptp *clock)
> +{
> +	return ptp_clock_index(clock->ptp_clock);
> +}

That needs to be fixed.

Thanks,
Richard
