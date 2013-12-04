From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 4 Dec 2013 07:27:43 -0800
Subject: [PATCH 3/3] ARM Coresight: Add PID control support for ETM tracing
In-Reply-To: <CANsc=4Vy911xcf7fYEjyeV_CNGp8POje9BZrLSP8xrk4YAfSNA@mail.gmail.com>
References: <CANsc=4Vy911xcf7fYEjyeV_CNGp8POje9BZrLSP8xrk4YAfSNA@mail.gmail.com>
Message-ID: <20131204152743.GC12847@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 11:40:59PM -0500, Adrien Verg? wrote:
> @@ -616,7 +670,7 @@ static int etm_probe(struct amba_device *dev,
> const struct amba_id *id)
>   if (ret)
>   goto out_unmap;
> 
> - /* failing to create any of these three is not fatal */
> + /* failing to create any of these four is not fatal */
>   ret = sysfs_create_file(&dev->dev.kobj, &trace_info_attr.attr);
>   if (ret)
>   dev_dbg(&dev->dev, "Failed to create trace_info in sysfs\n");
> @@ -629,6 +683,10 @@ static int etm_probe(struct amba_device *dev,
> const struct amba_id *id)
>   if (ret)
>   dev_dbg(&dev->dev, "Failed to create trace_addrrange in sysfs\n");
> 
> + ret = sysfs_create_file(&dev->dev.kobj, &trace_pid_attr.attr);
> + if (ret)
> + dev_dbg(&dev->dev, "Failed to create trace_pid in sysfs\n");
> +
>   dev_dbg(t->dev, "ETM AMBA driver initialized.\n");
> 
>  out:

Again, not your fault, but you just raced with userspace, so now
userspace can't see your device files at all.  Please use the correct
api for this (groups), and actually, it should all be using debugfs if
anything, not sysfs at all.

thanks,

greg k-h
