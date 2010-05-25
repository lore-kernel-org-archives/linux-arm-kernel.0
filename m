From: armando.visconti@st.com (Armando VISCONTI)
Date: Tue, 25 May 2010 14:07:31 +0200
Subject: facing undefined inconsistent cache issues on cortex-a9
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C57001F3@dbde02.ent.ti.com>
References: <4BF9F5FB.6020306@st.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C57001F3@dbde02.ent.ti.com>
Message-ID: <4BFBBD83.5080302@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shilimkar, Santosh wrote:
>> -----Original Message-----
>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
>> bounces at lists.infradead.org] On Behalf Of Shiraz HASHIM
>> Sent: Monday, May 24, 2010 9:14 AM
>> To: linux-arm-kernel at lists.infradead.org
>> Cc: 'Armando VISCONTI'; Vipin KUMAR; Viresh KUMAR
>> Subject: facing undefined inconsistent cache issues on cortex-a9
>>
>> Hi,
>> I am using linux-2.6.32 port on spear1300 platform, the port is largely based
>> on realview code.
>>
>> SPEAr1300 has a Cortex A9 dual core, both cores configured as participating in
>> SMP, but we are currently configuring Linux in non SMP mode, running Linux on
>> the first core only, while second core is spinning  forever in a tight loop.
>>
>> Linux is running with default configuration w.r.t. cache and other things on
>> core1. Since SMP is not enabled this means that SCU and local timers are off, L2
>> cache is also disabled.  While on core2 only instruction cache is on and both
>> MMU and Data cache is off.
>>
>> We observed a crash while booting. Investigating on the crash we found that this
>> was caused by a wrong value read by the core.  Strangely enough, the new value
>> was written few instruction before, but the core was still reading the old one.
>>
>> What happens is someting like this:
>>
>> r0 = X ; /* X is the address of a Linux variable */
>>
>> str r5, [r0]; /* write new value */
>> ...
>> ldr r5, [r0]; /* read back value - we get the old one (???) */
>>
>> The value read here, just few lines later the new value was written, is the old
>> one. Obviously we are expecting to find the new one.
>>
>> Moreover, using the jtag debugger it looks clear that the new value is indeed in
>> the memory, but surprisingly NOT in the data-cache.
>> If we put a read of X, before the store in order to avoid the write miss when
>> doing 'str r5, [r0]', we see that the problem doesn't appear.
>>
>>     
> Does this work if disable L1D as well on the processor you are running Linux ??
>   
If we disable the L1 DCache we are never able to boot.
But this might be a different problem.

If we disable ICache and leave DCache on it is much more stable, and
I think it might be related to timing issue in the data path.

We are using Cortex A9 r2p1.

Any clue?

Arm



-- 
-- "Every step appears to be the unavoidable consequence of the
-- preceding one." (A. Einstein) 
-- 
Armando Visconti                  Mobile: (+39) 346 8879146
Senior SW Engineer                Fax:    (+39) 02 93519290
CPG                               Work:   (+39) 02 93519683
Computer System Division          e-mail: armando.visconti at st.com
ST Microelectronics               TINA:   051  4683
                                    
 
