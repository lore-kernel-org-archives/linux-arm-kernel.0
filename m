From: pavel@denx.de (Pavel Machek)
Date: Wed, 1 Oct 2014 17:04:19 +0200
Subject: [PATCH 1/2] socfpga: hotplug: put cpu1 in wfi
In-Reply-To: <alpine.DEB.2.10.1410010915440.2332@shineypoop>
References: <1411590449-9794-1-git-send-email-atull@opensource.altera.com>
 <1411590449-9794-2-git-send-email-atull@opensource.altera.com>
 <20141001133527.GA12750@amd>
 <alpine.DEB.2.10.1410010915440.2332@shineypoop>
Message-ID: <20141001150418.GA14609@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > +		__raw_writel(RSTMGR_MPUMODRST_CPU1,
> > > +			     rst_manager_base_addr + 0x10);
> > 
> > Would it be possible to copy reset manager description struct from
> > u-boot and use it here, instead of raw offset?
> 
> I will replace this 0x10 with a macro that reflects how the register is 
> named in the register map.

That would be better than 0x10, but even better would be just copying

struct socfpga_reset_manager {
        u32     status;
        u32     ctrl;
        u32     counts;
        u32     padding1;
        u32     mpu_mod_reset;
        u32     per_mod_reset;
        u32     per2_mod_reset;
        u32     brg_mod_reset;
};

from u-boot. Unlike macros, structs have advantages that typos lead to
easier-to-see failure modes... (And they are easier to read/parse,
too).

Thanks,
									Pavel 
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
