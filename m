From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Dec 2011 08:13:27 +0000
Subject: [PATCHv2 5/5] ARM: picoxcell: implement watchdog restart
In-Reply-To: <1771411.xn5pEUbjJo@wuerfel>
References: <1324129357-16030-1-git-send-email-jamie@jamieiles.com>
 <1324129357-16030-6-git-send-email-jamie@jamieiles.com>
 <1771411.xn5pEUbjJo@wuerfel>
Message-ID: <20111218081327.GT14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 17, 2011 at 09:17:00PM +0100, Arnd Bergmann wrote:
> > +static void picoxcell_wdt_restart(char mode, const char *cmd)
> > +{
> > +	/*
> > +	 * Configure the watchdog to reset with the shortest possible timeout
> > +	 * and give it chance to do the reset.
> > +	 */
> > +	if (wdt_regs) {
> > +		__raw_writel(WDT_CTRL_REG_EN_MASK, wdt_regs + WDT_CTRL_REG_OFFS);
> > +		__raw_writel(0, wdt_regs + WDT_TIMEOUT_REG_OFFS);
> > +		mdelay(500);
> > +	}
> > +}
> 
> Does this work if the real watchdog is still running, on a preemtible kernel?
> 
> Also, please always use writel_relaxed instead of __raw_writel, and try to use
> msleep instead of mdelay by default. If msleep doesn't work here because it
> actually causes the system not to be reset, just add a comment.

Restarting can be called from atomic contexts, so any function which may
sleep must not be used.  That include sioremap.
