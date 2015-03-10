From: stsp@list.ru (Stas Sergeev)
Date: Tue, 10 Mar 2015 20:27:34 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <20150310171751.GD13687@e104818-lin.cambridge.arm.com>
References: <54FF21BE.2040506@list.ru>
 <20150310171751.GD13687@e104818-lin.cambridge.arm.com>
Message-ID: <54FF2986.6020503@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

10.03.2015 20:17, Catalin Marinas ?????:
> On Tue, Mar 10, 2015 at 07:54:22PM +0300, Stas Sergeev wrote:
>> Hello, the patch below is needed for a successful boot on armada-xp.
>>
>> -=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-
>> This fixes the following crash at boot:
>>
>>  Unhandled fault: external abort on non-linefetch (0x808) at 0xf00ca018
>>  Internal error: : 808 [#1] SMP ARM
> I think you have some other problems.
Likely, but IMHO the patch is still fine, there should be kmalloc() anyway.
I'd like to find the roots of the problem, but I think the patch can
be applied regardless.

>  That's an external abort, which
> means that the original vmalloc'ed memory was not mapping RAM but some
> empty physical address space.
>
> That's unless strex hits device memory and not having an exclusive
> monitor causes such external abort. But vmalloc() memory is Normal
> Cacheable. Some pointer could go wrong and it hits ioremap'ed memory
> which is in the same range as vmalloc'ed memory.
But strex is preceded by ldrex, which succeeds.
I am not arm guru at all, but if we hit empty space or ioremap
memory, shouldn't the ldrex also abort? It doesn't.

Any hints how can I make a better diagnostic?

Please also find the same crash here:
http://lists.linaro.org/pipermail/kernel-build-reports/2014-June/003872.html
---

Console logs for failures
=========================

arm-mvebu_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=y
----------------------------------------------

	armada-xp-openblocks-ax3-4: FAIL: last 40 lines of boot log:
	------------------------------------------------------------

3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 55048012 02109471
[<c0186b78>] (_set_bit) from [<c01c9ba8>] (n_tty_set_termios+0x234/0x348)
[<c01c9ba8>] (n_tty_set_termios) from [<c01c9da8>] (n_tty_open+0xec/0x114)
---
