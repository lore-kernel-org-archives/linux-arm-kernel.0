From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Wed, 1 Aug 2012 10:34:59 -0400
Subject: [Xen-devel] [PATCH 11/24] xen/arm: introduce CONFIG_XEN on ARM
In-Reply-To: <1343316846-25860-11-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-11-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20120801143459.GH7227@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 04:33:53PM +0100, Stefano Stabellini wrote:
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> ---
>  arch/arm/Kconfig |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a91009c..9c54cb4 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2228,6 +2228,16 @@ config NEON
>  	  Say Y to include support code for NEON, the ARMv7 Advanced SIMD
>  	  Extension.
>  
> +config XEN_DOM0
> +	def_bool y

What is the benefit of this ? I was hoping at some point to rip out all of those
XEN_DOM0 and just have, mostly,
	CONFIG_XEN_BACKEND_SUPPORT
		(which would compile whatever is needed for HVM or PV guests to run
		blkback/netback/grant/grantalloc/etc)
	CONFIG_XEN_FRONTEND_SUPPORT
		(the vice-versa)

	CONFIG_XEN_PCI
		which would have the PCI support, the ACPI routing (which is
		predomaintaly most of the dom0 support), VGA text support, and
		whatever else is in there.

In that fashion you could compile a kernel with CONFIG_XEN_BACKEND_SUPPORT
without any CONFIG_XEN_PCI and drop it in as an HVM device driver domain.
Thought maybe that wouldn't really work as if you do PCI passthrough to such
domain, you are going to need the PCI support and ACPI routing. The VGA text
maybe not...

OK, never mind - we should brainstorm it and figure out how to make this
nicely work. In the meantime this is OK.

> +
> +config XEN
> +	bool "Xen guest support on ARM"
> +	depends on ARM && OF
> +	select XEN_DOM0
> +	help
> +	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
> +
>  endmenu
>  
>  menu "Userspace binary formats"
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
