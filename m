From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 20 Mar 2010 14:06:25 +0000
Subject: [PATCH 1/3] watchdog: Add support for the Freescale MXC watchdog
In-Reply-To: <1269011607-23077-1-git-send-email-vzapolskiy@gmail.com>
References: <1269011607-23077-1-git-send-email-vzapolskiy@gmail.com>
Message-ID: <20100320140625.GA30391@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 06:13:27PM +0300, Vladimir Zapolskiy wrote:
> +/* The watchdog found on MXC chips cannot be disabled. */
> +static int mxc_wdt_release(struct inode *inode, struct file *file)
> +{
> +        struct mxc_wdt *wdt = file->private_data;
> +
> +        /* disable the watchdog timer unless NOWAYOUT is defined. */
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +        mxc_wdt_disable(wdt);
> +#else
> +        printk(KERN_CRIT "MXC watchdog: unexpected close, timer will not stop\n");
> +#endif
> +        clear_bit(0, &wdt->status);
> +
> +        clk_disable(wdt->clk);

You're sure that disabling the watchdog clock won't disable the watchdog
itself?
