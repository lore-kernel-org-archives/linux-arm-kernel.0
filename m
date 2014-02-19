From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 19 Feb 2014 17:17:40 +0100
Subject: [PATCH v4 03/13] ARM: mvebu: ll_set_cpu_coherent always uses
 the current CPU
In-Reply-To: <20140219170907.002941da@skate>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>	<1392312816-17657-4-git-send-email-gregory.clement@free-electrons.com>
 <20140219170907.002941da@skate>
Message-ID: <5304D924.2000208@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/2014 17:09, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Thu, 13 Feb 2014 18:33:26 +0100, Gregory CLEMENT wrote:
>> ll_set_cpu_coherent is always used on the current CPU, so instead of
>> passing the CPU id as argument, ll_set_cpu_coherent() can find it by
>> itself.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  arch/arm/mach-mvebu/coherency.c    | 10 +++++-----
>>  arch/arm/mach-mvebu/coherency.h    |  2 +-
>>  arch/arm/mach-mvebu/coherency_ll.S | 12 ++++++------
>>  arch/arm/mach-mvebu/headsmp.S      |  4 ----
>>  arch/arm/mach-mvebu/platsmp.c      |  2 +-
>>  5 files changed, 13 insertions(+), 17 deletions(-)
> 
> Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> with just one thing I am not entirely sure about:
> 
>>  	/* Create bit by cpu index */
>> -	mov	r3, #(1 << 24)
>> -	lsl	r1, r3, r1
>> -ARM_BE8(rev	r1, r1)
>> +	mrc	15, 0, r1, cr0, cr0, 5
>> +	and	r1, r1, #15
>> +	mov	r2, #(1 << 24)
>> +	lsl	r1, r2, r1
>> +	ARM_BE8(rev	r1, r1)
> 
> Have you tested this in a big endian configuration? I'd like to make
> sure we have gotten the ARM_BE8(rev ...) thing correct.

No I didn't test it in BE. This change is really similar of
what have been done before so I am quite confident that it works in
BE as well as after the commit "bca028e7c253 ARM: mvebu: support
running big-endian". As you have a BE setup maybe you could check
it and add your Tested-by.


Thanks,

Gregory


> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
