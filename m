From: john.garry@huawei.com (John Garry)
Date: Fri, 2 Nov 2018 10:10:48 +0000
Subject: Crash report: Broken NUMA distance map causes crash on arm64
 system
In-Reply-To: <20181102093904.GJ3178@hirez.programming.kicks-ass.net>
References: <b89bf686-05bd-a3de-e7ef-4ab9ab7bdb6c@huawei.com>
 <20181030092640.GE1459@hirez.programming.kicks-ass.net>
 <d126099d-2698-8e3a-06ca-f229e57c3052@huawei.com>
 <ae352fe1-3c59-dcde-fd00-2c03b4491dc6@huawei.com>
 <20181031204622.GB3141@hirez.programming.kicks-ass.net>
 <bf2b890a-4ce7-d0f6-0663-84a1a6e8dbd2@huawei.com>
 <20181102093904.GJ3178@hirez.programming.kicks-ass.net>
Message-ID: <d6d7485a-a7c9-5327-fb47-f279d260ec44@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> static void free_sched_groups(struct sched_group *sg, int free_sgc)
>> {
>> ...
>>     do {
>>         tmp = sg->next;
>>
>>         if (free_sgc && atomic_dec_and_test(&sg->sgc->ref))***
>>             kfree(sg->sgc);
>>
>> ...
>> }
>>
>> *** crash occurs when free_sgc is non-zero and sg->sgc is NULL
>
> Yeah, turns out to be random memory corruption; I've had the crash in a
> number of weird places; also GCC version dependent.
>
> KASAN is awesome and pinpointed the problem though.
>
>> And, as I mentioned earlier, I bisected this problem to 58d5af59d55b.
>
> You mean:
>
>   051f3ca02e46 ("sched/topology: Introduce NUMA identity node sched domain")
>
> right? and yes indeed! The below fixes my reproducer:
>

Yes, that's the one.

>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9d74371e4aad..039578429c25 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1337,7 +1348,7 @@ void sched_init_numa(void)
>  	int level = 0;
>  	int i, j, k;
>
> -	sched_domains_numa_distance = kzalloc(sizeof(int) * nr_node_ids, GFP_KERNEL);
> +	sched_domains_numa_distance = kzalloc(sizeof(int) * (nr_node_ids + 1), GFP_KERNEL);

Good find.

>  	if (!sched_domains_numa_distance)
>  		return;
>
>

So what about this:
 >>> I also note that if I apply the patch, below, to reject the invalid 
NUMA
 >>> distance, we're still getting a warning/error:
 >>>
 >>> [    7.144407] CPU: All CPU(s) started at EL2
 >>> [    7.148678] alternatives: patching kernel code
 >>> [    7.153557] ERROR: Node-0 not representative
 >>> [    7.153557]
 >>> [    7.159365]   10 15 20 25
 >>> [    7.162097]   15 10 25 30
 >>> [    7.164832]   20 25 10 15
 >>> [    7.167562]   25 30 15 10
 >>
 >> Yeah, that's an 'obviously' broken topology too.
 >>
 >
 > AFAICT, this conforms to ACPI spec SLIT rules, and the kernel SLIT
 > validation allows this also. So maybe we should shout louder here or
 > even mark the SLIT as invalid if totally broken.
 >

I plan to fix up OF map parsing to reject invalid distance maps.

However is this distance map so broken for the scheduler that it's 
better to reject this "valid" distance map also? If not, it may be nice 
for the user to know about it without having to enable scheduler debugging.

Thanks,
John
