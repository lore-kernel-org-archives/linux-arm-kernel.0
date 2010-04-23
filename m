From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 23 Apr 2010 11:02:05 +0800
Subject: [PATCH] serial/imx: only parse for iomem resources once
In-Reply-To: <20100422143343.GB32348@pengutronix.de>
References: <1271838838.643120.804272014834.1.gpush@pororo>
	<20100422143343.GB32348@pengutronix.de>
Message-ID: <201004231102.06849.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

> What are the effects for this regarding run time?  How often are
> request_port and release_port called?  I wonder if it's worth to save
> the value.  Or what else than run time is your concern?

I'm not too concerned with the reduction in run time here - I'd like to be 
able to parse the UART config from the device tree, rather than using 
platform_get_{irq,resource}.

With this patch, all of the existing parsing is done in serial_imx_probe(). 
This means we can just abstract the parsing once, rather than having to check 
what parsing method (platform or devtree) we're using in request_port and 
release_port as well.

See serial_imx_probe_pdata and serial_imx_probe_dt in:

http://kernel.ubuntu.com/git?p=jk/dt/linux-2.6.git;a=blob;f=drivers/serial/imx.c;h=a54f6464d35920a81fdcc9fd93de3283260ab839;hb=2610717ecacfba0db34ad5b28ed6379560108912

for my intended (work-in-progress) approach.

Cheers,


Jeremy
