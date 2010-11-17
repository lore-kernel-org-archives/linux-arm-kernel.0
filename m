From: cyril@ti.com (Cyril Chemparathy)
Date: Wed, 17 Nov 2010 12:35:37 -0500
Subject: [PATCH v5 04/12] spi: add ti-ssp spi master driver
In-Reply-To: <20101117161130.GC5757@angua.secretlab.ca>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
	<20101116072225.GF4074@angua.secretlab.ca>
	<AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q@mail.gmail.com>
	<4CE31F0E.7050103@ti.com>
	<20101117161130.GC5757@angua.secretlab.ca>
Message-ID: <4CE41269.2040303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2010 11:11 AM, Grant Likely wrote:
[...]
> To start, I'm not a fan of matching by name.  It's fragile because it
> makes assumptions about how devices will be names when they actually
> appear (ie. Sometimes .id is dynamically assigned).  Ideally I'd
> prefer to have direct references (ie. pointers) to the devices that
> need to be registered, which *shouldn't* be difficult to handle.  That
> guarantees that the correct device is always referenced.  (aside: the
> device-tree use case provides this information by having direct
> 'phandle' references between dependencies.)

The pointer approach is possibly problematic with devices that get
registered by other drivers/masters (mfd, spi, i2c, etc.).  With these
devices the board doesn't really have a reference to the device in question.

Something along the following lines may be better:

int device_requires(struct device *dev, const char *res);
int device_provides(struct device *provider, const char *res);

where res is a string of the form "gpio:25", "regulator:vlcd", or even
"dev:<dev_name>".

device_requires() would typically be used by board implementations, and
device_provides() would be called by gpiolib, regulator core, device
core, etc.

I guess this is somewhat along the lines of an earlier discussion on the
PPC list ([1] below), except that the drivers don't get probed until
specified prereqs are available.

Regards
Cyril.

[1] http://www.spinics.net/lists/linux-embedded/msg02764.html
