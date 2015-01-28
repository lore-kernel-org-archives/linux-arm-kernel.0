From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 28 Jan 2015 11:31:41 -0500
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <20150128154824.GM28663@atomide.com>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <alpine.LFD.2.11.1501280925400.1322@knanqh.ubzr>
 <20150128153912.GL28663@atomide.com> <201501281647.34477@pali>
 <20150128154824.GM28663@atomide.com>
Message-ID: <54C90EED.8010102@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/28/15 10:48 AM, Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [150128 07:50]:
>> On Wednesday 28 January 2015 16:39:13 Tony Lindgren wrote:
>>> * Nicolas Pitre <nico@fluxnic.net> [150128 06:37]:
>>>> On Wed, 28 Jan 2015, Pali Roh?r wrote:
>>>>> On Wednesday 28 January 2015 01:50:33 Tony Lindgren wrote:
>>>>>> On omaps, the bootrom passes the bootreason in r1 to the
>>>>>> bootloader that can do whatever it wants with it. We
>>>>>> could maybe pass it in the kernel cmdline to the
>>>>>> watchdog driver for user space?
>>>>>
>>>>> Not truth for N900. Bootreason depends on PRM_RSTST omap
>>>>> register, state of vbat charger pins, time how long was
>>>>> power key pressed, R&D data stored in CAL partition and
>>>>> other undocumented registers for omap HS devices. I
>>>>> already tried to implement at least some subset of it in
>>>>> userspace (or kernel), but it is impossible because NOLO
>>>>> bootloader clear status of PRM_RSTST register.
>>>>>
>>>>> There is also copy of PRM_RSTST register stored at address
>>>>> 0x4020FFB8 (tracing data) but that address is rewritten
>>>>> (probably by kernel), so we really cannot implement
>>>>> reading bootreason in kernel.
>>>>>
>>>>> But in early stage in uboot it is possible to read
>>>>> 0x4020FFB8 address and get some part of bootreason. But
>>>>> still PRM_RSTST is not enough!
>>>>>
>>>>> I would be happy if DT kernel can export /proc/atags file
>>>>> with ATAGs passed by bootloader. It would be enough for
>>>>> me. In userspace I can parse content and do what is
>>>>> needed.
>>>>
>>>> What about defining a DT boot reason property instead?
>>>> Maybe it already exists?  If not, it's something that could
>>>> certainly be generically used on other platforms too.
>>>>
>>>> Converting the special ATAG into its standard DT equivalent
>>>> would then be trivial and much cleaner overall.
>>>
>>> Sounds good to me as then we don't have to add any legacy
>>> custom Nokia specific atag. And it won't prevent us from
>>> adding a generic ATAG_BOOTREASON if really needed.
>>
>> And what would new atag ATAG_BOOTREASON solve for Nokia N900?
>> Nothing.
>
> Right, so probably no need to add it then :) But what Nico is
> saying we can translate the Nokia custom bootreason to a
> standard DT property if I'm reading right.

Well, it's mostly been forgotten now, but the pxa-impedance-matcher 
could do the proprietary ATAGS -> standard DT conversion before booting 
the kernel.

   https://github.com/zonque/pxa-impedance-matcher.git

Don't let the 'pxa' fool you, it's grown (slightly) beyond it's original 
purpose.

We augmented it to facilitate booting DT kernels from legacy bootloaders 
to prevent polluting the kernel with random vendor ATAG crap.

Ping me or Daniel Mack if you have any questions.

hth,

Jason.
