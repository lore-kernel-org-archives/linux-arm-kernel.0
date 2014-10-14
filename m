From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Oct 2014 12:08:19 +0200
Subject: [PATCH] arm64: compat: fix compat types affecting struct
 compat_elf_prpsinfo
In-Reply-To: <20141014095353.GD26987@e104818-lin.cambridge.arm.com>
References: <1413266105-32491-1-git-send-email-victor.kamensky@linaro.org>
 <1876499.pQrfMV3dKY@wuerfel>
 <20141014095353.GD26987@e104818-lin.cambridge.arm.com>
Message-ID: <5165393.b3bTx8bIzn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 October 2014 10:53:53 Catalin Marinas wrote:
> > > The problem is that elf_prpsinfo uses __kernel_uid_t which arm32 defines
> > > as (unsigned short) while compat_elf_prspinfo uses __compat_uid_t which
> > > is 32-bit. In reality compat_uid_t is different from the arm32
> > > kernel_uid_t (other 32-bit architectures may use a 32-bit kernel_uid_t).
> > 
> > compat_uid_t should match the __kernel_uid_t for all 32-bit architectures
> > that are emulated on a 64-bit architecture, that is the definition.
> 
> I guess you meant __compat_uid_t here. The compat_uid_t type is u32
> already.

Ah, that's weird: compat_uid_t is not used anywhere in the kernel,
and the definition is odd. Apparently it was intentional back in 2005
when Stephen Rothwell introduced it as part of 202e5979af4d9
("compat: be more consistent about [ug]id_t"), but I have trouble
understanding the intention.

> So that patch is fine, I'll take it for 3.17 (and cc stable all the way
> back to 3.7).

Ok. It might be worth checking if there are any uses of __compat_uid_t
in arm64 that should have been __compat_uid32_t. Currently they are
the same, but after Victor's patch, they would be different, which could
cause regressions.

	Arnd
