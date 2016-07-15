From: briannorris@chromium.org (Brian Norris)
Date: Thu, 14 Jul 2016 19:31:52 -0700
Subject: [PATCH] spi: rockchip: limit transfers to (64K - 1) bytes
In-Reply-To: <131afa39-4287-0fb8-61f4-146283dc7cf0@rock-chips.com>
References: <1468546259-136659-1-git-send-email-briannorris@chromium.org>
 <131afa39-4287-0fb8-61f4-146283dc7cf0@rock-chips.com>
Message-ID: <20160715023152.GA145248@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, Jul 15, 2016 at 09:56:59AM +0800, Shawn Lin wrote:
> ? 2016/7/15 9:30, Brian Norris ??:
> >The Rockchip SPI controller's length register only supports 16-bits,
> >yielding a maximum length of 64KiB (the CTRLR1 register holds "length -
> >1"). Trying to transfer more than that (e.g., with a large SPI flash
> >read) will cause the driver to hang.
> 
> Brian, are you using dma or pio?

I forgot to mention, I'm using PIO. (The rk3399.dts in linux-next
doesn't even have the 'dma{s,-names}' properties listed for spi[0-5].)

> From huibing's feedback for rk3399, you can see...
> 
> root at rk3399:/ # echo read 0 1 0x10001 > /sys/slt/SPI.0/SPI.0

I don't know what that file is, but presumably it's some kind of bare
SPI test interface you have in your private tree?

> [148360.004332] f0041200:       DMAMOV CCR 0x804200
> [148360.004772] f0041206:       DMAMOV SAR 0xff1d0800
> [148360.005161] f004120c:       DMAMOV DAR 0xc9f60000
> [148360.005549] f0041212:       DMALP_0 255
> [148360.005866] f0041214:       DMALP_1 255
> [148360.006178] f0041216:       DMAWFPB 13
> [148360.006483] f0041218:       DMALDPB 13
> [148360.006788] f004121a:       DMASTA
> [148360.007061] f004121b:       DMAFLUSHP 13
> [148360.007380] f004121d:       DMALPENDA_1 bjmpto_7
> [148360.007763] f004121f:       DMALPENDA_0 bjmpto_b
> [148360.008144] f0041221:       DMAWFPB 13
> [148360.008448] f0041223:       DMALDPB 13
> [148360.008752] f0041225:       DMASTA
> [148360.009026] f0041226:       DMAFLUSHP 13
> [148360.009344] f0041228:       DMASEV 1
> [148360.009633] f004122a:       DMAEND
> [148360.147993] slt_spi_test spi32766.0: SPI transfer timed out
> [148360.148653] spi read 65537*1 cost 144493us speed:453KB/S

And this means a 64KiB + 1 transfer using DMA timed out?

> root at rk3399:/ #
> root at rk3399:/ # echo read 0 1 0x10000 > /sys/slt/SPI.0/SPI.0
> 
> [148365.172429] f0041200:       DMAMOV CCR 0x804200
> [148365.172863] f0041206:       DMAMOV SAR 0xff1d0800
> [148365.173252] f004120c:       DMAMOV DAR 0xc9f90000
> [148365.173641] f0041212:       DMALP_0 255
> [148365.173958] f0041214:       DMALP_1 255
> [148365.174270] f0041216:       DMAWFPB 13
> [148365.174574] f0041218:       DMALDPB 13
> [148365.174878] f004121a:       DMASTA
> [148365.175152] f004121b:       DMAFLUSHP 13
> [148365.175471] f004121d:       DMALPENDA_1 bjmpto_7
> [148365.175852] f004121f:       DMALPENDA_0 bjmpto_b
> [148365.176234] f0041221:       DMASEV 1
> [148365.176522] f0041223:       DMAEND
> [148365.207421] spi read 65536*1 cost 35144us speed:1864KB/S

And a 64KiB transfer using DMA completed successfully?

So maybe there's a driver bug in the PIO path that gives us an
off-by-one error. I poked around a bit and couldn't figure out anything,
so I sent this. Technically, this patch is still valid (even if not
optimal) for the DMA case too...

If you can't figure out what the difference is, and you really don't
want to unnecessarily limit the DMA case, then a last resort hack could
be to say:

static size_t rockchip_spi_max_transfer_size(struct spi_device *device)
{
	if (using dma) // this is obviously pseudocode
		return SZ_64K;
	else
		return SZ_64K - 1;
}

or something like that.

Brian
