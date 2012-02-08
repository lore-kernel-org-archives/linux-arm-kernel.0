From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 08 Feb 2012 12:52:49 -0800 (PST)
Subject: [PATCH 2/3] ARM: make disable_fiq macro optional
In-Reply-To: <20120208203005.GB15849@n2100.arm.linux.org.uk>
References: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
 <1328562200-8810-3-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1202061424130.1656@xanadu.home> <4F30B225.60605@gmail.com>
 <alpine.LFD.2.02.1202062116210.1656@xanadu.home> <4F31AB1E.4010800@gmail.com>
 <20120208083842.GE889@n2100.arm.linux.org.uk> <4F32D3ED.2020500@gmail.com>
 <20120208203005.GB15849@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1202081247190.1656@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Feb 2012, Russell King - ARM Linux wrote:

> On Wed, Feb 08, 2012 at 01:58:37PM -0600, Rob Herring wrote:
> > Nico suggested adding a default handler with set_fiq_handler which would
> > do this same write to IOMD_FIQMASK. Or I can leave the ifdef for RPC
> > around disable_fiq. Guidance with what you would like to see here would
> > be helpful.
> 
> I don't think so - you either end up leaving a window where we disable
> FIQs in the CPSR (which could get propagated to other threads) or you
> leave a window where an errant FIQ could lock the system.

I was thinking about hooking a subarch specific disable_fiq handler 
using set_fiq_handler() from the mdesc->init_early callback.  This is 
done after the vector page is initialized, and if I'm not mistaken, IRQs 
and FIQs are still disabled at that point.


Nicolas
