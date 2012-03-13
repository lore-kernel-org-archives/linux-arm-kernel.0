From: khilman@ti.com (Kevin Hilman)
Date: Tue, 13 Mar 2012 09:31:46 -0700
Subject: [PATCH] ARM: OMAP4: Workaround the OCP synchronisation issue with
 32K synctimer.
In-Reply-To: <4F5F098E.4040006@ti.com> (Santosh Shilimkar's message of "Tue,
 13 Mar 2012 14:17:10 +0530")
References: <1331566388-2397-1-git-send-email-santosh.shilimkar@ti.com>
 <87399d225f.fsf@ti.com> <4F5F098E.4040006@ti.com>
Message-ID: <87vcm8tqbx.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Monday 12 March 2012 10:21 PM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>> 
>>> On OMAP4, recently a synchronisation bug is discovered by hardware
>>> team, which leads to incorrect timer value read from 32K sync timer
>>> IP when the IP is comming out of idle.
>>>
>>> The issue is due to the synchronization methodology used in the SYNCTIMER IP.
>>> The value of the counter register in 32kHz domain is synchronized to the OCP
>>> domain register only at count up event, and if the OCP clock is switched off,
>>> the OCP register gets out of synch until the first count up event after the
>>> clock is switched back -at the next falling edge of the 32kHz clock.
>>>
>>> Further investigation revealed that it applies to gptimer1 and watchdog timer2
>>> as well which may run on 32KHz. This patch fixes the issue for all the
>>> applicable modules.
>> 
>> The changelog describes the problem ver well, but doesn't actually
>> describe the fix (enable static dep.)  Can you update the changelog do
>> describe the fix, and why it fixes the problem.
>> 
> Sure. Updated patch below. The idea is to ensure that synctimer is
> syncronised before software does any reads on the counter. The BUG
> will get fixed in future OMAP designs

Thanks for the updated changelog.

Since this doesn't qualify as a regression, queuing for v3.4 (branch: for_3.4/fixes/pm)

Kevin
