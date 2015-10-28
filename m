From: pramodku@broadcom.com (Pramod Kumar)
Date: Wed, 28 Oct 2015 11:52:49 +0000
Subject: [PATCH 07/11] pinctrl: use ngpios propety from DT
In-Reply-To: <CACRpkdY1GDs6ypqCiY3iiv3DkfnHchnY+bWPoCqU=_sgn9f5vQ@mail.gmail.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
 <1445233398-27129-8-git-send-email-pramodku@broadcom.com>
 <CACRpkdY1GDs6ypqCiY3iiv3DkfnHchnY+bWPoCqU=_sgn9f5vQ@mail.gmail.com>
Message-ID: <0C803592FC378B4E83922050AB46442A2AD742F0@SJEXCHMB10.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: 27 October 2015 15:22
> To: Pramod Kumar
> Cc: Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala; Ray Jui;
> Scott Branden; Russell King; linux-gpio at vger.kernel.org; bcm-kernel-feedback-
> list; Jason Uy; Masahiro Yamada; Thomas Gleixner; Laurent Pinchart;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Jonas Gorski
> Subject: Re: [PATCH 07/11] pinctrl: use ngpios propety from DT
> 
> On Mon, Oct 19, 2015 at 7:43 AM, Pramod Kumar <pramodku@broadcom.com>
> wrote:
> 
> > Since identical hardware is used in several instances and all pins are
> > not routed to pinctrl hence getting total number of gpios from DT make
> > more sense hence stop using total number of gpios pins from drivers
> > and extract it from DT.
> >
> > Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> > Reviewed-by: Ray Jui <rjui@broadcom.com>
> > Reviewed-by: Scott Branden <sbranden@broadcom.com>
> 
> This patch is wrong.
> 
> Keep this per-compatible code, and only overrid the ngpios if and only if:
> 
> - The ngpios is set in the DT node
> - The ngpios in the DT node is *smaller* than the hardware
>   defined number of GPIOs.
> 
> ngpios is for restricting the number of available lines due to routing etc, not to
> define what the hardware has, because the hardware most certainly have all the
> lines, it's just that you're not using all of them.
> 
> Yours,
> Linus Walleij

I discussed with ASIC team regarding this iProc GPIO block. They use a library to create the GPIOs block where "total number of GPIO pins( let say N) in GPIO block" is used as an parameter. 
Library uses a construct for *a* GPIO pin. This gets instantiated N times to create a complete GPIO block with N pins.

All iProc based SoCs uses this library. So I'm not sure whether attaching "total number of GPIOs pins" to compatible-string make sense in this case. 
I personally feel that passing this number from the DT makes more sense here. Any iProc based future as well as current SoCs would be able to use this driver without any change.

Please advise us in this case.

Regards,
Pramod
