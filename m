From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 10 Nov 2016 07:22:33 -0800
Subject: [PATCH fpga 9/9] fpga: Remove support for non-sg drivers
In-Reply-To: <1478732303-13718-10-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-10-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <bad801c5-fe3a-665b-de67-bf69c42fb2b4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On 11/09/2016 02:58 PM, Jason Gunthorpe wrote:
> All drivers now use the sg interface so there is no reason to keep
> the contiguous interface any more.
>
> Now that all drivers support this interface we can also export it.
>
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/fpga/fpga-mgr.c       | 62 +++++++------------------------------------
>  include/linux/fpga/fpga-mgr.h |  7 ++---
>  2 files changed, 11 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index c2491ffeabd3..4ba22925d9d5 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -47,8 +47,8 @@ static struct class *fpga_mgr_class;
>   *
>   * Return: 0 on success, negative error code otherwise.
>   */
> -static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr, u32 flags,
> -				struct sg_table *sgt)
> +int fpga_mgr_buf_load_sg(struct fpga_manager *mgr, u32 flags,
> +			 struct sg_table *sgt)
>  {
>  	struct device *dev = &mgr->dev;
>  	int ret;
> @@ -92,52 +92,7 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr, u32 flags,
>  
>  	return 0;
>  }
> -
> -static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr, u32 flags,
> -				    const char *buf, size_t count)
> -{
> -	struct device *dev = &mgr->dev;
> -	int ret;
> -
> -	/*
> -	 * Call the low level driver's write_init function.  This will do the
> -	 * device-specific things to get the FPGA into the state where it is
> -	 * ready to receive an FPGA image.
> -	 */
> -	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
> -	ret = mgr->mops->write_init(mgr, flags, buf, count);
> -	if (ret) {
> -		dev_err(dev, "Error preparing FPGA for writing\n");
> -		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
> -		return ret;
> -	}
> -
> -	/*
> -	 * Write the FPGA image to the FPGA.
> -	 */
> -	mgr->state = FPGA_MGR_STATE_WRITE;
> -	ret = mgr->mops->write(mgr, buf, count);
> -	if (ret) {
> -		dev_err(dev, "Error while writing image data to FPGA\n");
> -		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
> -		return ret;
> -	}
> -
> -	/*
> -	 * After all the FPGA image has been written, do the device specific
> -	 * steps to finish and set the FPGA into operating mode.
> -	 */
> -	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
> -	ret = mgr->mops->write_complete(mgr, flags);
> -	if (ret) {
> -		dev_err(dev, "Error after writing image data to FPGA\n");
> -		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
> -		return ret;
> -	}
> -	mgr->state = FPGA_MGR_STATE_OPERATING;
> -
> -	return 0;
> -}
> +EXPORT_SYMBOL_GPL(fpga_mgr_buf_load_sg);
>  
>  /**
>   * fpga_mgr_buf_load - load fpga from image in buffer
> @@ -163,9 +118,6 @@ int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags, const char *buf,
>  	int index;
>  	int rc;
>  
> -	if (!mgr->mops->write_init_sg || !mgr->mops->write_sg)
> -		return fpga_mgr_buf_load_mapped(mgr, flags, buf, count);
> -
>  	/*
>  	 * Convert the linear kernel pointer into a sg_table of pages for use
>  	 * by the driver.
> @@ -226,6 +178,11 @@ int fpga_mgr_firmware_load(struct fpga_manager *mgr, u32 flags,
>  
>  	mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ;
>  
> +	/*
> +	 * FIXME: We do not need a vmap, just a page list, but
> +	 * request_firmware has no way to give us that, so this needlessly
> +	 * consumes vmalloc space.
> +	 */
>  	ret = request_firmware(&fw, image_name, dev);
>  	if (ret) {
>  		mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ_ERR;
> @@ -369,8 +326,7 @@ int fpga_mgr_register(struct device *dev, const char *name,
>  	int id, ret;
>  
>  	if (!mops || !mops->write_complete || !mops->state ||
> -	    ((!mops->write_init || !mops->write) &&
> -	     (!mops->write_init_sg || !mops->write_sg))) {
> +	    !mops->write_init_sg || !mops->write_sg) {
>  		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
>  		return -EINVAL;
>  	}
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 371b30ea60eb..5c698c8fe71b 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -72,8 +72,6 @@ enum fpga_mgr_states {
>  /**
>   * struct fpga_manager_ops - ops for low level fpga manager drivers
>   * @state: returns an enum value of the FPGA's state
> - * @write_init: prepare the FPGA to receive confuration data (linear memory)
> - * @write: write count bytes of configuration data to the FPGA
>   * @write_init_sg: prepare the FPGA to receive confuration data (scatter list
>   *                 table)
>   * @write_sg: write count bytes of configuration data to the FPGA
> @@ -86,9 +84,6 @@ enum fpga_mgr_states {
>   */
>  struct fpga_manager_ops {
>  	enum fpga_mgr_states (*state)(struct fpga_manager *mgr);
> -	int (*write_init)(struct fpga_manager *mgr, u32 flags,
> -			  const char *buf, size_t count);
> -	int (*write)(struct fpga_manager *mgr, const char *buf, size_t count);
>  	int (*write_init_sg)(struct fpga_manager *mgr, u32 flags,
>  			     struct sg_table *sgt);
>  	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
> @@ -118,6 +113,8 @@ struct fpga_manager {
>  
>  int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags,
>  		      const char *buf, size_t count);
> +int fpga_mgr_buf_load_sg(struct fpga_manager *mgr, u32 flags,
> +			 struct sg_table *sgt);
>  
>  int fpga_mgr_firmware_load(struct fpga_manager *mgr, u32 flags,
>  			   const char *image_name);
I don't have any feeling either way about switching to scatter-gather.
(Not zynq or socfpga user)
But I do object to renaming the API.
write_init() and write() do not imply a particular implementation, nor even that
the buffer is coherent.

I am working to merge an fpga manager which uses SPI to load the bitstream
(see https://www.spinics.net/lists/arm-kernel/msg539328.html)
Any dma in use there would come from the spi driver. write_init_sg, and write_sg
don't make any sense in my case.

Would it not make sense to keep the top level API the same?

Thanks, Joshua.
