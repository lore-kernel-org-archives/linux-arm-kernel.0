From: andy@warmcat.com (Andy Green)
Date: Thu, 03 Mar 2011 17:56:12 +0000
Subject: [PATCH 1/4] OMAP3 and 4 hwmod I2C units only allow 16 bit access
In-Reply-To: <4D6FD2F2.8050701@ti.com>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com>
	<20110303135022.30648.8996.stgit@otae.warmcat.com>
	<4D6FD2F2.8050701@ti.com>
Message-ID: <4D6FD63C.6000102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2011 05:42 PM, Somebody in the thread at some point said:
> On 3/3/2011 2:50 PM, Andy Green wrote:

Hi -

Thanks for the reply.

>> Peter Maydell noticed when running under QEMU he was getting
>> errors reporting 32-bit access to I2C peripheral unit registers
>> that are documented to be 8 or 16-bit only[1][2]
>
> Well, in that case, it is more a QEMU bug since the HW is working fine
> with 32 bits access to sysconfig :-)

Actually it's documented in TI documentation, as noted:

 >> [1] OMAP4430 Technical reference manual section 23.1.6.2
 >> [2] OMAP3530 Techincal reference manual section 18.6

With the following warning in a nice big grey box -->

''CAUTION
The I2Ci registers are limited to 16 bit and 8 bit data accesses, 32 bit 
data access is not allowed and can corrupt register content.''

So, as a side-issue it can be worth confirming with the author of the 
warning if it still holds or not and letting Qemu guys know if it's not 
actually true what is written in the TI docs about that.

> In fact that flag was added because 32 bits access to I2C sysconfig was
> generating bus abort on 2420 only:
> (2004290f55f03c52e22044a5843928cf0f6cc56a).
>
> Since 2430, OMAP3 and OMAP4 are working fine with 32 bits, we were lazy
> and didn't add that flag.

There is no bus abort.  However if the warning in the documentation is 
true, it'd be better that there was a bus abort.

> Did you check this patch on a real HW? Since this was reported using
> QEMU only.

I checked my patched code works OK on both IGEP2 (OMAP3) and Panda 
(OMAP4), there's no visible symptom without the patch it's true.

> Otherwise, I'm fine with that patch, it will not change anything but
> will improve the consistency across SoC version.
>
> BTW, It will be good if you could update the omap_hwmod_2430_data.c file
> as well.

I left it because I can't test it, but I'll happily do it additionally 
if you can test it on some OMAP2 hardware.

-Andy
