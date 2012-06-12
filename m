From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jun 2012 08:45:48 +0000
Subject: [PATCH v2 2/8] arm: mach-mvebu: add source files
In-Reply-To: <1339433585-28087-3-git-send-email-gregory.clement@free-electrons.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <1339433585-28087-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201206120845.48902.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 June 2012, Gregory CLEMENT wrote:
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> new file mode 100644
> index 0000000..72d39e5
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -0,0 +1,7 @@
> +if ARCH_MVEBU
> +
> +menu "Marvell SOC with device tree"
> +
> +endmenu
> +
> +endif

The "with device tree" part is implied here, so you should not need to
mention it, but it would be good if you could say which SOC this
relates to, i.e. not the pxa/mmp series but the other line, in whatever
way you want to name it.

> +static struct map_desc mvebu_io_desc[] __initdata = {
> +	{
> +		.virtual	= MVEBU_REGS_VIRT_BASE,
> +		.pfn		= __phys_to_pfn(MVEBU_REGS_PHYS_BASE),
> +		.length		= MVEBU_REGS_SIZE,
> +		.type		= MT_DEVICE,
> +	},
> +};
> +
> +void __init mvebu_map_io(void)
> +{
> +	iotable_init(mvebu_io_desc, ARRAY_SIZE(mvebu_io_desc));
> +}

It looks like MVEBU_REGS_PHYS_BASE is common between Armada XP and
Armada 370, but is different for the other ones we want to support
here (kirkwood, orion5x, mv78xx0, dove), so the name seems to be
inappropriate. I would recommend dropping the entire file and just
leaving the map_desc in the individual soc specific files, even
thouth that means you have two identical calls here.

	Arnd
