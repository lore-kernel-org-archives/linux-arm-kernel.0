From: ben@decadent.org.uk (Ben Hutchings)
Date: Thu, 04 Sep 2014 03:11:29 +0100
Subject: Autoloading of SPI/nor driver on kirkwood (qnap devices)
In-Reply-To: <1409673299.14324.43.camel@dagon.hellion.org.uk>
References: <1409673299.14324.43.camel@dagon.hellion.org.uk>
Message-ID: <1409796689.27524.34.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-09-02 at 16:54 +0100, Ian Campbell wrote:
> Hello,
> 
> I recently tried to switch to using the DT based kirkwood stuff with
> v3.16.1 on a QNAP TS-419 for the Debian kernel. Most things seemed ok
> except that the flash driver was not autoloaded -- as well as spi-nor.ko
> I had to manually modprobe m25p80.ko. Once I loaded both the flash was
> detected.
> 
> I noticed that many platforms declare the flash chip as compatible =
> "st,m25pXXX" whereas the ts219.dtsi just said m25p128 but I tried
> changing that and it didn't help. In any case without spi-nor.ko being
> autoloaded I don't support m25p80.ko ever would be.

m25p80.c has:

static struct spi_driver m25p80_driver = {
	...
	.id_table	= spi_nor_ids,
	...
};

while spi_nor_ids is defined in spi-nor.c.  Since they end up as two
separate modules, modpost can't read the ID table and add the device ID
aliases to m25p80.ko.

It looks like m25p80 has been split up in order that the new fsl-qspi
driver can share its code (bypassing the SPI core and its device
model!).  Why doesn't fsl-qspi implement an SPI controller device?  I
think it is totally unacceptable to regress m25p80 in this way for the
sake of a new driver.

> I could set these things to =m for the Debian kirkwood flavour, but
> since this is supposed to be a distro-style kernel.
> 
> I'm not entirely sure how module loading of this SPI stuff is supposed
> to fit together -- anyone got any hints?

Same as for any bus driver.

Ben.

-- 
Ben Hutchings
Experience is directly proportional to the value of equipment destroyed.
                                                         - Carolyn Scheppner
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140904/f6059f39/attachment.sig>
