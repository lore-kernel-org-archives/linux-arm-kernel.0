From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2009 14:10:03 +0100
Subject: [PATCH 2/9] collie: prepare for gpiolib use
In-Reply-To: <20091007124251.GB7656@rainbow>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-2-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-3-git-send-email-thommycheck@gmx.de>
	<20091007110805.GA7656@rainbow>
	<20091007112552.GC6246@n2100.arm.linux.org.uk>
	<20091007124251.GB7656@rainbow>
Message-ID: <20091007131003.GA11371@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2009 at 04:42:52PM +0400, Dmitry Artamonow wrote:
> Perhaps I wasn't exactly clear in explaining my thoughts. Sorry.
> I meant following - currently in mach/h3600_gpio.h we have gpios declared
> like that:
> #define GPIO_H3100_IR_ON                GPIO_GPIO (8)
> which effectively means:
> #define GPIO_H3100_IR_ON                (1 << 8)
> i.e. bit-shifted value. 
> 
> But gpiolibs needs numeric gpio definitions, something like that:
> #define NGPIO_H3100_IR_ON		8
> 
> That's all well, but not all direct operations with GPIO registers on
> SA1100 can be converted to gpiolib.

I tinkered around with this yesterday before your message came through,
and I defined a new set of definitions, eg:

#define H3100_GPIO_IR_ON	8

so avoiding the problem.  See my 'sa1100' branch published in the usual
places.

> Operations with GAFR (GPIO alternate function register), for example
> (PXA have MFD API for that, but StrongArm doesn't)

Maybe long-term replicating something like the MFP API would be a good
idea, rather than sticking with direct manipulation of the GAFR (which
is racy if done from two different contexts).

Currently, it's hard to audit that all GAFR manipulations are done in
a safe way.
