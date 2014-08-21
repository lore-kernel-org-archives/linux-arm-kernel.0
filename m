From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Aug 2014 05:32:59 +0200
Subject: [PATCH 3/3] ARM: at91/tclib: mask interruptions at shutdown and
 probe
In-Reply-To: <1408486072-19268-4-git-send-email-gael.portay@gmail.com>
References: <1408486072-19268-1-git-send-email-gael.portay@gmail.com>
 <1408486072-19268-4-git-send-email-gael.portay@gmail.com>
Message-ID: <201408210533.00196.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 August 2014, Ga?l PORTAY wrote:
> +static void tc_shutdown (struct platform_device *pdev)
> +{
> +       int i;
> +       struct atmel_tc *tc = platform_get_drvdata(pdev);
> +
> +       for (i = 0; i < 3; i++)
> +               __raw_writel(0xff, tc->regs + ATMEL_TC_REG(i, IDR));
> +}

In general, __raw_readl/__raw_writel are not meant to be called by device drivers.

Just use readl/writel by default, or readl_relaxed/writel_relaxed if the code is
performance critical and you are sure it is safe to use them.

	Arnd
