From: james.morse@arm.com (James Morse)
Date: Wed, 15 Feb 2017 12:09:48 +0000
Subject: <Query> Looking more details and reasons for using orig_add_limit.
In-Reply-To: <def87360266193184dc013a055ec3869@codeaurora.org>
References: <def87360266193184dc013a055ec3869@codeaurora.org>
Message-ID: <58A4450C.3040602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prasad,

On 15/02/17 05:52, Sodagudi Prasad wrote:
> When any sys call is made from user space orig_addr_limit will be zero and after
> that driver is calling set_fs(KERNEL_DS) and  then copy_to_user() to user space
> memory. 

Don't do this, its exactly the case PAN+UAO and the code you pointed to are
designed to catch. Accessing userspace needs doing carefully, setting USER_DS
and using the put_user()/copy_to_user() accessors are the required steps.

Which driver is doing this? Is it in mainline?


> If there is permission fault for user space address the above condition
> is leading to kernel crash. Because orig_add_limit is having KERNEL_DS as set_fs
> called before copy_to_user().
> 
> 1)    So I would like to understand that,  is that user space pointer leading to
> permission fault not correct(condition_1) in this scenario?

The correct thing has happened here. To access user space set_fs(USER_DS) first.
(and set it back to whatever it was afterwards).


> 2)    Are there any corner cases where these if conditions (condition_1 and
> condition2) would lead to kernel crash ?

If you do this on behalf of a user space process the kernel will try to clean up
as best it can and carry on. If you access user space from an interrupt handler
or from a kernel thread you can expect the kernel to panic().


> 3)    What are all scenarios these if conditions (condition_1 and condition2) 
> would like to take care?

I'm not sure I understand this question. PAN prevents general kernel code from
accessing user space, you have to use the accessors. When you have UAO too, it
can enforce the set_fs() limit as PAN will generate permission faults when the
accessors touch the kernel/user-space after setting the other set_fs() limit.

I hope this helps!


Thanks,

James
