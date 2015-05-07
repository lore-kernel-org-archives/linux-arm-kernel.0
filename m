From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 7 May 2015 22:49:48 +0200
Subject: [PATCH v2] dma-buf: add ref counting for module as exporter
In-Reply-To: <1431005324-22234-1-git-send-email-sumit.semwal@linaro.org>
References: <1431005324-22234-1-git-send-email-sumit.semwal@linaro.org>
Message-ID: <20150507204948.GA28822@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 07, 2015 at 06:58:44PM +0530, Sumit Semwal wrote:
> Add reference counting on a kernel module that exports dma-buf and
> implements its operations. This prevents the module from being unloaded
> while DMABUF file is in use.
> 
> The original patch [1] was submitted by Tomasz Stanislawski, but this
> is a simpler way to do it.
> 
> v2: move owner to struct dma_buf, and use DEFINE_DMA_BUF_EXPORT_INFO
>     macro to simplify the change.
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> 
> [1]: https://lkml.org/lkml/2012/8/8/163
> ---
>  drivers/dma-buf/dma-buf.c | 10 +++++++++-
>  include/linux/dma-buf.h   | 10 ++++++++--
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index c5a9138a6a8d..0eff4bf56ef6 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -29,6 +29,7 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/export.h>
>  #include <linux/debugfs.h>
> +#include <linux/module.h>
>  #include <linux/seq_file.h>
>  #include <linux/poll.h>
>  #include <linux/reservation.h>
> @@ -64,6 +65,7 @@ static int dma_buf_release(struct inode *inode, struct file *file)
>  	BUG_ON(dmabuf->cb_shared.active || dmabuf->cb_excl.active);
>  
>  	dmabuf->ops->release(dmabuf);
> +	module_put(dmabuf->owner);

The module can now go away.

>  
>  	mutex_lock(&db_list.lock);
>  	list_del(&dmabuf->list_node);

But you reference it here :(

Please drop the reference at the last possible moment.

thanks,

greg k-h
