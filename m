From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Oct 2011 00:01:27 +0100
Subject: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20110927121003.GB4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
Message-ID: <20111004230127.GB32102@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 01:10:04PM +0100, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:42:45PM +0530, Rajendra Nayak wrote:
> 
> > +	init_data = devm_kzalloc(dev, sizeof(struct regulator_init_data),
> > +						 GFP_KERNEL);
> > +	if (!init_data)
> > +		return NULL; /* Out of memory? */
> 
> This means that the init data will be kept around for the entire
> lifetime of the device rather than being discarded.

May I remind you that devm_* lifetime expires whenever the associated
driver is unbound, which can be much shorter than the lifetime of the
struct device.

It expires when any of the following occurs:
1. userspace asks the associated driver to be unbound
2. the driver is removed
3. any driver probe for this struct device fails
4. the struct device is unregistered.

So: don't use devm_* for anything other than stuff inside a driver being
associated with the struct device itself.  Other uses are a bug waiting
to happen.
