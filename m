From: b32955@freescale.com (Huang Shijie)
Date: Sun, 1 Apr 2012 16:16:08 +0800
Subject: Bug in v7_coherent_kern_range() ?
In-Reply-To: <4F780B65.7020904@googlemail.com>
References: <4F77C9A6.6080601@freescale.com> <4F77F13D.7000402@googlemail.com>
 <4F77FF24.5010809@freescale.com> <4F780B65.7020904@googlemail.com>
Message-ID: <4F780EC8.1090303@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk:
> Hi Huang Shijie,
>
> On 01.04.2012 09:09, Huang Shijie wrote:
>> Hi Dirk:
>>> Hi Huang Shijie,
>>>
>>> On 01.04.2012 05:21, Huang Shijie wrote:
>>>> [1] Platform:
>>>> freescale's IMX6Q(4 cores) , ARM CORTEX-A9
>>>>
>>>> [2] kernel:
>>>> 3.0.15(I have cherry-picked many patches, and the
>>>> arch/arm/mm/cache-v7.S
>>>> is same code with the latest kernel v3.4-rc1)
>>>> enable SMP, VIPT,
>>>
>>> Could you try an unpatched, clean v3.4-rc1 instead?
>> Sorry, I could not try the v3.4-rc1. Some our bsp drivers are not DT
>> supported.
>
> I think we are not talking about drivers, we are talking about some 
> kernel core code, like cache handling? To test 
> v7_coherent_kern_range() you might not need to many bsp drivers?
Yes , the gplay will use the vpu driver. But the VPU driver is not in 
the kernel. Without the vpu driver, the gplay can not works.
>
>>> What's about your 2.6.38?
>> 2.6.38 is not a good version to run the imx6q. It losts many our
>> drivers's patches.
>>>
>>> What's about 3.0.26? 3.0.15 seems to miss some maybe relevant patches.
>>>
>> Our bsp release are based on 3.0.15. so we could not test it on 3.0.26
>> too.
>
> You can. Just give git rebase a try.
It will be a nightmare to me.  We have nearly 1000 patches. I will cost 
me much time to handle the conflicts.

>
>>>> [3] application:
>>>
>>> Could you share a (simple) test case?
>> The test case is like this:
>> #gplay xx.avi
>>
>> gplay is our own player, such as mplayer.
>
> Could you share a (simple) test case? E.g. share 'gplay'? Or try to 
> reproduce your issue with an other test case? E.g. mplayer? Or better 
> anything simpler the community can use to try to reproduce your issue?
I can email to you the gplay, if you have an imx6q board. you can test it.
I just wish someone give me some advice about this issue.

I find the arch/arm/include/asm/assembler.h is out of date. So I will 
update it and test it again.

thanks a lot , Dirk.

Huang Shijie
>
> Best regards
>
> Dirk
>
>> I just created a script which will play the video files one by one.
>>
>> BR
>> Huang Shijie
>>
>>>
>>> Best regards
>>>
>>> Dirk
>>>
>>>> I use our our application which will clone many threads,
>>>> two threads (assume as A and B) may do the same thing at the same time
>>>> as the following code:
>>>>
>>>> In most of the time, it's ok.
>>>> But in some unknown situation, cacheflush() failed and one threads
>>>> (assume A) may hung up in the following code:
>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
>>>>
>>>>
>>>>
>>>> open("/usr/lib/lib_mp3_dec_arm12_elinux.so.2.10.0", O_RDONLY) = 8
>>>> read(8,
>>>> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\20\35\0\0004\0\0\0"..., 
>>>>
>>>>
>>>> 512) = 512
>>>> fstat64(8, {st_mode=S_IFREG|0644, st_size=56232, ...}) = 0
>>>> mmap2(NULL, 88032, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
>>>> 8, 0)
>>>> = 0x2ff0a000
>>>> mprotect(0x2ff18000, 28672, PROT_NONE) = 0
>>>> mmap2(0x2ff1f000, 4096, PROT_READ|PROT_WRITE,
>>>> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 8, 0xd) = 0x2ff1f000
>>>> close(8) = 0
>>>> mprotect(0x2ff0a000, 57344, PROT_READ|PROT_WRITE) = 0
>>>> mprotect(0x2ff0a000, 57344, PROT_READ|PROT_EXEC) = 0
>>>> cacheflush(0x2ff0a000, 0x2ff18000, 0, 0x6, 0x2cd03420) = 0 // System
>>>> hung up here!!!
>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
>>>>
>>>>
>>>>
>>>>
>>>> [4] kernel log
>>>> I use "echo t> /proc/sysrq-trigger" to show the tasks's information:
>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
>>>>
>>>>
>>>>
>>>> multiqueue0:src D 804cd678 0 7328 5963 0x00000001
>>>> [<804cd678>] (__schedule+0x228/0x760) from [<804d0564>]
>>>> (__down_read+0xa8/0xe0)
>>>> [<804d0564>] (__down_read+0xa8/0xe0) from [<800478c4>]
>>>> (do_page_fault+0xbc/0x480)
>>>> [<800478c4>] (do_page_fault+0xbc/0x480) from [<8003841c>]
>>>> (do_DataAbort+0x34/0x98)
>>>> [<8003841c>] (do_DataAbort+0x34/0x98) from [<8003df10>]
>>>> (__dabt_svc+0x70/0xa0)
>>>> Exception stack(0xbae37ea8 to 0xbae37ef0)
>>>> 7ea0: 31e05000 31e1d000 00000020 0000001f 31e05000 31e1d000
>>>> 7ec0: bfac86b8 31e05000 31e1d000 bae36000 08100075 31e056fc 31e08000
>>>> bae37ef0
>>>> 7ee0: 800424a8 8004a1fc 800f0013 ffffffff
>>>> [<8003df10>] (__dabt_svc+0x70/0xa0) from [<8004a1fc>]
>>>> (v7_coherent_kern_range+0x20/0x80)
>>>> [<8004a1fc>] (v7_coherent_kern_range+0x20/0x80) from [<800424a8>]
>>>> (arm_syscall+0x2a0/0x2c4)
>>>> [<800424a8>] (arm_syscall+0x2a0/0x2c4) from [<8003e500>]
>>>> (ret_fast_syscall+0x0/0x3c)
>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
>>>>
>>>>
>>>>
>>>>
>>>> The do_cache_op() has already held the mm->mmap_sem, but
>>>> v7_coherent_kern_range()
>>>> cause one page fault during it flush the cache. deadlock! So it
>>>> hung up
>>>> in the do_page_fault().
>>>>
>>>> [5] questions:
>>>> Why the v7_coherent_kern_range() can caused the data abort?
>>>> Is there something wrong about the v7_coherent_kern_range()?
>>>>
>>>>
>>>> thanks
>>>> Huang Shijie
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel at lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>>
>>>
>>
>>
>>
>
>
