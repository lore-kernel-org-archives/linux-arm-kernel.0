From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Apr 2015 10:09:50 +0100
Subject: kvm vs host (arm64)
In-Reply-To: <1967946020.115308.1429508745411.JavaMail.yahoo@mail.yahoo.com>
References: <1967946020.115308.1429508745411.JavaMail.yahoo@mail.yahoo.com>
Message-ID: <5534C25E.7070702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
