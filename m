From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 18 Jun 2015 08:21:57 -0500
Subject: [PATCH] ARM: imx6: Fix "BUG: scheduling while atomic" if PCIe
 switch is attached
In-Reply-To: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
References: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
Message-ID: <20150618132157.GB7710@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 09:56:54AM +0200, David M?ller wrote:
> This problem has already been reported as 
> https://bugzilla.kernel.org/show_bug.cgi?id=100031
> 
> Signed-off-by: David M?ller <dave.mueller@gmx.ch>
> ---
>  drivers/pci/host/pci-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index fdb9536..c63691c 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -489,7 +489,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
>  		 * Wait a little bit, then re-check if the link finished
>  		 * the training.
>  		 */
> -		usleep_range(1000, 2000);
> +		mdelay(20);
>  	}
>  	/*
>  	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.

I asked in the bugzilla why imx6_pcie_link_up() looks nothing like the
other pcie_host_ops.link_up() methods.

Lucas responded:
> the i.MX6 link up routine is a bit more complex compared to the other
> designware drivers because of a hardware bug, where some FIFOs could
> get out of sync when changing the link speed. We need to start the
> link at Gen1, wait for it to be stable, then start a directed link
> speed change if the EP is Gen2 and wait for the link to be stable
> again. If the link doesn't come back, we need to start over.

> I don't think any of the other DW PCIe implementations need this
> workaround.

That explanation makes sense, and a comment to that effect should be
in the code.  But I also wonder whether this workaround could be moved
to imx6_pcie_start_link() (just renamed to imx6_pcie_establish_link()).
Then imx6_pcie_link_up() could be a simple status check like the
others.

Bjorn
