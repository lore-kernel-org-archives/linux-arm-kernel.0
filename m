From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Feb 2015 20:28:42 +0000
Subject: [PATCH] coresight: Adding coresight support for arm64 architecture
In-Reply-To: <1422990133-26342-1-git-send-email-mathieu.poirier@linaro.org>
References: <1422990133-26342-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20150203202842.GZ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 12:02:13PM -0700, mathieu.poirier at linaro.org wrote:
> diff --git a/drivers/coresight/Kconfig b/drivers/coresight/Kconfig
> new file mode 100644
> index 000000000000..271fad830ae4
> --- /dev/null
> +++ b/drivers/coresight/Kconfig
> @@ -0,0 +1,60 @@
> +#
> +# Coresight configuration
> +#
> +menuconfig CORESIGHT
> +	bool "CoreSight Tracing Support"
> +	select ARM_AMBA
> +	help
> +	  This framework provides a kernel interface for the CoreSight debug
> +	  and trace drivers to register themselves with. It's intended to build
> +	  a topological view of the CoreSight components based on a DT
> +	  specification and configure the right serie of components when a
> +	  trace source gets enabled.
> +

You could surround the following options with

if CORESIGHT
...
endif

which will implicitly make anything between depend on CORESIGHT instead of
having to specify it every time.

> diff --git a/drivers/coresight/coresight-etb10.c b/drivers/coresight/coresight-etb10.c
> index c9acd406f0d0..aa47d31fe2a2 100644
> --- a/drivers/coresight/coresight-etb10.c
> +++ b/drivers/coresight/coresight-etb10.c
> @@ -314,7 +314,7 @@ static ssize_t etb_read(struct file *file, char __user *data,
>  	*ppos += len;
>  
>  	dev_dbg(drvdata->dev, "%s: %d bytes copied, %d bytes left\n",
> -		__func__, len, (int) (depth * 4 - *ppos));
> +		__func__, (int)len, (int)(depth * 4 - *ppos));

Please use %zu for size_t types.

>  	return len;
>  }
>  
> diff --git a/drivers/coresight/coresight-tmc.c b/drivers/coresight/coresight-tmc.c
> index 3ff232f9ddf7..d08460327bd2 100644
> --- a/drivers/coresight/coresight-tmc.c
> +++ b/drivers/coresight/coresight-tmc.c
> @@ -534,7 +534,7 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
>  	*ppos += len;
>  
>  	dev_dbg(drvdata->dev, "%s: %d bytes copied, %d bytes left\n",
> -		__func__, len, (int) (drvdata->size - *ppos));
> +		__func__, (int)len, (int)(drvdata->size - *ppos));

Ditto.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
