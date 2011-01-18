From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 16:00:37 +0000
Subject: [PATCH V4 06/62] ST SPEAr13XX: Adding machine specific header
	files
In-Reply-To: <91343ab3cb64f7082111535a9a3c006e958578fb.1295333958.git.viresh.kumar@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<91343ab3cb64f7082111535a9a3c006e958578fb.1295333958.git.viresh.kumar@st.com>
Message-ID: <20110118160037.GC16980@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 12:41:34PM +0530, Viresh Kumar wrote:
> +#define MISC_BASE		VA_SPEAR13XX_MISC_BASE
> +
> +/* General Configuration */
> +#define SOC_CFG			((unsigned int *)(MISC_BASE + 0x000))
> +#define BOOTSTRAP_CFG		((unsigned int *)(MISC_BASE + 0x004))

You could really do with an IOMEM() macro, thus:

#ifndef __ASSEMBLY__
#define IOMEM(x)	((void __iomem __force *)(x))
#else
#define IOMEM(x)	(x)
#endif

You can then use that for stuff like VA_SPEAR13XX_MISC_BASE, and all
these definitions then become:

#define SOC_CFG			(MISC_BASE + 0x000)

because GCC allows void pointer arithmetic (treats it as char).
