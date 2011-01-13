From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 13 Jan 2011 17:28:27 +0100 (CET)
Subject: resume regression in 2.6.37
In-Reply-To: <1294933492.2535.23.camel@sven>
References: <1294933492.2535.23.camel@sven>
Message-ID: <alpine.LFD.2.00.1101131720350.2678@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jan 2011, Sven Neumann wrote:
> Now I've tried to update the kernel to 2.6.37. After fixing the already
> reported NULL pointer dereference on bootup in pxa3xx_nand_probe(), the
> device seems to work fine until I suspend it and then try to wake it up
> from suspend. Suspend seems to work fine, no warnings whatsoever.
> However there is absolutely no sign of resume.
> 
> I've used git bisect to track this down to the following commit:
> 
> 
> commit 2f7e99bb9be6a2d8d7b808dc86037710cc8b7bf1
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Mon Sep 27 12:45:50 2010 +0000
> 
>     genirq: Provide compat handling for chip->set_wake()
>     
>     Wrap the old chip function set_wake() until the migration is
>     complete and the old chip functions are removed.
>     
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     LKML-Reference: <20100927121842.927527393@linutronix.de>
>     Reviewed-by: H. Peter Anvin <hpa@zytor.com>
>     Reviewed-by: Ingo Molnar <mingo@elte.hu>
> 
> 
> Any idea on how to proceed from here? I don't think I can just revert
> this commit and expect things to work, right?

Well, I somehow doubt, that this is the real culprit. The patch does
not change anything of the set_wake() functionality. It's a functional
equivivalent wrapper, nothing else.

Can you revert it on top of 2.6.37 and verify that it helps ?

Thanks,

	tglx
