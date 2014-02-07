From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 7 Feb 2014 11:13:59 -0700
Subject: [PATCH 10/21] ARM: MM: Add DT binding for Feroceon L2 cache
In-Reply-To: <20140207093206.GE17758@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-11-git-send-email-andrew@lunn.ch>
 <20140207012752.GO8533@titan.lakedaemon.net>
 <20140207093206.GE17758@lunn.ch>
Message-ID: <20140207181359.GD16263@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 10:32:06AM +0100, Andrew Lunn wrote:

> > I'd prefer to fallback to hardcoded register address here.  We know
> > we're on kirkwood at this point.
> 
> We could also be on mv78xx0, sometime in the future. So we need to at
> least look at the compatible string to see what SoC we are. It is also
> rather ugly having hard coded addresses. We might as well go back to
> platform devices.

The driver should have a default mode "marvell,feroceon-cache" which
doesn't manipulate the write through register at all. In this mode you
don't need any register mapping or DT block, just do the mcr/mrc
operations to switch the cache on and inhibit printing of the write
through status.

So, I'd suggest rough logic like:

int feroceon_of_init()
{
 writethrough = -1;
 if (np = of_find_compatible("marvell,kirkwood-cache")) {
     writethrough = set_writethrough(np, L2_WT_REG_KIRKWOOD, 
                                     L2_WRITETHROUGH_KIRKWOOD);
 else if (np = of_find_compatible("marvell,mv78xx0-cache")) {
     writethrough = set_writethrough(np, L2_WT_REG_MV78XX0,
                                     L2_WRITETHROUGH_MV78XX0);

 feroceon_l2_init(writethrough);

[..]
void __init feroceon_l2_init(int __l2_wt_override)
{
    /* If we don't know the write through state then assume it is
       write back, as that is the safest option. */
    if (__l2_wt_override == -1)
      l2_wt_override = 0;
    else
      l2_wt_override = __l2_wt_override;

[..]
        printk(KERN_INFO "Feroceon L2: Cache support initialised%s.\n",
                         l2_wt_override == 1 ? ", write through enabled" : "");

> I would prefer upping this to pr_err(FW_INFO, and not falling back to
> hard coded values. This is not a fatal error, the machine continues to
> run, just a bit slower.

The only loss with not having the register mappings is you must assume
write back and thus the system must do possibly useless cache flushes
in the DMA path. Otherwise the cache can be fully enabled without
needing model specific registers.

The writethrough disable is such an obscure feature, I think we can
just skip having a compatibility fall back for missing DT node.

BTW, if you have a git URL for your patch set I can probably give v2 a
try here on Kirkwood..

Regards,
Jason
