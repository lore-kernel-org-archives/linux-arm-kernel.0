From: koyo.take@gmail.com (Koyo Takenoshita)
Date: Tue, 19 Jan 2010 15:37:18 +0900
Subject: ioctl() returns EFAULT / MMU domain problem?
In-Reply-To: <ac4446ac1001182235m2efde18dl902c7ecc9fc6b100@mail.gmail.com>
References: <ac4446ac1001180535u299fa2f8rc2fdb3317a566066@mail.gmail.com>
	<20100118134723.GA2695@n2100.arm.linux.org.uk>
	<ac4446ac1001182235m2efde18dl902c7ecc9fc6b100@mail.gmail.com>
Message-ID: <ac4446ac1001182237j34e40dn7e472692feebfd11@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/1/19 Koyo Takenoshita <koyo.take@gmail.com>:
> 2010/1/18 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> On Mon, Jan 18, 2010 at 10:35:26PM +0900, Koyo Takenoshita wrote:
>>> I think that the problem is that there is a possibility of schedule
>>> while doing set_fs(KERNEL_DS) and copy_to_user.
>>
>> The domain register setting is stored in the per-thread cpu_domain
>> variable (current_thread_info()->cpu_domain). ?set_fs() modifies
>> this according to KERNEL_DS vs USER_DS.
> Yes,
>
> But, Neither current_thread_info()->cpu_domain nor CP15 domain register were
> matched in my case.
>
> The variables are
> current_thread_info()->addr_limit=0x0 ? ? ? (KERNEL_DS)
> current_thread_info()->cpu_domain=0x17 ?(DOMAIN_KERNEL is DOMAIN_MANAGER)
> CP15 domain register = 0x15 ? ? ? ? ? ? ? ? ? (DOMAIN_KERNEL is DOMAIN_CLIENT)
>
> It seems that "A" has been changed where i don't know.
typo
It seems that "domain register" has been changed where i don't know.

sorry for my poor english.

>
>> On context switches, the domain register is reloaded from cpu_domain,
>> so it will be preserved across context switches for the same thread;
>> if it wasn't, kernel boot wouldn't work (because the kernel boot uses
>> KERNEL_DS to be able to call execve(), open(), etc.)
> Would you please tell me where the context switch is done in kernel code?
> And, Is there any other point to change the domain register?
>
> regards,
> Koyo
>
