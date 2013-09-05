From: pekon@ti.com (Gupta, Pekon)
Date: Thu, 5 Sep 2013 04:25:39 +0000
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130905020435.GA3970@gmail.com>
References: <1377828449-18912-1-git-send-email-b32955@freescale.com>
 <522697E9.1050208@freescale.com> <20130904095523.GT3084@sirena.org.uk>
 <52270B8E.5080402@freescale.com> <20130904113322.GA5859@sirena.org.uk>
 <20130905014350.GA2261@gmail.com>
 <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shijie,

> 
> > Hello Huang,
> >
> > >> In what way does the controller driver depend on those changes?
> > > This driver needs the spi nor command to fill the LUT register, such as
> > > OPCODE_WREN(0x06), so the patch 1 moves the spi nor command to a
> seprate
> > > header spi-nor.h, and this driver includes this new header.
> > >
> > Then some questions come up:
> > - Why does the spi controller need to know this?
> The hardware works in this way.
> > - What is this LUT register at all?
> Please see the patch 1.
> > - What happens if something different that a flash is connected and
> >    the data starts with one of these opcodes?
> Submit a new patch to fix it.
> 
This is not the correct approach, because for every NOR flash device
user needs to submit a patch to populate these LUT with CMD, OPERAND
and DUMMY values specific to that NOR device into these header files.
As the supported NOR device list grows, the header file would become
unmanageable and cluttered.

I would rather suggest to get these values from DT bindings specific to 
your fsl-qspi-controller. This way you would provide scalability without
affecting other framework. This should also help you to keep your 
MTD driver independent of QSPI-controller driver.

With regards, pekon
