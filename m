From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Nov 2015 09:23:43 +0100
Subject: [PATCH] PCI: Fix logic OF logic in pci_dma_configure()
In-Reply-To: <1447894192-17210-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1447894192-17210-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <4205822.O3dsjd4r6S@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 November 2015 16:49:52 Suravee Suthikulpanit wrote:
> -       if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
> -               if (bridge->parent)
> +       if (IS_ENABLED(CONFIG_OF) &&
> +               bridge->parent && bridge->parent->of_node) {
>                         of_dma_configure(&dev->dev, bridge->parent->of_node);
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I was wondering for a bit whether we should warn about the case where there
is no of_node pointer, as that would mean we cannot do DMA on that PCI
device, but on second thought we have to do it exactly like you do, because
we would otherwise break machines that do not use DT.

	Arnd
