From: lkp@intel.com (kbuild test robot)
Date: Fri, 27 Nov 2015 20:02:33 +0800
Subject: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in NMI
In-Reply-To: <1448622572-16900-2-git-send-email-pmladek@suse.com>
Message-ID: <201511271911.gmHRjeel%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Petr,

[auto build test ERROR on: powerpc/next]
[also build test ERROR on: v4.4-rc2 next-20151127]
[cannot apply to: tip/x86/core]

url:    https://github.com/0day-ci/linux/commits/Petr-Mladek/Cleaning-printk-stuff-in-NMI-context/20151127-191620
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: i386-randconfig-s1-201547 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/percpu.h:551:0,
                    from arch/x86/include/asm/current.h:5,
                    from arch/x86/include/asm/processor.h:15,
                    from arch/x86/include/asm/atomic.h:6,
                    from include/linux/atomic.h:4,
                    from include/linux/llist.h:58,
                    from include/linux/smp.h:14,
                    from kernel/printk/nmi.c:18:
   kernel/printk/printk.h: In function 'vprintk_func':
>> include/asm-generic/percpu.h:111:2: error: implicit declaration of function 'preempt_disable' [-Werror=implicit-function-declaration]
     preempt_disable();      \
     ^
>> include/asm-generic/percpu.h:305:31: note: in expansion of macro 'this_cpu_generic_read'
    #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                                  ^
>> include/linux/percpu-defs.h:311:23: note: in expansion of macro 'this_cpu_read_8'
     case 8: pscr_ret__ = stem##8(variable); break;   \
                          ^
>> include/linux/percpu-defs.h:494:29: note: in expansion of macro '__pcpu_size_call_return'
    #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                                ^
>> kernel/printk/printk.h:34:9: note: in expansion of macro 'this_cpu_read'
     return this_cpu_read(printk_func)(fmt, args);
            ^
>> include/asm-generic/percpu.h:113:2: error: implicit declaration of function 'preempt_enable' [-Werror=implicit-function-declaration]
     preempt_enable();      \
     ^
>> include/asm-generic/percpu.h:305:31: note: in expansion of macro 'this_cpu_generic_read'
    #define this_cpu_read_8(pcp)  this_cpu_generic_read(pcp)
                                  ^
>> include/linux/percpu-defs.h:311:23: note: in expansion of macro 'this_cpu_read_8'
     case 8: pscr_ret__ = stem##8(variable); break;   \
                          ^
>> include/linux/percpu-defs.h:494:29: note: in expansion of macro '__pcpu_size_call_return'
    #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_, pcp)
                                ^
>> kernel/printk/printk.h:34:9: note: in expansion of macro 'this_cpu_read'
     return this_cpu_read(printk_func)(fmt, args);
            ^
   kernel/printk/nmi.c: In function '__printk_nmi_flush':
>> kernel/printk/nmi.c:106:9: error: unknown type name 'raw_spinlock_t'
     static raw_spinlock_t read_lock =
            ^
>> kernel/printk/nmi.c:107:3: error: implicit declaration of function '__RAW_SPIN_LOCK_INITIALIZER' [-Werror=implicit-function-declaration]
      __RAW_SPIN_LOCK_INITIALIZER(read_lock);
      ^
>> kernel/printk/nmi.c:107:3: error: initializer element is not constant
>> kernel/printk/nmi.c:118:2: error: implicit declaration of function 'raw_spin_lock' [-Werror=implicit-function-declaration]
     raw_spin_lock(&read_lock);
     ^
>> kernel/printk/nmi.c:163:2: error: implicit declaration of function 'raw_spin_unlock' [-Werror=implicit-function-declaration]
     raw_spin_unlock(&read_lock);
     ^
   cc1: some warnings being treated as errors

vim +/preempt_disable +111 include/asm-generic/percpu.h

