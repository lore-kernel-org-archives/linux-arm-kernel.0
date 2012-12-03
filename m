From: cyril@ti.com (Cyril Chemparathy)
Date: Mon, 3 Dec 2012 15:13:12 -0500
Subject: [PATCH v3 5/6] ARM: davinci: remoteproc board support for
 OMAP-L138 DSP
In-Reply-To: <50BCBA26.4070608@ti.com>
References: <1352853207-20602-1-git-send-email-rtivy@ti.com>
 <1352853207-20602-5-git-send-email-rtivy@ti.com> <50AB76FA.1050505@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C14311F952B@DFLE08.ent.ti.com>
 <50B88F7C.5000705@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C14311FAC29@DFLE08.ent.ti.com>
 <50BCBA26.4070608@ti.com>
Message-ID: <50BD07D8.5000305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2012 09:41 AM, Sekhar Nori wrote:
> Hi Rob,
>
> On 12/1/2012 7:41 AM, Tivy, Robert wrote:
>> Hi Sekhar,
>>
>>> -----Original Message-----
>>> From: Nori, Sekhar
>>> Sent: Friday, November 30, 2012 2:51 AM
>>> To: Tivy, Robert
>>> Cc: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
>>> kernel at lists.infradead.org; Ring, Chris; Grosen, Mark
>>> Subject: Re: [PATCH v3 5/6] ARM: davinci: remoteproc board support for
>>> OMAP-L138 DSP
>>>
>>> Hi Rob,
>>>
>>> On 11/29/2012 7:08 AM, Tivy, Robert wrote:
>>>> Hi Sekhar,
>>>>
>>>> Please see comments and noob questions below...
>>>>
>>>>> -----Original Message-----
>>>>> From: Nori, Sekhar
>>>>> Sent: Tuesday, November 20, 2012 4:27 AM
>>>>> To: Tivy, Robert
>>>>> Cc: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
>>>>> kernel at lists.infradead.org; Ring, Chris; Grosen, Mark
>>>>> Subject: Re: [PATCH v3 5/6] ARM: davinci: remoteproc board support
>>>>> for
>>>>> OMAP-L138 DSP
>>>>>
>>>>> On 11/14/2012 6:03 AM, Robert Tivy wrote:
>>>>>> Requires CMA services.
>>>>>>
>>>>>> New 'clk_reset()' API added so that the DSP's reset state can be
>>>>>> toggled separately from its enable/disable operation.
>>>>>
>>>>> But we cannot add a private clk_ API without it being defined in
>>>>> include/linux/clk.h. So, this requires wider alignment.
>>>>>
>>>>> And I am not sure clock API should be extended to support reset
>>> since
>>>>> "resetting a clock" does not make a lot of sense. On DaVinci, clock
>>>>> gating and reset are handled by the same module, but that need not
>>>>> always be the case.
>>>>>
>>>>> What you need is a way to reset an IP. I do not know of an existing
>>>>> framework to do this; likely a new API needs to be created. I am
>>>>> guessing this never existed so far because most of the IPs can be
>>>>> reset internally (by writing a bit within its own register space). I
>>>>> guess DSP is different since its actually a co-processor and may not
>>>>> have such a bit.
>>>>>
>>>>> How about simulating a reset by making the DSP jump to its reset
>>>>> address. While I am sure its not quite the same as resetting the DSP
>>>>> using PSC, may be it could be used while you wait for consensus
>>>>> around handling module reset in kernel?
>>>>
>>>> Since the ARM can't write the DSP's program counter I suspect such a
>>> temporary solution is not possible.
>>>
>>> Okay. I think the way forward on this is to start a separate thread
>>> including the ARM list, LKML and the remoteproc folks to see if it
>>> makes sense to create a reset API in kernel. You can describe the
>>> usecase you have.
>>
>> Instead of fighting that fight, I thought of another way.  The da8xx_dsp platform_device has private data registered in its device struct.  This private data can contain a function pointer for a "DSP reset" function, and davinci_remoteproc.c can call the registered function.  Does that sound OK?
>
> Passing function pointers from platform code will not work when
> converting to device tree (DT). DA850 will gain DT boot with v3.8 and
> there is work ongoing on converting drivers to be DT-aware. Adding a new
> driver which is DT-incompatible will not be right. Hence, I will not
> recommend this now.
>

Not sure if this solves your problem, but you could add a new clock type 
(PSC_LRESET?) as a child under the PSC clock node for the DSP. 
Something like:

   |
   +-- PSC x (DSP0 clock)
   |    |
   |    +-- PSC-LRESET x (DSP0 reset control)
   |
   +-- PSC y (DSP1 clock)
   |    |
   |    +-- PSC-LRESET y (DSP1 reset control)
   |
   +-- PSC z (DSP2 clock)
   |    |
   |    +-- PSC-LRESET z (DSP2 reset control)


The idea here being that if you enable the PSC clocks, you enable the 
clock gates, but leave the DSPs in reset.  On the other hand, if you 
enable the reset clock, the code implicitly enables the gate (via 
parent), and takes the DSP out of reset as well.

This is not quite the cleanest way to do it, considering that reset 
lines have no business in the clock tree, but then, this is probably the 
simplest way to fit in.  Thoughts?

BTW, we have the same situation on Keystone.

Thanks
-- Cyril.
