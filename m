From: robherring2@gmail.com (Rob Herring)
Date: Tue, 12 Mar 2013 15:52:39 -0500
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <201303121933.47994.arnd@arndb.de>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
 <513F7EBD.80207@gmail.com> <201303121933.47994.arnd@arndb.de>
Message-ID: <513F9597.8050000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2013 02:33 PM, Arnd Bergmann wrote:
> On Tuesday 12 March 2013, Rob Herring wrote:
>> On 03/12/2013 12:08 PM, Haojian Zhuang wrote:
> 
>> You are breaking existing dtb's changing this, but this is wrong for
>> other reasons. The integrator does not have an SP804. It is the same
>> programming model, but is a single timer and not the dual timer. So
>> having a different compatible string is the correct way. I doubt it has
>> the primecell ID registers which is what "arm,primecell" indicates.
> 
> At least the qemu model has the primecell ID only for actual sp804 but
> not for the integrator, see http://git.qemu.org/?p=qemu.git;a=blob;f=hw/arm_timer.c

Right. I think I added that to qemu...

Since the primecell ID registers are defined to be at 0xFF? offset, it
is quite impossible for the integrator timers to have the ID registers
within their 0x100 address space.

> 
>>>  	};
>>>  
>>>  	timer1: timer at 13000100 {
>>> -		compatible = "arm,integrator-timer";
>>> +		compatible = "arm,sp804", "arm,primecell";
>>> +		arm,sp804-clockevent = <0>;
>>
>> I don't like this nor the old way with aliases. We should describe the
>> h/w features of the timer to determine what to use it for. AFAICT, all 3
>> timers are identical on integrator and it does not matter which one
>> Linux picks for clocksource vs. clockevent.
> 
> Interesting point. I remember we had a discussion about this when the
> initial binding integrator code was merged, but I don't remember what
> the intent was for doing it like this. Probably just minimizing the
> changes to the existing code.

Re-reading the thread on this for Integrator, I don't think any
conclusion was really made, but it got merged. I don't think we should
a) change the existing alias names or b) expand their usage. OMAP is a
good example of lots of timers and using h/w properties to select
particular instances based on properties. I think on the ARM boards the
selection has been pretty arbitrary. I traced the commit history back
for the timer code and could not find any evidence to the contrary
except on VExpress which has broken sp804 on the core tile.

Another part is sched_clock selection. I use the sp804 on highbank, but
the ARM boards have their 24MHz counter. Also, if I'm on midway, then I
want to use the arch timers even though the sp804 is still there. My
sched_clock patches yesterday attempt to address that. Any comments on
what characteristics should be used to select timer would be helpful.
Higher frequency and/or bits is better, but to what limit in frequency?

Rob
