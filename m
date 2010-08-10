From: dzu@denx.de (Detlev Zundel)
Date: Tue, 10 Aug 2010 11:20:36 +0200
Subject: [PATCH 4/8] ARM i.MX: add SDMA driver
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
	<1281344743-2029-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <m2k4ny3jtn.fsf@ohwell.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> This patch adds DMA support for i.MX25/31/35/51 based SoCs.
> The SDMA engine is a scatter/gather DMA engine which is implemented
> as a seperate coprocessor. SDMA needs its own firmware which is
> requested using the standard request_firmware mechanism. The firmware
> has different entry points for each peripheral type, so drivers
> have to pass the peripheral type to the DMA engine which in turn
> picks the correct firmware entry point from a table contained in
> the firmware image itself.
> The original Freescale code also supports support for transfering
> data to the internal SRAM which needs different entry points to
> the firmware. Support for this is currently not implemented. Also,
> support for the ASRC (asymmetric sample rate converter) is skipped.
>
> This code has been tested with sound on i.MX31/35 and with SD/MMC on
> i.MX31. It should work on i.MX25/51, but this is currently untested.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx3/Kconfig             |    2 +
>  arch/arm/plat-mxc/Kconfig             |   10 +
>  arch/arm/plat-mxc/Makefile            |    1 +
>  arch/arm/plat-mxc/include/mach/sdma.h |    8 +
>  arch/arm/plat-mxc/sdma.c              | 1181 +++++++++++++++++++++++++++++++++
>  5 files changed, 1202 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/include/mach/sdma.h
>  create mode 100644 arch/arm/plat-mxc/sdma.c

[...]

> +	if (header->magic != SDMA_FIRMWARE_MAGIC)
> +		goto err_firmware;
> +	if (header->ram_code_start + header->ram_code_size > fw->size)
> +		goto err_firmware;
> +
> +	addr = (void *)header + header->script_addrs_start;
> +	ram_code = (void *)header + header->ram_code_start;
> +	memcpy(&__sdma_script_addrs, addr, sizeof(*addr));

As the firmware file is an external entity, I think it makes sense to
explicitely specify the endianness of 32-bit values and use endian
macros i.e. (le32_to_cpu) when accessing it.

Considering that Freescale (re)uses functional blocks in ARM and Power
Architecture chips, this may save efforts in the future.

Apart from this I would also welcome if the whole driver could be
adapted to the drivers/dma dmaengine API as pointed out by Linus
Walleij.  The dma controller support for the Power Architecture chips of
Freescale do implement this API, so this would also be a great step
towards code unification of drivers here.

Thanks
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu at denx.de
