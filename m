From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Thu, 4 Oct 2018 09:28:05 +0000
Subject: [PATCH 0/4] spi: add support for octal mode data transfer
In-Reply-To: <43cff872-0dc5-d3ce-ca35-082faa0e0e7c@ti.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <43cff872-0dc5-d3ce-ca35-082faa0e0e7c@ti.com>
Message-ID: <VI1PR04MB103828C628A6550F7E1B942E99EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vignesh,

> -----Original Message-----
> From: Vignesh R [mailto:vigneshr at ti.com]
> Sent: Thursday, October 4, 2018 2:52 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd at lists.infradead.org; boris.brezillon at bootlin.com; marek.vasut at gmail.com;
> linux-spi at vger.kernel.org; devicetree at vger.kernel.org
> Cc: robh at kernel.org; mark.rutland at arm.com; shawnguo at kernel.org; linux-
> arm-kernel at lists.infradead.org; computersforpeace at gmail.com;
> frieder.schrempf at exceet.de; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 0/4] spi: add support for octal mode data transfer
> 
> Hi Yogesh,
> 
> On Thursday 04 October 2018 02:18 PM, Yogesh Gaur wrote:
> > Add support for octal mode IO data transfer.
> > Micron flash, mt35xu512aba, supports octal mode data transfer and NXP
> > FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).
> >
> > Patch series
> > * Add support for octal mode flags and parsing of same in spi driver.
> > * Add octal data communication commands required for mt35xu512aba [1]
> flash.
> > * Add support for Read and Write proto for (1-1-8/1-8-8) mode.
> > * Add mode bit required for octal mode in nxp-fspi driver [2].
> > * Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].
> >
> > Tested on LX2160ARDB target with nxp-fspi driver, below are Read
> > performance number of 1-1-1 and 1-1-8 read protocol.
> >
> >  root at lxxx:~# cat /proc/mtd
> >  dev:    size   erasesize  name
> >  mtd0: 04000000 00001000 "spi0.0"
> >  mtd1: 04000000 00001000 "spi0.1"
> >  root at lxxx:~# time mtd_debug read /dev/mtd0 0x0 0x1000000 0read
> > Copied 16777216 bytes from address 0x00000000 in flash to 0read
> >
> >  real    0m2.792s
> >  user    0m0.000s
> >  sys     0m2.790s
> >  root at lxxx:~# time mtd_debug read /dev/mtd1 0x0 0x1000000 0read
> > Copied 16777216 bytes from address 0x00000000 in flash to 0read
> >
> >  real    0m0.441s
> >  user    0m0.000s
> >  sys     0m0.440s
> >  root at ls1012ardb:~#
> >
> >  Flash device MTD0 configured in 1-1-1 protocol.
> >  Flash device MTD1 configured in 1-1-8 protocol.
> >
> > [1]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> > chwork.ozlabs.org%2Fproject%2Flinux-
> mtd%2Flist%2F%3Fseries%3D66317&amp
> > ;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C7aae8ba71d80420d4
> 49f08d
> >
> 629dad44d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636742417
> 189300
> >
> 574&amp;sdata=xsSpmoRzDKJ9Z6O56kTG5pHPojjmUfSz9rB5cWQlPEM%3D&am
> p;reser
> > ved=0 [2]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> > chwork.ozlabs.org%2Fproject%2Flinux-
> mtd%2Flist%2F%3Fseries%3D66887&amp
> > ;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C7aae8ba71d80420d4
> 49f08d
> >
> 629dad44d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636742417
> 189300
> >
> 574&amp;sdata=oFsfTtpt0GDi3y0Fi%2B%2F9SFp8ZvbwPPe5qMNFIwVw7wE%3D
> &amp;r
> > eserved=0
> >
> > Yogesh Gaur (4):
> >   spi: add support for octal I/O data transfer
> >   mtd: spi-nor: add support for octal mode data transfer
> >   spi: nxp-fspi: add mode flag bit for octal support
> >   arm64: dts: lx2160a: update fspi node
> 
> This is a bit confusing and difficult to follow. I suggest to order patches such that
> spi-nor layer changes are at the first, then m25p80 related things, followed by
> spi-mem (if needed spi) changes and finally spi-mem controller driver changes.
> 

Thanks for the comment.
Would change the patch order as suggested and break the functionality in small patches as suggested by Boris.

--
Regards
Yogesh Gaur

> --
> Regards
> Vignesh
