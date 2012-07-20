From: mturquette@ti.com (Turquette, Mike)
Date: Fri, 20 Jul 2012 11:12:23 -0700
Subject: [PATCH 4/4] ARM: clps711x: Added simple clkdev framework
In-Reply-To: <1342807362.877202427@f305.mail.ru>
References: <1342805080.993377715@f259.mail.ru>
 <201207172033.10302.arnd@arndb.de>
 <CAJOAzNezpfn4-+aYfC=Ea8qemDdi47LKpHCcM-sJyrur-Po1A@mail.gmail.com>
 <1342807362.877202427@f305.mail.ru>
Message-ID: <CAJOA=zMnfk6drJrxb9tB48Ok8waocLitEYCTYKrVhbY3EpnLeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 11:02 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
> Hello.
>
> Fri, 20 Jul 2012 10:41:59 -0700 ?? "Turquette, Mike" <mturquette@ti.com>:
>> On Fri, Jul 20, 2012 at 10:24 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
>> > Hello.
>> >
>> > Thu, 19 Jul 2012 15:02:00 -0700 ?? "Turquette, Mike" <mturquette@ti.com>:
>> >> On Tue, Jul 17, 2012 at 1:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> > On Monday 16 July 2012, Alexander Shiyan wrote:
>> >> >> Modern CPUs from CLPS711X-line can operate at frequencies other than 73 MHz.
>> >> >> This patch adds simple clkdev framework for handling all possible CPU rates.
>> >> >> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>> >> > We just had the exact same discussion about a new clock implementation for
>> >> > mcs814x and for the socfpga port. My feeling is that it makes no sense
>> >> > to keep adding new private implementations of the API as we're trying
>> >> > to get rid of the existing ones and replace them with the common code.
>> >> >
>> >> > If I understand this correctly, you should be using DEFINE_CLK_FIXED_RATE
>> >> > and DEFINE_CLK_DIVIDER etc to define the initial clocks and the lookup
>> >> > table, and possibly move all of that to drivers/clk.
>> >>
>> >> Arnd is correct.  Let's go ahead and move everything over to the
>> >> common clk framework.  These patches will have to wait for 3.7
>> >> anyways, so there is plenty of time to port it over.
>> >
>> > OK, I keep this patch and will be create new one, for review, but as I say before,
>> > COMMON_CLOCK framework is too overloaded because clps711x-target CPU
>> > has no enable/disable and change rate functional for clocks. We only can
>> > determine CPU speed from fuses and recalculate some values for system
>> > timer and UART.
>>
>> It might be worthwhile to implement something like
>> drivers/clk/clk-dummy.c which provides no real clk_ops, but
>> initializes parents and rates at clk_register-timer.  I haven't looked
>> at your patch yet to know if such an idea is applicable or not, but I
>> doubt you are the only platform which has "noop" clocks, so it might
>> be nice to expose a standard clock type for this.
>>
>> What do you think?
>
> If I understand correctly, FIXED_CLK have to deal with it.
> Why need one more class?

Ah, I thought that maybe you would have to dynamically detect parents
as well.  Also fixed clk expects to have the rate passed into it, so
if you need to read some registers to determine rate then that will be
something new.

If you don't have mux clocks and you know you rate already (in
software) then fixed clk is fine for you.

Regards,
Mike
