From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 17 Jun 2014 14:20:25 +0300
Subject: [PATCH v3 2/4] pinctrl: Add NVIDIA Tegra XUSB pad controller
 support
In-Reply-To: <1402930623-28886-2-git-send-email-thierry.reding@gmail.com>
References: <1402930623-28886-1-git-send-email-thierry.reding@gmail.com>
 <1402930623-28886-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <53A02479.8080405@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This v3 breaks SATA; see below

On 16/06/14 17:57, Thierry Reding wrote:
...
> +                       regval = padctl_readl(padctl, lane->offset);
> +
> +                       if (!value)
> +                               regval &= ~lane->iddq;
> +                       else
> +                               regval |= lane->iddq;
> +
> +                       padctl_writel(padctl, regval, lane->offset);
...

The bits at at lane->iddq are actually IDDQ_DISABLE bits, so this is the 
wrong way around: having iddq = <0> in device tree leads to the device 
turning off. So either the DT property should be renamed or the branches 
of the if here should be switched around.

v2 used the wrong variable so the else branch ended up being chosen each 
time, this also meant that SATA worked by chance.

- Mikko
