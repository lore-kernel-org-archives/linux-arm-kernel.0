From: jeffy.chen@rock-chips.com (jeffy)
Date: Sat, 14 Oct 2017 03:26:16 +0800
Subject: [PATCH v5 1/3] PCI: rockchip: Add support for pcie wake irq
In-Reply-To: <20171013191906.GF25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170911151029.25185-1-jeffy.chen@rock-chips.com>
 <20170911151029.25185-2-jeffy.chen@rock-chips.com>
 <20171013030441.GA25517@bhelgaas-glaptop.roam.corp.google.com>
 <2453698.N4jfPaHx71@aspire.rjw.lan> <59E10709.4020300@rock-chips.com>
 <20171013191906.GF25517@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <59E11358.3090409@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 10/14/2017 03:19 AM, Bjorn Helgaas wrote:
> I'm sure they're harmless.  The point is that the cleanup should be
> done near the failure, not in the caller of the caller of the function
> where the failure was detected.  You have:
>
>    rockchip_pcie_probe
>      rockchip_pcie_parse_dt
>        rockchip_pcie_setup_irq
>          err = dev_pm_set_dedicated_wake_irq
>          if (err)
>            dev_err(...)
>
> So you detect the error in rockchip_pcie_setup_irq(), but you clean up
> from it in rockchip_pcie_probe(), which doesn't make sense because
> rockchip_pcie_probe() doesn't do anything related to wakeup interupts.
>
right, but if something wrong happens in rockchip_pcie_probe() later 
than rockchip_pcie_setup_irq(), we may still need to clean it up ;)

i think the error handling is a little like what we do in the remove 
callback
> Bjorn
>
>
>
