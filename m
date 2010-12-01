From: cyril@ti.com (Cyril Chemparathy)
Date: Wed, 01 Dec 2010 11:17:41 -0500
Subject: Forced HW_BREAKPOINT
In-Reply-To: <004a01cb913d$c9c1e070$5d45a150$@deacon@arm.com>
References: <4CF58F22.6070803@ti.com>
	<004a01cb913d$c9c1e070$5d45a150$@deacon@arm.com>
Message-ID: <4CF67525.2010304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 12/01/2010 04:54 AM, Will Deacon wrote:
> Hi Cyril,
> 
>> I am running an ARM1176JZ-S based SoC, on which HW breakpoints do not
>> seem to function for some reason.
> 
> What are the symptoms that you are seeing? The 1176 has debug architecture
> v6.1 so it should be supported by the code.
>  

Yes, this CPU has a trustzone capable v6.1 debug (DIDR reads
0x15121004).  The problem I am facing is that DSCR bit 15 (monitor
debug-mode enable bit) cannot be set, it always reads back 0x2.  As a
result the hw_breakpoint code spews a WARN_ON() at boot.

>> Unfortunately the current Kconfig forces HW_BREAKPOINT if PERF_EVENTS is
>> enabled on ARMV6 (commit 19852e59002fbba1c2c6ba0f154095a37ad2ac03):
>>
>>> +       select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V7))
>>
>> As a result, I am unable to use the PMU for OProfile, without having hw
>> breakpoints barf at boot.  Is there any dependency between h/w
>> breakpoints and PMU that I am missing?  If not, does H/W breakpoints
>> have be forced here?
> 
> The hw_breakpoint code depends on 1.) perf and 2.) hardware debug capabilities.
> Since all v6 and v7 cores are supported (at least, everything should fail
> gracefully if something is awry) then I don't see the point in not having it
> enabled. However, if this is causing your board to break during boot we
> should either fix it or allow it to be turned off.
> 

I understand hw_breakpoint's dependency on perf, as well as oprofile's
dependency on perf.  However, if perf does not depend on hw_breakpoint
(on v6/v7), isn't the select above incorrect?

Regards
Cyril.
