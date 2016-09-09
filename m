From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 9 Sep 2016 09:58:55 -0700
Subject: [PATCH] hwmon: xgene: access mailbox as RAM
In-Reply-To: <2529114.aAikiSWl11@wuerfel>
References: <1469134557-26869-1-git-send-email-hotran@apm.com>
 <13081573.BbD3TmEU5Y@wuerfel> <20160907223705.GA31582@roeck-us.net>
 <2529114.aAikiSWl11@wuerfel>
Message-ID: <20160909165855.GB18952@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Sep 09, 2016 at 05:38:58PM +0200, Arnd Bergmann wrote:
> The newly added hwmon driver fails to build in an allmodconfig
> kernel:
> 
>       1  ERROR: "memblock_is_memory" [drivers/hwmon/xgene-hwmon.ko] undefined!
> 
> According to comments in the code, the mailbox is a shared memory region,
> not a set of MMIO registers, so we should use memremap() for mapping it
> instead of ioremap or acpi_os_ioremap, and pointer dereferences instead
> of readl/writel.
> 
> The driver already uses plain kernel pointers, so it's a bit unusual
> to work with functions that operate on __iomem pointers, and this
> fixes that part too.
> 
> I'm using READ_ONCE/WRITE_ONCE here to keep the existing behavior
> regarding the ordering of the accesses from the CPU, but note that
> there are no barriers (also unchanged from before).
> 
> I'm also keeping the endianess behavior, though I'm unsure whether
> the message data was supposed to be in LE32 format in the first
> place, it's possible this was meant to be interpreted as a byte
> stream instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 

Thanks a lot for looking into this.

I'll apply this patch to address the build problem. Much better than
my rude "depends on BROKEN". It would be great to get a Tested-by:
from someone with access to the hardware.

Guenter

> diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
> index bc78a5d10182..e834dfb3acca 100644
> --- a/drivers/hwmon/xgene-hwmon.c
> +++ b/drivers/hwmon/xgene-hwmon.c
> @@ -34,7 +34,8 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <acpi/acpi_io.h>
> +#include <linux/io.h>
> +
>  #include <acpi/pcc.h>
>  
>  /* SLIMpro message defines */
> @@ -126,10 +127,10 @@ static u16 xgene_word_tst_and_clr(u16 *addr, u16 mask)
>  {
>  	u16 ret, val;
>  
> -	val = readw_relaxed(addr);
> +	val = le16_to_cpu(READ_ONCE(*addr));
>  	ret = val & mask;
>  	val &= ~mask;
> -	writew_relaxed(val, addr);
> +	WRITE_ONCE(*addr, cpu_to_le16(val));
>  
>  	return ret;
>  }
> @@ -137,7 +138,7 @@ static u16 xgene_word_tst_and_clr(u16 *addr, u16 mask)
>  static int xgene_hwmon_pcc_rd(struct xgene_hwmon_dev *ctx, u32 *msg)
>  {
>  	struct acpi_pcct_shared_memory *generic_comm_base = ctx->pcc_comm_addr;
> -	void *ptr = generic_comm_base + 1;
> +	u32 *ptr = (void*)(generic_comm_base + 1);
>  	int rc, i;
>  	u16 val;
>  
> @@ -146,21 +147,21 @@ static int xgene_hwmon_pcc_rd(struct xgene_hwmon_dev *ctx, u32 *msg)
>  	ctx->resp_pending = true;
>  
>  	/* Write signature for subspace */
> -	writel_relaxed(PCC_SIGNATURE_MASK | ctx->mbox_idx,
> -		       &generic_comm_base->signature);
> +	WRITE_ONCE(generic_comm_base->signature,
> +		   cpu_to_le32(PCC_SIGNATURE_MASK | ctx->mbox_idx));
>  
>  	/* Write to the shared command region */
> -	writew_relaxed(MSG_TYPE(msg[0]) | PCCC_GENERATE_DB_INT,
> -		       &generic_comm_base->command);
> +	WRITE_ONCE(generic_comm_base->command,
> +		   cpu_to_le16(MSG_TYPE(msg[0]) | PCCC_GENERATE_DB_INT));
>  
>  	/* Flip CMD COMPLETE bit */
> -	val = readw_relaxed(&generic_comm_base->status);
> +	val = le16_to_cpu(READ_ONCE(generic_comm_base->status));
>  	val &= ~PCCS_CMD_COMPLETE;
> -	writew_relaxed(val, &generic_comm_base->status);
> +	WRITE_ONCE(generic_comm_base->status, cpu_to_le16(val));
>  
>  	/* Copy the message to the PCC comm space */
>  	for (i = 0; i < sizeof(struct slimpro_resp_msg) / 4; i++)
> -		writel_relaxed(msg[i], ptr + i * 4);
> +		WRITE_ONCE(ptr[i], cpu_to_le32(msg[i]));
>  
>  	/* Ring the doorbell */
>  	rc = mbox_send_message(ctx->mbox_chan, msg);
> @@ -652,9 +653,9 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
>  		 */
>  		ctx->comm_base_addr = cppc_ss->base_address;
>  		if (ctx->comm_base_addr) {
> -			ctx->pcc_comm_addr =
> -					acpi_os_ioremap(ctx->comm_base_addr,
> -							cppc_ss->length);
> +			ctx->pcc_comm_addr = memremap(ctx->comm_base_addr,
> +							cppc_ss->length,
> +							MEMREMAP_WT);
>  		} else {
>  			dev_err(&pdev->dev, "Failed to get PCC comm region\n");
>  			rc = -ENODEV;
> 
