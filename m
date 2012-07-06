From: omycle@gmail.com (Li Haifeng)
Date: Sat, 7 Jul 2012 07:36:39 +0800
Subject: Fwd: before arm Linux 2.6.38, how to protect the kernel memory
 from accessing in user space?
In-Reply-To: <20120704104402.GL16319@n2100.arm.linux.org.uk>
References: <CAFNq8R6cxPgADH=oOxkyenx4ADEPs+dapzj5mDrVftya3yBj3A@mail.gmail.com>
 <CAFNq8R5qSRh0iEo1en_p8g+z9jgELyOOLPxs7rp-6ZV7OE1Cog@mail.gmail.com>
 <20120704104402.GL16319@n2100.arm.linux.org.uk>
Message-ID: <CAFNq8R4bmdfVq6kJV96FVfpobPAiiDcKS0Aj4gZz2Xev7Sg0Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you.

I have got the answer too.

Before 2.6.38, the access permission management is still rely on
domain and AP field in Page table entry and Domain access control
register. The start-up code initialize the DOMAIN_USER by
DOMAIN_MANAGER. But in early_trap_init, the system will modify
DOMAIN_USER to DOMAIN_CLIENT. And when the domain attribute is
DOMAIN_CLIENT, the AP field in Page table entry will be effective.

2012/7/4 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Jul 04, 2012 at 02:01:25PM +0800, Li Haifeng wrote:
>> Hi, I am a newbie Linux Kernel learner. I am confused  at memory
>> protected between user space and kernel space.  In arm, the hardware
>> support the memory protecting by Domain access register.
>>
>> But in Linux, it may not take effect in ARM Linux. Because before the
>> official kernel 2.6.38, I found that both DOMAIN_USER and
>> DOMAIN_KERNEL all set to DOMAIN_MANAGER(0x3). So, before arm Linux
>> 2.6.38, how to protect the kernel memory from accessing in user space?
>
> That doesn't sound right.
>
> When we start booting, then the domain register will be set as that.
> However, when we exec the first user thread (or indeed any user thread),
> the user domain will be set to client mode (see the set_fs(USER_DS) in
> fs/exec.c).

More accurately, in early_init_trap, the modify action will be done too ^_^.
