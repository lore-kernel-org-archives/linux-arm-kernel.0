From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 13 Dec 2017 10:50:14 +0100
Subject: [PATCH V4 07/12] boot_constraint: Add debugfs support
In-Reply-To: <a796de9a338d7d0876faa3ec99f5cb49315c893c.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <a796de9a338d7d0876faa3ec99f5cb49315c893c.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <20171213095014.GI13194@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 29, 2017 at 07:18:55PM +0530, Viresh Kumar wrote:
> This patch adds debugfs support for boot constraints. This is how it
> looks for a "vmmc-supply" constraint for the MMC device.
> 
> $ ls -R /sys/kernel/debug/boot_constraints/
> /sys/kernel/debug/boot_constraints/:
> f723d000.dwmmc0
> 
> /sys/kernel/debug/boot_constraints/f723d000.dwmmc0:
> clk-ciu  pm-domain  supply-vmmc  supply-vmmcaux
> 
> /sys/kernel/debug/boot_constraints/f723d000.dwmmc0/clk-ciu:
> 
> /sys/kernel/debug/boot_constraints/f723d000.dwmmc0/pm-domain:
> 
> /sys/kernel/debug/boot_constraints/f723d000.dwmmc0/supply-vmmc:
> u_volt_max  u_volt_min
> 
> /sys/kernel/debug/boot_constraints/f723d000.dwmmc0/supply-vmmcaux:
> u_volt_max  u_volt_min
> 
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/boot_constraints/clk.c    |  3 ++
>  drivers/boot_constraints/core.c   | 60 +++++++++++++++++++++++++++++++++++++++
>  drivers/boot_constraints/core.h   |  6 ++++
>  drivers/boot_constraints/pm.c     | 11 +++++--
>  drivers/boot_constraints/supply.c |  9 ++++++
>  5 files changed, 87 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/boot_constraints/clk.c b/drivers/boot_constraints/clk.c
> index b5b1d63c3e76..91b7b538ef32 100644
> --- a/drivers/boot_constraints/clk.c
> +++ b/drivers/boot_constraints/clk.c
> @@ -49,6 +49,8 @@ int constraint_clk_add(struct constraint *constraint, void *data)
>  	cclk->clk_info.name = kstrdup_const(clk_info->name, GFP_KERNEL);
>  	constraint->private = cclk;
>  
> +	constraint_add_debugfs(constraint, clk_info->name);
> +
>  	return 0;
>  
>  put_clk:
> @@ -63,6 +65,7 @@ void constraint_clk_remove(struct constraint *constraint)
>  {
>  	struct constraint_clk *cclk = constraint->private;
>  
> +	constraint_remove_debugfs(constraint);
>  	kfree_const(cclk->clk_info.name);
>  	clk_disable_unprepare(cclk->clk);
>  	clk_put(cclk->clk);
> diff --git a/drivers/boot_constraints/core.c b/drivers/boot_constraints/core.c
> index f4d3520ddb04..707ffac690fc 100644
> --- a/drivers/boot_constraints/core.c
> +++ b/drivers/boot_constraints/core.c
> @@ -24,6 +24,64 @@
>  static LIST_HEAD(constraint_devices);
>  static DEFINE_MUTEX(constraint_devices_mutex);
>  
> +/* Debugfs */
> +
> +static struct dentry *rootdir;
> +
> +static void constraint_device_add_debugfs(struct constraint_dev *cdev)
> +{
> +	struct device *dev = cdev->dev;
> +
> +	cdev->dentry = debugfs_create_dir(dev_name(dev), rootdir);
> +}
> +
> +static void constraint_device_remove_debugfs(struct constraint_dev *cdev)
> +{
> +	debugfs_remove_recursive(cdev->dentry);
> +}
> +
> +void constraint_add_debugfs(struct constraint *constraint, const char *suffix)
> +{
> +	struct device *dev = constraint->cdev->dev;
> +	const char *prefix;
> +	char name[NAME_MAX];
> +
> +	switch (constraint->type) {
> +	case DEV_BOOT_CONSTRAINT_CLK:
> +		prefix = "clk";
> +		break;
> +	case DEV_BOOT_CONSTRAINT_PM:
> +		prefix = "pm";
> +		break;
> +	case DEV_BOOT_CONSTRAINT_SUPPLY:
> +		prefix = "supply";
> +		break;
> +	default:
> +		dev_err(dev, "%s: Constraint type (%d) not supported\n",
> +			__func__, constraint->type);
> +		return;
> +	}
> +
> +	snprintf(name, NAME_MAX, "%s-%s", prefix, suffix);
> +
> +	constraint->dentry = debugfs_create_dir(name, constraint->cdev->dentry);
> +}
> +
> +void constraint_remove_debugfs(struct constraint *constraint)
> +{
> +	debugfs_remove_recursive(constraint->dentry);
> +}
> +
> +static int __init constraint_debugfs_init(void)
> +{
> +	/* Create /sys/kernel/debug/opp directory */
> +	rootdir = debugfs_create_dir("boot_constraints", NULL);

Your comment makes no sense at all, it would be better, and correct, to
have no comment at all :)
