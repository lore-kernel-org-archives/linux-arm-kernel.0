From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 May 2013 19:59:42 +0200
Subject: [PATCH 9/9] arm: mvebu: switch internal register address at
 runtime if needed
In-Reply-To: <20130522174258.GO2824@lunn.ch>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1369132414-18959-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130522174258.GO2824@lunn.ch>
Message-ID: <20130522195942.33ff1131@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Wed, 22 May 2013 19:42:58 +0200, Andrew Lunn wrote:

> > + * However, when the bit is not set, we do a static mapping of the
> > + * register area that allows to change the internal register address,
> > + * we change this address, and set this bit.
> 
> Hi Thomas
> 
> Please could you explain this "and set this bit".
> 
> If i understand the comment correctly, you are talking about the bit
> in CP15. Why is it necessary to set it, since at the next WFI its
> going to get cleared. I also don't actually see any code doing the
> setting of this bit.

Nice catch. This is a left-over from a previous implementation. For
experimentation purposes, I have been using a different CP15 bit that
was not getting cleared on WFIs, so once the register address switch was
done, I was setting this bit to indicate to further invocations of
earlyprintk that the switch has occurred.

In the mean time, the code has been changed to use the final bit used
by Marvell bootloaders, and this one gets cleared at the next WFI. So
I'm now using a global variable instead to indicate that the switch has
occurred making this comment inaccurate.

I'll fix that in the next revision of this patch set.


> > +		/*
> > +		 * Change the physical base address of the
> > +		 * registers. From now on, and until
> > +		 * debug_ll_io_init() is called below, it is not
> > +		 * possible to do any print, because earlyprintk will
> > +		 * not work.
> 
> Is its "not work" or "locks up the CPU as dead as a Dodo?".

locks up the CPU as a Dodo: you have switched the registers from 0xd0
to 0xf1, but the earlyprintk virtual mapping still points to 0xd0. So
if you try to do a printk, it will call earlyprintk, which will use the
old virtual mapping (since mvebu_switched_regs isn't set yet, it will
be at the next line), and that will make it use the old physical
address of the UART. So you'll write to 0xd0012000, and you're dead.

Thanks for the review!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
