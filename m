From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Oct 2010 11:21:35 +0100
Subject: recent ARM Erratas 742231 & 742230 broken.
In-Reply-To: <AANLkTim6LRZQhW6R83P0n70GdqEwFnFvb55KC8459KwY@mail.gmail.com>
References: <AANLkTim6LRZQhW6R83P0n70GdqEwFnFvb55KC8459KwY@mail.gmail.com>
Message-ID: <000401cb7040$930cf970$b926ec50$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinidhi,

> Are the below ERRATAs (in linux-next) on Cortex-A9 have been tested with
> booting in non secure mode?
> 
> commit 9f05027c7cb3cfe56a31892bd83391138d41a667
> Author: Will Deacon <will.deacon@arm.com>
> Date:   Tue Sep 14 09:51:43 2010 +0100
> 
>     ARM: 6388/1: errata: DMB operation may be faulty

[...]

> commit a672e99b129e286df2e2697a1b603d82321117f3
> Author: Will Deacon <will.deacon@arm.com>
> Date:   Tue Sep 14 09:53:02 2010 +0100
> 
>     ARM: 6389/1: errata: incorrect hazard handling in the SCU may lead
> to data corruption

[...]

> 
> What I see is that when I try to boot the system having this version
> of Cortex-A9 I see
> that the system does not boot at all. These diagnostic registers which seems
> undocumented and unable to see what's going on. However the system boots if I
> start from secure mode.

The diagnostic register is only writable from secure mode so you'll need to
look at what these patches do (they perform simple read-modify-writes) and
incorporate that code into your secure software. You will then need to ensure
that you don't have the workarounds enabled in the Kernel. Note that not
all revisions of the A9 are affected by these problems so you might not
need to implement both of the workarounds (the patches above check the MIDR).

I doubt that your secure monitor exposes the diagnostic register through an
SMC interface so you'll need to change the secure boot code to enable these
workarounds when the system comes out of reset.

I hope that helps,

Will
