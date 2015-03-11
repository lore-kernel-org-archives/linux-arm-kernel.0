From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Mar 2015 13:24:56 +0000
Subject: [PATCH 4/7] ARM: mx25: Retrieve IIM base from dt
In-Reply-To: <1426077835-31081-4-git-send-email-festevam@gmail.com>
References: <1426077835-31081-1-git-send-email-festevam@gmail.com>
 <1426077835-31081-4-git-send-email-festevam@gmail.com>
Message-ID: <20150311132456.GD8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 09:43:52AM -0300, Fabio Estevam wrote:
> +	void __iomem *iim_base;
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx25-iim");
> +	iim_base = of_iomap(np, 0);
> +	WARN_ON(!iim_base);
> +	rev = readl(iim_base + MXC_IIMSREV);
> +	iounmap(iim_base);

Is there much point to that WARN_ON()?  Are you avoiding the political
BUG_ON(!iim_base) ? :)

Since a NULL pointer there will lead to a NULL pointer dereference, it's
silly to use WARN_ON() there - we'll get a backtrace etc from the WARN_ON
followed immediately by an oops dump due to the readl(), crashing the
kernel.

Better to just use BUG_ON() and only get one set of diagnostics.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
