From: saeed.bishara@gmail.com (saeed bishara)
Date: Mon, 7 Feb 2011 16:58:05 +0200
Subject: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <20110207143351.GH31929@n2100.arm.linux.org.uk>
References: <20110206191117.GA17808@n2100.arm.linux.org.uk>
	<E1PmA28-0000AC-2t@rmk-PC.arm.linux.org.uk>
	<20110207120103.GC31929@n2100.arm.linux.org.uk>
	<20110207121052.GD31929@n2100.arm.linux.org.uk>
	<AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com>
	<20110207133457.GE31929@n2100.arm.linux.org.uk>
	<AANLkTi=B45PuOErxR49Gfhfq6-=y_NugbWBLBo0MEoCt@mail.gmail.com>
	<20110207141734.GG31929@n2100.arm.linux.org.uk>
	<AANLkTi=JCQBH4sjJzWajYJx6VuUTgdB76nxXbvKTrcwc@mail.gmail.com>
	<20110207143351.GH31929@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikVQG1ngkT7VwvjiSJjSfNsSMw=msfhc44emx6B@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> I fully agree with you, but what I was suggesting is to create
>> temporary identity page table at boot time, the resume code will load
>> that page table (Context ID will be loaded with unique ASID), enable
>> mmu, then the original page table and Context ID will be restored.
>
> That's much easier to do in C code than in the assembly code. ?Let's
> keep the assembly code as simple as possible...
well, the allocation of the identity page table doesn't need to be
done in assembly code. this is the similar to what you did in
__cpu_up.
for example, this allocation can be done in arch/arm/kernel/setup.c.
the assembly code only need to know the offset of this page table.
looks that there are several usages for the identity page table (smp
boot, kexec, pm), maybe all those clients can share the same one.

you may also consider loading this identity page table before calling
suspend flow, thus saving all the v:p stuff, and the resume code will
take care for restoring the original page table after enabling the
mmu.
saeed
