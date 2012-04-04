From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 4 Apr 2012 02:57:22 +0100 (BST)
Subject: linux-3.4-rc1 PXA2xx PCMCIA possible regression
Message-ID: <1333504642.26202.YahooMailClassic@web29009.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On linux-3.3 the PCMCIA/CF on my hx4700 worked OK.

On linux-3.4-rc1 the PCMCIA/CF has stopped working:

pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 156)
pata_pcmcia: probe of 0.0 failed with error -12

I've traced the -ENOMEM error back to pcmcia_init_one() in
drivers/ata/pata_pcmcia.c:

   237		/* iomap */
   238		ret = -ENOMEM;
   239		io_addr = devm_ioport_map(&pdev->dev, io_base, 8);
   240		ctl_addr = devm_ioport_map(&pdev->dev, ctl_base, 1);
   241		if (!io_addr || !ctl_addr)
   242			goto failed;

Both calls to devm_ioport_map() return NULL.

The ultimate source of both NULL values appears to be __io() and
thence __typesafe_io(), both defined in arch/arm/include/asm/io.h
