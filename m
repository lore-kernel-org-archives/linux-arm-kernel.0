From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 May 2013 10:49:50 +0100
Subject: [PATCH] arm64: extable: sort the exception table at build time
In-Reply-To: <20130517184950.GA22304@merkur.ravnborg.org>
References: <1368809021-25130-1-git-send-email-will.deacon@arm.com>
 <20130517184950.GA22304@merkur.ravnborg.org>
Message-ID: <20130520094950.GG31359@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 07:49:50PM +0100, Sam Ravnborg wrote:
> On Fri, May 17, 2013 at 05:43:41PM +0100, Will Deacon wrote:
> > +	. = ALIGN(8);
> > +	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
> > +		__start___ex_table = .;
> > +		*(__ex_table)
> > +		__stop___ex_table = .;
> > +	}
> 
> Here you could use:
>      EXCEPTION_TABLE(align)
> 
> (From include/asm-generic/vmlinux.lds.h)

Good spot, I'll spin a v2 using that. Looks like we don't use that for
arch/arm/ because we want to discard the section ifdef CONFIG_MMU. Maybe we
could change the generic macro to expand to nothing if !MMU, but I'm not
sure if other MMU-less architectures are playing tricks with this.

Will
