From: mohan_gg@yahoo.com (Mohan G)
Date: Mon, 20 Apr 2015 10:39:35 +0000 (UTC)
Subject: kvm vs host (arm64)
In-Reply-To: <5534C25E.7070702@arm.com>
References: <5534C25E.7070702@arm.com>
Message-ID: <865655860.251789.1429526375276.JavaMail.yahoo@mail.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for looking into this Marc. 
Its the xgene  storm based SOC. for profiling , we used the ftrace tool. The support for ftrace is present from 3.16 
onwards. Its the main line kernel that we have installed. The main purpose of running this BM is for 
I/O. 
We initially saw these numbers with DD. The DD numbers too reflect the same. 

We even tried netperf, just to remove i/o path from perf results. Here too the results are same. 
Have pasted the perf stat below too 

guest stat 
========== 

directlocalhost:~]# perf stat dd if=/dev/zero of=/dev/sdc bs=8192 count=1 oflag= 
1+0 records in 
1+0 records out 
8192 bytes (8.2 kB) copied, 0.0132908 s, 616 kB/s 

Performance counter stats for 'dd if=/dev/zero of=/dev/sdc bs=8192 count=1 oflag=direct': 

110.474128 task-clock (msec) # 0.848 CPUs utilized 
1 context-switches # 0.009 K/sec 
0 cpu-migrations # 0.000 K/sec 
174 page-faults # 0.002 M/sec 
<not supported> cycles 
<not supported> stalled-cycles-frontend 
<not supported> stalled-cycles-backend 
<not supported> instructions 
<not supported> branches 
<not supported> branch-misses 

0.130255744 seconds time elapsed 



host 
===== 
root at mustang1:/home/gmohan# perf stat dd if=/dev/zero of=/dev/sda6 bs=8192 count=1 oflag=direct 
1+0 records in 
1+0 records out 
8192 bytes (8.2 kB) copied, 0.00087308 s, 9.4 MB/s 

Performance counter stats for 'dd if=/dev/zero of=/dev/sda6 bs=8192 count=1 oflag=direct': 

1.024280 task-clock (msec) # 0.525 CPUs utilized 
9 context-switches # 0.009 M/sec 
0 cpu-migrations # 0.000 K/sec 
198 page-faults # 0.193 M/sec 
24,17,939 cycles # 2.361 GHz 
<not supported> stalled-cycles-frontend 
<not supported> stalled-cycles-backend 
8,30,511 instructions # 0.34 insns per cycle 
<not supported> branches 
17,198 branch-misses # 0.00% of all branches 

0.001949620 seconds time elapsed 



Regards
Mohan


----- Original Message -----
From: Marc Zyngier <marc.zyngier@arm.com>
To: Mohan G <mohan_gg@yahoo.com>; "linux-arm-kernel at lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: 
Sent: Monday, April 20, 2015 2:39 PM
Subject: Re: kvm vs host (arm64)

On 20/04/15 06:45, Mohan G wrote:
> Hi, 
> I have got hold of few mustang boards (cortex-a57). Ran a few bench

Mustang is *not* based on Cortex-A57. So which hardware do you have?

> marks to measure perf numbers b/w host and guest (kvm). The numbers 
> are pretty bad. (drop of about 90% to that of host). I even tried
> running this simple program .
> 
> main(){ 
> int i=0; 
> 
> for(i=0;i<10;i++); 
> } 
> Profiling the above shows that same kernel functions in guest takes
> almost 10x to that of host. sample below
>
> 
> Host 
> ==== 
> 7202              one-3920  [003] 20015.611563: funcgraph_entry:                   |              find_vma() { 
> 7203              one-3920  [003] 20015.611564: funcgraph_entry:        0.180 us   |                vmacache_find(); 
> 7204              one-3920  [003] 20015.611565: funcgraph_entry:        0.120 us   |                vmacache_update(); 
> 7205              one-3920  [003] 20015.611566: funcgraph_exit:         2.320 us   |              } 
> 
> 
> Guest 
> ===== 
> 
> one-751   [000]   206.843300: funcgraph_entry:                   |              find_vma() { 
> one-751   [000]   206.843312: funcgraph_entry:        4.880 us   |                vmacache_find(); 
> one-751   [000]   206.843335: funcgraph_entry:        2.656 us   |                vmacache_update(); 
> one-751   [000]   206.843354: funcgraph_exit:       + 46.256 us  |              } 


I wonder how you manage to profile this, as we don't have any perf
support in KVM yet (you cannot profile a guest). Can you describe your
profiling method? Also, can you use a non-trivial test (i.e. something
that is not pure overhead)?

If that's all your test does, you end up measuring the cost of a stage-2
page fault, which only happens at startup.

> kernel: 3.18.9 

Is that mainline 3.18.9? Or some special tree? I'm also interested in
seeing results from a 4.0 kernel.

Thanks,


    M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
