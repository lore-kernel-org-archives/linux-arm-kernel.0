From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Apr 2015 10:13:10 +0100
Subject: [PATCH v2 2/2] arch: arm: Show the serial number from devicetree
 in cpuinfo
In-Reply-To: <1429296235-14123-2-git-send-email-contact@paulk.fr>
References: <1429296235-14123-1-git-send-email-contact@paulk.fr>
 <1429296235-14123-2-git-send-email-contact@paulk.fr>
Message-ID: <20150418091310.GI12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 17, 2015 at 08:43:55PM +0200, Paul Kocialkowski wrote:
>  static int __init init_machine_late(void)
>  {
> +#ifdef CONFIG_OF
> +	unsigned long dt_root;
> +	int size;
> +
> +	dt_root = of_get_flat_dt_root();
> +
> +	/* Scan for serial number */
> +	system_serial = of_get_flat_dt_prop(dt_root, "serial-number", &size);

I was really hoping for:

	if (of_property_read_string(of_root, "serial-number", &system_serial))
		system_serial = NULL;

here.  I can't see a reason to use the flattened DT at this point as
we've already parsed it.

I'd also put this after the call to machine_desc->init_late().

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
