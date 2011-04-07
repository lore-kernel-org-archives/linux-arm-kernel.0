From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 7 Apr 2011 15:07:53 +0800
Subject: [PATCH] ARM: The mandatory barrier rmb() must be a dsb() in for
	device accesses
In-Reply-To: <1301412104.583.85.camel@e102109-lin.cambridge.arm.com>
References: <20110325101651.27120.56045.stgit@e102109-lin.cambridge.arm.com>
	<AANLkTi=vx7fttc0B08dcfB_s9ya-98Rt-=a8Hr0QGvsM@mail.gmail.com>
	<1301412104.583.85.camel@e102109-lin.cambridge.arm.com>
Message-ID: <BANLkTi=SgC3sT5aHpFc8Yi-JZrc1PPcVwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

2011/3/29 Catalin Marinas <catalin.marinas@arm.com>:
> On Tue, 2011-03-29 at 16:02 +0100, Martin Furmanski wrote:
>> Do you have a reference on this?
>
> Usually the ARM ARM but a document with examples is this:
>
> http://infocenter.arm.com/help/topic/com.arm.doc.genc007826/Barrier_Litmus_Tests_and_Cookbook_A08.pdf

After glancing over the above, I find DSB is only applied in the WFE/WFI
example in section 6, but all other examples in this section do use DMB.

So could you point out which example is the reference for the mandatory DSB
wrt. read memory barrier?

> (infocenter.arm.com -> Developer Guides and Articles -> ARM architecture
> -> Barrier Litmus and Tests Cookbook)
>
>> I have been under the impression that DMB is a barrier for all memory
>> accesses. I find no support in ARMv7, for the hypothesis that DSB is
>> needed to order between Device and Normal.
>
> The key point is that DMB only ensures the *observability* of memory
> accesses by the processors and not arrival to the device or block of

How could you conclude that the memory accesses order is different with
the order of memory requests observed on the same type of memory?

> memory. In the drawing below, DMB only ensures the ordering at point
> (1). For arrival to RAM or Device you need a DSB.
>
> ? ? ? +------+ ? ? +------+
> ? ? ? | ?P1 ?| ? ? | ?P2 ?|
> ? ? ? +------+ ? ? +------+
> ? ? ? ? ?| ? ? (1) ? ? |
> ? ? ? ? ?+------+------+
> ? ? ? ? ? ? ? ? |
> ? +-------------+-------------+
> ? | ? ? ? ? ? ? | ? ? ? ? ? ? |
> +------+ ? ? +------+ ? ? +--------+
> | RAM1 | ? ? | RAM2 | ? ? | Device |
> +------+ ? ? +------+ ? ? +--------+


thanks,
-- 
Ming Lei
