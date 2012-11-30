From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 30 Nov 2012 16:20:36 +0530
Subject: [PATCH v3 5/6] ARM: davinci: remoteproc board support for
 OMAP-L138 DSP
In-Reply-To: <13514BD7FAEBA745BBD7D8A672905C14311F952B@DFLE08.ent.ti.com>
References: <1352853207-20602-1-git-send-email-rtivy@ti.com>
 <1352853207-20602-5-git-send-email-rtivy@ti.com> <50AB76FA.1050505@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C14311F952B@DFLE08.ent.ti.com>
Message-ID: <50B88F7C.5000705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 11/29/2012 7:08 AM, Tivy, Robert wrote:
> Hi Sekhar,
> 
> Please see comments and noob questions below...
> 
>> -----Original Message-----
>> From: Nori, Sekhar
>> Sent: Tuesday, November 20, 2012 4:27 AM
>> To: Tivy, Robert
>> Cc: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
>> kernel at lists.infradead.org; Ring, Chris; Grosen, Mark
>> Subject: Re: [PATCH v3 5/6] ARM: davinci: remoteproc board support for
>> OMAP-L138 DSP
>>
>> On 11/14/2012 6:03 AM, Robert Tivy wrote:
>>> Requires CMA services.
>>>
>>> New 'clk_reset()' API added so that the DSP's reset state can be
>>> toggled separately from its enable/disable operation.
>>
>> But we cannot add a private clk_ API without it being defined in
>> include/linux/clk.h. So, this requires wider alignment.
>>
>> And I am not sure clock API should be extended to support reset since
>> "resetting a clock" does not make a lot of sense. On DaVinci, clock
>> gating and reset are handled by the same module, but that need not
>> always be the case.
>>
>> What you need is a way to reset an IP. I do not know of an existing
>> framework to do this; likely a new API needs to be created. I am
>> guessing this never existed so far because most of the IPs can be reset
>> internally (by writing a bit within its own register space). I guess
>> DSP is different since its actually a co-processor and may not have
>> such a bit.
>>
>> How about simulating a reset by making the DSP jump to its reset
>> address. While I am sure its not quite the same as resetting the DSP
>> using PSC, may be it could be used while you wait for consensus around
>> handling module reset in kernel?
> 
> Since the ARM can't write the DSP's program counter I suspect such a temporary solution is not possible.

Okay. I think the way forward on this is to start a separate thread
including the ARM list, LKML and the remoteproc folks to see if it makes
sense to create a reset API in kernel. You can describe the usecase you
have.

> 
>>
>>>
>>> Signed-off-by: Robert Tivy <rtivy@ti.com>
>>> ---
>>>  arch/arm/mach-davinci/board-da850-evm.c        |   10 +++
>>>  arch/arm/mach-davinci/board-omapl138-hawk.c    |   10 +++
>>>  arch/arm/mach-davinci/clock.c                  |   22 +++++++
>>>  arch/arm/mach-davinci/clock.h                  |    1 +
>>>  arch/arm/mach-davinci/da850.c                  |   17 ++++++
>>>  arch/arm/mach-davinci/devices-da8xx.c          |   78
>> +++++++++++++++++++++++-
>>>  arch/arm/mach-davinci/include/mach/da8xx.h     |    1 +
>>>  arch/arm/mach-davinci/include/mach/psc.h       |    3 +
>>>  arch/arm/mach-davinci/psc.c                    |   27 ++++++++
>>>  arch/arm/mach-davinci/remoteproc.h             |   23 +++++++
>>>  include/linux/clk.h                            |   17 ++++++
>>>  include/linux/platform_data/da8xx-remoteproc.h |   34 +++++++++++
>>
>> This patch is touching too many areas at once and needs to be split
>> according to whether the changes are in the soc support or board
>> support. 
> 
> OK.
> 
>> Also, platform data needs be added along with the driver. And
>> the driver itself needs to be added before its platform users.
> 
> Are these comments suggesting some change to the code, or are they more of a guide as to how to split this part of the patch up into related chunks?  Please clarify.

Its about how the patches should be split and structured.

[...]
>>> +static struct da8xx_rproc_pdata rproc_pdata = {
>>> +	.name		= "dsp",
>>> +	.firmware	= "da8xx-dsp.xe674",
>>
>> Sounds like the user can name the firmware whatever he wants and so it
>> should be a module parameter to the remote proc driver? There is
>> nothing platform specific about the firmware name, no?
> 
> Sounds OK.  I propose then to have the above be the default firmware name, along with a module parameter that will override if specified.

Sounds good.

>>> +#ifdef CONFIG_CMA
>>> +
>>> +static phys_addr_t rproc_base __initdata =
>>> +CONFIG_DAVINCI_DSP_RPROC_CMA_BASE;
>>> +static unsigned long rproc_size __initdata =
>>> +CONFIG_DAVINCI_DSP_RPROC_CMA_SIZE;
>>
>> These are not defined at this point so the kernel build will fail after
>> applying this patch. This breaks things for those who run git-bisect.
>> Please verify kernel build after applying each patch.
>>
>> Looking at patch 6/6 where these are actually defined, it is not
>> correct to define these using Kconfig. This prevents users from running
>> a single kernel image on systems where the value needs to be different.
> 
> They can run a single image if the image supports overriding the Kconfig settings with kernel command-line arguments.
> 
> The most basic solution is constants in the .c file itself.  A better solution is Kconfig settings used by the .c file.  An even better solution is Kconfig settings with kernel command-line overrides.

If you have kernel command line, you could default to some values which
are sane in most cases if they are not provided. No, need to have a
Kconfig as well. That will be too many hooks to control the same things
and probably not necessary.

> 
>> If you want the remoteproc driver to allocate a certain area of memory
>> to the dsp, why don't you take that value as a module parameter so
>> people who need different values can pass them differently? It is not
>> clear to me why this memory management needs to be dealt with in
>> platform code.
> 
> Unfortunetly we need to reserve this dsp memory during early boot, using CMA.  Runtime module insertion is too late.

Then I guess most of the time the module would be built into the kernel
and will be initialized using an early enough initcall.

> 
>>
>>> +
>>> +static int __init early_rproc_mem(char *p) {
>>> +	char *endp;
>>> +
>>> +	rproc_size = memparse(p, &endp);
>>> +	if (*endp == '@')
>>> +		rproc_base = memparse(endp + 1, NULL);
>>> +
>>> +	return 0;
>>> +}
>>> +early_param("rproc_mem", early_rproc_mem);
>>
>> Use of non-standard kernel parameters is discouraged. All kernel
>> parameters should be documented in Documentation/kernel-parameters.txt
>> (this means each and every kernel parameter needs to be justified
>> well).
> 
> Can I use the kernel command-line (i.e., u-boot bootargs variable) to specify non-kernel parameters?  I guess my question is more one about the terminology "kernel parameter" - is there a way to specify a module parameter on the kernel command line (like, perhaps, rproc.membase and rproc.memsize)?

Right. Module parameters are passed from kernel command line when the
module is built into the kernel.

Thanks,
Sekhar
