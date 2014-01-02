From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 2 Jan 2014 16:08:32 -0700
Subject: [PATCH] ARM: Kirkwood: Add support for Excito Bubba B3
In-Reply-To: <1388702192.16958.54.camel@hastur.hellion.org.uk>
References: <1388247131-19301-1-git-send-email-andrew@lunn.ch>
 <20131228170114.GH19878@titan.lakedaemon.net>
 <20140102194924.GA3321@obsidianresearch.com>
 <1388702192.16958.54.camel@hastur.hellion.org.uk>
Message-ID: <20140102230832.GB9339@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 10:36:32PM +0000, Ian Campbell wrote:
> On Thu, 2014-01-02 at 12:49 -0700, Jason Gunthorpe wrote:
> > On Sat, Dec 28, 2013 at 12:01:14PM -0500, Jason Cooper wrote:
> > 
> > > > + * Note: This requires a new'ish version of u-boot, which disables the
> > > > + * L2 cache. If your B3 silently fails to boot, u-boot is probably too
> > > > + * old. Either upgrade, or consider the following email:
> > > > + *
> > > > + * http://lists.debian.org/debian-arm/2012/08/msg00128.html
> > > 
> > > Nice, thanks for adding this.
> > 
> > Nifty.. But what is the root cause for the above?
> > 
> > I'm guessing that at some point the the L1 icache has been enabled,
> > the L1 dcache disabled, and the L2 cache enabled?
> > 
> > If the pv_fixup runs with both L1 caches off and an empty L2 then it
> > shouldn't cause a problem.
> 
> I'm not 100% sure but I think the issue is that the kernel expects to be
> running with all of the caches off, but u-boot incorrectly left the l2
> on. The L2 is probably not empty (because u-boot was using it).

I think I see the problem now.. The decompressor turns on the L1
dcache, which populates the enabled L2 with write through data. When
the decompressor turns the dcache off again the L2 retains some of the
kernel image and any data writes done in head.S while the dcache is
off could be corrupted if they overlap the L2's retention,
specifically the pv_fixup stuff, but other elements could potentially
be mangled too.

So all Marvell platforms with their L2 cache controller must boot into
the decompressor with the L2 cache completely off, or the kernel needs
additional Marvell L2 specific flushing code prior to enabling the MMU
:(

.. and since the problem only shows obviously with multiplatform
kernels that have been relocated it could be a broader, subtler issue
than just your one board ...

Jason C: What do you think about applying this [untested]?

Or do you think the kernel should support booting with L2 on (this is
just two instructions, but they need to be conditional on the CPU type
:( :( )?

-----
arm: Kirkwood: Log a FW_BUG if the L2 cache is turned on at boot

Linux can't cope if the the L2 cache is enabled at boot. It works
sometimes, if the data writes head.S does during the L1 cache-off
period do not overlap with lines in the L2.

This is unlikely if CONFIG_ARM_PATCH_PHYS_VIRT is used, as the
decompressor will pull a chunk of the kernel code into L2 cache.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index 48bc3c0..68781a4 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -331,7 +331,8 @@ static void __init enable_l2(void)
                        enable_icache();
                if (d)
                        enable_dcache();
-       }
+       } else
+               pr_err(FW_BUG "Feroceon L2: bootloader left the L2 cache on!\n");
 }
 
 void __init feroceon_l2_init(int __l2_wt_override)


Jason
