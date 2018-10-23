From: Ramana.Radhakrishnan@arm.com (Ramana Radhakrishnan)
Date: Tue, 23 Oct 2018 08:39:19 +0000
Subject: [PATCH 00/17] ARMv8.3 pointer authentication support
In-Reply-To: <20181019123646.GG14246@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181019123646.GG14246@arm.com>
Message-ID: <8478fc27-6e74-4fa6-7956-ffc1cca6c063@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/10/2018 13:36, Will Deacon wrote:
> On Fri, Oct 05, 2018 at 09:47:37AM +0100, Kristina Martsenko wrote:
>> 1) Key support
>>
>> This series enables the use of instructions using APIAKey, which is
>> initialised and maintained per-process (shared by all threads). GCC
>> currently only makes use of APIAKey.
>>
>> This series does not add support for APIBKey, APDAKey, APDBKey, nor
>> APGAKey. HINT-space instructions using these keys will currently execute
>> as NOPs. Support for these keys can be added as users appear.
>>
>> Note that while we expose the cpuid register (ID_AA64ISAR1_EL1) to
>> userspace, it only contains one feature for address authentication
>> (API/APA), so it cannot be used by userspace to tell which keys the
>> kernel supports. For this the kernel exposes HWCAP bits, one per key
>> (currently only APIAKey), which must be checked instead.
> 
> Given that the architecture doesn't provide an identification mechanism
> for the case where only one of the keys is available, I would much prefer
> that we expose both of the keys to userspace. Is the only downside of
> that a possible exception entry overhead if the kernel wants to use pointer
> authentication as well?
> 
> Having an initial implementation where the B key operations act as NOPs
> isn't ideal if we want to support future users -- chances are they'll
> be put off because deployed kernels don't give them whatever security
> guarantees they require. It's a bit of a chicken-and-egg problem, so
> unless we have good reasons to keep the B key hidden, I think we should
> be exposing it from the start.

There are patches in flight to get B key signing support in for GCC 9  - 
so exposing this to user space will be good.

Ramana

> 
> Will
> 