9c28278a24 Tejun Heo 2014-06-17  105  	(__ret);							\
9c28278a24 Tejun Heo 2014-06-17  106  })
9c28278a24 Tejun Heo 2014-06-17  107  
eba117889a Tejun Heo 2014-06-17  108  #define this_cpu_generic_read(pcp)					\
eba117889a Tejun Heo 2014-06-17  109  ({									\
eba117889a Tejun Heo 2014-06-17  110  	typeof(pcp) __ret;						\
9c28278a24 Tejun Heo 2014-06-17 @111  	preempt_disable();						\
eba117889a Tejun Heo 2014-06-17  112  	__ret = *this_cpu_ptr(&(pcp));					\
9c28278a24 Tejun Heo 2014-06-17 @113  	preempt_enable();						\
eba117889a Tejun Heo 2014-06-17  114  	__ret;								\
9c28278a24 Tejun Heo 2014-06-17  115  })
9c28278a24 Tejun Heo 2014-06-17  116  
eba117889a Tejun Heo 2014-06-17  117  #define this_cpu_generic_to_op(pcp, val, op)				\
9c28278a24 Tejun Heo 2014-06-17  118  do {									\
eba117889a Tejun Heo 2014-06-17  119  	unsigned long __flags;						\
eba117889a Tejun Heo 2014-06-17  120  	raw_local_irq_save(__flags);					\
9c28278a24 Tejun Heo 2014-06-17  121  	*raw_cpu_ptr(&(pcp)) op val;					\
eba117889a Tejun Heo 2014-06-17  122  	raw_local_irq_restore(__flags);					\
9c28278a24 Tejun Heo 2014-06-17  123  } while (0)
9c28278a24 Tejun Heo 2014-06-17  124  
eba117889a Tejun Heo 2014-06-17  125  #define this_cpu_generic_add_return(pcp, val)				\
9c28278a24 Tejun Heo 2014-06-17  126  ({									\
eba117889a Tejun Heo 2014-06-17  127  	typeof(pcp) __ret;						\
eba117889a Tejun Heo 2014-06-17  128  	unsigned long __flags;						\
eba117889a Tejun Heo 2014-06-17  129  	raw_local_irq_save(__flags);					\
9c28278a24 Tejun Heo 2014-06-17  130  	raw_cpu_add(pcp, val);						\
eba117889a Tejun Heo 2014-06-17  131  	__ret = raw_cpu_read(pcp);					\
eba117889a Tejun Heo 2014-06-17  132  	raw_local_irq_restore(__flags);					\
eba117889a Tejun Heo 2014-06-17  133  	__ret;								\
9c28278a24 Tejun Heo 2014-06-17  134  })
9c28278a24 Tejun Heo 2014-06-17  135  
eba117889a Tejun Heo 2014-06-17  136  #define this_cpu_generic_xchg(pcp, nval)				\
eba117889a Tejun Heo 2014-06-17  137  ({									\
eba117889a Tejun Heo 2014-06-17  138  	typeof(pcp) __ret;						\
eba117889a Tejun Heo 2014-06-17  139  	unsigned long __flags;						\
eba117889a Tejun Heo 2014-06-17  140  	raw_local_irq_save(__flags);					\
eba117889a Tejun Heo 2014-06-17  141  	__ret = raw_cpu_read(pcp);					\
9c28278a24 Tejun Heo 2014-06-17  142  	raw_cpu_write(pcp, nval);					\
eba117889a Tejun Heo 2014-06-17  143  	raw_local_irq_restore(__flags);					\
eba117889a Tejun Heo 2014-06-17  144  	__ret;								\
9c28278a24 Tejun Heo 2014-06-17  145  })
9c28278a24 Tejun Heo 2014-06-17  146  
eba117889a Tejun Heo 2014-06-17  147  #define this_cpu_generic_cmpxchg(pcp, oval, nval)			\
9c28278a24 Tejun Heo 2014-06-17  148  ({									\
eba117889a Tejun Heo 2014-06-17  149  	typeof(pcp) __ret;						\
eba117889a Tejun Heo 2014-06-17  150  	unsigned long __flags;						\
eba117889a Tejun Heo 2014-06-17  151  	raw_local_irq_save(__flags);					\
eba117889a Tejun Heo 2014-06-17  152  	__ret = raw_cpu_read(pcp);					\
eba117889a Tejun Heo 2014-06-17  153  	if (__ret == (oval))						\
9c28278a24 Tejun Heo 2014-06-17  154  		raw_cpu_write(pcp, nval);				\
eba117889a Tejun Heo 2014-06-17  155  	raw_local_irq_restore(__flags);					\
eba117889a Tejun Heo 2014-06-17  156  	__ret;								\
9c28278a24 Tejun Heo 2014-06-17  157  })
9c28278a24 Tejun Heo 2014-06-17  158  
eba117889a Tejun Heo 2014-06-17  159  #define this_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)	\
9c28278a24 Tejun Heo 2014-06-17  160  ({									\
eba117889a Tejun Heo 2014-06-17  161  	int __ret;							\
eba117889a Tejun Heo 2014-06-17  162  	unsigned long __flags;						\
eba117889a Tejun Heo 2014-06-17  163  	raw_local_irq_save(__flags);					\
eba117889a Tejun Heo 2014-06-17  164  	__ret = raw_cpu_generic_cmpxchg_double(pcp1, pcp2,		\
9c28278a24 Tejun Heo 2014-06-17  165  			oval1, oval2, nval1, nval2);			\
eba117889a Tejun Heo 2014-06-17  166  	raw_local_irq_restore(__flags);					\
eba117889a Tejun Heo 2014-06-17  167  	__ret;								\
9c28278a24 Tejun Heo 2014-06-17  168  })
9c28278a24 Tejun Heo 2014-06-17  169  
47b69ad673 Tejun Heo 2014-06-17  170  #ifndef raw_cpu_read_1
47b69ad673 Tejun Heo 2014-06-17  171  #define raw_cpu_read_1(pcp)		(*raw_cpu_ptr(&(pcp)))
47b69ad673 Tejun Heo 2014-06-17  172  #endif
47b69ad673 Tejun Heo 2014-06-17  173  #ifndef raw_cpu_read_2
47b69ad673 Tejun Heo 2014-06-17  174  #define raw_cpu_read_2(pcp)		(*raw_cpu_ptr(&(pcp)))
47b69ad673 Tejun Heo 2014-06-17  175  #endif
47b69ad673 Tejun Heo 2014-06-17  176  #ifndef raw_cpu_read_4
47b69ad673 Tejun Heo 2014-06-17  177  #define raw_cpu_read_4(pcp)		(*raw_cpu_ptr(&(pcp)))
47b69ad673 Tejun Heo 2014-06-17  178  #endif
47b69ad673 Tejun Heo 2014-06-17  179  #ifndef raw_cpu_read_8
47b69ad673 Tejun Heo 2014-06-17  180  #define raw_cpu_read_8(pcp)		(*raw_cpu_ptr(&(pcp)))
47b69ad673 Tejun Heo 2014-06-17  181  #endif
47b69ad673 Tejun Heo 2014-06-17  182  
47b69ad673 Tejun Heo 2014-06-17  183  #ifndef raw_cpu_write_1
eba117889a Tejun Heo 2014-06-17  184  #define raw_cpu_write_1(pcp, val)	raw_cpu_generic_to_op(pcp, val, =)
47b69ad673 Tejun Heo 2014-06-17  185  #endif
47b69ad673 Tejun Heo 2014-06-17  186  #ifndef raw_cpu_write_2
eba117889a Tejun Heo 2014-06-17  187  #define raw_cpu_write_2(pcp, val)	raw_cpu_generic_to_op(pcp, val, =)
47b69ad673 Tejun Heo 2014-06-17  188  #endif
47b69ad673 Tejun Heo 2014-06-17  189  #ifndef raw_cpu_write_4
eba117889a Tejun Heo 2014-06-17  190  #define raw_cpu_write_4(pcp, val)	raw_cpu_generic_to_op(pcp, val, =)
47b69ad673 Tejun Heo 2014-06-17  191  #endif
47b69ad673 Tejun Heo 2014-06-17  192  #ifndef raw_cpu_write_8
eba117889a Tejun Heo 2014-06-17  193  #define raw_cpu_write_8(pcp, val)	raw_cpu_generic_to_op(pcp, val, =)
47b69ad673 Tejun Heo 2014-06-17  194  #endif
47b69ad673 Tejun Heo 2014-06-17  195  
47b69ad673 Tejun Heo 2014-06-17  196  #ifndef raw_cpu_add_1
eba117889a Tejun Heo 2014-06-17  197  #define raw_cpu_add_1(pcp, val)		raw_cpu_generic_to_op(pcp, val, +=)
47b69ad673 Tejun Heo 2014-06-17  198  #endif
47b69ad673 Tejun Heo 2014-06-17  199  #ifndef raw_cpu_add_2
eba117889a Tejun Heo 2014-06-17  200  #define raw_cpu_add_2(pcp, val)		raw_cpu_generic_to_op(pcp, val, +=)
47b69ad673 Tejun Heo 2014-06-17  201  #endif
47b69ad673 Tejun Heo 2014-06-17  202  #ifndef raw_cpu_add_4
eba117889a Tejun Heo 2014-06-17  203  #define raw_cpu_add_4(pcp, val)		raw_cpu_generic_to_op(pcp, val, +=)
47b69ad673 Tejun Heo 2014-06-17  204  #endif
47b69ad673 Tejun Heo 2014-06-17  205  #ifndef raw_cpu_add_8
eba117889a Tejun Heo 2014-06-17  206  #define raw_cpu_add_8(pcp, val)		raw_cpu_generic_to_op(pcp, val, +=)
47b69ad673 Tejun Heo 2014-06-17  207  #endif
47b69ad673 Tejun Heo 2014-06-17  208  
47b69ad673 Tejun Heo 2014-06-17  209  #ifndef raw_cpu_and_1
eba117889a Tejun Heo 2014-06-17  210  #define raw_cpu_and_1(pcp, val)		raw_cpu_generic_to_op(pcp, val, &=)
47b69ad673 Tejun Heo 2014-06-17  211  #endif
47b69ad673 Tejun Heo 2014-06-17  212  #ifndef raw_cpu_and_2
eba117889a Tejun Heo 2014-06-17  213  #define raw_cpu_and_2(pcp, val)		raw_cpu_generic_to_op(pcp, val, &=)
47b69ad673 Tejun Heo 2014-06-17  214  #endif
47b69ad673 Tejun Heo 2014-06-17  215  #ifndef raw_cpu_and_4
eba117889a Tejun Heo 2014-06-17  216  #define raw_cpu_and_4(pcp, val)		raw_cpu_generic_to_op(pcp, val, &=)
47b69ad673 Tejun Heo 2014-06-17  217  #endif
47b69ad673 Tejun Heo 2014-06-17  218  #ifndef raw_cpu_and_8
eba117889a Tejun Heo 2014-06-17  219  #define raw_cpu_and_8(pcp, val)		raw_cpu_generic_to_op(pcp, val, &=)
47b69ad673 Tejun Heo 2014-06-17  220  #endif
47b69ad673 Tejun Heo 2014-06-17  221  
47b69ad673 Tejun Heo 2014-06-17  222  #ifndef raw_cpu_or_1
eba117889a Tejun Heo 2014-06-17  223  #define raw_cpu_or_1(pcp, val)		raw_cpu_generic_to_op(pcp, val, |=)
47b69ad673 Tejun Heo 2014-06-17  224  #endif
47b69ad673 Tejun Heo 2014-06-17  225  #ifndef raw_cpu_or_2
eba117889a Tejun Heo 2014-06-17  226  #define raw_cpu_or_2(pcp, val)		raw_cpu_generic_to_op(pcp, val, |=)
47b69ad673 Tejun Heo 2014-06-17  227  #endif
47b69ad673 Tejun Heo 2014-06-17  228  #ifndef raw_cpu_or_4
eba117889a Tejun Heo 2014-06-17  229  #define raw_cpu_or_4(pcp, val)		raw_cpu_generic_to_op(pcp, val, |=)
47b69ad673 Tejun Heo 2014-06-17  230  #endif
47b69ad673 Tejun Heo 2014-06-17  231  #ifndef raw_cpu_or_8
eba117889a Tejun Heo 2014-06-17  232  #define raw_cpu_or_8(pcp, val)		raw_cpu_generic_to_op(pcp, val, |=)
47b69ad673 Tejun Heo 2014-06-17  233  #endif
47b69ad673 Tejun Heo 2014-06-17  234  
47b69ad673 Tejun Heo 2014-06-17  235  #ifndef raw_cpu_add_return_1
47b69ad673 Tejun Heo 2014-06-17  236  #define raw_cpu_add_return_1(pcp, val)	raw_cpu_generic_add_return(pcp, val)
47b69ad673 Tejun Heo 2014-06-17  237  #endif
47b69ad673 Tejun Heo 2014-06-17  238  #ifndef raw_cpu_add_return_2
47b69ad673 Tejun Heo 2014-06-17  239  #define raw_cpu_add_return_2(pcp, val)	raw_cpu_generic_add_return(pcp, val)
47b69ad673 Tejun Heo 2014-06-17  240  #endif
47b69ad673 Tejun Heo 2014-06-17  241  #ifndef raw_cpu_add_return_4
47b69ad673 Tejun Heo 2014-06-17  242  #define raw_cpu_add_return_4(pcp, val)	raw_cpu_generic_add_return(pcp, val)
47b69ad673 Tejun Heo 2014-06-17  243  #endif
47b69ad673 Tejun Heo 2014-06-17  244  #ifndef raw_cpu_add_return_8
47b69ad673 Tejun Heo 2014-06-17  245  #define raw_cpu_add_return_8(pcp, val)	raw_cpu_generic_add_return(pcp, val)
47b69ad673 Tejun Heo 2014-06-17  246  #endif
47b69ad673 Tejun Heo 2014-06-17  247  
47b69ad673 Tejun Heo 2014-06-17  248  #ifndef raw_cpu_xchg_1
47b69ad673 Tejun Heo 2014-06-17  249  #define raw_cpu_xchg_1(pcp, nval)	raw_cpu_generic_xchg(pcp, nval)
47b69ad673 Tejun Heo 2014-06-17  250  #endif
47b69ad673 Tejun Heo 2014-06-17  251  #ifndef raw_cpu_xchg_2
47b69ad673 Tejun Heo 2014-06-17  252  #define raw_cpu_xchg_2(pcp, nval)	raw_cpu_generic_xchg(pcp, nval)
47b69ad673 Tejun Heo 2014-06-17  253  #endif
47b69ad673 Tejun Heo 2014-06-17  254  #ifndef raw_cpu_xchg_4
47b69ad673 Tejun Heo 2014-06-17  255  #define raw_cpu_xchg_4(pcp, nval)	raw_cpu_generic_xchg(pcp, nval)
47b69ad673 Tejun Heo 2014-06-17  256  #endif
47b69ad673 Tejun Heo 2014-06-17  257  #ifndef raw_cpu_xchg_8
47b69ad673 Tejun Heo 2014-06-17  258  #define raw_cpu_xchg_8(pcp, nval)	raw_cpu_generic_xchg(pcp, nval)
47b69ad673 Tejun Heo 2014-06-17  259  #endif
47b69ad673 Tejun Heo 2014-06-17  260  
47b69ad673 Tejun Heo 2014-06-17  261  #ifndef raw_cpu_cmpxchg_1
eba117889a Tejun Heo 2014-06-17  262  #define raw_cpu_cmpxchg_1(pcp, oval, nval) \
eba117889a Tejun Heo 2014-06-17  263  	raw_cpu_generic_cmpxchg(pcp, oval, nval)
47b69ad673 Tejun Heo 2014-06-17  264  #endif
47b69ad673 Tejun Heo 2014-06-17  265  #ifndef raw_cpu_cmpxchg_2
eba117889a Tejun Heo 2014-06-17  266  #define raw_cpu_cmpxchg_2(pcp, oval, nval) \
eba117889a Tejun Heo 2014-06-17  267  	raw_cpu_generic_cmpxchg(pcp, oval, nval)
47b69ad673 Tejun Heo 2014-06-17  268  #endif
47b69ad673 Tejun Heo 2014-06-17  269  #ifndef raw_cpu_cmpxchg_4
eba117889a Tejun Heo 2014-06-17  270  #define raw_cpu_cmpxchg_4(pcp, oval, nval) \
eba117889a Tejun Heo 2014-06-17  271  	raw_cpu_generic_cmpxchg(pcp, oval, nval)
47b69ad673 Tejun Heo 2014-06-17  272  #endif
47b69ad673 Tejun Heo 2014-06-17  273  #ifndef raw_cpu_cmpxchg_8
eba117889a Tejun Heo 2014-06-17  274  #define raw_cpu_cmpxchg_8(pcp, oval, nval) \
eba117889a Tejun Heo 2014-06-17  275  	raw_cpu_generic_cmpxchg(pcp, oval, nval)
47b69ad673 Tejun Heo 2014-06-17  276  #endif
47b69ad673 Tejun Heo 2014-06-17  277  
47b69ad673 Tejun Heo 2014-06-17  278  #ifndef raw_cpu_cmpxchg_double_1
47b69ad673 Tejun Heo 2014-06-17  279  #define raw_cpu_cmpxchg_double_1(pcp1, pcp2, oval1, oval2, nval1, nval2) \
47b69ad673 Tejun Heo 2014-06-17  280  	raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
47b69ad673 Tejun Heo 2014-06-17  281  #endif
47b69ad673 Tejun Heo 2014-06-17  282  #ifndef raw_cpu_cmpxchg_double_2
47b69ad673 Tejun Heo 2014-06-17  283  #define raw_cpu_cmpxchg_double_2(pcp1, pcp2, oval1, oval2, nval1, nval2) \
47b69ad673 Tejun Heo 2014-06-17  284  	raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
47b69ad673 Tejun Heo 2014-06-17  285  #endif
47b69ad673 Tejun Heo 2014-06-17  286  #ifndef raw_cpu_cmpxchg_double_4
47b69ad673 Tejun Heo 2014-06-17  287  #define raw_cpu_cmpxchg_double_4(pcp1, pcp2, oval1, oval2, nval1, nval2) \
47b69ad673 Tejun Heo 2014-06-17  288  	raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
47b69ad673 Tejun Heo 2014-06-17  289  #endif
47b69ad673 Tejun Heo 2014-06-17  290  #ifndef raw_cpu_cmpxchg_double_8
47b69ad673 Tejun Heo 2014-06-17  291  #define raw_cpu_cmpxchg_double_8(pcp1, pcp2, oval1, oval2, nval1, nval2) \
47b69ad673 Tejun Heo 2014-06-17  292  	raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
47b69ad673 Tejun Heo 2014-06-17  293  #endif
47b69ad673 Tejun Heo 2014-06-17  294  
47b69ad673 Tejun Heo 2014-06-17  295  #ifndef this_cpu_read_1
eba117889a Tejun Heo 2014-06-17  296  #define this_cpu_read_1(pcp)		this_cpu_generic_read(pcp)
47b69ad673 Tejun Heo 2014-06-17  297  #endif
47b69ad673 Tejun Heo 2014-06-17  298  #ifndef this_cpu_read_2
eba117889a Tejun Heo 2014-06-17  299  #define this_cpu_read_2(pcp)		this_cpu_generic_read(pcp)
47b69ad673 Tejun Heo 2014-06-17  300  #endif
47b69ad673 Tejun Heo 2014-06-17  301  #ifndef this_cpu_read_4
eba117889a Tejun Heo 2014-06-17  302  #define this_cpu_read_4(pcp)		this_cpu_generic_read(pcp)
47b69ad673 Tejun Heo 2014-06-17  303  #endif
47b69ad673 Tejun Heo 2014-06-17  304  #ifndef this_cpu_read_8
eba117889a Tejun Heo 2014-06-17 @305  #define this_cpu_read_8(pcp)		this_cpu_generic_read(pcp)
47b69ad673 Tejun Heo 2014-06-17  306  #endif
47b69ad673 Tejun Heo 2014-06-17  307  
47b69ad673 Tejun Heo 2014-06-17  308  #ifndef this_cpu_write_1

:::::: The code at line 111 was first introduced by commit
:::::: 9c28278a24c01c0073fb89e53c1d2a605ab9587d percpu: reorder macros in percpu header files

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Tejun Heo <tj@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22753 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151127/4f94f47a/attachment-0001.obj>
