From: michal.vokac@ysoft.com (=?UTF-8?B?TWljaGFsIFZva8OhxI0=?=)
Date: Mon, 1 Oct 2018 18:27:16 +0200
Subject: [PATCH v2 1/2] Revert "pwm: Set class for exported channels in
 sysfs"
In-Reply-To: <1538400237-28766-2-git-send-email-fabrice.gasnier@st.com>
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
 <1538400237-28766-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <156b0b28-a23a-b8f9-c8ef-67dfe31815ad@ysoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1.10.2018 15:23, Fabrice Gasnier wrote:
> This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 ("pwm: Set
> class for exported channels in sysfs") as it causes regression with
> multiple pwm chip[1], when exporting a pwm channel (echo X > export):
> 
> - ABI (Documentation/ABI/testing/sysfs-class-pwm) states pwmX should be
>    created in /sys/class/pwm/pwmchipN/pwmX
> - Reverted patch causes new entry to be also created directly in
>    /sys/class/pwm/pwmX
> - 1st time, exporting pwmX will create an entry in /sys/class/pwm/pwmX
> - class attributes are added under pwmX folder, such as export, unexport
>    npwm, symlinks. This is wrong as it belongs to pwmchipN. It may cause
>    bad behavior and report wrong values.
> - when another export happens on another pwmchip, it can't be created
>    (e.g. -EEXIST). This is causing the issue with multiple pwmchip.
> 
> Example on stm32 (stm32429i-eval) platform:
> $ ls /sys/class/pwm
> pwmchip0 pwmchip4
> 
> $ cd /sys/class/pwm/pwmchip0/
> $ echo 0 > export
> $ ls /sys/class/pwm
> pwm0 pwmchip0 pwmchip4
> 
> $ cd /sys/class/pwm/pwmchip4/
> $ echo 0 > export
> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> ...Exception stack follows...
> 
> This is also seen on other platform [2]
> 
> [1] https://lkml.org/lkml/2018/9/25/713
> [2] https://lkml.org/lkml/2018/9/25/447
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Tested-by: Gottfried Haider <gottfried.haider@gmail.com>

Tested-by: Michal Vok?? <michal.vokac@ysoft.com>

> ---
>   drivers/pwm/sysfs.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 7c71cdb..4726d43 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -263,7 +263,6 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
>   	export->pwm = pwm;
>   	mutex_init(&export->lock);
>   
> -	export->child.class = parent->class;
>   	export->child.release = pwm_export_release;
>   	export->child.parent = parent;
>   	export->child.devt = MKDEV(0, 0);
> 
