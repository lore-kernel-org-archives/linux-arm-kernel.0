From: pinskia@gmail.com (pinskia at gmail.com)
Date: Wed, 2 Sep 2015 01:58:56 +0800
Subject: [PATCHv2] ARM64: Add AT_ARM64_MIDR to the aux vector
In-Reply-To: <20150901173043.GE16430@leverpostej>
References: <1440873982-44062-1-git-send-email-apinski@cavium.com>
 <20150901163304.GC16430@leverpostej>
 <A9115CAF-0C57-4810-97F6-6245E7D0CE48@gmail.com>
 <4C8DD5E0-E1EA-40C6-B947-72189241023C@caviumnetworks.com>
 <20150901173043.GE16430@leverpostej>
Message-ID: <9AA83792-C973-4642-88BA-3C59F23EB048@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org





> On Sep 2, 2015, at 1:30 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> 
> [...]
> 
>>>>> On Sat, Aug 29, 2015 at 07:46:22PM +0100, Andrew Pinski wrote:
>>>>> It is useful to pass down MIDR register down to userland if all of
>>>>> the online cores are all the same type.  This adds AT_ARM64_MIDR
>>>>> aux vector type and passes down the midr system register.
>>>>> 
>>>>> This is alternative to MIDR_EL1 part of
>>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358995.html.
>>>>> It allows for faster access to midr_el1 than going through a trap and
>>>>> does not exist if the set of cores are not the same.
>>>> 
>>>> I'm not sure I follow the rationale. If speed is important the
>>>> application can cache the value the first time it reads it with a trap.
>>> 
>>> It is also about compatibility also. Exposing the register is not backwards compatible but using the aux vector is.
>> 
>> That would also break big.little too. So either break it with hot plug or break it in userland, your choice.
> 
> The value wouldn't be representative of the system as a whole; that is
> true. However, we never guaranteed that it was, while the aux vector
> code implied that we did.

Yes but I guess you talk about caching the value in userspace but doing it via the aux vector is the same as your suggestion. Just one difference is you don't get the aux vector entry if there is a CPU that is online which is different. No difference from your suggestion of caching it. Without considering hot pug for a second (that is a huge different issue all together), if userland wants to know if all up CPUs have the same midr, they would either read /sys entries (lots of syscalls) or bind to each CPU and do the trap. That means at least three or two syscalls/traps for each CPU. My way is none and gets a value of midr if they are all the Same for free. 

Again what is the difference between the aux vector and caching the value in userspace? Because it seems like you suggesting I do that but then avoiding big.little also. 

Thanks,
Andrew

> 
> For optimisation that may be good enough; code optimized for a different
> uArch should still function on another, even if it is slower.
> 
>>>> This also means that the behaviour is different across homogeneous and
>>>> heterogeneous systems.
>> 
>> That should be ok because it is still backwards compatible with what
>> was done before.  My goal here is just to allow quick easy access to
>> midr in the case of a homogeneous system which I care about, thunderx
>> and to allow glibc to select a memcpy/memset that is better for
>> thunderx.
> 
> As I mentioned in the other thread, I think that HWCAP_CPUID is
> sufficient to enable forwards and backwards compatibility. If it is
> present then you can use the current CPU's MIDR to select a better
> memcpy/memset if required.
> 
> Thanks,
> Mark.
