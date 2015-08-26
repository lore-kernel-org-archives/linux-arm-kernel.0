From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 26 Aug 2015 12:08:48 -0500
Subject: [PATCH 4/4] remoteproc: debugfs: Add ability to boot remote
 processor using debugfs
In-Reply-To: <1440594483-29601-5-git-send-email-lee.jones@linaro.org>
References: <1440594483-29601-1-git-send-email-lee.jones@linaro.org>
 <1440594483-29601-5-git-send-email-lee.jones@linaro.org>
Message-ID: <55DDF2A0.5010404@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2015 08:08 AM, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_debugfs.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

The commit message should describe why this is needed...


> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index 9d30809..9620962 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -88,8 +88,33 @@ static ssize_t rproc_state_read(struct file *filp, char __user *userbuf,
>  	return simple_read_from_buffer(userbuf, count, ppos, buf, i);
>  }
>  
> +static ssize_t rproc_state_write(struct file *filp, const char __user *userbuf,
> +				 size_t count, loff_t *ppos)
> +{
> +	struct rproc *rproc = filp->private_data;
> +	char buf[2];
> +	int ret;
> +
> +	ret = copy_from_user(buf, userbuf, 1);
> +	if (ret)
> +		return -EFAULT;
> +
> +	switch (buf[0]) {
> +	case '1':
> +		ret = rproc_boot(rproc);
> +		if (ret)
> +			dev_warn(&rproc->dev, "Boot failed: %d\n", ret);
> +		break;
> +	default:
> +		rproc_shutdown(rproc);
> +	}
> +
> +	return count;
> +}

... and I suggest that the user interface be reconsidered.  If '1' means
"boot" and literally anything else means "shut down" then you can't add
operations in the future without potentially breaking things.
