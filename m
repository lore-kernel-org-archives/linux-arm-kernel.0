From: viresh.kumar@st.com (Viresh KUMAR)
Date: Thu, 15 Jul 2010 15:05:52 +0530
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100715083032.GA26212@n2100.arm.linux.org.uk>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>	<20100709124050.GF22845@n2100.arm.linux.org.uk>	<AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>	<20100710071913.GM22845@n2100.arm.linux.org.uk>	<AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>	<20100713074449.GA20118@n2100.arm.linux.org.uk>	<AANLkTilZJTHh_iFS37UL7XoUs_DhAB50A3tHfcfEr5JM@mail.gmail.com>	<20100713182644.GC30142@n2100.arm.linux.org.uk>	<4C3EA46B.1000709@st.com>
	<20100715083032.GA26212@n2100.arm.linux.org.uk>
Message-ID: <4C3ED678.7010308@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/15/2010 2:00 PM, Russell King - ARM Linux wrote:
> On Thu, Jul 15, 2010 at 11:32:19AM +0530, Viresh KUMAR wrote:
>> These cases particularly in our architecture where functional and
>> interface clock are tied together (through same gating option) would
>> produce difficult scenarios (as already mentioned by you) and which
>> would be difficult and not so clean to handle.
> 
> I don't see the problem.
> 
> What I'm proposing means:
> 
> 1. when the driver probe function is called, pclk is guaranteed to be
>    enabled, and therefore device registers are guaranteed to be accessible.
>    This clock will then stay enabled all the time the device is bound to
>    the driver unless the driver wants to request that it is disabled.
> 
> 2. if the driver wants to do something with its functional clock, it
>    clk_get() that, and does the standard enable/disable on it at the
>    appropriate time.
> 
> So, if pclk and the functional clock are bound together, then at probe
> time the 'pclk' is obtained and enabled, which sets your enable bit and
> increases the clk use count to 1.
> 
> When the driver gets its functional clock, which happens to be the same
> as clk structure as 'pclk', calling clk_enable() increases the use count
> to 2, but doesn't touch the register because the clock is already enabled.
> 
> If the driver subsequently calls clk_disable(), this decreases the use
> count to 1, and because there's still one user, the clock isn't disabled.
> 
> Only if the driver wants both its pclk and functional clock disabled will
> your enable bit be reset.
> 
> So, provided a driver participating in pclk control (by disabling it in
> its probe function) always re-enables pclk before it accesses the device
> then the pclk control is completely transparent - whether or not it's
> tied to the functional clock.
> 
> If a driver isn't participating in pclk control, it continues to work as
> is with no alterations - because we guarantee that pclk will be enabled
> to the device whenever the driver is bound to the device.
> 
> This allows us to incrementally add pclk control to each primecell driver.
> 
>> For example just looking at driver src which disables bus clock (without
>> enabling it) in different scenarios would not be very readable.
>> Further that would vary from architecture to architecture (even for
>> standard drivers).
> 
> How so?
> 
>>> You can't have the core code doing that.  If you unconditionally turn
>>> the bus clock off after probe, what happens when a driver receives an
>>> interrupt and tries to access its registers?
>>>
>>> Hint: the core code can't know that the driver has registered an IRQ
>>> handler.
>>
>> We haven't seen this kind of issues in our devices, SPEAr as well as
>> U300 (as we have both clocks controlled by same bit). Normally, when
>> device is not in use then interrupts are disabled. When device is
>> used then interrupts and clock are enabled and clocks are not disabled
>> till the time work is finished. So, this condition might not occur that
>> you have landed in interrupt handler with clocks off.
> 
> So what happens with the PL011 driver which accesses the device with
> the primecell UARTCLK disabled?  Eg, when reading the procfs file in
> /proc/tty/driver/ ?
> 
> What about the SPI primecell, which only enables its functional clock
> when its really required?  It accesses device registers without the
> functional clock enabled?
> 
> Basically, we do not guarantee that drivers will have their functional
> clock enabled prior to accessing their registers.
> 

I got it!!!

Just a little issue, in your patch you were enabling interface clock in
amba_probe which is called after reading peripheral id registers in
amba_device_register. We need interface clock enabled before reading these
registers.

viresh.
