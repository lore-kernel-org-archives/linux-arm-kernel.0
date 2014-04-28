From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Apr 2014 12:40:16 -0600
Subject: [PATCH 00/16] Another 16 L2C patches
In-Reply-To: <20140428181904.GP26756@n2100.arm.linux.org.uk>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
 <535E8BEE.1000100@wwwdotorg.org> <535E8F6D.9000803@wwwdotorg.org>
 <20140428173943.GN26756@n2100.arm.linux.org.uk>
 <535E990B.2020405@wwwdotorg.org>
 <20140428181904.GP26756@n2100.arm.linux.org.uk>
Message-ID: <535EA090.6030903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 12:19 PM, Russell King - ARM Linux wrote:
> On Mon, Apr 28, 2014 at 12:08:11PM -0600, Stephen Warren wrote:
>> (Dropping most people from CC since this sub-thread is a Tegra-specific
>> discussion)
>>
>> On 04/28/2014 11:39 AM, Russell King - ARM Linux wrote:
>>> On Mon, Apr 28, 2014 at 11:27:09AM -0600, Stephen Warren wrote:
>> ...
>>>> I do see one error in dmesg during boot, but it doesn't appear to
>>>> negatively affect operation in brief testing, and is present in
>>>> linux-next without this series anyway. Is this message a problem?
>>>>
>>>>> [    0.000000] L2C: platform modifies aux control register: 0x02080000 -> 0x3e480001
>>>>> [    0.000000] L2C: DT/platform modifies aux control register: 0x02080000 -> 0x3e480001
>>>>> [    0.000000] L2C-310 errata 727915 769419 enabled
>>>>> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
>>>>> [    0.000000] L2C-310: enabling full line of zeros but not enabled in Cortex-A9
>>>>                           ^^^^^^ this is logged at error level
>>>
>>> Correct, it's an error because on Tegra you explicitly set bit 0 in the
>>> auxiliary control register, which is pointless unless the feature is
>>> also enabled in the Cortex-A9 control register as well.
>>
>> Please forgive my almost complete lack of knowledge re: cache
>> controllers. Is the correct fix for this:
>>
>> a) To remove bit 0 from the aux_val passed to l2x0_of_init()
>>
>> b) To set some BIT(3) in the Cortex-A9 auxcr, so this feature is enabled
>> there too.
>>
>> And if (b), I assume that's something that the bootloader should be
>> doing, not the kernel?
> 
> See "Full line of zero write."
> 
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0246h/CJACBHHB.html#CJADBCJJ
> 
> which makes it (a).  The reverse steps are required when disabling the L2
> cache controller.

Do you say that simply because to make use of this feature, it also
needs to be enabled in the A9 but no code in the kernel is currently
doing that? Or, because enabling the feature stops the cache controller
from supporting strongly ordered writes?

It seems like the condition this error message detects is benign; the
cache controller is prepared to receive these transactions, but the A9
will never send them. Nothing can go wrong in this case, I believe,
although admittedly it's a pointless configuration.

Equally, given the required enable sequence in that document, won't this
error always get printed if BIT(0) is sent in aux_val; before the bit is
enabled in the cache controller, the associated bit in the A9 /should/
be disabled. It seems like the test in the kernel should simply check if
BIT(0) is set in aux_val and ignore the value in the A9 completely, if
you want to ban people from enabling this feature via aux_val. Or, are
there some platforms where something outside (before) the kernel enables
the feature in the A9 even before the kernel cache init code runs, and
you want to avoid printing the error in that case?

> If we decide that we encounter a platform which needs this feature
> disabled, the correct way to deal with that is to add a L2C-310

I assume /disabled/enabled/ there?

> specific property to DT, and not to try to crowbar it in via the L2C
> aux control register masks (which should never have been exposed to
> platforms using DT.)
