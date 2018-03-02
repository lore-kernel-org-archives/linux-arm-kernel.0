From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Mar 2018 11:19:31 +0000
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
In-Reply-To: <1519936484-23132-1-git-send-email-krzk@kernel.org>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
Message-ID: <20180302111931.GX9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 09:34:44PM +0100, Krzysztof Kozlowski wrote:
> Interrupt number 0 (returned by platform_get_irq()) might be a valid IRQ
> so do not treat it as an error.  If interrupt 0 was configured, the driver
> would exit the probe early, before finishing initialization, but with
> 0-exit status.

The official position (as stated by Linus) is that interrupt zero is
not a valid interrupt for peripheral drivers (it may be valid within
architecture code for things like the x86 PIT, but nothing else.)

You need to number your platform interrupts from one rather than zero.

Note that there have been patches proposed to make platform_get_irq()
return an error rather than returning a value of zero, so changing
the driver in this way is not a good idea.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
