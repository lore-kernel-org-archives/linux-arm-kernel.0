From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 18 Nov 2011 12:20:50 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <20111117160536.GU9581@n2100.arm.linux.org.uk>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
 <20111117160536.GU9581@n2100.arm.linux.org.uk>
Message-ID: <1321618850.24216.325.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-11-17 at 16:05 +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 11, 2011 at 06:27:04PM +0000, Pawel Moll wrote:
> > +#if defined(CONFIG_ARCH_VEXPRESS_DT)
> > +		int err;
> > +		const char *path;
> > +		struct device_node *node;
> > +
> > +		node = of_find_compatible_node(NULL, NULL, "arm,sp810");
> > +		BUG_ON(!node);
> > +		sysctl_base = of_iomap(node, 0);
> > +		BUG_ON(!sysctl_base);
> > +
> > +		err = of_property_read_string(of_aliases, "timer", &path);
> > +		BUG_ON(err);
> > +		node = of_find_node_by_path(path);
> > +		BUG_ON(!node);
> > +		timer01_base = of_iomap(node, 0);
> > +		BUG_ON(!timer01_base);
> > +		timer01_irq = irq_of_parse_and_map(node, 0);
> 
> Are you sure you have enough BUG_ON()s there?  

Yes, just enough, thank you.

> It's well worth reading
> Linus' various messages on the use of BUG(), which can be found:
> 
> 	http://yarchive.net/comp/linux/BUG.html

It was worth reading indeed. I will adapt to the policy.

> The lack of the timer and sysctl registers are really a 'report and maybe
> we could get a message out' kind of scenario rather than a 'oops, kill
> the machine'.
> 
> > +#endif
> > +	} else {
> >  		sysctl_base = ioremap(V2M_SYSCTL, SZ_4K);
> >  		BUG_ON(!sysctl_base);
> >  		timer01_base = ioremap(V2M_TIMER01, SZ_4K);
> >  		BUG_ON(!timer01_base);
> >  		timer01_irq = IRQ_V2M_TIMER0;
> > +	}
> 
> And in any case, both these paths have a common set of BUG_ON()s:
> 	BUG_ON(!sysctl_base);
> 	BUG_ON(!timer01_base);
> 
> So do we really need them having this independently?

No, you are right.

> > @@ -383,11 +412,18 @@ static struct clk_lookup v2m_lookups[] = {
> >  	},
> >  };
> >  
> > +static void __init v2m_system_id(void)
> > +{
> > +	if (!system_rev)
> > +		system_rev = readl(v2m_sysreg_base + V2M_SYS_ID);
> 
> You do understand that system_rev is for the system _revision_ not for
> some kind of system ID.  For example, it's to identify whether we're on
> a revision 4, 5 or 6 system.

SYS_ID encodes the motherboard revision (SYS_ID >> 28) and the FPGA
build (SYS_ID & 0xf) - those two together constitute the system
revision. As as 4 < 5 < 6, SYS_IDs of Rev A < Rev B < Rev C. I should
have masked out the non-relevant bits.

> However, with DT the differences in system revision should be encoded
> into the DT itself, and the kernel should not be making choices about
> the hardware off this.

This change had nothing to do DT or making choices - I was simply asked
to expose this information to the userspace for testing purposes and the
system_rev, available via /proc/cpuinfo seemed the best choice.

But as this change has nothing to do with DT it shouldn't be included in
this patch in the first place. I will split it out.

All comments appreciated as always, thanks!

Pawel
