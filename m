From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Feb 2014 15:53:45 +0100
Subject: [PATCH v5 08/14] ahci-platform: "Library-ise" suspend / resume
 functionality
In-Reply-To: <1390417489-5354-9-git-send-email-hdegoede@redhat.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
 <1390417489-5354-9-git-send-email-hdegoede@redhat.com>
Message-ID: <201402031553.46083.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 January 2014, Hans de Goede wrote:
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -50,4 +50,11 @@ int ahci_platform_init_host(struct platform_device *pdev,
>                             unsigned int force_port_map,
>                             unsigned int mask_port_map);
>  
> +#ifdef CONFIG_PM_SLEEP
> +int ahci_platform_suspend_host(struct device *dev);
> +int ahci_platform_resume_host(struct device *dev);
> +int ahci_platform_suspend(struct device *dev);
> +int ahci_platform_resume(struct device *dev);
> +#endif
> +

Not sure if the #ifdef does any good here. Normally, we don't hide declarations
so we can do stuff like

	if (IS_ENABLED(CONFIG_PM_SLEEP))
		ret = ahci_platform_suspend_host(dev);

and expect the code to compile and link just fine.

	Arnd
