From: david.cohen@nokia.com (David Cohen)
Date: Tue, 5 Oct 2010 13:35:16 +0300
Subject: [PATCHv3 1/6] omap3: Add external VBUS power switch and
	overcurrent detect on IGEP v2 board.
In-Reply-To: <AANLkTin0FBudq5saFhcuonrzK2LqU0UueiN_-C=B0N0j@mail.gmail.com>
References: <1285967349-32767-1-git-send-email-eballetbo@gmail.com>
	<1285967349-32767-2-git-send-email-eballetbo@gmail.com>
	<20101002080427.GC14377@esdhcp036161.research.nokia.com>
	<AANLkTin0FBudq5saFhcuonrzK2LqU0UueiN_-C=B0N0j@mail.gmail.com>
Message-ID: <20101005103516.GC12614@esdhcp036161.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 02, 2010 at 12:12:32PM +0200, ext Enric Balletb? i Serra wrote:
> 2010/10/2 David Cohen <david.cohen@nokia.com>:
> > Hi,
> >
> > On Fri, Oct 01, 2010 at 11:09:04PM +0200, ext Enric Balletbo i Serra wrote:
> >> GPIO for various devices are missing from the board initialization.
> >> This patch adds support for the VBUS and over current gpios. ?Without this
> >> patch, input/outputs from these two sources are ignored.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> >> ---
> >> ?arch/arm/mach-omap2/board-igep0020.c | ? 16 ++++++++++++++++
> >> ?1 files changed, 16 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> >> index 175f043..07dbdb7 100644
> >> --- a/arch/arm/mach-omap2/board-igep0020.c
> >> +++ b/arch/arm/mach-omap2/board-igep0020.c
> >> @@ -274,6 +274,22 @@ static int igep2_twl_gpio_setup(struct device *dev,
> >> ? ? ? igep2_vmmc1_supply.dev = mmc[0].dev;
> >> ? ? ? igep2_vmmc2_supply.dev = mmc[1].dev;
> >>
> >> + ? ? /*
> >> + ? ? ?* REVISIT: need ehci-omap hooks for external VBUS
> >> + ? ? ?* power switch and overcurrent detect
> >> + ? ? ?*/
> >> + ? ? if ((gpio_request(gpio + 1, "GPIO_EHCI_NOC") < 0) ||
> >> + ? ? ? ? (gpio_direction_input(gpio + 1) < 0))
> >> + ? ? ? ? ? ? pr_err("IGEP2: Could not obtain gpio for EHCI NOC");
> >
> > Shouldb't you return error if it can't request the GPIO?
> 
> I'm not sure what happens if I return and error, I see only prints a
> debug message. Maybe the twl4030-gpio maintainer can explain if I need
> return and error or not.
> 
> Other omap boards just don't check the gpio_request call and always
> return 0. I don't consider this a critical error so maybe should be
> better replace the pr_err with a pr_warning.

I checked some board files and it seems they're not verifying gpio_request()
results most of the times. But if you check board-omap3pandor.c, it's
been done in a better way.

Br,

David
