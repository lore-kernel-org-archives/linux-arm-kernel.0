From: chen.gang.flying.transformer@gmail.com (Chen Gang F T)
Date: Sat, 11 Jan 2014 00:48:48 +0800
Subject: [PATCH v3] arm: remove !CPU_V6 and !GENERIC_ATOMIC64 build
 dependencies for XEN
In-Reply-To: <20140109184251.GL17838@mudshark.cambridge.arm.com>
References: <1389204023-26912-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20140109103004.GB11089@mudshark.cambridge.arm.com>
 <201401091204.17932.arnd@arndb.de>
 <alpine.DEB.2.02.1401091247000.21510@kaball.uk.xensource.com>
 <20140109184251.GL17838@mudshark.cambridge.arm.com>
Message-ID: <52D02470.6050303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2014 02:42 AM, Will Deacon wrote:
> On Thu, Jan 09, 2014 at 12:47:24PM +0000, Stefano Stabellini wrote:
>> On Thu, 9 Jan 2014, Arnd Bergmann wrote:
>>> On Thursday 09 January 2014, Will Deacon wrote:
>>>> On Wed, Jan 08, 2014 at 06:00:23PM +0000, Stefano Stabellini wrote:
>>>>> Remove !GENERIC_ATOMIC64 build dependency:
>>>>> - rename atomic64_xchg to armv7_atomic64_xchg and define it even ifdef
>>>>>   GENERIC_ATOMIC64;
>>>>> - call armv7_atomic64_xchg directly from xen/events.h.
>>>>>
>>>>> Remove !CPU_V6 build dependency:
>>>>> - introduce __cmpxchg8 and __cmpxchg16, compiled even ifdef
>>>>>   CONFIG_CPU_V6;
>>>>> - implement sync_cmpxchg using __cmpxchg8 and __cmpxchg16.
>>>>>
>>>>> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
>>>>> CC: arnd at arndb.de
>>>>> CC: linux at arm.linux.org.uk
>>>>> CC: will.deacon at arm.com
>>>>> CC: gang.chen at asianux.com
>>>>> CC: catalin.marinas at arm.com
>>>>> CC: jaccon.bastiaansen at gmail.com
>>>>> CC: linux-arm-kernel at lists.infradead.org
>>>>> CC: linux-kernel at vger.kernel.org
>>>>>
>>>>
>>>> I'm confused here. It looks like you want to call armv7 code in a v6 kernel.
>>>> What am I missing?
>>>
>>> This is about being able to build a kernel that runs on ARMv6 and ARMv7
>>> and also includes Xen. Because of obvious hardware limitations, Xen
>>> will only run on v7, but currently you cannot even build it once you
>>> enable (pre-v6K) ARMv6 support, since the combined v6+v7 kernel can't
>>> do atomic accesses in a generic way on non-32bit variables.
>>
>> Yep, that's right.
> 
> Ok, thanks for the explanation. Looking at the patch, I wonder whether it's
> not cleaner just to implement xchg code separately for Xen? The Linux code
> isn't always sufficient (due to the GENERIC_ATOMIC64 stuff) and most of the
> churn coming out of this patch is an attempt to provide some small code
> reuse at the cost of code readability.
> 
> What do others think?
> 

What Will said sounds reasonable to me.


Thanks.
-- 
Chen Gang
