From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Nov 2011 11:41:47 +0000
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
In-Reply-To: <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
 <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
Message-ID: <20111111114147.GE12410@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding Benoit to CC].

On Thu, Nov 10, 2011 at 09:02:14AM +0000, Paul Walmsley wrote:
> On Wed, 9 Nov 2011, Ming Lei wrote:
> > Also, current arm perf code don't handle three IRQs(one pl310 irq and 
> > two CTI irq) inside one device correctly.
> 
> To fix this, that ARM perf code should either be using 
> platform_get_irq_byname(), or the hwmod hardware data will need to be 
> rearranged to meet the arbitrary ordering requirement.  I'd suggest 
> pinging Will on this issue to see what he wants to do.

The issue stems from the fact that we have to route the PMU interrupts to
the correct CPU manually (I think only MSM routes them as PPIs, which is
clearly the correct thing to do). To do this, we expect the IRQ resources to
be laid out in CPU order. In hindsight, maybe naming the resources might
have been a good idea, but them we'd still have to generate the names using
CPU numbers when iterating through the platform device.

So although the ordering requirements are a bit of a pain, I do think it's
reasonable for perf to expect that it's not being handed some random other
interrupts along with those for the PMU.

> So the clockdomain is already defined in 
> mach-omap2/clockdomains44xx_data.c and there's code to control it - see 
> for example clkdm_enable_idle().  But this code should not be called 
> directly by any device driver code or driver integration code.  The thing 
> to do here is to ask Beno?t to release the hwmod data for the DEBUGSS 
> hwmod, then someone will need to write an MFD driver for that which 
> exposes the PMU address space to the PMU platform driver.

Benoit? Please can you chime in here?

Will
