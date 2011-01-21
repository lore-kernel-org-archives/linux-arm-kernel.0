From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 12:14:21 +0000
Subject: CLCD support in phy3250
Message-ID: <20110121121421.GQ13235@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While looking at clcd support, I spotted this:

        .tim2           = (TIM2_IVS | TIM2_IHS),

Note that we already do this:

        val = fb->panel->tim2;
        val |= fb->fb.var.sync & FB_SYNC_HOR_HIGH_ACT  ? 0 : TIM2_IHS;
        val |= fb->fb.var.sync & FB_SYNC_VERT_HIGH_ACT ? 0 : TIM2_IVS;

so if your .mode.sync member is unset, you'll have IHS and IVS already
set.  So this can be removed.  Please can you submit a patch for this?
Thanks.


Also, I spotted this:

        .cntl           = (CNTL_BGR | CNTL_LCDTFT | CNTL_LCDVCOMP(1) |
                                CNTL_LCDBPP16_565),

This doesn't switch to 565 mode - this is decided by other parts of the
code.  As we or in the mode, this could cause problems.  If you ensure
that .bpp is 16, and you have a PL111, it will default to 565 mode.

Having looked at this, I think we need a capability field to mark what
depths and layouts are supported, both from the platform and from the
panel information, as you don't want to permit RGB5551 if your panel can
only do BGR565.  I'll see about adding that.
