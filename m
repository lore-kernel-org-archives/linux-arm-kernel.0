From: david.woodhouse@intel.com (Woodhouse, David)
Date: Tue, 29 Jan 2013 16:46:58 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <20130129083522.GA14302@pd.tnic>
References: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
 <20130129083522.GA14302@pd.tnic>
Message-ID: <1359478014.3529.157.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-29 at 09:35 +0100, Borislav Petkov wrote:
> 
> >  
> >  #ifdef CONFIG_ARCH_USE_BUILTIN_BSWAP
> > -#if GCC_VERSION >= 40400
> > +#if (!defined(__arm__) && GCC_VERSION >= 40400) || \
> > +    (defined(__arm__) && GCC_VERSION >= 40600)
> 
> There should be no arch-specific stuff in a generic header. I guess
> you probably need to select ARCH_USE_BUILTIN_BSWAP in an arm-specific
> compiler.h header after checking compiler version...

If we're really going to have many different architectures depending on
different versions of GCC for this (if it wasn't sane to use it from
4.4/4.8 when it got introduced, and depends on some later arch-specific
optimisation), then perhaps we'll have the arch provide the
corresponding required GCC_VERSION for using each of 64/32/16 bit
builtins, instead of just a yes/no flag? Or just define
__HAVE_BUILTIN_BSWAPxx__ for itself, perhaps?

In fact we could start by having just the problematic architectures set
__HAVE_BUILTIN_BSWAPxx__ for themselves according to whatever criteria
they want, and then if there's scope for consolidating that in the
generic code then we can do so later.

-- 
                   Sent with MeeGo's ActiveSync support.

David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation



-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4370 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/9fde7c1d/attachment.bin>
