From: mpatocka@redhat.com (Mikulas Patocka)
Date: Fri, 12 Oct 2018 14:59:16 -0400 (EDT)
Subject: ARM64 KVM crash
In-Reply-To: <b3355304-5144-b17a-c39c-866e197e3cc6@arm.com>
References: <alpine.LRH.2.02.1810121204120.16008@file01.intranet.prod.int.rdu2.redhat.com>
 <b3355304-5144-b17a-c39c-866e197e3cc6@arm.com>
Message-ID: <alpine.LRH.2.02.1810121453380.14664@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 12 Oct 2018, Marc Zyngier wrote:

> Right. But how is that related to KVM? See below:
> 
> > [75476.680725]  find_next_and_bit+0xc/0x70
> > [75476.680728]  find_busiest_group+0x128/0x938
> > [75476.680730]  load_balance+0x148/0x848
> > [75476.680732]  pick_next_task_fair+0x1d4/0x568
> > [75476.680734]  __schedule+0xe8/0x4b0
> > [75476.680736]  schedule+0x38/0xa0
> > [75476.680739]  kvm_vcpu_block+0x88/0x180
> > [75476.680742]  kvm_handle_wfx+0x80/0xb8
> > [75476.680744]  handle_exit+0x138/0x1b8
> 
> The guest is exiting because it has executed a blocking WFI, so KVM's
> job is done and we're calling schedule(). The scheduler then starts
> doing its job of picking the next victim.
> 
> At this stage, the kernel indeed blows up. But this doesn't immediately
> seem to be KVM's fault. It is far more likely that the scheduler has
> messed something up in its own data structure, which is even worse :-(.
> 
> I'd suggest you get in touch with the scheduler guys to see if they have
> any insight. Also, trying to come up with a reproducer would be
> extremely useful.
> 
> Thanks,
> 
> 	M.

I use this machine most of the time without KVM - and it crashed when I 
started KVM - so I assume that KVM had something to do with it. Perhaps it 
corrupts random memory? I may try to run some KVM stress for many days to 
test if I reproduce it.

Mikulas
