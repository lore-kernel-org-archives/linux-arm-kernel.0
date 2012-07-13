From: kangshan0910@gmail.com (shan kang)
Date: Fri, 13 Jul 2012 17:10:52 +0800
Subject: ARM: why smp_mb() is not needed in the "__mutex_fastpath_lock"
 and "__mutex_fastpath_unlock" functions
In-Reply-To: <CAFNq8R6dNb0BrDVZScJ8s=P3B-OMgtr8tUdy8XqQcCAeUWuH+A@mail.gmail.com>
References: <CAK2TD5ygowdy9t1TpfxAPbpvNQfMnMB-3Zp8TKMsTYtBZdGW=Q@mail.gmail.com>
 <CAFNq8R6dNb0BrDVZScJ8s=P3B-OMgtr8tUdy8XqQcCAeUWuH+A@mail.gmail.com>
Message-ID: <CAK2TD5z2DticZAQ-Pxzo7YT9tx=YWZkwcn-YZJ3aQa4AFoE_Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For example, in the following scenario, Process2  may get the wrong value;
Process1:
mutex_lock(&lock);
write data; (store operation)
mutex_unlock(&lock);

Process2:
mutex_lock(&lock);
read data; (load operation)
mutex_unlock(&lock);

Suppose Process1 gets the lock first, write data and unlock. If the
store operation completes very slowly, the load operation of the
Process2 will fail to get the new value.
Since there are no dmb instructions in the mutex_lock and
mutex_unlock, which doesn't make sure that after Process2 gets the
lock, the result of the Process1's store operation will be seen by the
Process2.



2012/7/13 Li Haifeng <omycle@gmail.com>:
> Hi Shan,
>
> 2012/7/12 shan kang <kangshan0910@gmail.com>:
>> Hello,
>>    I wonder why smp_mb() is not needed in the "__mutex_fastpath_lock"
>> and "__mutex_fastpath_unlock" functions which are located in the
>> "arch/arm/include/asm/mutex.h"?
>>    I think "dmb" instruction is necessary there.
>
> Why necessary? Could you explain more detailed?
>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
