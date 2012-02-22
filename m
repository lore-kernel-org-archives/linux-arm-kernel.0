From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Feb 2012 08:56:23 +0000
Subject: [PATCH 2/2] iommu/omap: fix NULL pointer dereference
In-Reply-To: <1329900772-9306-2-git-send-email-ohad@wizery.com>
References: <1329900772-9306-1-git-send-email-ohad@wizery.com>
 <1329900772-9306-2-git-send-email-ohad@wizery.com>
Message-ID: <20120222085623.GF22675@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 10:52:52AM +0200, Ohad Ben-Cohen wrote:
> @@ -274,7 +274,7 @@ static ssize_t debug_read_mem(struct file *file, char __user *userbuf,
>  	mutex_lock(&iommu_debug_lock);
>  
>  	area = omap_find_iovm_area(dev, (u32)ppos);
> -	if (IS_ERR(area)) {
> +	if (IS_ERR_OR_NULL(area)) {
>  		bytes = -EINVAL;

There's something else which needs fixing here - the return code.  If
omap_find_iovm_area() returns an error code that needs propagating.
Otherwise it might as well just return NULL for all errors.
