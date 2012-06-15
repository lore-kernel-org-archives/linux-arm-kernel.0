From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 15 Jun 2012 12:07:34 +0200
Subject: [PATCH v3 3/9] arm: mach-mvebu: add source files
In-Reply-To: <1339746250-26650-4-git-send-email-gregory.clement@free-electrons.com>
References: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
 <1339746250-26650-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20120615100734.GJ26034@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +/* System controller registers */
> +#define MVEBU_RSTOUTN_MASK_OFFSET	  0x60
> +#define   MVEBU_RSTOUTN_MASK_RESET_OUT_EN  0x1
> +#define MVEBU_SYSTEM_SOFT_RESET_OFFSET	  0x64
> +#define   MVEBU_SYSTEM_SOFT_RESET          0x1

$ grep -hr "#define RSTOUTn "*
#define RSTOUTn_MASK            (BRIDGE_VIRT_BASE | 0x0108)
#define RSTOUTn_MASK            (ORION5X_BRIDGE_VIRT_BASE | 0x108)
#define RSTOUTn_MASK            (BRIDGE_VIRT_BASE | 0x0108)
#define RSTOUTn_MASK            (BRIDGE_VIRT_BASE | 0x0108)

$ grep -rh "#define SYSTEM_SOFT_RESET" *
#define SYSTEM_SOFT_RESET       (BRIDGE_VIRT_BASE | 0x010c)
#define SYSTEM_SOFT_RESET       (BRIDGE_VIRT_BASE | 0x010c)
#define SYSTEM_SOFT_RESET       (BRIDGE_VIRT_BASE | 0x010c)
/* Orion5x also puts it at 0x10c, but has a different name! */

So, it looks like the Marvell ASIC engineers moved it for the latest
SoCs. Could you add a child property of marvell,system-controller
which indicates where within the system controller the reset
subcontroller is? Since the two registers are always next to each
other, we just need one address.

Thanks
	Andrew
