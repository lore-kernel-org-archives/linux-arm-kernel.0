From: s-anna@ti.com (Suman Anna)
Date: Thu, 3 Sep 2015 14:32:11 -0500
Subject: [PATCH] remoteproc: report error if resource table doesn't exist
In-Reply-To: <1440810499-24327-1-git-send-email-stefan@agner.ch>
References: <1440810499-24327-1-git-send-email-stefan@agner.ch>
Message-ID: <55E8A03B.9090608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2015 08:08 PM, Stefan Agner wrote:
> Currently, if the resource table is completely missing in the
> firmware, powering up the remoteproc fails silently. Add a message
> indicating that the resource table is missing in the firmware.

Yeah, pretty useful to have a trace there..

Acked-by: Suman Anna <s-anna@ti.com>

> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Hi Ohad,
> 
> I am currently working on remoteproc support for Freescale Vybrid's
> secondary Cortex-M4 core. I stumbled upon this rough spot since the
> little test firmware I am using now does not have a resource table
> yet.
> 
> This also opens up a more general question: Is it mandatory to have
> a resource table in the firmware? Theoretically a remoteproc could
> also work completely independent, all what would be used from the
> remoteproc framework is the loading and starting capabilities...

Hi Ohad,

We will probably be seeing more of such scenarios for very simplistic
devices (like the ones that load into their internal memories), it looks
like the framework needs some kind of support for booting such devices,
whether auto-boot, or give some kind of sysfs control for userspace. We
do have the rproc_boot() and rproc_shutdown() API, but that almost
always requires some other entity in the kernel to be able to invoke
those API. Any suggestions here?

regards
Suman

> 
> --
> Stefan
> 
>  drivers/remoteproc/remoteproc_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 8b3130f..29db8b3 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -823,8 +823,10 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  
>  	/* look for the resource table */
>  	table = rproc_find_rsc_table(rproc, fw, &tablesz);
> -	if (!table)
> +	if (!table) {
> +		dev_err(dev, "Failed to find resource table\n");
>  		goto clean_up;
> +	}
>  
>  	/* Verify that resource table in loaded fw is unchanged */
>  	if (rproc->table_csum != crc32(0, table, tablesz)) {
> 
