From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2011 09:58:53 +0100
Subject: [PATCH 3/3] ARM: zImage: fix issues with missing GOT entries
	for some global variables
In-Reply-To: <alpine.LFD.2.00.1104200843560.24613@xanadu.home>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-4-git-send-email-nicolas.pitre@linaro.org>
	<20110420084234.GV31131@pengutronix.de>
	<alpine.LFD.2.00.1104200826550.24613@xanadu.home>
	<20110420123607.GX31131@pengutronix.de>
	<alpine.LFD.2.00.1104200843560.24613@xanadu.home>
Message-ID: <20110427085853.GN17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 08:47:17AM -0400, Nicolas Pitre wrote:
> Uninitialized variables are allocated to the .bss section, regardless if 
> they're static or not.  The static keyword only affects the global 
> visibility of the variable,

Wrong.

int foo(void)
{
	static int bar = 1;
	return bar++;
}

With static allowed to have its normal meaning, this function will return
1 on the first call, 2 on the second, etc.  With static defined away, it
will always return 1.  That's a behavioural change.

Moreover, if we have:

int foo(void)
{
	static int table[] = { ... };
}

then with static defined away, this turns into a runtime memcpy from
read-only data to read-write data each time the function is called.

Defining away static causes this kind of undesirable (and often hidden)
effect - and in these cases it most certainly is not just about variable
visibility.
