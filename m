From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 18 Jun 2015 10:27:01 +0200
Subject: [PATCH] ARM: imx6: Fix "BUG: scheduling while atomic" if PCIe
 switch is attached
In-Reply-To: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
References: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
Message-ID: <1434616021.3061.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 18.06.2015, 09:56 +0200 schrieb David M?ller:
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

While switching to mdelay might be the right thing to do here, you are
also changing the timeout. This is a change in behavior and so not okay.
Especially as you keep the CPU spinning for the duration of that
timeout.
 
>  	}
>  	/*
>  	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
