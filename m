From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 15 Oct 2010 21:56:20 +0900
Subject: [PATCH RFC/RFT] ARM: S5P: Fix USB and 48M clock enable procedure
In-Reply-To: <AANLkTimVh7hkWiZyK5f3+22EmNHSJcmMVb_tKYRQSGxN@mail.gmail.com>
References: <20101012194021.11514.12704.stgit@localhost.localdomain>
	<008001cb6b7e$ba952920$2fbf7b60$%kim@samsung.com>
	<AANLkTimVh7hkWiZyK5f3+22EmNHSJcmMVb_tKYRQSGxN@mail.gmail.com>
Message-ID: <01de01cb6c68$5ede0bc0$1c9a2340$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paulius Zaleckas wrote:
> 
> On Thu, Oct 14, 2010 at 12:03 PM, Kukjin Kim <kgene.kim@samsung.com>
wrote:
> > Paulius Zaleckas wrote:
> >>
> >> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> >> ---
> >>
> >>  arch/arm/mach-s5p6440/clock.c              |   23 -------
> >>  arch/arm/plat-s5p/clock.c                  |   86
> >> ++++++++++++++++++++++++++++
> >>  arch/arm/plat-s5p/include/plat/s5p-clock.h |    1
> >>  3 files changed, 86 insertions(+), 24 deletions(-)
> >>
> > Hi Paulius,
> >
> > There are some comments about your patches which includes previous
S3C64XX
> patches.
> >
> > Basically your approach looks good trial and structure...but I'm not
sure
> whether your approach can be used commonly on Samsung's all SoCs or not.
> > Need to do more test on boards and I already informed your patches to
USB
> engineers in my team, actually need to discuss about this.
> >
> > As a note, I know, 'xusbxti' clock is structure for external xtal which
is
> used for generating USB clock on board... it depends on board condition,
> because can be used 12/24/48Mhz on board. The clk_48m means generated
actual
> USB clock, 48Mhz. So should be implemented enable function by using
clk_48m...
> 
> I don't agree that enable should be for clk_48m. The reason is that
> IMO it is possible
> to enable 48m clock, but suspend the clock for USB device part (I am
> not sure about this yet...).

Umm...please see below.

          |\
xxti------|O|
          |M|-----..System..-- HCLK --> usb_device...
xusbxti---| |  |
        | |/   |
        |      |
       (1)    (2)  -------------
         ---------| USB OTG Phy | --> clk_48M
                   -------------

Firstly, 'xusbxti' can be used to system clock when selected by OM pin.
As I said, the rate of xusbxti can be 12/24/48Mhz and there is it on
board...usually is used 12Mhz or 24Mhz on SMDK board.
It means depends on board and always enabled, so no need following 'rate'
and 'enable' in your following patch.

 struct clk clk_xusbxti = {
 	.name		= "xusbxti",
 	.id		= -1,
+	.rate		= 48000000,
+	.enable		= clk_xusbxti_ctrl,
 };
 
 struct clk s5p_clk_27m = {
@@ -49,6 +134,7 @@ struct clk clk_48m = {
 	.name		= "clk_48m",
 	.id		= -1,
 	.rate		= 48000000,
+	.parent		= &clk_xusbxti,
 };

According to above clock diagram, the parent of 'clk_48m' can be 'xxti' or
'xusbxti', it is decided by SoC and OM pin. For example, there is line (1)
on S5P6440 so your patch is right, but there is line (2) on S5PC100 but
line (1) so it's wrong..the parent of clk_48m can be xxti by OM Pin.

It means the parent of clk_48m depends on SoC, can't define it in the plat-
s5p. And maybe as you know, in the S5PV210/S5PC110 case, need two clk_48m
structures for Host and Device...

So its clock structure has SoC(ARCH) dependency and it's difficult to merge
it into plat-s5p now.

We need to re-think to implement it...and I and my team will sort out it.

> 
> If that is true than I think we will need one more clk for USB device:
> 
>         /->clk_48m
> xusbxti-|
>         \->clk_usb_device
> 
Actually, it's different on each SoCs...

> > Anyway let you know about the result of internal discussion soon, then
> let's talk.
> >

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
