From: will.deacon@arm.com (Will Deacon)
Date: Tue, 2 Feb 2016 16:48:18 +0000
Subject: [PATCH] arm64: asm: Explicitly include linux/personality.h in
 asm/page.h
In-Reply-To: <20160128144610.GA2380@ulmo>
References: <1453983508-20410-1-git-send-email-broonie@kernel.org>
 <20160128124417.GE6078@sirena.org.uk>
 <20160128141425.GA20099@e104818-lin.cambridge.arm.com>
 <20160128144610.GA2380@ulmo>
Message-ID: <20160202164817.GM10166@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 03:46:10PM +0100, Thierry Reding wrote:
> On Thu, Jan 28, 2016 at 02:14:26PM +0000, Catalin Marinas wrote:
> > On Thu, Jan 28, 2016 at 12:44:17PM +0000, Mark Brown wrote:
> > > On Thu, Jan 28, 2016 at 12:18:28PM +0000, Mark Brown wrote:
> > > > asm/page.h uses READ_IMPLIES_EXEC from linux/personality.h but does not
> > > > explicitly include it causing build failures in -next where whatever was
> > > > causing it to be implicitly included has changed to remove that
> > > > inclusion.  Add an explicit inclusion to fix this.
> > > 
> > > Argh, sorry - this causes problems further down the line with linking
> > > vdso.lds due to enums getting into the linker script and upsetting the
> > > linker (there are several compile errors today so it was masked).
> > 
> > You can move the include further down after the #ifndef __ASSEMBLY__
> 
> Indeed, here's what I've been using to successfully complete ARM64 test
> builds:
> 
> --- >8 ---
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index 9b2f5a9d019d..ae615b9d9a55 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -39,6 +39,7 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/personality.h> /* for READ_IMPLIES_EXEC */
>  #include <asm/pgtable-types.h>
>  
>  extern void __cpu_clear_user_page(void *p, unsigned long user);

I see this has ended up in linux-next, but I'm not sure whether or not
it's actually queued someplace for 4.6. Any ideas?

If not, I can take it (or some derivative) through arm64 as a fix for
-rc3.

Will
