From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jul 2017 00:53:54 +0100
Subject: IMX53 on recent 4.4.x kernels
In-Reply-To: <D24E577EA1E37B4788A3BFBC418F14A7075925A1@wetsrvex01.loepfe.com>
References: <D24E577EA1E37B4788A3BFBC418F14A707591D67@wetsrvex01.loepfe.com>
 <20170720123933.rioxhsthaaby4cnl@pengutronix.de>
 <D24E577EA1E37B4788A3BFBC418F14A707592381@wetsrvex01.loepfe.com>
 <CAOMZO5DrFnr6mr991ayMxLF0+jQddJyTbCbK1A5JVNAUVMDw3A@mail.gmail.com>
 <D24E577EA1E37B4788A3BFBC418F14A70759249B@wetsrvex01.loepfe.com>
 <20170720141528.kxrw5r4hpa2hebvd@pengutronix.de>
 <D24E577EA1E37B4788A3BFBC418F14A7075925A1@wetsrvex01.loepfe.com>
Message-ID: <20170720235354.GF31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 03:06:27PM +0000, Vellemans, Noel wrote:
> 3.b: stripped ROOTFS to minimum on BOTH ( running the same STRIPPED rootfs)
> And I did build a small TEST-tool that was probing for kernel time ( looping X times) as test result of this small test tool , I measured execution times on both Kernels ( it's a simple stupid loop probing for kernel time in a loop)
> 
> The measured  RUNTIMES on 2.6.35 are in the 18000 ms range
> The measured  RUNTIMES on 4.4.x  are in the 61000 ms range ( see below)  { for the same TEST tool } 

It may help to test some intervening kernels - v2.6.35 was released
on 1st August 2010 and 4.4 in January 2016.  That's an awful lot of
changes, and to ask people what happened during six years to cause
a performance regression is a tad unfair.

I'd suggest one potential candidate for testing would be 2.6.38,
where the clock_gettime() code was restructured somewhat - that
shouldn't be too different from 2.6.35 to port your additional
patches to.

You may also like to consider doing a manual bisection of kernel
versions to try and track down whether it's been a gradual loss
of performance or a sudden change, and where it occurred.  I know
it's a pain to do it over such a large series of kernels, but
otherwise you're basically asking people to guess.

Also, I suspect most people's userspace may break if they try to
wind their kernels back to 2.6.35 (I suspect most folk's hardware
wasn't supported by that kernel.)

Another thing to check is that you have features like the spinlock
debug, semaphore debug, lockdep, tracing etc all disabled - these
can add quite a bit of additional processing into critical paths.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
