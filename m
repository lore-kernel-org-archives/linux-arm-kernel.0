From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 17 Sep 2013 03:25:25 +0200
Subject: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
In-Reply-To: <20130916233111.GB21013@sirena.org.uk>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1861747.RtS0ZLgUUN@vostro.rjw.lan> <20130916233111.GB21013@sirena.org.uk>
Message-ID: <1820315.QOOAzSjac3@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 17, 2013 12:31:11 AM Mark Brown wrote:
> On Mon, Sep 16, 2013 at 09:07:07PM +0200, Rafael J. Wysocki wrote:
> 
> > That may be left to the client driver altogether.  I mean, if the client wants
> > the controller to be powered up, it should just call
> > pm_runtime_get_sync(controller device) at a suitable place (and then do the
> > corresponding _put when the controller is not necessary anu more) from its
> > ->probe() callback.
> 
> It shouldn't even need to do that, it should just be able to rely on the
> controller to power itself up when asked to do work.   This is how the
> existing implementations are done - the controller power management is
> totally transparent to the slave.

If both the I2C client and I2C controller have corresponding objects in the
ACPI namespace and the client's object is a child of the controller's object,
then in order to power up the client we need to power up the controller even
if no transactions are going to be carried out.  That's what the spec simply
requires us to do in that case.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
