From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 27 Apr 2011 11:00:31 -0400 (EDT)
Subject: [PATCH 3/3] ARM: zImage: fix issues with missing GOT entries
	for some global variables
In-Reply-To: <20110427085853.GN17290@n2100.arm.linux.org.uk>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-4-git-send-email-nicolas.pitre@linaro.org>
	<20110420084234.GV31131@pengutronix.de>
	<alpine.LFD.2.00.1104200826550.24613@xanadu.home>
	<20110420123607.GX31131@pengutronix.de>
	<alpine.LFD.2.00.1104200843560.24613@xanadu.home>
	<20110427085853.GN17290@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1104271055550.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Apr 2011, Russell King - ARM Linux wrote:

> On Wed, Apr 20, 2011 at 08:47:17AM -0400, Nicolas Pitre wrote:
> > Uninitialized variables are allocated to the .bss section, regardless if 
> > they're static or not.  The static keyword only affects the global 
> > visibility of the variable,
> 
> Wrong.
> 
> int foo(void)
> {
> 	static int bar = 1;
> 	return bar++;
> }

I was talking about global variables.  Variables within a function are 
always visible to the local scope, static or not.

> With static allowed to have its normal meaning, this function will return
> 1 on the first call, 2 on the second, etc.  With static defined away, it
> will always return 1.  That's a behavioural change.

Exact.  And I've dropped that patch.  That doesn't mean that static 
variables within functions are always OK in the context of zImage 
though, as they are always turned into GOTOFF relocs.


Nicolas
