From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 4 Jan 2012 15:20:33 -0800
Subject: [PATCH 4/9] arm/tegra: fuse: add functions to access chip revision
In-Reply-To: <1324599468-12845-5-git-send-email-olof@lixom.net>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
 <1324599468-12845-5-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F156A@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Thursday, December 22, 2011 5:18 PM:
> Add function to get chip revision, and print it out at boot time.
> 
> Restructure the fuse access to just use cached variables instead
> of always reading the fuses, and export those variables directly
> instead of using accessor functions.
> 
> Add a SKU ID table of currently known values.

> +static enum tegra_revision tegra_get_revision(void)
> +{
> +	void __iomem *chip_id = IO_ADDRESS(TEGRA_APB_MISC_BASE) + 0x804;
> +	u32 id = readl(chip_id);
> +
> +	switch ((id >> 16) & 0xf) {

We probably should decode A01 too; I certainly had a Tegra30 A01 until
recently, so it's entirely possible others do and want a meaningful
result.

Should the "A" should be decoded from the register too? It's bits 7:4
of the register and IIRC, 0=??? 1=A, presumably 2=B etc.

> +	case 2:
> +		return TEGRA_REVISION_A02;
> +	case 3:
> +		if (get_spare_fuse(18) || get_spare_fuse(19))
> +			return TEGRA_REVISION_A03p;

Does that apply equally to Tegra30 as well as Tegra20? I'm afraid I don't
know, but if you need I can try and find out.

> +		else
> +			return TEGRA_REVISION_A03;
> +	case 4:
> +		return TEGRA_REVISION_A04;

And there's space in the register for numbers higher than 4, although I
don't think there's any current silicon where this would matter.

> +	default:
> +		return TEGRA_REVISION_UNKNOWN;
> +	}
> +}

-- 
nvpublic
