From: icenowy@aosc.io (icenowy at aosc.io)
Date: Fri, 28 Jul 2017 07:27:08 +0800
Subject: halting the kernel does not stop the CPU cores?
In-Reply-To: <20170727222545.GT31807@n2100.armlinux.org.uk>
References: <VI1PR04MB1662099750F9EAFA0324C6538CBE0@VI1PR04MB1662.eurprd04.prod.outlook.com>
 <26ccb0f7-0f78-27cd-cead-ddd810f4a33e@gmail.com>
 <20170727222545.GT31807@n2100.armlinux.org.uk>
Message-ID: <dec9a2e080cbd15502659e78260b62cd@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-07-28 06:25?Russell King - ARM Linux ???
> On Thu, Jul 27, 2017 at 01:07:00PM -0700, Florian Fainelli wrote:
>> On 07/27/2017 07:38 AM, Heinz Wrobel wrote:
>> > Hi,
>> >
>> > I noticed that when halting the kernel (intentionally or not), the cores effectively go into a while(1) loop and power consumption on larger devices really jumps up significantly to the point where, e.g., a ?crash? turns into ?crash and burn?.

This is also an issue on Allwinner H3 boards.

Allwinner H3 boards usually doesn't have any PMICs, so it cannot do
hardware shutdown, so if it halts the CPU will also go into while(1)
loop. More serious problem is that some boards are not well designed
and the heat produced by while(1) is possible to hurt the hardware.

I remember Chen-Yu Tsai suggested in #linux-sunxi IRC channel to change
this busy loop to a WFI loop, so it can reduce power consumption and
heat.

>> >
>> > I would assume that if a system is halted, you don?t want to dissipate more power than on a running system but go as silent as low power as reasonable.
>> >
>> > Is there any specific reason why the cores would not go into a wfi loop like they do on idle?
>> > The patch to fix this seems to be easy at first glance, but is there a good reason *NOT* to do such a patch and to leave the plain while(1)?
>> 
>> In fact, if your platform supports CPU_HOTPLUG, I am not clear why
>> smp_send_stop() + ipi_send_stop() is not calling platform_cpu_kill()
>> which would be smp_ops.cpu_kill() but instead cpu_relax() was chosen?
>> 
>> The CPU is dead anyway so as you say, so it's not like there is a 
>> remote
>> chance to resume execution on these secondary cores?
> 
> The cpu kill method also needs another cpu to be interacting with the
> cpu die methods as well - the CPU hotunplug is a combination effort
> between the CPU to be killed and the CPU asking for the killing of
> that CPU.
> 
> We don't have that luxury in these paths, which are used amongst
> other things for when the kernel panics, which can happen from any
> context.
