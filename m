From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 24 Oct 2017 08:51:38 +0200
Subject: [PATCH] ARM: compressed: discard ksym/kcrctab input section
In-Reply-To: <20171023221928.GX20805@n2100.armlinux.org.uk>
References: <20170908153143.27279-1-ard.biesheuvel@linaro.org>
 <33486b3e-8221-92b0-7e18-859be7d0a74b@suse.com>
 <CAKv+Gu-8PEPuWH=bT_wD0MYDw67RY3gQudW2mLO-QeBYqQesyw@mail.gmail.com>
 <2b3af288-51b1-561a-a1a9-f5f42f7ca1c4@gmail.com>
 <20171023092956.GN20805@n2100.armlinux.org.uk>
 <20171023114825.GV20805@n2100.armlinux.org.uk>
 <4950796f-efdc-337a-bbbb-f09213eb54ce@gmail.com>
 <20171023221928.GX20805@n2100.armlinux.org.uk>
Message-ID: <96bb61e5-a909-67d5-647d-1be0d2773ed3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/24/2017 12:19 AM, Russell King - ARM Linux wrote:
> On Mon, Oct 23, 2017 at 11:17:35PM +0200, Matthias Brugger wrote:
>> Yes, I apply a dtb to my zImage. I do that because the board has no support on
>> mainline u-boot right now and I do kernel enablement on the board. Support in
>> u-boot is no priority ATM.
> 
> Right, so the reason your system isn't booting is because of the
> additional section in the zImage, which causes additional bytes
> after _edata.
> 
> That causes the appending of the dtb to be in the wrong place,
> so it doesn't get found.
> 
> With Arnd's patch applied, if you do:
> 
> dd if=arch/arm/boot/zImage bs=1 count=$(( $(stat -c %s arch/arm/boot/zImage) - 8)) of=zImg
> cat zImg $dtb > zImg.boot
> 
> and then try booting zImg.boot instead, that should work, and
> would prove my point.
> 

I can confirm that this fixes the issue.

Regards,
Matthias
