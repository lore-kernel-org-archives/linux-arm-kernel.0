From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Feb 2013 12:08:03 +0000
Subject: [PATCH] staging: imx/drm: request irq only after adding the crtc
In-Reply-To: <20773.51303.693814.857398@ipc1.ka-ro>
References: <1361284559-25125-1-git-send-email-p.zabel@pengutronix.de>
 <CAKGA1bmFubywyW=t86P_O3YXqzKoboa0xLQvFFQaDqUcaMBX-Q@mail.gmail.com>
 <20773.51303.693814.857398@ipc1.ka-ro>
Message-ID: <20130221120802.GA17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 08:10:31AM +0100, Lothar Wa?mann wrote:
> IMO its more about defensive programming. Registering an interrupt
> handler only after everything that the handler needs has been
> initialized is a Good Thing(TM), no matter whether the interrupt could
> possibly occur or not.

There are debugging modes in the kernel explicitly for this, although
wrt shared interrupts.  They explicitly trigger a call to the interrupt
handler as soon as the handler is registered.

It's there to trip up exactly these kinds of programming errors.  And
yes, it is _bad_ _practice_ to register an interrupt handler which is
not ready to be run.  You should expect the handler to be callable as
soon as it is registered.

As for ensuring that interrupts are disabled on the device before
registering the handler, that's up to the driver author to decide, but
it's also a common sense issue - if you're not ready to handle interrupts
then make sure they're not unmasked on the device.

So... sensible programming with interrupts:
1. don't register your interrupt handler before the point where it's able
   to run without causing any problems.
2. don't assume that interrupts will be masked when you're entered.

As long as we have the kexec and crashdump stuff (which effectively means
that the replacement kernel can be entered with devices in any state what
so ever), arguments around "handoff" between boot loaders and the kernel
are completely irrelevant and misguided.
