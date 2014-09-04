From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Sep 2014 23:42:43 +0200
Subject: [PATCH] ARM: cns3xxx: fix allmodconfig panic in pci driver
In-Reply-To: <1409750292-24105-1-git-send-email-kaixu.xia@linaro.org>
References: <kaixu.xia@linaro.org>
 <1409750292-24105-1-git-send-email-kaixu.xia@linaro.org>
Message-ID: <7546804.XWPgHM2sst@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 21:18:12 Xia Kaixu wrote:
> 
> +#ifdef CONFIG_PCI
> +extern int __init cns3xxx_pcie_init_late(void);
> +#else
> +static inline int __init cns3xxx_pcie_init_late(void)
> +{
> +       return -ENXIO;
> +}
> +#endif
> +
>  void __init cns3xxx_map_io(void);
> 

I found another problem: we get a new compile-time warning
because the function returns an 'int' while the .init_late
callback expects a function returning 'void'.

I've fixed it up locally, but please be more careful about
introducing warnings in the future.

	Arnd
