From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Feb 2014 13:04:19 -0700
Subject: [PATCH RFC 31/31] mmc: sdhci-tegra: get rid of special
 PRESENT_STATE register handling
In-Reply-To: <E1WFmKj-0006nv-Py@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
 <E1WFmKj-0006nv-Py@rmk-PC.arm.linux.org.uk>
Message-ID: <53050E43.3030602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2014 08:11 AM, Russell King wrote:
> sdhci-tegra provides a get_ro method, which overrides the checking
> of the write protect bit in the PRESENT_STATE register in sdhci.c:
> 
>         if (host->flags & SDHCI_DEVICE_DEAD)
>                 is_readonly = 0;
>         else if (host->ops->get_ro)
>                 is_readonly = host->ops->get_ro(host);
>         else
>                 is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
>                                 & SDHCI_WRITE_PROTECT);
> 
> This means it's pointless detecting accesses to this register and
> manually setting the SDHCI_WRITE_PROTECT as it has no effect.
> 
> This means that the whole of tegra_sdhci_readl() can be removed and
> we can use the builtin sdhci readl functionality here.

Acked-by: Stephen Warren <swarren@nvidia.com>

> =-DO NOT APPLY-=

Is that just because it's an RFC and you want to make sure it doesn't
get accepted early, or are you explicitly trying to stop people applying
this, testing it, and giving Tested-by?
