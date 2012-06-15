From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jun 2012 09:12:56 +0000
Subject: [PATCH v3 3/9] arm: mach-mvebu: add source files
In-Reply-To: <1339746250-26650-4-git-send-email-gregory.clement@free-electrons.com>
References: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
 <1339746250-26650-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201206150912.57190.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 June 2012, Gregory Clement wrote:
> +static int __init mvebu_system_controller_init(void)
> +{
> +       struct device_node *np;
> +
> +       np = of_find_compatible_node(NULL, NULL, "marvell,system-controller");
> +       if (!np) {
> +               pr_warn("No marvell,system-controller found\n");
> +               return -ENODEV;
> +       }

Much better than before, but there are now two problems:

* You look for a generic "marvell,system-controller" node, which does not tell
  you at all which kind it is. I'm sure that inside of Marvell there has been more
  than one peripheral that can be described as a system controller, so please
  be more specific here.

* You should not issue a warning if the device is not found. The initialization
  comes from a platform independent arch_initcall, so in a future combined
  kernel, it will be executed on all machines including non-Marvell ones.

	Arnd
