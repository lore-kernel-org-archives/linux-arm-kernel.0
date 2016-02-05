From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 05 Feb 2016 14:55:31 +0200
Subject: [PATCH V2 1/6] stm class: Add ioctl get_options interface
In-Reply-To: <1454487337-30184-2-git-send-email-zhang.chunyan@linaro.org>
References: <1454487337-30184-1-git-send-email-zhang.chunyan@linaro.org>
 <1454487337-30184-2-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <87k2mj5nb0.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chunyan Zhang <zhang.chunyan@linaro.org> writes:

> There is already an interface of set_options, but no get_options yet.
> Before setting any options, one would may want to see the current
> status of that option by means of get_options interface. This
> interface has been used in CoreSight STM driver.
>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/hwtracing/stm/core.c | 11 +++++++++++
>  include/linux/stm.h          |  3 +++
>  include/uapi/linux/stm.h     |  1 +
>  3 files changed, 15 insertions(+)
>
> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> index b6445d9..86bb4e3 100644
> --- a/drivers/hwtracing/stm/core.c
> +++ b/drivers/hwtracing/stm/core.c
> @@ -571,6 +571,17 @@ stm_char_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  						    options);
>  
>  		break;
> +
> +	case STP_GET_OPTIONS:
> +		if (stm_data->get_options)
> +			err = stm_data->get_options(stm_data,
> +						    stmf->output.master,
> +						    stmf->output.channel,
> +						    stmf->output.nr_chans,
> +						    &options);
> +
> +		return copy_to_user((void __user *)arg, &options, sizeof(u64));

The return value of copy_to_user() is not what you assume it is.

Regards,
--
Alex
