From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Aug 2012 14:45:09 +0000
Subject: [PATCH 4/5] arm: mvebu: add basic address decoding support to
 Armada 370/XP
In-Reply-To: <1344003237-13575-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1344003237-13575-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1344003237-13575-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201208031445.10102.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 August 2012, Thomas Petazzoni wrote:
> +static void __iomem *
> +armada_cfg_base(const struct orion_addr_map_cfg *cfg, int win)
> +{
> +       unsigned int offset;
> +
> +       /* The register layout is a bit annoying and the below code
> +        * tries to cope with it.
> +        * - At offset 0x0, there are the registers for the first 8
> +        *   windows, with 4 registers of 32 bits per window (ctrl,
> +        *   base, remap low, remap high)
> +        * - Then at offset 0x80, there is a hole of 0x10 bytes for
> +        *   the internal registers base address and internal units
> +        *   sync barrier register.
> +        * - Then at offset 0x90, there the registers for 12
> +        *   windows, with only 2 registers of 32 bits per window
> +        *   (ctrl, base).
> +        */
> +       if (win < 8)
> +               offset = (win << 4);
> +       else
> +               offset = ARMADA_WINDOW_8_PLUS_OFFSET + (win << 3);
> +
> +       return (void __iomem *)(cfg->bridge_virt_base + offset);
> +}
> +

This cast can go away now that the type is already correct. Other
than that, the patch looks fine.

	Arnd
