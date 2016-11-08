From: labath@google.com (Pavel Labath)
Date: Tue, 8 Nov 2016 11:58:53 +0000
Subject: [PATCH V2 3/5] arm64: hw_breakpoint: Handle inexact watchpoint
 addresses
In-Reply-To: <20161108032941.GC20591@arm.com>
References: <cover.1476941895.git.panand@redhat.com>
 <22f4d20911e39efa0b8a6f7082d6839b80bb16b0.1476941895.git.panand@redhat.com>
 <20161108032941.GC20591@arm.com>
Message-ID: <CAJt8pk9tH5nm5sUsKx-dAvW4uzKP+EoRumhYV1mXsU_mk6dRDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>>               /* Do we need to handle the stepping? */
>>               if (is_default_overflow_handler(wp))
>>                       step = 1;
>> -
>> -unlock:
>> -             rcu_read_unlock();
>>       }
>> +     if (min_dist > 0 && min_dist != -1) {
>> +             /* No exact match found. */
>> +             wp = slots[closest_match];
>> +             info = counter_arch_bp(wp);
>> +             info->trigger = addr;
>> +             perf_bp_event(wp, regs);
>> +     }
>
> Why don't we need to bother with the stepping in the case of a non-exact
> match?

Good catch. I think we do. I must have dropped that part somehow.

Pratyush, could you include the attached fixup in the next batch?

regards,
pavel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fixup.diff
Type: text/x-patch
Size: 493 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161108/b4638fbe/attachment.bin>
