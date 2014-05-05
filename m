From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Mon, 05 May 2014 14:50:58 +0400
Subject: [PATCH] arm: put_user: fix possible data corruption in put_user
In-Reply-To: <20140505090126.GD3693@n2100.arm.linux.org.uk>
References: <1399270438-26181-1-git-send-email-a.ryabinin@samsung.com>
 <20140505090126.GD3693@n2100.arm.linux.org.uk>
Message-ID: <53676D12.9040300@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/14 13:01, Russell King - ARM Linux wrote:
> On Mon, May 05, 2014 at 10:13:58AM +0400, Andrey Ryabinin wrote:
>> According to arm procedure call standart r2 register is call-cloberred.
>> So after the result of x expression was put into r2 any following
>> function call in p may overwrite r2. To fix this, the result of p
>> expression must be saved to the temporary variable before the
>> assigment x expression to __r2.
> 
> This and the patch make no sense.  You talk about r2, but you're doing
> nothing with r2 in the patch.
> 

No, you didn't get it. I'll try to explain better.

Lets consider following example:

unsigned int __user *get_address(void);
...
	put_user(1, get_address());
...

Pay attention that in get_address function register r2  may be used.
In above example, without my patch, put_user macro will be expanded to the following code:

...
	register const unsigned int __r2 asm("r2") = (1);
	register const unsigned int __user *__p asm("r0") = (get_address());
...

At first we put value 1 into r2 register. After that get_address is called, and clobbers r2 register.
This means that after assignment to variable __p, register r2 may no longer contain a valid value - 1.

My patch put get_address calls befor the assignment of (x) to __r2.
With my patch, put_user macro will be expanded to the following code:

...
	const unsigned int __user *tmp_p = (get_address());
	register const unsigned int __r2 asm("r2") = (1);
	register const unsigned int __user *__p asm("r0") = tmp_p;
...

In this time get_address() call happens before loading 1 to r2, so it won't be corrupted.


Here is the full code of test, so anyone could check.

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/uaccess.h>

unsigned int x = 0;
unsigned int y = 0;

/* get_address returns address of x, and clobbers r2 register */
unsigned int __user *get_address(void)
{
	mm_segment_t oldfs;
	oldfs = get_fs();
	set_fs(get_ds());
	put_user(2, &y); /* this put_user call will put value 2 in register r2 */
	set_fs(oldfs);
	return &x;
}

static __init int test_init(void)
{
	mm_segment_t oldfs;
	oldfs = get_fs();
	set_fs(get_ds());
	put_user(1, get_address()); /* put 1 to x */
	set_fs(oldfs);

	printk("\nput_user_test: value %x\n\n", *get_address()); /* this will print "put_user_test: value 2" instead of "put_user_test: value 1"
	return 0;
}

module_init(test_init);
