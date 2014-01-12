From: ben@decadent.org.uk (Ben Hutchings)
Date: Sun, 12 Jan 2014 03:57:07 +0000
Subject: [PATCH 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <1388678476-12875-2-git-send-email-gregory.clement@free-electrons.com>
References: <1388678476-12875-1-git-send-email-gregory.clement@free-electrons.com>
 <1388678476-12875-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1389499027.3720.42.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-01-02 at 17:01 +0100, Gregory CLEMENT wrote:
> All the mvebu SoCs have information related to their variant and
> revision that can be read from the PCI control register.
> 
> This patch adds support for Armada XP and Armada 370. This reading of
> the revision and the ID are done before the PCI initialization to
> avoid any conflicts. Once these data are retrieved, the resources are
> freed to let the PCI subsystem use it.
[...]
> --- /dev/null
> +++ b/include/linux/mvebu-soc-id.h
> @@ -0,0 +1,32 @@
> +/*
> + * Marvell EBU SoC ID and revision definitions.
> + *
> + * Copyright (C) 2014 Marvell Semiconductor
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __LINUX_MVEBU_SOC_ID_H
> +#define __LINUX_MVEBU_SOC_ID_H
> +
> +/* Armada XP ID */
> +#define MV78230_DEV_ID	    0x7823
> +#define MV78260_DEV_ID	    0x7826
> +#define MV78460_DEV_ID	    0x7846
> +
> +/* Armada XP Revision */
> +#define MV78XX0_A0_REV	    0x1
> +#define MV78XX0_B0_REV	    0x2
> +
> +#ifdef CONFIG_ARCH_MVEBU
> +int mvebu_get_soc_id(u32 *dev, u32 *rev);
> +#else
> +int mvebu_get_soc_id(u32 *dev, u32 *rev)

This definition needs to be static inline, assuming anything will
actually include this header when !defined(CONFIG_ARCH_MVEBU).

Ben.

> +{
> +	return -1;
> +}
> +#endif
> +
> +#endif /* __LINUX_MVEBU_SOC_ID_H */

-- 
Ben Hutchings
Quantity is no substitute for quality, but it's the only one we've got.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140112/0c7921e9/attachment.sig>
