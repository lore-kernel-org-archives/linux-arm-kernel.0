From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 19 May 2015 18:39:42 +0800
Subject: [PATCH 1/5] soc: mediatek: Add infracfg misc driver support
In-Reply-To: <20150519074535.GY6325@pengutronix.de>
References: <1431372206-1237-1-git-send-email-s.hauer@pengutronix.de>
 <1431372206-1237-2-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omADXpnBnLvuH+xNmatL+89kLBELz6KqMFid7SOx=veiAg@mail.gmail.com>
 <20150518081625.GO6325@pengutronix.de>
 <CAGS+omD-0bPeQqau9mm4pTqOhtPW=ecR5ibB8==pifRMgSKrjg@mail.gmail.com>
 <20150519074535.GY6325@pengutronix.de>
Message-ID: <CAGS+omBR6NwFbCpRN+6v7LX9h2Esmm6RQYp_Qxeqa84q-WTRzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 3:45 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, May 19, 2015 at 02:54:41PM +0800, Daniel Kurtz wrote:
>> >> > +       while (1) {
>> >> > +               ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
>> >> > +               if (ret)
>> >> > +                       return ret;
>> >> > +
>> >> > +               if ((val & mask) == mask)
>> >> > +                       break;
>> >> > +
>> >> > +               cpu_relax();
>> >> > +               if (time_after(jiffies, expired))
>> >> > +                       return -EIO;
>> >>
>> >> I think we should check for timeout first, and then cpu_relax() if
>> >> there is still time left (here and in
>> >> mtk_infracfg_clear_bus_protection()).  Otherwise we end up doing one
>> >> final cpu_relax() without rechecking the register we are polling
>> >> (again, I have the same comment for the timeout loops in mtk-scpsys).
>> >
>> > I think cpu_relax() delays execution in the order of microseconds (I
>> > don't actually know, just a guess), so if the timeout is a second the
>> > order doesn't really matter. What can happen though is an interrupt
>> > after the (val & mask) test but before the timeout check. So to be
>> > truly correct we have to repeat the (val & mask) test after the
>> > time_after() check. Is that what you want?
>>
>> I'm not following, why would you need to repeat (val & mask) test
>> after time_after?
>> What does an interrupt have to do with it?
>> Can you show a code snippet with what exactly you are proposing?
>
> Consider you have this timeout loop:
>
>         while (1) {
>                 if (success())
>                         break;
>
>                 if (time_after(jiffies, expired))
>                         return -ETIMEDOUT;
>         }
>
> Now when an interupt comes in between success() and time_after() then it
> can happen that the delay caused by the interrupt makes the code timeout
> even though success() might have become true in the meantime. So to be
> correct you have to:

I agree - I was confused because you only mentioned repeating the
"(val & mask) test", not re-reading the register, which is the
important bit.
For other drivers, I've seen "wait_for()" macros, like below, which do
exactly as you suggest above:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/rockchip-iommu.c#n110

>
>         while (1) {
>                 if (success())
>                         break;
>
>                 if (time_after(jiffies, expired)) {
>                         if (success())
>                                 break;
>                         return -ETIMEDOUT;
>         }
>
> Or, if you don't want to repeat the termination condition:
>
>         bool timeout = false;
>
>         while (1) {
>                 if (success())
>                         break;
>
>                 if (timeout)
>                         return -ETIMEDOUT;
>
>                 if (time_after(jiffies, expired))
>                         timeout = true;
>         }
>
> Anyway, with the timeout of one second used here this is all academic.

I totally agree that this is academic for the loops here and in
SCPSYS, where the timeout is arbitrary and long.

-Dan

>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
