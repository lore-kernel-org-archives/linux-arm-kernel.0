From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Nov 2013 16:52:23 +0000
Subject: [PATCH] ARM: Use udiv/sdiv for __aeabi_{u}idiv library functions
In-Reply-To: <20131108095842.GG28304@ns203013.ovh.net>
References: <1383852042-10780-1-git-send-email-sboyd@codeaurora.org>
 <20131108095842.GG28304@ns203013.ovh.net>
Message-ID: <20131108165223.GL16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08, 2013 at 10:58:42AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 11:20 Thu 07 Nov     , Stephen Boyd wrote:
> > @@ -381,6 +384,13 @@ static void __init cpuid_init_hwcaps(void)
> >  		elf_hwcap |= HWCAP_IDIVT;
> >  	}
> >  
> > +#ifdef CONFIG_THUMB2_KERNEL
> if (IS_ENABLED(CONFIG_THUMB2_KERNEL) && elf_hwcap & HWCAP_IDIVT)
> > +	if (elf_hwcap & HWCAP_IDIVT)
> > +#else
> > +	if (elf_hwcap & HWCAP_IDIVA)
> > +#endif

Take another look, and you'll see the change that you're suggesting is
wrong.  Instead, the following may be a more reasonable suggestion as
a suitable replacement:

	if (elf_hwcap & (IS_ENABLED(CONFIG_THUMB2_KERNEL) ?
				HWCAP_IDIVT : HWCAP_IDIVA))
