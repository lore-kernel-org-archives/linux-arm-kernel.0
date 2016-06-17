From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 17 Jun 2016 18:25:02 +0100
Subject: [PATCH 6/6] arm64: trap userspace "dc cvau" cache operation on
 errata-affected core
In-Reply-To: <c5d47238-6391-8468-b9d7-6a28e82a3edc@arm.com>
References: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
 <1462812590-4494-7-git-send-email-andre.przywara@arm.com>
 <57602DF2.1040501@arm.com> <c5d47238-6391-8468-b9d7-6a28e82a3edc@arm.com>
Message-ID: <5764326E.1080702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/16 18:20, Andre Przywara wrote:
> Hi Suzuki,
>
> thanks for having a look!
>
> On 14/06/16 17:16, Suzuki K Poulose wrote:
>> On 09/05/16 17:49, Andre Przywara wrote:
>>> The ARM errata 819472, 826319, 827319 and 824069 for affected
>>> Cortex-A53 cores demand to promote "dc cvau" instructions to
>>> "dc civac". Since we allow userspace to also emit those instructions,
>>> we should make sure that "dc cvau" gets promoted there too.
>>> So lets grasp the nettle here and actually trap every userland cache
>>> maintenance instruction once we detect at least one affected core in
>>> the system.
            __user_cache_maint("dc civac", address, ret);
>>> +            break;
>>> +        case 10:        /* DC CVAC, gets promoted */
>>> +            __user_cache_maint("dc civac", address, ret);
>>> +            break;
>>> +        case 14:        /* DC CIVAC */
>>> +            __user_cache_maint("dc civac", address, ret);
>>> +            break;
>>> +        case 5:            /* IC IVAU */
>>> +            __user_cache_maint("ic ivau", address, ret);
>>> +            break;
>>> +        default:
>>> +            force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
>>> +            return;
>>> +        }
>>> +    } else {
>>> +        force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
>>> +        return;
>>
>> Correct me if I am wrong, I think we should handle DC ZVA and emulate
>> the same ?
>> Thats the only EL0 accessible instruction we don't handle above.
>
> Mmmh, but why should we care?
> 1) DC ZVA is not trapped by setting SCTLR.UCI - instead it has its own
> bit (SCTLR.DZE).

You are right. I was thinking that UCI traps all DC operations. It only
traps  DC CVAU, DC CIVAC, DC CVAC, and IC IVAU.






Cheers
Suzuki
