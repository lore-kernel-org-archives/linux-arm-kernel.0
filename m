From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 31 Jan 2012 13:09:45 -0700
Subject: [PATCH 1/2] remoteproc: bail out if firmware has different
 endianess
In-Reply-To: <1328028762-28352-1-git-send-email-ohad@wizery.com>
References: <1328028762-28352-1-git-send-email-ohad@wizery.com>
Message-ID: <20120131200945.GD22611@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 06:52:41PM +0200, Ohad Ben-Cohen wrote:
> At this point we don't support remote processors that have
> a different endianess than the host.
> 
> Look out for these unsupported scenarios, and bail out if
> encountered.
> 
> Reported-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Mark Grosen <mgrosen@ti.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  drivers/remoteproc/remoteproc_core.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 6212b82..567a3c5 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -39,6 +39,7 @@
>  #include <linux/elf.h>
>  #include <linux/virtio_ids.h>
>  #include <linux/virtio_ring.h>
> +#include <asm/byteorder.h>
>  
>  #include "remoteproc_internal.h"
>  
> @@ -851,6 +852,16 @@ static int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
>  
>  	ehdr = (struct elf32_hdr *)fw->data;
>  
> +	/* We assume the firmware has the same endianess as the host */
> +# ifdef __LITTLE_ENDIAN
> +	if (ehdr->e_ident[EI_DATA] != ELFDATA2LSB) {
> +# else /* BIG ENDIAN */
> +	if (ehdr->e_ident[EI_DATA] != ELFDATA2MSB) {
> +# endif
> +		dev_err(dev, "Unsupported firmware endianess\n");
> +		return -EINVAL;
> +	}
> +
>  	if (fw->size < ehdr->e_shoff + sizeof(struct elf32_shdr)) {
>  		dev_err(dev, "Image is too small\n");
>  		return -EINVAL;
> -- 
> 1.7.5.4
> 
