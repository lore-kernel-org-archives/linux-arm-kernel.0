From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 29 Aug 2017 08:39:23 +0200
Subject: [PATCH V3 1/8] drivers: Add boot constraints core
In-Reply-To: <1a844e27ee7e0b22acf8ea582bf4e8d35f54c84a.1501578037.git.viresh.kumar@linaro.org>
References: <cover.1501578037.git.viresh.kumar@linaro.org>
 <1a844e27ee7e0b22acf8ea582bf4e8d35f54c84a.1501578037.git.viresh.kumar@linaro.org>
Message-ID: <20170829063923.GD12198@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 02:53:42PM +0530, Viresh Kumar wrote:
> Some devices are powered ON by the bootloader before the bootloader
> handovers control to Linux. It maybe important for those devices to keep
> working until the time a Linux device driver probes the device and
> reconfigure its resources.
> 
> A typical example of that can be the LCD controller, which is used by
> the bootloaders to show image(s) while the platform is booting into
> Linux. The LCD controller can be using some resources, like clk,
> regulators, PM domain, etc, that are shared between several devices.
> These shared resources should be configured to satisfy need of all the
> users. If another device's (X) driver gets probed before the LCD
> controller driver in this case, then it may end up reconfiguring these
> resources to ranges satisfying the current users (only device X) and
> that can make the LCD screen unstable.
> 
> This patch introduces the concept of boot-constraints, which will be set
> by the bootloaders and the kernel will satisfy them until the time
> driver for such a device is probed (successfully or unsuccessfully).
> 
> The list of boot constraint types is empty for now, and will be
> incrementally updated by later patches.
> 
> Only two routines are exposed by the boot constraints core for now:
> 
> - dev_boot_constraint_add(): This shall be called by parts of the kernel
>   (before the device is probed) to set the constraints.
> 
> - dev_boot_constraints_remove(): This is called only by the driver core
>   after a device is probed successfully or unsuccessfully. Special
>   handling is done here for deffered probing.

How is this information getting to the kernel from the bootloader?  I
didn't see where that happened, just a single example driver that
somehow "knew" what had to happen, which seems odd...

This is a lot of new code for no users, I would like to see at least 3
real drivers that are using it before we merge it, as then you have a
chance of getting the user/kernel api correct.

thanks,

greg k-h
