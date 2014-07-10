From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Thu, 10 Jul 2014 23:04:34 +0400
Subject: [RFC/PATCH RESEND -next 01/21] Add kernel address sanitizer
 infrastructure.
In-Reply-To: <53BE9CED.4090103@oracle.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-2-git-send-email-a.ryabinin@samsung.com>
 <53BE7F29.20304@oracle.com> <53BE8EA5.2030402@samsung.com>
 <53BE959A.4010206@oracle.com> <53BE9786.4060700@samsung.com>
 <53BE9CED.4090103@oracle.com>
Message-ID: <CAPAsAGy279XqO0Yq9v1q1OoW4TLv2iFKC0UjY+fOh31LxYOB+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-07-10 18:02 GMT+04:00 Sasha Levin <sasha.levin@oracle.com>:
> On 07/10/2014 09:39 AM, Andrey Ryabinin wrote:
>>> Anyways, the machine won't boot with more than 1GB of RAM, is there a solution to
>>> > get KASAN running on my machine?
>>> >
>> Could you share you .config? I'll try to boot it by myself. It could be that some options conflicting with kasan.
>> Also boot cmdline might help.
>>
>
> Sure. It's the .config I use for fuzzing so it's rather big (attached).
>
> The cmdline is:
>
> [    0.000000] Command line: noapic noacpi pci=conf1 reboot=k panic=1 i8042.direct=1 i8042.dumbkbd=1 i8042.nopnp=1 console=ttyS0 earlyprintk=serial i8042.noaux=1 numa=fake=32 init=/virt/init zcache ftrace_dump_on_oops debugpat kvm.mmu_audit=1 slub_debug=FZPU rcutorture.rcutorture_runnable=0 loop.max_loop=64 zram.num_devices=4 rcutorture.nreaders=8 oops=panic nr_hugepages=1000 numa_balancing=enable softlockup_all_cpu_backtrace=1 root=/dev/root rw rootflags=rw,trans=virtio,version=9p2000.L rootfstype=9p init=/virt/init
>
> And the memory map:
>
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000ffffe] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cfffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000705ffffff] usable
>
>
> On 07/10/2014 09:50 AM, Andrey Ryabinin wrote:>> Anyways, the machine won't boot with more than 1GB of RAM, is there a solution to
>>> > get KASAN running on my machine?
>>> >
>> It's not boot with the same Failed to allocate error?
>
> I think I misunderstood your question here. With >1GB is triggers a panic() when
> KASAN fails the memblock allocation. With <=1GB it fails a bit later in boot just
> because 1GB isn't enough to load everything - so it fails in some other random
> spot as it runs on out memory.
>
>
> Thanks,
> Sasha

Looks like I found where is a problem. memblock_alloc cannot allocate
accross numa nodes,
therefore kasan fails for numa=fake>=8.
You should succeed with numa=fake=7 or less.


-- 
Best regards,
Andrey Ryabinin
