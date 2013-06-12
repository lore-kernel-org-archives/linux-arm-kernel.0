From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Jun 2013 14:05:11 +0100
Subject: [PATCH 1/3] ARM: dts: Add headers with constants for MTD
 partitions
In-Reply-To: <1370962138-9631-2-git-send-email-florian.vaussard@epfl.ch>
References: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch>
 <1370962138-9631-2-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20130612130511.CE3D93E0A56@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Jun 2013 16:48:56 +0200, Florian Vaussard <florian.vaussard@epfl.ch> wrote:
> These constants can be used to easily declare MTD partitions inside
> DTS.
> 
> The constants MTDPART_OFS_* are purposely not included. Indeed,
> parse_ofpart_partitions() is expecting u64, but a DT cell is u32.
> Negative constants, as defined by MTDPART_OFS_*, would be wrongly

The DT binding uses the number of cells defined by #address-cells. It is
not fixed to a u32 or a u64

> interpreted by parse_ofpart_partitions(). Two cells should be
> used to correctly encode the negative constants, but this breaks
> current usage.

The binding doesn't even allow for shortcuts like MTDPART_SIZ_FULL. If a
partition fills the whole device, then the reg property should include
the actual size. If the code is allowing '0' to be used to mean
MTDPART_SIZ_FULL, then that is a bug that needs to be fixed.

Please drop the mtd/partitions.h hunk from this patch.

g.

> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  include/dt-bindings/mtd/partitions.h |   12 ++++++++
>  include/dt-bindings/sizes.h          |   52 ++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+), 0 deletions(-)
>  create mode 100644 include/dt-bindings/mtd/partitions.h
>  create mode 100644 include/dt-bindings/sizes.h
> 
> diff --git a/include/dt-bindings/mtd/partitions.h b/include/dt-bindings/mtd/partitions.h
> new file mode 100644
> index 0000000..7dfa676
> --- /dev/null
> +++ b/include/dt-bindings/mtd/partitions.h
> @@ -0,0 +1,12 @@
> +/*
> + * This header provides constants used with MTD partitions.
> + */
> +
> +#ifndef _DT_BINDINGS_MTD_PARTITIONS_H
> +#define _DT_BINDINGS_MTD_PARTITIONS_H
> +
> +/* Partition size */
> +#define MTDPART_SIZ_FULL	0
> +
> +#endif
> +
> diff --git a/include/dt-bindings/sizes.h b/include/dt-bindings/sizes.h
> new file mode 100644
> index 0000000..995f2de
> --- /dev/null
> +++ b/include/dt-bindings/sizes.h
> @@ -0,0 +1,52 @@
> +/*
> + * This header provides size constants.
> + *
> + * Original version:
> + *   include/linux/sizes.h
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _DT_BINDINGS_SIZES_H
> +#define _DT_BINDINGS_SIZES_H
> +
> +#define SZ_1				0x00000001
> +#define SZ_2				0x00000002
> +#define SZ_4				0x00000004
> +#define SZ_8				0x00000008
> +#define SZ_16				0x00000010
> +#define SZ_32				0x00000020
> +#define SZ_64				0x00000040
> +#define SZ_128				0x00000080
> +#define SZ_256				0x00000100
> +#define SZ_512				0x00000200
> +
> +#define SZ_1K				0x00000400
> +#define SZ_2K				0x00000800
> +#define SZ_4K				0x00001000
> +#define SZ_8K				0x00002000
> +#define SZ_16K				0x00004000
> +#define SZ_32K				0x00008000
> +#define SZ_64K				0x00010000
> +#define SZ_128K				0x00020000
> +#define SZ_256K				0x00040000
> +#define SZ_512K				0x00080000
> +
> +#define SZ_1M				0x00100000
> +#define SZ_2M				0x00200000
> +#define SZ_4M				0x00400000
> +#define SZ_8M				0x00800000
> +#define SZ_16M				0x01000000
> +#define SZ_32M				0x02000000
> +#define SZ_64M				0x04000000
> +#define SZ_128M				0x08000000
> +#define SZ_256M				0x10000000
> +#define SZ_512M				0x20000000
> +
> +#define SZ_1G				0x40000000
> +#define SZ_2G				0x80000000
> +
> +#endif
> +
> -- 
> 1.7.5.4
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
