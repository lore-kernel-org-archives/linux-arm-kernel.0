From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 4 Oct 2011 17:48:05 -0600
Subject: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111004230127.GB32102@n2100.arm.linux.org.uk>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
	<20111004230127.GB32102@n2100.arm.linux.org.uk>
Message-ID: <20111004234805.GJ3009@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2011 at 12:01:27AM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 27, 2011 at 01:10:04PM +0100, Mark Brown wrote:
> > On Tue, Sep 27, 2011 at 03:42:45PM +0530, Rajendra Nayak wrote:
> > 
> > > +	init_data = devm_kzalloc(dev, sizeof(struct regulator_init_data),
> > > +						 GFP_KERNEL);
> > > +	if (!init_data)
> > > +		return NULL; /* Out of memory? */
> > 
> > This means that the init data will be kept around for the entire
> > lifetime of the device rather than being discarded.
> 
> May I remind you that devm_* lifetime expires whenever the associated
> driver is unbound, which can be much shorter than the lifetime of the
> struct device.
> 
> It expires when any of the following occurs:
> 1. userspace asks the associated driver to be unbound
> 2. the driver is removed
> 3. any driver probe for this struct device fails
> 4. the struct device is unregistered.
> 
> So: don't use devm_* for anything other than stuff inside a driver being
> associated with the struct device itself.  Other uses are a bug waiting
> to happen.

Yes, Russell is right.  There were a number of places where I
suggested using devm_* in entirely the wrong places.  Double check
anyplace where you've added devm_ calls.

g.
