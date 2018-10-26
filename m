From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Fri, 26 Oct 2018 11:05:30 +0000
Subject: [PATCH] power: reset: at91-reset: enable I-cache for
 at91sam9260_reset
In-Reply-To: <CALDOjzhgqcx5XEWon9EQXEGxt9J280Z6AvuFQcBa=nh-9VA6PQ@mail.gmail.com>
References: <20181007125815.8392-1-jonas@threetimestwo.org>
 <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com>
 <2351196.3BzoFE0xYq@ws-140106>
 <CALDOjzhZg3X1y22KE1yw_0ZFjuvaa=3GhEF2iU=KUk6-eRZN2g@mail.gmail.com>
 <11b4bcb4-8882-bdd2-c7f7-6a74d0758cbc@microchip.com>
 <CALDOjzhgqcx5XEWon9EQXEGxt9J280Z6AvuFQcBa=nh-9VA6PQ@mail.gmail.com>
Message-ID: <f8ed781a-2ee7-9d0e-1220-b23ccf3fdbb2@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19.10.2018 13:30, Jonas Danielsson wrote:
> On Wed, Oct 17, 2018 at 3:10 PM <Claudiu.Beznea@microchip.com> wrote:
>>
>>>
>>> We take the normal path of sys_reboot => kernel_restart => machine_restart ...
>>>
>>> I added code to print the c1 register in different paths. And I-cache
>>> is enabled.
>>> So now I am really confused about why the patch worked.
>>
>> Just saying... maybe your instructions add some delay on the execution path
>> and this is why it helps... try to access cp15 co-processor for read and
>> write back the value you read without actually to modify it, to see if this
>> could be the reason: e.g.:
>>
>> mrc     p15, 0, r0, c1, c0, 0
>> orr     r1, r1, #4096           // whatever is in r1, doesn't matter
>> mcr     p15, 0, r0, c1, c0, 0
>>
> 
> Yes, this also seems to work. I have over 100 reboots completed with this code.
> So what could be the issue here? It seem related to the powering down
> of the sdram at least.

I don't know what could be the issue here. 

> 
> This thread on the AT91SAM community deals with the same issue:
> http://www.at91.com/viewtopic.php?t=25830
> There the solution people chose was removing the SDRAM powering down.
> But that leaves one open to the cause of the errata.
> 
> Do you have any thought on how to approach this?

For now, no. I didn't dug this issue.

Thank you,
Claudiu

> 
>> Thank you,
>> Claudiu Beznea
>>
> 
> Regards
> Jonas
> 
> 
>>>
>>>> Best regards,
>>>> Alexander
>>>
>>> Jonas
>>>
>>>>
>>>>
>>>>
>>>
>>>
> 
> 
> 
