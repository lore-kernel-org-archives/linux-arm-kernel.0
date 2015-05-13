From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 13 May 2015 08:56:56 +0200
Subject: [PATCH v2 0/4] Clk drivers for NXP LPC18xx family
In-Reply-To: <20150512223126.GA14873@codeaurora.org>
References: <1430170693-28303-1-git-send-email-manabian@gmail.com>
 <20150512223126.GA14873@codeaurora.org>
Message-ID: <CAGhQ9VxoDvLzZPFkCJSDeFBZHOu=dFUFMMVekPhnGOuWbKETKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 May 2015 at 00:31, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 04/27, Joachim Eastwood wrote:
>> This patch set adds support for the two main clock peripherals in the
>> LPC18xx/43xx MCU family.
>>
>> The Clock Generation Unit (CGU) is the base source of all clocks. It has
>> five external inputs and contains PLLs, dividers and muxes. The outputs
>> from the CGU are then routed to a Clock Control Unit (CCU) and a few
>> peripherals directly. There are two CCUs in the MCU. The CCU is a
>> collection of gates and a few dividers that sits between the CGU and
>> most of the peripherals.
>>
>> Which clocks that are available depends on the specific device and it's
>> peripherals. It's possible in DT to setup the routing between the CGU
>> and the CCUs.
>
> Is there any reason why this uses CLK_OF_DECLARE over the
> platform device model? Typically we have CLK_OF_DECLARE for cases
> where a provider needs to be up and running early during boot for
> hardware that can't probe defer (i.e. timers, irq controllers).

One of the CCUs provided clock for two of the timers that are used as
clock sources.
Specifically this timer:
http://marc.info/?l=linux-arm-kernel&m=143138193704763&w=2

Since the CGU provides the clock to the CCU which then again provides
the clock to the timer both must use CLK_OF_DECLARE for clk enable/get
rate to work in the timer driver.

> Otherwise we should be able to use the standard linux device
> model to probe clk providers. It looks like the clocksource is
> using something from CCU, but perhaps CGU isn't "special" and
> could be using device model.

It's is the CCU that uses the clocks from the CGU. So I think both
drivers needs to use CLK_OF_DECLARE.

regards,
Joachim Eastwood
