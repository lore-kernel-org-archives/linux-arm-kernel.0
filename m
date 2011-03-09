From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 Mar 2011 17:47:52 +0000
Subject: [RFC PATCHv1 1/2] Export SoC info through sysfs
In-Reply-To: <1299689961-5028-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299689961-5028-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
Message-ID: <20110309174752.GC1225@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2011 at 05:59:20PM +0100, Maxime Coquelin wrote:

> +config SYS_SOC
> +	bool "Export SoC specific informations"
> +	depends on EMBEDDED
> +
>  endmenu

Would it not be better for this to depend on a symbol that systems can
select when they add useful output?  If there's nothing that generates
information for it on a given platform there's no point in enabling it.

> +static ssize_t show_info(struct sysdev_class *class,
> +				struct sysdev_class_attribute *attr, char *buf)
> +{
> +	struct sys_soc_info *si = container_of(attr,
> +			struct sys_soc_info, attr);
> +
> +	if (si->info)
> +		return sprintf(buf, "%s\n", si->info);
> +	else if (si->get_info)
> +		return sprintf(buf, "%s\n", si->get_info(si));

It seems like it'd be easier to pass the output buffer directly to
get_info(), otherwise the get_info() implementation will have to figure
out a buffer to return data from.
