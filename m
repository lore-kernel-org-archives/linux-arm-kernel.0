From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 26 Oct 2016 13:29:39 +0530
Subject: [PATCH v6 1/5] ARM: davinci: da8xx: add usb phy clocks
In-Reply-To: <1477451211-31979-2-git-send-email-david@lechnology.com>
References: <1477451211-31979-1-git-send-email-david@lechnology.com>
 <1477451211-31979-2-git-send-email-david@lechnology.com>
Message-ID: <6bcc1ac1-446c-6191-1c63-e37ccfaf9556@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 October 2016 08:36 AM, David Lechner wrote:
> Up to this point, the USB phy clock configuration was handled manually in
> the board files and in the usb drivers. This adds proper clocks so that
> the usb drivers can use clk_get and clk_enable and not have to worry about
> the details. Also, the related code is removed from the board files and
> replaced with the new clock registration functions.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
> 
> I have added "ARM: davinci: da8xx: Enable the usb20 "per" clk on phy_clk_enable"
> from Axel Haslam to this patch.
> 
> In the review of Axel's patch, Sekhar said:
> 
>> We should not be using a NULL device pointer here. Can you pass the musb
>> device pointer available in the same file? Also, da850_clks[] in da850.c
>> needs to be fixed to add the matching device name.
> 
> However, the musb device may not be registered. The usb20_clk can be used to
> supply a 48MHz clock to USB 1.1 (ohci) without using the musb device. So, I am
> inclined to leave this as NULL.

But clock look-up has nothing to do with device being registered AFAICT.
It is used to identify the clock consumer. Passing NULL there means the
clock is not associated with any device. Which is not correct as we are
specifically looking at MUSB module clock.

Thanks,
Sekhar
