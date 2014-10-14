From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Oct 2014 11:28:14 +0100
Subject: [PATCH] arm64: compat: fix compat types affecting struct
 compat_elf_prpsinfo
In-Reply-To: <5165393.b3bTx8bIzn@wuerfel>
References: <1413266105-32491-1-git-send-email-victor.kamensky@linaro.org>
 <1876499.pQrfMV3dKY@wuerfel>
 <20141014095353.GD26987@e104818-lin.cambridge.arm.com>
 <5165393.b3bTx8bIzn@wuerfel>
Message-ID: <20141014102814.GE26987@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 11:08:19AM +0100, Arnd Bergmann wrote:
> On Tuesday 14 October 2014 10:53:53 Catalin Marinas wrote:
> > > > The problem is that elf_prpsinfo uses __kernel_uid_t which arm32 defines
> > > > as (unsigned short) while compat_elf_prspinfo uses __compat_uid_t which
> > > > is 32-bit. In reality compat_uid_t is different from the arm32
> > > > kernel_uid_t (other 32-bit architectures may use a 32-bit kernel_uid_t).
> > > 
> > > compat_uid_t should match the __kernel_uid_t for all 32-bit architectures
> > > that are emulated on a 64-bit architecture, that is the definition.
> > 
> > I guess you meant __compat_uid_t here. The compat_uid_t type is u32
> > already.
> 
> Ah, that's weird: compat_uid_t is not used anywhere in the kernel,
> and the definition is odd. Apparently it was intentional back in 2005
> when Stephen Rothwell introduced it as part of 202e5979af4d9
> ("compat: be more consistent about [ug]id_t"), but I have trouble
> understanding the intention.

It may be worth removing to avoid confusion.

> > So that patch is fine, I'll take it for 3.17 (and cc stable all the way
> > back to 3.7).
> 
> Ok. It might be worth checking if there are any uses of __compat_uid_t
> in arm64 that should have been __compat_uid32_t. Currently they are
> the same, but after Victor's patch, they would be different, which could
> cause regressions.

A quick grep shows __compat_uid_t being used for:

struct compat_ncp_mount_data
struct compat_elf_prpsinfo
struct compat_ipc_perm

In all these cases, the native structures on arm32 would use
__kernel_uid_t. The arch/arm64 code doesn't make any use of
__compat_uid_t, apart from defining it.

But I'll run some LTP again to make sure (though I don't have many hopes
of it being useful since this bug wasn't previously detected).

-- 
Catalin
