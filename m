From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 05 Jun 2013 14:44:55 +0200
Subject: [PATCH v3 5/6] arm64/xen: introduce CONFIG_XEN and hypercall.S on
 ARM64
In-Reply-To: <1370434530-22428-5-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1306041712100.4589@kaball.uk.xensource.com>
 <1370434530-22428-5-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1471793.18ZhhAHKN9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 June 2013 13:15:29 Stefano Stabellini wrote:
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index c95c5cb..79dd13d 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -37,6 +37,7 @@ TEXT_OFFSET := 0x00080000
>  export TEXT_OFFSET GZFLAGS
>  
>  core-y         += arch/arm64/kernel/ arch/arm64/mm/
> +core-$(CONFIG_XEN)             += arch/arm64/xen/
>  libs-y         := arch/arm64/lib/ $(libs-y)
>  libs-y         += $(LIBGCC)
>  
> diff --git a/arch/arm64/xen/Makefile b/arch/arm64/xen/Makefile
> new file mode 100644
> index 0000000..be24040
> --- /dev/null
> +++ b/arch/arm64/xen/Makefile
> @@ -0,0 +1,2 @@
> +xen-arm-y      += $(addprefix ../../arm/xen/, enlighten.o grant-table.o)
> +obj-y          := xen-arm.o hypercall.o

I think it would be nicer to redirect the entire directory, not just
the enlighten.o and grant-table.o files. You could do in arch/arm64/Makefile:

core-(CONFIG_XEN) += arch/arm/xen/

That leaves a small difference in hypercall.o, which I think you can
handle with an #ifdef.

I believe the reason why KVM does the more elaborate variant is that
they want to be able to build their code as a loadable module that
also includes code from virt/kvm, which you don't need.

	Arnd
