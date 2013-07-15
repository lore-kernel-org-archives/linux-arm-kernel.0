From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 15 Jul 2013 15:03:42 -0700
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130712075602.GA4002@gmail.com>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <1367829775-4434-2-git-send-email-kyungsik.lee@lge.com>
 <20130712075602.GA4002@gmail.com>
Message-ID: <20130715150342.35f7620ffe0835e3e2bc37d0@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Jul 2013 09:56:02 +0200 Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Kyungsik Lee <kyungsik.lee@lge.com> wrote:
> >  quiet_cmd_lz4 = LZ4     $@
> >  cmd_lz4 = (cat $(filter-out FORCE,$^) | \
> > -	lz4demo -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
> > +	lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
> >  	(rm -f $@ ; false)
> 
> None of the major distros I tried has the lz4 or lz4c binary available, 
> and this breaks randconfig builds:
> 
>   /bin/sh: lz4c: command not found
> 
> If:
> 
>  CONFIG_HAVE_KERNEL_LZ4=y
>  CONFIG_KERNEL_LZ4=y
>  CONFIG_RD_LZ4=y
>  CONFIG_LZ4_DECOMPRESS=y
>  CONFIG_DECOMPRESS_LZ4=y
> 
> If a utility is not widely available yet and if the utility is not in the 
> kernel proper, could you please at least make sure that randconfig does 
> not stumble over non-buildable kernels?

I don't know how to do this.  Any suggestions?

It has to be done at `make config' time.  We'd need to probe for the
presence of lz4c and then....  what?

Is there any precedent for this?

I don't think we can just ignore the absence of lz4c - the user has
selected a config which his system cannot build.  The problem lies
within randconfig itself.
