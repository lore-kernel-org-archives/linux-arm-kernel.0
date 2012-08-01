From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 1 Aug 2012 09:38:07 +0200
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <20120801074051.GG1672@S2100-06.ap.freescale.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <201208010810.37652.marex@denx.de>
 <20120801063936.GC2764@roeck-us.net>
 <201208010845.19361.marex@denx.de>
 <20120801074051.GG1672@S2100-06.ap.freescale.net>
Message-ID: <20504.56543.699097.320114@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo writes:
> On Wed, Aug 01, 2012 at 08:45:19AM +0200, Marek Vasut wrote:
> > > I must be missing something.  Why do almost all spi drivers call it in the
> > > error path, even if there is no call to spi_master_get ?
> > 
> > To push the refcounting to 0, to deallocate the device, I'd say ...
> > 
> It's not going to work if spi_master_put is called without
> spi_master_get being called before that.
> 
spi_alloc_master() calls device_initialize() which resuires a
device_put() (called from spi_master_put()) to free the device.

Thus each call of either spi_alloc_master() or spi_master_get() must
be paired with an spi_master_put() call to free the resources.

The kfree() is taken care of by the spi_master_release() function that
is called once the last reference to the underlying struct device has
been released. Thus kfree() must not be called after
spi_alloc_master().


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
