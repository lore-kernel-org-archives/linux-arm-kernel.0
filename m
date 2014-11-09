From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun, 9 Nov 2014 23:56:50 +0100
Subject: [PATCH 2/3] spi: meson: Add support for Amlogic Meson SPIFC
In-Reply-To: <20141109101712.GM2722@sirena.org.uk>
References: <1415525113-25598-1-git-send-email-b.galvani@gmail.com>
 <1415525113-25598-3-git-send-email-b.galvani@gmail.com>
 <20141109101712.GM2722@sirena.org.uk>
Message-ID: <20141109225650.GA27950@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 09, 2014 at 10:17:12AM +0000, Mark Brown wrote:
> On Sun, Nov 09, 2014 at 10:25:12AM +0100, Beniamino Galvani wrote:
> 
> > +static int meson_spifc_wait_ready(struct meson_spifc *spifc)
> > +{
> > +	unsigned long deadline = jiffies + msecs_to_jiffies(1000);
> > +	u32 data;
> > +
> > +	do {
> > +		regmap_read(spifc->regmap, REG_SLAVE, &data);
> > +		if (data & SLAVE_TRST_DONE)
> > +			return 0;
> > +		cond_resched();
> > +	} while (time_before(jiffies, deadline));
> 
> This will busy wait for up to a second, that seems like a long time to
> busy wait.  We also appear to be using this for the entire duration of
> the transfer which could be a fairly long time even during normal
> operation if doing a large transfer such as a firmware download, or if
> the bus speed is low.

Yes, probably the timeout value is too long since the maximum length
of a basic transfer is 64 bytes. Can you suggest a reasonable value?

> 
> > +	meson_spifc_setup_speed(spifc, xfer->speed_hz ? xfer->speed_hz :
> > +				spi->max_speed_hz);
> > +
> 
> Please avoid the ternery operator, it does nothing for legibility and in
> this case it's not needed as the core will always ensure that there is a
> per-transfer speed set.

Ok.

> > +	while (done < xfer->len && !ret) {
> > +		len = min_t(int, xfer->len - done, SPIFC_BUFFER_SIZE);
> > +		ret = meson_spifc_txrx(spifc, xfer, done, len,
> > +				       last_xfer, done + len >= xfer->len);
> > +		done += len;
> > +	}
> 
> I noticed that the handling of /CS was done in the spifc_txrx() function
> - will this do the right thing if the transfer needs to be split for the
> buffer size?

It should. When the transfer gets split, CS is kept active for all the
chunks and the value of CS after that depends on the value of
cs_change.

> 
> > +	if (!ret && xfer->delay_usecs)
> > +		udelay(xfer->delay_usecs);
> 
> The core will do this for you if you implement this as transfer_one().

Please correct me if I'm wrong, but I think that transfer_one() can't
be used in this case. The hardware doesn't support direct manipulation
of CS and allows only to specify if CS must be kept active after the
current transfer. So I need to know for each transfer if it's the last
and this can be achieved only implementing transfer_one_message().

> 
> > +static int meson_spifc_transfer_one_message(struct spi_master *master,
> > +					    struct spi_message *msg)
> 
> This appears to do nothing that the core won't do - just implement
> transfer_one() and remove this.
> 
> > +	spifc = spi_master_get_devdata(master);
> > +	memset(spifc, 0, sizeof(struct meson_spifc));
> 
> There should be no need for this memset.
> 
> > +	spifc_regmap_config.max_register = resource_size(res) - 4;
> > +	spifc_regmap_config.name = "amlogic,meson-spifc";
> 
> If you're dynamically initializing the structure you need to work with a
> copy of it rather than directly since there may be multiple instances.
> I'm not seeing a reason to override the regmap name here, this is only
> really intended for devices with multiple register maps.
> 
> > +	ret = clk_prepare_enable(spifc->clk);
> > +	if (ret) {
> > +		dev_err(spifc->dev, "can't prepare clock\n");
> > +		goto out_err;
> > +	}
> 
> You should really implement runtime PM operations to disable this when
> not in use and use auto_runtime_pm to make sure this happens.
> 
> > +	master->bus_num = pdev->id;
> 
> Leave this blank for DT only devices (and for non-DT devices this won't
> work if you get two different buses).

Ok, will do. Thanks for the review.

Beniamino
