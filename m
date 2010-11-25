From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu, 25 Nov 2010 19:10:27 +0800
Subject: [PATCH 1/1] arm: imx: share imx5x_register_gpios for mach-mx5
In-Reply-To: <20101125084302.GN6017@pengutronix.de>
References: <1290695312-30031-1-git-send-email-linuxzsc@gmail.com>
	<20101125062924.GD4693@pengutronix.de>
	<AANLkTimvcAS3BmjtaYCMzHcv=q2znS2zy_Dto_OMJeWh@mail.gmail.com>
	<20101125074244.GE4693@pengutronix.de>
	<AANLkTikZkXRmddSYN0-7eSBKO_BpXbz+xuJRhDfKeU02@mail.gmail.com>
	<20101125081406.GG4693@pengutronix.de>
	<20101125084302.GN6017@pengutronix.de>
Message-ID: <AANLkTimy3qV+ZXs9urdTX2rq=0XrKEtbt2m8x+eBvMce@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/25 Sascha Hauer <s.hauer@pengutronix.de>:
> On Thu, Nov 25, 2010 at 09:14:06AM +0100, Uwe Kleine-K?nig wrote:
>> On Thu, Nov 25, 2010 at 04:01:04PM +0800, Richard Zhao wrote:
>> > 2010/11/25 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> > > Hey Richard,
>> > >
>> > > On Thu, Nov 25, 2010 at 02:44:48PM +0800, Richard Zhao wrote:
>> > >> > IMO the machine files shouldn't need to know how many gpio banks are
>> > >> > available. ?This is a per-SoC thing and so should be set in a SoC function.
>> > >> But we don't have SoC level device file.
>> > > Check how I did it for imx{1,21,27,25} in arch/arm/plat-mxc/gpio.c.
>> > I considered put it there too. but we can not add new defconfig, and
>> > even can not create new items in Kconfig. So we can not use ifdefs.
>> Why not add new Kconfig symbols? ?Up to now I was unfettered by scruples
>> adding new ones.
>>
>> > And per my understanding, mx5x is going to use one zImage, correct?
>> It should be possible to have a single image for more than one SoC, yes.
Thanks. I go through the code again. Here is mx50 adding plan:
1. basic memory map definitions
Add it in individual arch/arm/plat-mxc/include/mach/mx50.h
2. clock.c crm_regs.h
clock tree is different. mx50 use arch/arm/mach-mx5/clock-mx50.c.
Possibly individual crm_regs.h too.
3. iomux
individual arch/arm/plat-mxc/include/mach/iomux-mx50.h
4. gpio
Add it in arch/arm/plat-mxc/gpio.c under macro CONFIG_SOC_IMX50.
5. irq
Add it in individual arch/arm/plat-mxc/include/mach/mx50.h
6. device and resource.
Dynamicly add device. SoC level data is in arch/arm/plat-mxc/devices
init section, plat data is in board level file.

Any comments?

Thanks
Richard
>>
>> > >> > How do you want to continue this change? ?mx51 and mx53 have the same
>> > >> > number of ports? ?Does mx50 have more or less? ?The addresses are the
>> > >> > same?
>> > >> mx53 and mx50 have similar memory map. but mx51 is different. ?Sorry,
>> > >> I forgot upstream version IO_ADDR can not handler differnt SoC base
>> > >> addr offset.
>> > > It might even work in this case, still I prefer a more explicit way.
>> > >
>> > >> ? ? ? ? ? ? ?It can not be shared with mx51, but it can be shared with
>> > >> mx50/53, correct? May plan is mx53/50 share
>> > >> arch/arm/plat-mxc/include/mach/mx5x.h file.
>> > > mx5x.h is for mx50 and mx53 but not mx51? ?No please.
>> > For memory map, mx51 is a special case. From mx53 on , IC tuned memory
>> > map to support large memory.
>> > If we use things like mx53-50.h, symbols is hard to define.
>> > MX53_50_XXX_XXX is wired. Any possibly, we need to add new SoC with
>> > similar memory map in the future.
>> I still think defining symbols for a single SoC is fine most of the
>> time.
>
> +1
>
> MX2X was confusing when the i.MX25 came out and we won't start *any*
> MX5X things when we already know that it's wrong. Go with MX51_ MX53_
> MX50_ or whatever the SoC of the day is. Putting things together to
> share the code is done in the upper layers, *not* the register defines.
>
> Sascha
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>
