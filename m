From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Thu, 8 Oct 2015 23:32:43 +0900
Subject: [PATCH v4 1/2] arm64: Introduce IRQ stack
In-Reply-To: <20151008102520.GA10912@dhcppc13.redhat.com>
References: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
 <1444231692-32722-2-git-send-email-jungseoklee85@gmail.com>
 <20151008102520.GA10912@dhcppc13.redhat.com>
Message-ID: <66863807-964F-41D1-9788-D0FD8E79ADB6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 8, 2015, at 7:25 PM, Pratyush Anand wrote:
> Hi Jungseok,

Hi Pratyush,

> 
> On 07/10/2015:03:28:11 PM, Jungseok Lee wrote:
>> Currently, kernel context and interrupts are handled using a single
>> kernel stack navigated by sp_el1. This forces a system to use 16KB
>> stack, not 8KB one. This restriction makes low memory platforms suffer
>> from memory pressure accompanied by performance degradation.
> 
> How will it behave on 64K Page system? There, it would take atleast 64K per cpu,
> right?

It would take 16KB per cpu even on 64KB page system.
The following code snippet from kernel/fork.c would be helpful.

----8<----
# if THREAD_SIZE >= PAGE_SIZE                                                                  
static struct thread_info *alloc_thread_info_node(struct task_struct *tsk,                     
                                                  int node)                                    
{
        struct page *page = alloc_kmem_pages_node(node, THREADINFO_GFP,                        
                                                  THREAD_SIZE_ORDER);                          

        return page ? page_address(page) : NULL;                                               
}

static inline void free_thread_info(struct thread_info *ti)                                    
{
        free_kmem_pages((unsigned long)ti, THREAD_SIZE_ORDER);                                 
}
# else                                                                                         
static struct kmem_cache *thread_info_cache;                                                   

static struct thread_info *alloc_thread_info_node(struct task_struct *tsk,                     
                                                  int node)                                    
{
        return kmem_cache_alloc_node(thread_info_cache, THREADINFO_GFP, node);                 
}

static void free_thread_info(struct thread_info *ti)                                           
{
        kmem_cache_free(thread_info_cache, ti);                                                
}

void thread_info_cache_init(void)                                                              
{
        thread_info_cache = kmem_cache_create("thread_info", THREAD_SIZE,
                                              THREAD_SIZE, 0, NULL);
        BUG_ON(thread_info_cache == NULL);                                                     
}
# endif
----8<----

> 
>> +int alloc_irq_stack(unsigned int cpu)
>> +{
>> +	void *stack;
>> +
>> +	if (per_cpu(irq_stacks, cpu).stack)
>> +		return 0;
>> +
>> +	stack = (void *)__get_free_pages(THREADINFO_GFP, THREAD_SIZE_ORDER);
> 
> Above would not compile for 64K pages as THREAD_SIZE_ORDER is only defined for
> non 64K. This need to be fixed.

Thanks for pointing it out! I will update it.

Best Regards
Jungseok Lee
