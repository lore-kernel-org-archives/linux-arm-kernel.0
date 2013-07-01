From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 01 Jul 2013 14:56:36 +0200
Subject: [PATCH 1/2] ARM: dts: mx53qsb: Enable VPU support
In-Reply-To: <1372459759-10488-1-git-send-email-festevam@gmail.com>
References: <1372459759-10488-1-git-send-email-festevam@gmail.com>
Message-ID: <1372683396.4971.35.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Am Freitag, den 28.06.2013, 19:49 -0300 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Enable Video Processing Unit (VPU) support.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Depends on Philipp Zabel's patch:
> [PATCH] ARM: dts: add sram for imx53 and imx6q
> 
> Philipp,
> 
> I tried using the original mx53 vpu firmware that comes with the FSL BSP, but it
> failed to load:
> 
> coda 63ff4000.vpu: firmware get command error                                   
> coda 63ff4000.vpu: HW initialization failed  
> 
> Any suggestions?
> 
> Thanks!

/*
 * The CODA driver needs the raw firmware without header in memory order.
 * This is how I converted vpu_fw_imx53.bin from the Freescale BSP into
 * v4l2-coda7541-imx53.bin:
 */

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>

struct fw_header_info {
	u_int8_t  platform[12];
	u_int32_t size;
};

int main(int argc, char *argv[])
{
	int fd, i, n, size;
	struct fw_header_info header;
	u_int32_t *buf;

	if (argc < 3) {
		fprintf(stderr, "usage: %s <infile> <outfile>\n", argv[0]);
		fprintf(stderr, "example: %s vpu_fw_imx53.bin v4l2-coda7541-imx53.bin\n", argv[0]);
		return 0;
	}

	fd = open(argv[1], O_RDONLY);
	if (fd < 0) {
		fprintf(stderr, "Failed to open source file '%s'.\n", argv[1]);
		return EXIT_FAILURE;
	}

	n = read(fd, &header, sizeof(header));
	if (n != sizeof(header)) {
		fprintf(stderr, "Failed to read header.\n");
		return EXIT_FAILURE;
	}

	size = header.size * sizeof(u_int16_t);
	buf = malloc(size);
	if (buf == NULL)
		return EXIT_FAILURE;

	n = read(fd, buf, size);
	if (n != size) {
		fprintf(stderr, "Failed to read firmware.\n");
		return EXIT_FAILURE;
	}

	close(fd);

	for (i = 0; i < size / 4; i += 2) {
		u_int32_t tmp = buf[i + 1] << 16 | buf[i + 1] >> 16;
		buf[i + 1] = buf[i] << 16 | buf[i] >> 16;
		buf[i] = tmp;
	}

	fd = open(argv[2], O_RDWR | O_CREAT, 0644);
	if (fd < 0)
		error("Failed to open target file '%s'.\n", argv[2]);

	n = write(fd, buf, size);
	if (n != size)
		error("Failed to write reordered firmware\n");

	close(fd);

	return 0;
}

/*
 * regards
 * Philipp
 */
