From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 5 Dec 2011 22:44:05 +0800
Subject: [PATCH 2/2] gpio/tegra: Dynamically allocate IRQ base, and
 support DT
In-Reply-To: <4EDCC894.7060200@gmail.com>
References: <1322700336-26866-1-git-send-email-swarren@nvidia.com>
 <1322700336-26866-2-git-send-email-swarren@nvidia.com>
 <20111205065527.GD2980@S2100-06.ap.freescale.net>
 <4EDCC894.7060200@gmail.com>
Message-ID: <20111205144404.GE2980@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 07:35:16AM -0600, Rob Herring wrote:
> Shawn,
> 
> On 12/05/2011 12:55 AM, Shawn Guo wrote:
> > On Wed, Nov 30, 2011 at 05:45:36PM -0700, Stephen Warren wrote:
> > [...]
> >>  static void tegra_gpio_irq_ack(struct irq_data *d)
> >>  {
> >> -	int gpio = d->irq - INT_GPIO_BASE;
> >> +	int gpio = d->hwirq;
> >>  
> > Though it's working right now, I'm not sure it's safe enough.  This
> > only works when d->hwirq_base is 0, which is true for now.  But I doubt
> > it will be always true.  I guess hwirq_base was introduced there for
> > some reason.  When some day irqdomain starts using this field, the
> > above code starts being broken.  IMO, the way that generic-chip.c is
> > using to calculate the number, d->irq - gc->irq_base, is much more
> > safer.
> 
> It does work as the GIC hwirq_base is non-zero. It was introduced
> exactly so that no conversion of hwirq is needed for functions like
> this. hwirq_base is the starting point local to the controller
> numbering. Say you have gpio controller with 16 lines, but only the
> upper 8 lines have interrupt capability. Then you would set hwirq_base
> to 8 and nr_irq to 8. Then hwirq will always be set to 8-15.
> 
Ah, ok.  In that case, it's safe to use.  Thanks for help understand
it.  I will use hwirq for my gpio-mxc patch then.

-- 
Regards,
Shawn
