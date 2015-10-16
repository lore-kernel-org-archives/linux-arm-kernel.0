From: Yuantian.Tang@freescale.com (Yuantian Tang)
Date: Fri, 16 Oct 2015 02:12:45 +0000
Subject: [PATCH] ahci: qoriq: Fix a compiling warning
In-Reply-To: <20151015160410.GC27717@mtj.duckdns.org>
References: <1444812412-33321-1-git-send-email-Yuantian.Tang@freescale.com>
 <20151015151152.GB27717@mtj.duckdns.org> <15555694.OtW6JZzsoS@wuerfel>
 <20151015160410.GC27717@mtj.duckdns.org>
Message-ID: <DM2PR03MB574F11953B0007523D7A385FA3D0@DM2PR03MB574.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Tejun.

Regards,
Yuantian

> -----Original Message-----
> From: Tejun Heo [mailto:htejun at gmail.com] On Behalf Of Tejun Heo
> Sent: Friday, October 16, 2015 12:04 AM
> To: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel at lists.infradead.org; Tang Yuantian-B29983
> <Yuantian.Tang@freescale.com>; linux-ide at vger.kernel.org; linux-
> kernel at vger.kernel.org; hdegoede at redhat.com; fengguang.wu at intel.com
> Subject: Re: [PATCH] ahci: qoriq: Fix a compiling warning
> 
> Hello,
> 
> I see.  I applied the following to libata/for-4.4.
> 
> Thanks.
> 
> ------ 8< ------
> From eb351031a15c4a83b9955aadad783c6672ab8868 Mon Sep 17 00:00:00
> 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, 14 Oct 2015 16:46:52 +0800
> Subject: [PATCH] ahci: qoriq: Fix a compiling warning
> 
> kbuild test robot reports the warnings:
> drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
> >> include/asm-generic/io.h:163:2: warning: 'px_is' may be used
> >> uninitialized in this function [-Wuninitialized]
> drivers/ata/ahci_qoriq.c:70:14: note: 'px_is' was declared here
> >> include/asm-generic/io.h:163:2: warning: 'px_cmd' may be used
> >> uninitialized in this function [-Wuninitialized]
> drivers/ata/ahci_qoriq.c:70:6: note: 'px_cmd' was declared here
> 
> This patch fixed it by introducing a local variable.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/ahci_qoriq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c index
> e5e4988..58c1a94 100644
> --- a/drivers/ata/ahci_qoriq.c
> +++ b/drivers/ata/ahci_qoriq.c
> @@ -76,6 +76,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link,
> unsigned int *class,
>  	struct ata_taskfile tf;
>  	bool online;
>  	int rc;
> +	bool ls1021a_workaround = (qoriq_priv->type == AHCI_LS1021A);
> 
>  	DPRINTK("ENTER\n");
> 
> @@ -92,7 +93,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link,
> unsigned int *class,
>  	 * After the sequence is complete, software should restore the
>  	 * PxCMD and PxIS with the stored values.
>  	 */
> -	if (qoriq_priv->type == AHCI_LS1021A) {
> +	if (ls1021a_workaround) {
>  		px_cmd = readl(port_mmio + PORT_CMD);
>  		px_is = readl(port_mmio + PORT_IRQ_STAT);
>  	}
> @@ -106,7 +107,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link,
> unsigned int *class,
>  				 ahci_check_ready);
> 
>  	/* restore the PxCMD and PxIS on ls1021 */
> -	if (qoriq_priv->type == AHCI_LS1021A) {
> +	if (ls1021a_workaround) {
>  		px_val = readl(port_mmio + PORT_CMD);
>  		if (px_val != px_cmd)
>  			writel(px_cmd, port_mmio + PORT_CMD);
> --
> 2.4.3
