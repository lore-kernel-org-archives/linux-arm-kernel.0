From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 16 Nov 2010 00:47:04 -0700
Subject: [PATCH v5 04/12] spi: add ti-ssp spi master driver
In-Reply-To: <20101116072225.GF4074@angua.secretlab.ca>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
	<20101116072225.GF4074@angua.secretlab.ca>
Message-ID: <AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 12:22 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Mon, Nov 15, 2010 at 02:12:06PM -0500, Cyril Chemparathy wrote:
>> This patch adds an SPI master implementation that operates on top of an
>> underlying TI-SSP port.
>>
>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> [...]
>> +static int __init ti_ssp_spi_init(void)
>> +{
>> + ? ? return platform_driver_register(&ti_ssp_spi_driver);
>> +}
>> +subsys_initcall(ti_ssp_spi_init);
>
> After discussions about device init dependencies at plumbers, and
> since this is the first SPI device driver I've reviewed since that
> dicussion, this driver gets to be the first to implement the proposed
> policy. ?:-)
>
> Change this to module_initcall(). ?Many spi and i2c drivers use
> module or subsys_initcall to try and influence driver probe order so
> that certain regulator chips get registered before the devices that
> try to use them. ?This approach is insane.
>
> Instead, it is now incumbent on the board support code to ensure that
> any device that depends on another device (including i2c or spi
> regulators) will defer registration until the prerequisite devices are
> bound to drivers.
>
> I don't *think* this change will affect anything in this particular
> patch series, but if it does then let me know and I'll help you work out
> how to fix it using a bus notifier.

Oh, wait, spoke too soon.  You do add a regulator in this series, so
this change will require a fixup.  The solution is to register an
bus_notifier to the spi bus type before you start registering devices.
It also requires deferring the musb_hdrc.1 and tps6116x registrations
until the bus_notifier callback gets called with an indication that
the regulator is bound.  It will look something like this:

static int tnetv107x_spi_notifier_call(struct notifier_block *nb,
				unsigned long event, void *__dev)
{
	struct device *dev = __dev;

	if ((event == BUS_NOTIFY_BOUND_DRIVER) && (dev == (the-regulator))) {
		register-the-remaining-devices();
		return NOTIFY_STOP;
	};
	return NOTIFY_DONE;
}

static struct notifier_block tnetv107x_spi_nb = {
	.notifier_call = tnetv107x_spi_notifier_call,
};

and then in the device registration code, before registering the
regulator:

	bus_register_notifier(&spi_bus_type, &tnetv107x_spi_nb);

Let me know if you have any trouble.

g.
