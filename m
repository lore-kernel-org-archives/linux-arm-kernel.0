From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 21 Oct 2013 08:35:03 +0800
Subject: [PATCH] imx6q: fix emergency restart
In-Reply-To: <20131020232217.GS25034@n2100.arm.linux.org.uk>
References: <1380832337-4637-1-git-send-email-nathan_lynch@mentor.com>
 <20131020232217.GS25034@n2100.arm.linux.org.uk>
Message-ID: <20131021003500.GA17165@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 12:22:17AM +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 03, 2013 at 03:32:17PM -0500, Nathan Lynch wrote:
> > @@ -192,8 +188,15 @@ static void __init imx6q_1588_init(void)
> >  
> >  static void __init imx6q_init_machine(void)
> >  {
> > +	struct device_node *np;
> > +
> >  	imx6q_enet_phy_init();
> >  
> > +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
> > +	if (np)
> > +		wdog_base = of_iomap(np, 0);
> > +	pr_info("%s: wdog_base = %p\n", __func__, wdog_base);
> 
> I don't know whether this has been applied yet, but please don't add
> to the kernel messages unnecessarily; there's already enough of them
> and unless it provides something which is useful, it doesn't deserve
> to be at "info" level.  If you want it to report it for debugging,
> then please use the debugging level.
> 
> Specifically for imx6q, I'm finding the boot is noisy enough that it
> takes some time to find the bits you want to find amongst the 240-odd
> lines it spits out.
> 
> Also, I don't see it in arm-soc yet - is there a reason this isn't
> queued as a fix?  Without it, using sysrq to force a reboot is rather
> counter-productive.

I queued an equivalent patch [1] for it.  Since it's something never
worked and we're at late -rc time, I chose to queue it for the next
release.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/271105
