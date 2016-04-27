From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2016 21:04:35 +0100
Subject: Build regressions/improvements in v4.6-rc5
In-Reply-To: <CAMuHMdX4LJ-OVTijYn-VB0B5djM4n3G=1NrHg8WaJoNq_NXMzg@mail.gmail.com>
References: <1461572127-14630-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdX4LJ-OVTijYn-VB0B5djM4n3G=1NrHg8WaJoNq_NXMzg@mail.gmail.com>
Message-ID: <20160427200435.GS19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 10:18:39AM +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 25, 2016 at 10:15 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v4.6-rc5[1] to v4.6-rc4[3], the summaries are:
> >   - build errors: +15/-5
> 
>   + /home/kisskb/slave/src/arch/arm/mach-sa1100/assabet.c: error:
> 'PMD_MASK' undeclared (first use in this function):  => 496:38
>   + /home/kisskb/slave/src/arch/arm/mach-sa1100/assabet.c: error:
> 'pmdval_t' undeclared (first use in this function):  => 498:13
>   + /home/kisskb/slave/src/arch/arm/mach-sa1100/assabet.c: error:
> implicit declaration of function 'flush_pmd_entry'
> [-Werror=implicit-function-declaration]:  => 503:2

Looks like nommu stuff, as I know assabet builds with my mmu-full
configuration.

>   + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
> 'COPYPAGE_MINICACHE' undeclared (first use in this function):  =>
> 77:14
>   + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
> 'L_PTE_MT_MINICACHE' undeclared (first use in this function):  =>
> 77:47
>   + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
> 'L_PTE_PRESENT' undeclared (first use in this function):  => 77:47
>   + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
> 'L_PTE_YOUNG' undeclared (first use in this function):  => 77:47
>   + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
> implicit declaration of function '__flush_dcache_page'
> [-Werror=implicit-function-declaration]:  => 73:3
>   + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
> implicit declaration of function 'mk_pte'
> [-Werror=implicit-function-declaration]:  => 77:2
>   + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
> implicit declaration of function 'set_top_pte'
> [-Werror=implicit-function-declaration]:  => 77:2
>   + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error: unknown
> field 'cpu_clear_user_highpage' specified in initializer:  => 113:2
>   + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error: unknown
> field 'cpu_copy_user_highpage' specified in initializer:  => 114:2
>   + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
> variable 'v4_mc_user_fns' has initializer but incomplete type:  =>
> 112:8

My guess is that it (and other copypage-* headers) need to include
asm/page.h, but maybe this is another nommu problem, I don't know.
I don't have time to analyse these as I'm still catching up with
email, and will be for a while yet.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
