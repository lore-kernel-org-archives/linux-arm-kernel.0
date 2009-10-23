From: ospite@studenti.unina.it (Antonio Ospite)
Date: Fri, 23 Oct 2009 11:50:28 +0200
Subject: [WARNING] pxamci: 'pxa2xx-mci.0' does not have a release()
	function.
In-Reply-To: <20091022225758.GA9106@n2100.arm.linux.org.uk>
References: <20091023003631.1331a60a.ospite@studenti.unina.it>
	<20091022225758.GA9106@n2100.arm.linux.org.uk>
Message-ID: <20091023115028.59ed7f74.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Oct 2009 23:57:58 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Fri, Oct 23, 2009 at 12:36:31AM +0200, Antonio Ospite wrote:
> > Hi,
> > 
> > I get this warning on shutdown. How to fix it properly?
> > 
> > FYI, in my setup pxa2xx_spi is the parent for pxamci, set using
> > this patch:
> > http://git.openezx.org/openezx.git?a=commitdiff;h=0ffd85ad8faea3456d4ecf5f63ae65aca26fff21
> 
> This sounds like it's the cause of the problem - from the backtrace, it
> looks like SPI expects the children of the SPI device to be its own
> responsibility to maintain.
> 
> Hence, because you've made pxamci a child of SPI, SPI is trying to
> unregister and release the pxamci device.

A little more background: we need pxamci to be a child of SPI because
our PMIC is connected via SPI, and a PMIC regulator is used for mmc
powering; enforcing this hierarchy is needed to make pxamci suspend and
resume properly.

The board init does:
	spi_pd = platform_device_alloc("pxa2xx-spi", 1);
	spi_pd->dev.platform_data = &ezx_spi_masterinfo;
	platform_device_add(spi_pd);
	spi_register_board_info(ARRAY_AND_SIZE(a780_spi_boardinfo));

	pxa_set_mci_parent(&spi_pd->dev);
	pxa_set_mci_info(&ezx_mci_platform_data);

Now, do you suggest to adapt pxamci so it supports the case when
another driver wants to release it? I am not sure how to do that, tho.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091023/6e44a83b/attachment-0001.sig>
