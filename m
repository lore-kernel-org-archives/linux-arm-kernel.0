From: joravec@drewtech.com (Joey Oravec)
Date: Tue, 05 Jul 2011 11:37:57 -0400
Subject: plat-orion multi purpose pins problem for mv78200
In-Reply-To: <CAMAG_eexDoKrPsrd7+3bpsN3y0pptqwhFRP2NKqd_Nny+M+NGg@mail.gmail.com>
References: <4E0E1CA8.7090200@drewtech.com>	<20110702122344.GJ31228@kw.sim.vm.gnt>
	<CAMAG_eexDoKrPsrd7+3bpsN3y0pptqwhFRP2NKqd_Nny+M+NGg@mail.gmail.com>
Message-ID: <4E132FD5.1090409@drewtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/3/2011 8:46 AM, saeed bishara wrote:
>> It doesn't seems the code was behaving differently before 3.0-rc. I mean
>> before the MPP and GPIO consolidation work. It was ?
> that's right, this issue was before the consolidation work.
Agreed. I only meant to say that the MPP code is broken for mv78200 in 
3.0-rc5, so the maintainers should consider a short-term fix of 
disabling the checks in orion_gpio_is_valid().

>> Does hardware allows a configuration like MPP0_GE0_COL and MPP32_GPIO
>> simultaneously ?
> yes, this is possible.
Agreed. MPP is the pin that can be mux'ed to 7 resources. GPIO is just 
one of those resources. Yes the hardware supports your example. Most 
resources can be routed to several different pins to allow flexibility 
in board design.

Since MPP is just a pin-mux, it's possible for Marvell to build an SoC 
in the future that can route a few different GPIOs onto a given MPP pin. 
It seems like any solution should account for this.

>> If not (and only if not), the problem is simply mapping a MPP number on
>> the correct GPIO number. Isn't it ?
>>
>> In that case, what about using the MPPxx_GPIO definitions (found in
>> mach-mv78xx0/mpp.h) to map the right GPIO number ?
>>
>> For example:
>>
>> #define MPP32_GPIO        MPP(32, 0x1, 1, 1, 1)
>>
>> could be replaced by:
>>
>> #define MPP32_GPIO        MPP(0, 0x1, 1, 1, 1)
> that won't work because the num (first number) is used as the mpp
> index. see orion_mpp_conf() implementation.
> I think the solution is to extend the MPP define to include the
> explicit gpio number, so it will look like:
> #define MPP(_num, _gpio _sel, _in, _out, _78100_A0)
That could work as long as a value is reserved to mean "not gpio" like:

#define MPP0_GPIO        MPP(0, 0, 0x0, 1, 1, 1)
#define MPP0_GE0_COL        MPP(0, -1, 0x1, 1, 0, 1)

Note that orion_gpio_set_valid() and orion_gpio_is_valid() would both 
need rework. The functions need to handle that a GPIO can be mux'ed onto 
any MPP pin. I described this problem in another email on the thread.

There has been some discussion of a pinmux API. Does this API offer any 
simpler solution?

-joey
