From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 5 Oct 2013 16:45:44 +0800
Subject: IMX6 USDHC card detection
In-Reply-To: <20131003193623.GF12758@n2100.arm.linux.org.uk>
References: <20131003193623.GF12758@n2100.arm.linux.org.uk>
Message-ID: <20131005084542.GK2734@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 08:36:23PM +0100, Russell King - ARM Linux wrote:
> Having spent many hours chasing around wondering why controller based
> card detection doesn't work on IMX6, I've finally found it.
> 
> The hardware is setup such that we have a card detect signal routed to
> GPIO 4.  If we try and use the host controller's built-in card detection,
> things go awry - the host controller believes that a card is always
> inserted.
> 
> This appears to be because the kernel sets the D3CD bit in the PROT_CTRL
> register.  This enables card detection via the DAT3 signal, which
> indicates a logic '1' level when a card is inserted.  SD cards have a 50k
> pullup internally which provides the card detection mechanism, and hosts
> are expected to have a weak pull-down on this signal.
> 
> However, the default setup of the SD data lines in IOMUX is this (eg):
> 
>              MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
>              MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
>              MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
>              MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
> 
> Bits 14 and 15 indicate "pull this pin up via a 22K resistor".
> 
> What you end up with is the SD controller believes that a card is always
> inserted no matter what you do.  You can see this through the PRES_STATE
> register - you see bit 18 assert/deassert appropriately on card insertion
> and removals indicating that the socket CD signal is changing state, but
> you don't see the card inserted bit (bit 16) ever change.  Neither does
> the kernel react in any way.
> 
> So, are the defaults for DATA3 signals really appropriate, or should they
> be adjusted (in other words, 0x13059 for DATA3).  The alternative is to
> ignore the built-in host card detection, and configure the CD pin as a
> GPIO instead.

Unless we're sure that 0x13059 will not cause any ill effect, I would
suggest you configure the CD pin as GPIO and keep 0x17059 as pad
configuration, since it's been validated by various boards.

Shawn
