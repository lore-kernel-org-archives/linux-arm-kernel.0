From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Fri, 26 Jul 2013 09:28:52 -0700
Subject: [PATCH 0/1] ARM: atomic64: fix endian-ness in atomic.h
Message-ID: <1374856133-2939-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes atomic64_xxx functions endian-ness isussues as it was discussed on
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/185898.html
Patch itself follows in separate email. This cover letter describes what
testing has been done

Tested on pandaboard for both cases: LE and BE, CONFIG_GENERIC_ATOMIC64 was
forcefully disabled.

In BE case it was tested on top of Ben's other BE patches covered by 
(updates for be8  patch series).

The following tests passed:

1) CONFIG_ATOMIC64_SELFTEST

2) The following module produced identical output for both LE, BE, 
and GENERIC_ATOMIC64

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/atomic.h>


atomic64_t a = {0};

#define STEP 0x40000000

void atomic64_add_test1 (void)
{
    atomic64_add(STEP, &a);
}    

void test_atomic64_add(void)
{
    int i;

    printk("atomic64_add\n");

    atomic64_set(&a, 0);
    
    printk("a = 0x%llx (%lld)\n", a.counter, a.counter);

    for (i = 0; i < 10; i++) {
        atomic64_add_test1();
        printk("i = %2d: a = 0x%llx (%lld)\n", i, a.counter, a.counter);
    }
}

void atomic64_sub_test1 (void)
{
    atomic64_sub(STEP, &a);
}

void test_atomic64_sub(void)
{
    int i;

    printk("atomic64_sub\n");

    /* value of a is set by previos test */
    printk("a = 0x%llx (%lld)\n", a.counter, a.counter);

    for (i = 0; i < 20; i++) {
        atomic64_sub_test1();
        printk("i = %2d: a = 0x%llx (%lld)\n", i, a.counter, a.counter);
    }
}

u64 atomic64_add_return_test1 (void)
{
    return atomic64_add_return(STEP, &a);
}    

void test_atomic64_add_return(void)
{
    int i;
    u64 ret;

    printk("atomic64_add_return\n");

    atomic64_set(&a, 0);
    
    printk("a = 0x%llx (%lld)\n", a.counter, a.counter);

    for (i = 0; i < 10; i++) {
        ret = atomic64_add_return_test1();
        printk("i = %2d: a = 0x%llx (%lld), ret = %llx (%lld)\n",
               i, a.counter, a.counter, ret, ret);
    }
}

u64 atomic64_sub_return_test1 (void)
{
    return atomic64_sub_return(STEP, &a);
}

void test_atomic64_sub_return(void)
{
    int i;
    u64 ret;

    printk("atomic64_sub_return\n");

    /* value of a is set by previos test */
    printk("a = 0x%llx (%lld)\n", a.counter, a.counter);

    for (i = 0; i < 20; i++) {
        ret = atomic64_sub_return_test1();
        printk("i = %2d: a = 0x%llx (%lld), ret = %llx (%lld)\n",
               i, a.counter, a.counter, ret, ret);
    }
}

void atomic64_dec_if_positive_test1 (void)
{
    atomic64_dec_if_positive(&a);
}

void test1_atomic64_dec_if_positive (void)
{
    int i;    
    printk("atomic64_dec_if_positive test1\n");

    atomic64_set(&a, 0x100000003);    
    /* value of a is set by previos test */
    printk("a = 0x%llx (%lld)\n", a.counter, a.counter);

    for (i = 0; i < 10; i++) {
        atomic64_dec_if_positive_test1();
        printk("i = %2d: a = 0x%llx (%lld))\n",
               i, a.counter, a.counter);
    }
}

void test2_atomic64_dec_if_positive (void)
{
    int i;    
    printk("atomic64_dec_if_positive test2\n");

    atomic64_set(&a, 0x3);    
    /* value of a is set by previos test */
    printk("a = 0x%llx (%lld)\n", a.counter, a.counter);

    for (i = 0; i < 10; i++) {
        atomic64_dec_if_positive_test1();
        printk("i = %2d: a = 0x%llx (%lld))\n",
               i, a.counter, a.counter);
    }
}

void atomic64_add_unless_test1(long long u)
{
    atomic64_add_unless(&a, STEP, u);
}

void test_atomic64_add_unless(void)
{
    int i;
    u64 prev;
    
    printk("atomic64_add_unless\n");

    atomic64_set(&a, 0);
    
    printk("a = 0x%llx (%lld)\n", a.counter, a.counter);

    for (i = 0; i < 10; i++) {
        prev = a.counter;
        atomic64_add_unless_test1(prev);
        printk("i = %2d: no change: prev = 0x%llx (%lld), a = 0x%llx (%lld)\n", i,
               prev, prev, a.counter, a.counter);
        atomic64_add_unless_test1(prev - 1);
        printk("i = %2d: change: prev = 0x%llx (%lld), a = 0x%llx (%lld)\n", i,
               prev, prev, a.counter, a.counter);
    }
}


int
init_module (void)
{
    test_atomic64_add();
    test_atomic64_sub();

    test_atomic64_add_return();
    test_atomic64_sub_return();

    test1_atomic64_dec_if_positive();
    test2_atomic64_dec_if_positive();

    test_atomic64_add_unless();
    
    return 0;
}

void
cleanup_module(void)
{
}

MODULE_LICENSE("GPL");

Thanks,
Victor

Victor Kamensky (1):
  ARM: atomic64: fix endian-ness in atomic.h

 arch/arm/include/asm/atomic.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

-- 
1.8.1.4
