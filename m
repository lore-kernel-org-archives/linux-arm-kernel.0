From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 29 Aug 2017 08:37:34 +0200
Subject: [PATCH V3 2/8] drivers: boot_constraint: Add
 boot_constraints_disable kernel parameter
In-Reply-To: <4bec0c3e58f76e06e5305c5ddbab859e2a87935e.1501578037.git.viresh.kumar@linaro.org>
References: <cover.1501578037.git.viresh.kumar@linaro.org>
 <4bec0c3e58f76e06e5305c5ddbab859e2a87935e.1501578037.git.viresh.kumar@linaro.org>
Message-ID: <20170829063734.GC12198@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 02:53:43PM +0530, Viresh Kumar wrote:
> Users must be given an option to discard any constraints set by
> bootloaders. For example, consider that a constraint is set for the LCD
> controller's supply and the LCD driver isn't loaded by the kernel. If
> the user doesn't need to use the LCD device, then he shouldn't be forced
> to honour the constraint.
> 
> We can also think about finer control of such constraints with help of
> some sysfs files, but a kernel parameter is fine to begin with.
> 
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  3 +++
>  drivers/base/boot_constraints/core.c            | 17 +++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d9c171ce4190..0706d1b6004d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -426,6 +426,9 @@
>  			embedded devices based on command line input.
>  			See Documentation/block/cmdline-partition.txt
>  
> +	boot_constraints_disable
> +			Do not set any boot constraints for devices.

Shouldn't that be the default?  As really, that is what the situation is
today, why force everyone to always enable the disable value?  And
enabling a value to disable something is usually a sign of bad naming...

> +
>  	boot_delay=	Milliseconds to delay each printk during boot.
>  			Values larger than 10 seconds (10000) are changed to
>  			no delay (0).
> diff --git a/drivers/base/boot_constraints/core.c b/drivers/base/boot_constraints/core.c
> index 366a05d6d9ba..e0c33b2b216f 100644
> --- a/drivers/base/boot_constraints/core.c
> +++ b/drivers/base/boot_constraints/core.c
> @@ -24,6 +24,17 @@
>  static LIST_HEAD(constraint_devices);
>  static DEFINE_MUTEX(constraint_devices_mutex);
>  
> +static bool boot_constraints_disabled;

Again, this should only be an "enable" type of option, that kicks in if
you are using this type of bootloader/kernel interaction.  Don't force
someone to disable it.

thanks,

greg k-h
