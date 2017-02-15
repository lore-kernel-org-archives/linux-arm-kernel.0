From: psodagud@codeaurora.org (Sodagudi Prasad)
Date: Wed, 15 Feb 2017 13:12:05 -0800
Subject: <Query> Looking more details and reasons for using orig_add_limit.
In-Reply-To: <58A4450C.3040602@arm.com>
References: <def87360266193184dc013a055ec3869@codeaurora.org>
 <58A4450C.3040602@arm.com>
Message-ID: <7c727e6043e58077d143e35de0ce632c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James and Will,

Thanks James and Will for providing detailed information.
On 2017-02-15 04:09, James Morse wrote:
> Hi Prasad,
> 
> On 15/02/17 05:52, Sodagudi Prasad wrote:
>> When any sys call is made from user space orig_addr_limit will be zero 
>> and after
>> that driver is calling set_fs(KERNEL_DS) and  then copy_to_user() to 
>> user space
>> memory.
> 
> Don't do this, its exactly the case PAN+UAO and the code you pointed to 
> are
> designed to catch. Accessing userspace needs doing carefully, setting 
> USER_DS
> and using the put_user()/copy_to_user() accessors are the required 
> steps.
> 
> Which driver is doing this? Is it in mainline?

Yes. It is mainline driver - 
drivers/media/v4l2-core/v4l2-compat-ioctl32.c
Currently working on a platform which is ARMv8 based, so disabled 
ARMv8.1
and ARMv8.2 features (ARM64_PAN, ARM64_HW_AFDBM, LSE_ATOMICS and  
ARM64_UAO)
on lsk-v4.4-16.09. In some v4l2 use-case kernel panic is observed. Below 
part
of the code has set_fs to KERNEL_DS before calling native_ioctl().

static long do_video_ioctl(struct file *file, unsigned int cmd, unsigned 
long arg)
{
?
?
         if (compatible_arg)
                 err = native_ioctl(file, cmd, (unsigned long)up);
         else {
                 mm_segment_t old_fs = get_fs();

                 set_fs(KERNEL_DS);   ====> KERNEL_DS.
                 err = native_ioctl(file, cmd, (unsigned long)&karg);
                 set_fs(old_fs);
         }

Here is the call stack which is resulting crash, because user space 
memory has
read only permissions.
[27249.920041] [<ffffff8008357890>] __arch_copy_to_user+0x110/0x180
[27249.920047] [<ffffff8008847c98>] video_ioctl2+0x38/0x44
[27249.920054] [<ffffff8008840968>] v4l2_ioctl+0x78/0xb4
[27249.920059] [<ffffff80088542d8>] do_video_ioctl+0x91c/0x1160
[27249.920064] [<ffffff8008854b7c>] v4l2_compat_ioctl32+0x60/0xcc
[27249.920071] [<ffffff800822553c>] compat_SyS_ioctl+0x124/0xd88
[27249.920077] [<ffffff8008084e30>] el0_svc_naked+0x24/0x2

> 
> 
>> If there is permission fault for user space address the above 
>> condition
>> is leading to kernel crash. Because orig_add_limit is having KERNEL_DS 
>> as set_fs
>> called before copy_to_user().
>> 
>> 1)    So I would like to understand that,  is that user space pointer 
>> leading to
>> permission fault not correct(condition_1) in this scenario?
> 
> The correct thing has happened here. To access user space 
> set_fs(USER_DS) first.
> (and set it back to whatever it was afterwards).
> 

So, Any clean up needed to above call path similar to what was done in 
the below commit?
commit a7f61e89af73e9bf760826b20dba4e637221fcb9 - compat_ioctl: don't 
call do_ioctl under set_fs(KERNEL_DS)

> 
>> 2)    Are there any corner cases where these if conditions 
>> (condition_1 and
>> condition_2) would lead to kernel crash ?
> 
> If you do this on behalf of a user space process the kernel will try to 
> clean up
> as best it can and carry on. If you access user space from an interrupt 
> handler
> or from a kernel thread you can expect the kernel to panic().
> 
> 
>> 3)    What are all scenarios these if conditions (condition_1 and 
>> condition_2)
>> would like to take care?
> 
> I'm not sure I understand this question. PAN prevents general kernel 
> code from
> accessing user space, you have to use the accessors. When you have UAO 
> too, it
> can enforce the set_fs() limit as PAN will generate permission faults 
> when the
> accessors touch the kernel/user-space after setting the other set_fs() 
> limit.
> 
> I hope this helps!
> 
> 
> Thanks,
> 
> James

-Thanks,
Prasad
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
