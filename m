From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 02 Dec 2014 09:32:25 +0100
Subject: [PATCH] ARM: dts: Add dts file for odroid XU3 board
In-Reply-To: <547D596E.9000402@samsung.com>
References: <1417438770-28696-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <547D596E.9000402@samsung.com>
Message-ID: <1417509145.21830.20.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-12-02 at 15:17 +0900, Heesub Shin wrote:
> Hello Simons,
> 
> On 12/01/2014 09:59 PM, Sjoerd Simons wrote:
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > +*/
> > +
> > +/dts-v1/;
> > +#include "exynos5800.dtsi"
> 
> Looking at exynos5800.dtsi, it derives from exynos5420.dtsi and seems 
> having differences on clock and mfc. Is it proper to include 
> exynos5800.dtsi here, instead of exynos5420.dtsi? It's just my curiosity 
> as I am not in a position to know detailed things on the soc. Only 
> semiconductor guys could answer this.

I would love to get a conclusive answer on this one as the exynos 5422
vs. exynos 5800 question seems to keep coming up (both on this list and
the u-boot one where XU3 support is being added as well). 

As far as i understand things the Exynos 5800 is a "variant" of the
Exynos 5422 for chromebooks[0]. I suspect things are just being called
5800 in the kernel and u-boot as the chromebooks were the first boards
based on this SoC to reach mainline...

Which led to interesting things like: 
  #define EXYNOS5800_SOC_ID  0xE5422000

Iotw, the identifier for the 5800 is 0x5422, which doesn't really make
things more clear.

I'm working on the assumption that this SoC variation doesn't expose
differences to the OS. I did not yet test the MFC, but should get round
to that later this week, which should help in verifying the MFC side of
things at least.. I haven't yet seen any issues caused due to the
differences in clock setup between samsung,exynos5800-clock and
samsung,exynos5420-clock

> > +
> > +/ {
> > +	model = "Hardkernel Odroid XU3";
> > +	compatible = "hardkernel,odroid-xu3", "samsung,exynos5800", "samsung,exynos5";
> > +
> > +	memory {
> > +		reg = <0x20000000 0x80000000>;
> > +	};
> 
> Start address above should be 0x40000000, not 0x20000000.

Indeed, the Hardkernel DTS also starts at 0x40000000, I missed that.
Looking at the other exynos5800/5420 based boards in the kernel they all
have their start offset at 0x20000000, is this different for the XU3
because it runs with secure firmware or is there some other reason
behind this?

> One more thing, having bootargs which specifies 'console=xxx' would be 
> better.

Hrm, i've got a dislike for chosen/bootargs as they typically seem
rather random/inconsistent (not sure who they're meant for). However, I
should indeed specify chosen/stdout-path to point to the serial console.

Thanks for your review!

0: See table at the bottom of
http://www.samsung.com/global/business/semiconductor/minisite/Exynos/w/solution.html#?v=octa_5422

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141202/9be0d0ed/attachment-0001.bin>
