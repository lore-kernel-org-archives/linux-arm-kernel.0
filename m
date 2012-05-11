From: bill4carson@gmail.com (bill4carson)
Date: Fri, 11 May 2012 17:53:07 +0800
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <20120511085150.GA17453@mudshark.cambridge.arm.com>
References: <4FAA34A9.5020708@gmail.com>
 <20120511085150.GA17453@mudshark.cambridge.arm.com>
Message-ID: <4FACE183.4080405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?05?11? 16:51, Will Deacon wrote:
> Bill,
>
> On Wed, May 09, 2012 at 10:11:05AM +0100, bill4carson wrote:
>> I'm using ARM11 MPCore on linux-2.6.34, unfortunately I have random
>> panic/segment fault with task migration. I noticed a patch set
>> [ARM11 MPCore: preemption/task migration cache coherency fixups] to fix
>> such issues in here:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-October/069851.html
>>
>> It seems there is no follow ups, is there official patch to fix such
>> issues?
>
> Let's be honest: you haven't given us a lot to go on here. Perhaps you could
> answer the following?
>

Hi, Will

First thanks for your reply.


> (1) Do you experience the same issues with a more recent kernel?

This ARM11MPcore based SOC is not merged into mainline kernel, to make
things worse, we do not any other ARM11MPcore based SOC to verify
whether this issue is bsp related or generic ARM core code issue.


> (2) If you apply the patches linked to above, does it fix your problem?
Yes, We apply the v4 patch set after some minor fix followed in the
discussion. This problem still exits.

> (3) If you can reproduce on current mainline, do you have a testcase?
We are trying to contact with the vendor to verify this, it's a bit
of slow, so I send this noisy query to mail list with a hope to find
a way for this issue.

> (4) Does disabling CONFIG_PREEMPT make the problem disappear?

Yes, the problem still exits.

For now, I can only forward some error message.

Procedures:

# cat /opt/test_yaffs1.sh
#!/bin/sh

for i in `seq $1`
do
  	sync
  	echo 3>  /proc/sys/vm/drop_caches
  	cat /cat >/dev/null&
	cat /wrsv-lttctl >/dev/null&
  	cat /wrsv-lttd >/dev/null&
	cat /busybox >/dev/null&
  	wait
  	echo debug ---"$i"---
done

# echo 0>  /proc/sys/kernel/sched_migration_cost
# /opt/test_yaffs1.sh 10000


Some different Errors:

*** glibc detected *** cat: munmap_chunk(): invalid pointer: 0xbeaa0f13 ***
 >
 > [10870.314465] Unhandled fault: alignment exception (0x821) at 0xebfffee6
 > [10870.315347] Unhandled fault: alignment exception (0x821) at 0xebfffee6
 > [10870.354917] Unhandled fault: alignment exception (0x821) at 0xebfffee6
------------------------------------------------------------------------

[13758.255564] Alignment trap: not handling instruction e1a00001 at
 > [<00033e38>]
 > [13758.256459] Alignment trap: not handling instruction e1a00001 at
 > [<00033e38>]
 > [13758.256522] Unhandled fault: alignment exception (0x811) at 0x0019f1aa
 > [13758.319272] Alignment trap: not handling instruction e1a00001 at
 > [<00033e38>]
 > [13758.340860] Unhandled fault: alignment exception (0x811) at 0x0019f1aa
 > [13758.361612] Unhandled fault: alignment exception (0x811) at 0x0019f1aa




When disable migration by:

echo -1 >  /proc/sys/kernel/sched_migration_cost

All errors message gone.


-------------------------------------------------------



>
> That should provide us with some information about the problem.
>




> Thanks,
>
> Will
>

-- 
Love each day!

--bill
