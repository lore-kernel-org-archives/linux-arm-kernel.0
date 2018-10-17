From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Wed, 17 Oct 2018 13:10:46 +0000
Subject: [PATCH] power: reset: at91-reset: enable I-cache for
 at91sam9260_reset
In-Reply-To: <CALDOjzhZg3X1y22KE1yw_0ZFjuvaa=3GhEF2iU=KUk6-eRZN2g@mail.gmail.com>
References: <20181007125815.8392-1-jonas@threetimestwo.org>
 <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com>
 <2351196.3BzoFE0xYq@ws-140106>
 <CALDOjzhZg3X1y22KE1yw_0ZFjuvaa=3GhEF2iU=KUk6-eRZN2g@mail.gmail.com>
Message-ID: <11b4bcb4-8882-bdd2-c7f7-6a74d0758cbc@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17.10.2018 15:17, Jonas Danielsson wrote:
> On Tue, Oct 16, 2018 at 4:52 PM Alexander Stein
> <alexander.stein@systec-electronic.com> wrote:
>>
>> On Tuesday, October 16, 2018, 3:30:24 PM CEST Claudiu.Beznea at microchip.com wrote:
>>> Hi Jonas,
>>>
>>> On 07.10.2018 15:57, Jonas Danielsson wrote:
>>>> From: Jonas Danielsson <jonas@orbital-systems.com>
>>>>
>>>> This fixes a bug where our embedded system (AT91SAM9260 based) would
>>>> hang at reboot. At the most we managed 16 boot loops without a hang.
>>>>
>>>> With this patch applied the problem has not been observed and the board
>>>> has managed above 250 boot loops.
>>>>
>>>> The AT91SAM9260 datasheet tells us that with the instruction cache
>>>> disabled all instructions are fetched from SDRAM. And we have an errata
>>>> telling us we must power down the SDRAM before issuing cpu reset.
>>>>
>>>> This means we need the instruction cache enabled in at91sam9260_reset()
>>>> At the moment it is being disabled in cpu_proc_fin() which is called from
>>>> arch/arm/kernel/reboot.c.
>>>
>>> Are you using kexec reboot or implemented hibernate mode on this machine?
>>> I'm seeing cpu_proc_fin() is called only in case of kexec reboot or
>>> switching to hibernate mode.
>>>
>>> In case of normal reboot (e.g. reboot command) machine_restart() from
>>> arch/arm/kernel/reboot.c is called. Please correct me if I'm wrong.
>>
>> Another location is cpu_reset() aka cpu_arm926_reset() in proc-arm926.S
>> which also disables I-cache. But I can't track down a callstack
>> ending there.
>>
> 
> We take the normal path of sys_reboot => kernel_restart => machine_restart ...
> 
> I added code to print the c1 register in different paths. And I-cache
> is enabled.
> So now I am really confused about why the patch worked.

Just saying... maybe your instructions add some delay on the execution path
and this is why it helps... try to access cp15 co-processor for read and
write back the value you read without actually to modify it, to see if this
could be the reason: e.g.:

mrc	p15, 0, r0, c1, c0, 0
orr	r1, r1, #4096		// whatever is in r1, doesn't matter
mcr	p15, 0, r0, c1, c0, 0

Thank you,
Claudiu Beznea

> 
>> Best regards,
>> Alexander
> 
> Jonas
> 
>>
>>
>>
> 
> 
