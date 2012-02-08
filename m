From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 08 Feb 2012 12:14:00 -0800 (PST)
Subject: [PATCH 2/3] ARM: make disable_fiq macro optional
In-Reply-To: <4F32D3ED.2020500@gmail.com>
References: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
 <1328562200-8810-3-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1202061424130.1656@xanadu.home> <4F30B225.60605@gmail.com>
 <alpine.LFD.2.02.1202062116210.1656@xanadu.home> <4F31AB1E.4010800@gmail.com>
 <20120208083842.GE889@n2100.arm.linux.org.uk> <4F32D3ED.2020500@gmail.com>
Message-ID: <alpine.LFD.2.02.1202081210500.1656@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Feb 2012, Rob Herring wrote:

> On 02/08/2012 02:38 AM, Russell King - ARM Linux wrote:
> > On Tue, Feb 07, 2012 at 04:52:14PM -0600, Rob Herring wrote:
> >> Wouldn't the fiq be masked then? rpc_init_irq masks out the interrupts
> >> in the same register as disable_fiq macro:
> >>
> >> iomd_writeb(0, IOMD_FIQMASK);
> > 
> > The point of the stuff in disable_fiq is to catch cases where the FIQMASK
> > register hasn't been disabled, and we receive a spurious FIQ.  What happens
> > in that case (without code in disable_fiq) is that we will endlessly spin
> > entering and re-entering the FIQ code.
> > 
> > No normal interrupts will be received, and no non-FIQ handler instructions
> > will ever be executed.
> > 
> > Without this, we're 100% reliant on the FIQMASK register being correctly
> > set.
> > 
> > I would suggest that other platforms which _can_ receive FIQs should
> > implement the disable_fiq macro for safety against these kinds of silent
> > lockups.  It shouldn't be needed in the same way that printascii()
> > shouldn't be needed.
> 
> Couldn't this be fixed generically by masking FIQ in the SPSR rather
> than the source?
> 
> Nico suggested adding a default handler with set_fiq_handler which would
> do this same write to IOMD_FIQMASK. Or I can leave the ifdef for RPC
> around disable_fiq. Guidance with what you would like to see here would
> be helpful.

Using set_fiq_handler() we could achieve the same result at run time 
instead of compile time, by using the same code as found in the macro.  
Given that this is done early enough during boot, the same result should 
be achieved.


Nicolas
