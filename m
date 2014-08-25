From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 25 Aug 2014 13:05:39 -0700
Subject: [PATCH 04/29] drivers: base: add notifier for failed driver bind
In-Reply-To: <1407235677-26324-5-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
 <1407235677-26324-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20140825200539.GA22076@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 05, 2014 at 12:47:32PM +0200, Marek Szyprowski wrote:
> This patch adds support for getting a notify for failed device driver
> bind, so all the items done in BUS_NOTIFY_BIND_DRIVER event can be
> cleaned if the driver fails to bind.

But doesn't the bus know if the driver fails to bind, so why would a
notifier be needed here?  Can't it unwind any problems then?

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/base/dd.c      | 10 +++++++---
>  include/linux/device.h |  4 +++-
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index e4ffbcf..541a41f 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -237,10 +237,14 @@ static int driver_sysfs_add(struct device *dev)
>  	return ret;
>  }
>  
> -static void driver_sysfs_remove(struct device *dev)
> +static void driver_sysfs_remove(struct device *dev, int failed)

I _hate_ having functions with a flag that does something different
depending on it.  If you _really_ need this, just make the notifier call
before calling this function, which should work just fine, right?

thanks,

greg k-h
