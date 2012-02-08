From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Feb 2012 08:38:42 +0000
Subject: [PATCH 2/3] ARM: make disable_fiq macro optional
In-Reply-To: <4F31AB1E.4010800@gmail.com>
References: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
 <1328562200-8810-3-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1202061424130.1656@xanadu.home> <4F30B225.60605@gmail.com>
 <alpine.LFD.2.02.1202062116210.1656@xanadu.home> <4F31AB1E.4010800@gmail.com>
Message-ID: <20120208083842.GE889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 04:52:14PM -0600, Rob Herring wrote:
> Wouldn't the fiq be masked then? rpc_init_irq masks out the interrupts
> in the same register as disable_fiq macro:
> 
> iomd_writeb(0, IOMD_FIQMASK);

The point of the stuff in disable_fiq is to catch cases where the FIQMASK
register hasn't been disabled, and we receive a spurious FIQ.  What happens
in that case (without code in disable_fiq) is that we will endlessly spin
entering and re-entering the FIQ code.

No normal interrupts will be received, and no non-FIQ handler instructions
will ever be executed.

Without this, we're 100% reliant on the FIQMASK register being correctly
set.

I would suggest that other platforms which _can_ receive FIQs should
implement the disable_fiq macro for safety against these kinds of silent
lockups.  It shouldn't be needed in the same way that printascii()
shouldn't be needed.
