From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Oct 2017 23:19:28 +0100
Subject: [PATCH] ARM: compressed: discard ksym/kcrctab input section
In-Reply-To: <4950796f-efdc-337a-bbbb-f09213eb54ce@gmail.com>
References: <20170908153143.27279-1-ard.biesheuvel@linaro.org>
 <33486b3e-8221-92b0-7e18-859be7d0a74b@suse.com>
 <CAKv+Gu-8PEPuWH=bT_wD0MYDw67RY3gQudW2mLO-QeBYqQesyw@mail.gmail.com>
 <2b3af288-51b1-561a-a1a9-f5f42f7ca1c4@gmail.com>
 <20171023092956.GN20805@n2100.armlinux.org.uk>
 <20171023114825.GV20805@n2100.armlinux.org.uk>
 <4950796f-efdc-337a-bbbb-f09213eb54ce@gmail.com>
Message-ID: <20171023221928.GX20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 11:17:35PM +0200, Matthias Brugger wrote:
> Yes, I apply a dtb to my zImage. I do that because the board has no support on
> mainline u-boot right now and I do kernel enablement on the board. Support in
> u-boot is no priority ATM.

Right, so the reason your system isn't booting is because of the
additional section in the zImage, which causes additional bytes
after _edata.

That causes the appending of the dtb to be in the wrong place,
so it doesn't get found.

With Arnd's patch applied, if you do:

dd if=arch/arm/boot/zImage bs=1 count=$(( $(stat -c %s arch/arm/boot/zImage) - 8)) of=zImg
cat zImg $dtb > zImg.boot

and then try booting zImg.boot instead, that should work, and
would prove my point.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
