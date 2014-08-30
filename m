From: dianders@chromium.org (Doug Anderson)
Date: Fri, 29 Aug 2014 21:51:46 -0700
Subject: [PATCH 0/2] IO voltage domain support for rk3188 and rk3288
In-Reply-To: <53FF9E93.3040601@ti.com>
References: <1409254565-10677-1-git-send-email-dianders@chromium.org>
 <53FF9E93.3040601@ti.com>
Message-ID: <CAD=FV=Vcj+tAno92c38Prviyi-v2CmuGSzak1ppETL033KAF4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh,

On Thu, Aug 28, 2014 at 2:26 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Thursday 28 August 2014 03:36 PM, Doug Anderson wrote:
>> These two patches add support for automatically configuring the IO
>> voltage domains on rk3188 and rk3288 SoCs.  The first patch adds some
>> new notification types to the regulator code.  It's used by the second
>> patch which actually implements the IO voltage domain driver.
>>
>> These two patches were co-developed by Heiko St?bner and Doug Anderson
>> (proof of concept patches were written by Heiko).  They were tested in
>> a private branch on an rk3288 board using rk808 instead of mainline
>> since rk808 support isn't finalized in mainline yet.
>>
>> (sorry if you got this series twice; my mailer seems unhappy with me)
>>
>> Heiko St?bner (2):
>>   regulator: core: Add REGULATOR_EVENT_PRE_VOLTAGE_CHANGE (and ABORT)
>>   soc/rockchip: io-domain: add driver handling io domains
>>
> Sorry to shot down but your IO domains are nothing but voltage domains
> and you should really build something in the drivers/power/*

If everyone agrees that this belongs in drivers/power that's totally
OK.  Neither Heiko nor I was confident that it should be in
drivers/soc.  I had even though that the code wouldn't be totally out
of place in the Rockchip pinctrl driver (adding Linus W since I think
some SoCs did add code to handle 3.3V vs. 1.8V in pinctrl).


> Please have a look at the RFC [1]. You should really go on those
> lines and collaborate to make a generic voltage domain layer instead of throwing
> the driver under drivers/soc.

Trying to base things on a 7-month old RFC that hasn't been touched is
not something I'm going to do.  Maybe that makes me a bad person...

I would also say that I'm not convinced that we really need a
complicated framework here.  Maybe when we're talking about things
like ABB and DevFreq and the like then having a nice framework is a
good idea.  Really here we're just setting properties associated with
IO pins.  There's no decisions about latency, power tradeoffs, etc.
If the pin is connected to 1.8V we need to set the 1.8V bit.  If it's
connected to 3.3V we need to set the 3.3V bit.  The end.

The only remotely complicated thing (and why this isn't just a pinctrl
property) is what happens with dynamic voltages.  SD Card IO lines can
change voltage depending on UHS negotiation.  In that case the SD Card
Driver will request that its regulator change from 3.3V to 1.8V.  The
bit in the IO domain register needs to update in tandem.


The driver is really quite tiny (333 lines).  If we find that lots of
people copy it and they have code that's nearly the same then we
should try to abstract things out then.


I'd be interested in hearing other opinions, though.

-Doug
