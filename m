From: nm@ti.com (Nishanth Menon)
Date: Mon, 6 Jun 2016 16:49:57 -0500
Subject: [PATCH v10 3/4] tee: add OP-TEE driver
In-Reply-To: <1464784888-19854-4-git-send-email-jens.wiklander@linaro.org>
References: <1464784888-19854-1-git-send-email-jens.wiklander@linaro.org>
 <1464784888-19854-4-git-send-email-jens.wiklander@linaro.org>
Message-ID: <5755F005.3050104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 07:41 AM, Jens Wiklander wrote:
[...]
> diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
> index 60d2dab..53f3c76 100644
> --- a/drivers/tee/Makefile
> +++ b/drivers/tee/Makefile
> @@ -1,3 +1,4 @@
>  obj-y += tee.o
>  obj-y += tee_shm.o
>  obj-y += tee_shm_pool.o
> +obj-$(CONFIG_OPTEE) += optee/
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> new file mode 100644
> index 0000000..a7a8b71
> --- /dev/null
> +++ b/drivers/tee/optee/Kconfig
> @@ -0,0 +1,8 @@
> +# OP-TEE Trusted Execution Environment Configuration
> +config OPTEE
> +	tristate "OP-TEE"
> +	default n
You should'nt need this.

> +	depends on HAVE_ARM_SMCCC

HAVE_ARM_SMCCC might depend on OPTEE secure support in place, right? I
wonder if setsup any constraints for having a single zImage for OPTEE
and non-OPTEE systems, I think not.. just wondering.

Further, at this patch, smatch[1] complains:
> +drivers/tee/optee/core.c:488 optee_probe() error: we previously assumed 'optee' could be null (see line 444) 

Checkpatch --strict complains:

> +CHECK: Alignment should match open parenthesis
> +#878: FILE: drivers/tee/optee/core.c:333:
> ++static struct tee_shm_pool *optee_config_shm_ioremap(struct device *dev,
> ++                      optee_invoke_fn *invoke_fn,


[1] git://repo.or.cz/smatch.git
-- 
Regards,
Nishanth Menon
