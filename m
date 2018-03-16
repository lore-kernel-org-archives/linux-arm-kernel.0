From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 16 Mar 2018 14:13:31 +0000
Subject: arm64 kvm built with clang doesn't boot
In-Reply-To: <CAAeHK+xjnXnrG0p06r-QRcUucYi5vcTJOn3mSS-JVxX9_TYg4w@mail.gmail.com>
References: <CAAeHK+xjnXnrG0p06r-QRcUucYi5vcTJOn3mSS-JVxX9_TYg4w@mail.gmail.com>
Message-ID: <26a25069-ea1d-5fb3-549c-ab653f454a30@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On 16/03/18 13:49, Andrey Konovalov wrote:
> Hi!
> 
> I've recently tried to boot clang built kernel on real hardware
> (Odroid C2 board) instead of using a VM. The issue that I stumbled
> upon is that arm64 kvm built with clang doesn't boot.
> 
> Adding -fno-jump-tables compiler flag to arch/arm64/kvm/* helps. There
> was a patch some time ago that did exactly that
> (https://patchwork.kernel.org/patch/10060381/), but it wasn't accepted
> AFAICT (see the discussion on that thread).

I wasn't aware of that discussion, but this is indeed quite annoying.
Note that you should be able to restrict this to arch/arm64/kvm/hyp/*
and virt/kvm/arm/hyp/*.

> What would be the best way to get this fixed?

Ideally, I'd like to see is a way to stick to PC-relative addressing
within a compilation unit.

> I've also had to disable CONFIG_JUMP_LABEL to get the kernel boot
> (even without kvm enabled), but that might be a different (though
> related) issue.

That's quite bizarre. Does clang has the equivalent of "asm goto"? Or do
you rely on reading a variable to decide whether or not to branch?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
