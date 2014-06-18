From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 18 Jun 2014 18:49:09 +0400
Subject: [PATCH] arm: get rid of hardcoded assumptions about kernel stack
 size
In-Reply-To: <20140618143145.GH2186@arm.com>
References: <1403099422-850-1-git-send-email-a.ryabinin@samsung.com>
 <20140618143145.GH2186@arm.com>
Message-ID: <53A1A6E5.6070200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/14 18:31, Will Deacon wrote:
> On Wed, Jun 18, 2014 at 02:50:22PM +0100, Andrey Ryabinin wrote:
>> Changing kernel stack size on arm is not as simple as it should be:
>> 1) THRED_SIZE macro doen't respect PAGE_SIZE and THREAD_SIZE_ORDER
> 
> THREAD_SIZE
> 
Yup, I just found some more typos in my commit message.
I'll fix them in update.

>> 2) stack size is hardcoded in get_thread_info macro
>>
>> This patch fixes it by caculating THREAD_SIZE and thread_info address
>> taking into account PAGE_SIZE and THREAD_SIZE_ORDER.
>>
>> Now changing stack size becomes simply changing THREAD_SIZE_ORDER.
> 
> Curious: is this just a cleanup, or are you actually running out of kernel
> stack on an ARM platform?
> 

It's actually both.
I'm working on address sanitizer for kernel [1]. Recently we started experiments with
stack instrumentation. Compiler inserts redzones around every variable on stack, so
we could detect accesses to such redzones and catch out-of-bound read/write bugs on stack variables.
Obviously stack is bloated in such kernel.
For mainline kernel it just a cleanup.


[1] https://code.google.com/p/address-sanitizer/wiki/AddressSanitizerForKernel

> Will
> 
