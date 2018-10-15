From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Mon, 15 Oct 2018 11:58:43 +0000
Subject: [PATCH v2 0/7] spi: add support for octal mode
In-Reply-To: <20181015135408.49142c88@bbrezillon>
References: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181015135408.49142c88@bbrezillon>
Message-ID: <VI1PR04MB1038DA393DB625463800956699FD0@VI1PR04MB1038.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon at bootlin.com]
> Sent: Monday, October 15, 2018 5:24 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd at lists.infradead.org; marek.vasut at gmail.com; vigneshr at ti.com;
> linux-spi at vger.kernel.org; devicetree at vger.kernel.org; robh at kernel.org;
> mark.rutland at arm.com; shawnguo at kernel.org; linux-arm-
> kernel at lists.infradead.org; computersforpeace at gmail.com;
> frieder.schrempf at exceet.de; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v2 0/7] spi: add support for octal mode
> 
> Hi Yogesh,
> 
> On Mon, 15 Oct 2018 11:47:55 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
> > Add support for octal mode IO data transfer.
> > Micron flash, mt35xu512aba, supports octal mode data transfer and NXP
> > FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).
> >
> > Patch series
> > * Add support for octal mode flags and parsing of same in spi driver.
> > * Add opcodes for octal I/O commands in spi-nor framework, Read and Write
> proto for (1-1-8/1-8-8) mode.
> >   Opcodes are added as per octal data IO commands required for
> mt35xu512aba [1] flash.
> > * Add parsing logic for spi-mem framework and m25p80.c device file.
> > * Add mode bit required for octal mode in nxp-fspi driver [2].
> > * Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].
> >
> > Cherry pick below 2 patches (from:
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ker
> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbroonie%2Fspi.git&amp;da
> ta=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C9af69996cae344b6e7b70
> 8d63294eaf5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6367520
> 12521352025&amp;sdata=euwK9X2tael3Q69QO%2BirRznB%2BHKazDbumdAOp
> eZvxCc%3D&amp;reserved=0):
> >     c639f871febe6667d9afce28108c634e5636c735 spi: spi-mem: Fix inverted
> logic in op sanity check
> >     db122eb8a749a1eff038f9a282c620ab16c4be1d spi: spi-mem: Add extra
> > sanity checks on the op param
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
> mtd%2Flist%2F%3Fseries%3D70384&amp
> > ;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C9af69996cae344b6e
> 7b708d
> >
> 63294eaf5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636752012
> 521352
> >
> 025&amp;sdata=ldk0ny8vksO%2FayIsYX26M4akFUojtaP1YyOtpMEGJZA%3D&a
> mp;res
> > erved=0 [2]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> > chwork.ozlabs.org%2Fproject%2Flinux-
> mtd%2Flist%2F%3Fseries%3D70210&amp
> > ;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C9af69996cae344b6e
> 7b708d
> >
> 63294eaf5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636752012
> 521352
> >
> 025&amp;sdata=wq%2BCnrk4Ovx4itHrZfv%2FGH5raStF91hfjHBQmO9Sjq0%3D&
> amp;r
> > eserved=0
> >
> > Yogesh Gaur (7):
> >   spi: add support for octal I/O data transfer
> >   mtd: spi-nor: add opcodes for octal Read/Write commands
> >   mtd: spi-nor: add octal read flag for flash mt35xu512aba
> >   mtd: m25p80: add support of octal I/O transfer
> >   spi: spi-mem: add support for octal I/O data transfer
> 
> Patch 5 should be moved before patch 4 (ideally in 2nd position) if you want this
> series to be bisectable.
> 

Ok.
For now, order which I have selected is as per the comments from Vignesh. Would resend again with the suggested order.

--
Regards
Yogesh Gaur

> Regards,
> 
> Boris
> 
> >   spi: nxp-fspi: add mode flag bit for octal support
> >   arm64: dts: lx2160a: update fspi node
> >
> > Changes for v2:
> >  Incorporated review comments of Boris and Vignesh.
> >
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
> >  drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
> >  drivers/mtd/spi-nor/spi-nor.c                     | 15 ++++++++++++++-
> >  drivers/spi/spi-mem.c                             |  9 ++++++++-
> >  drivers/spi/spi-nxp-fspi.c                        |  4 ++--
> >  drivers/spi/spi.c                                 |  6 ++++++
> >  include/linux/mtd/spi-nor.h                       |  8 ++++++++
> >  include/linux/spi/spi.h                           |  2 ++
> >  8 files changed, 52 insertions(+), 5 deletions(-)
> >
