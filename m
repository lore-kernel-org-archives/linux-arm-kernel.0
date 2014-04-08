From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Apr 2014 14:25:33 +0100
Subject: ARM: SA1100: collie broken (and fixes pending)
In-Reply-To: <CAAQYJAvBwf4ohnBajvKwSYRWr-9QxD4=Mrrzyu2=9DvHUSh3ow@mail.gmail.com>
References: <CAAQYJAvBwf4ohnBajvKwSYRWr-9QxD4=Mrrzyu2=9DvHUSh3ow@mail.gmail.com>
Message-ID: <20140408132532.GG16119@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 02:29:35PM +0200, Andrea Adami wrote:
> there are two patchsets pending for collie/sa1110:
> 
> http://archive.arm.linux.org.uk/lurker/message/20131116.220725.42397482.en.html
> http://archive.arm.linux.org.uk/lurker/message/20131215.042807.213f9035.en.html
> 
> >From the first patchset we need at least the first 3:
>       arm: sa1100: add cpu clock
>       fbdev: sa1100fb: make use of device clock
>       pcmcia: sa1100: make use of device clock
> 
> The second has been tested as well by Linus Walleij.
> 
> Unfortunately there is now a conflict about clk_get_rate() introduced
> with commit # 0ad04fb "ARM: SA1100: Create dummy clk_get_rate() to
> avoid build failures".
> 
> To add more fun, there is a second issue:
> 
> MODPOST 247 modules
> ERROR: "clk_set_rate" [drivers/usb/phy/phy-generic.ko] undefined!
> 
> so to build 3.14 I had to revert 0ad04fb and to add a dummy
> clk_set_rate() [1]. Please verify that.
> 
> I think it is urgent that we sort this out to avoid more differences in
> future.

I'm building sa11x0 (for the assabet+neponset) every night, and haven't
found any regression:

http://www.arm.linux.org.uk/developer/build/index.php?id=2002

It's been one of the cleanest ARM SoC implementations build-wise, unlike
the rest.

A few of points on the first patch series:

- Patches 4, 5 need to come before patch 3 to avoid a NULL pointer deref
  in sa1100_pcmcia_set_timing() (ISTR this function gets called on SA1111
  as well.)

- Returning from clk_get() failure should return the error number returned
  by clk_get().  PTR_ERR() is your friend here.

- We should have clk_prepare_enable() calls in these drivers for proper
  driver behaviour (even though we never want to "turn this clock off"
  because it's the CPU clock.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
