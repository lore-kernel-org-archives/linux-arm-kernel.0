From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 4 Jan 2017 14:41:16 +0100 (CET)
Subject: [PATCH] rtc: armada38x: add __ro_after_init to armada38x_rtc_ops
In-Reply-To: <20170104130628.GQ14217@n2100.armlinux.org.uk>
References: <1482751862-18699-1-git-send-email-bhumirks@gmail.com>
 <20170102140654.GF14217@n2100.armlinux.org.uk>
 <CAGXu5jJLA=GcOhV5Z_6AOGa1KhW7fXtqBGrewEeViaJ9TiE-aw@mail.gmail.com>
 <20170103213118.GM14217@n2100.armlinux.org.uk>
 <20170103215421.GN14217@n2100.armlinux.org.uk>
 <alpine.DEB.2.20.1701041155380.3073@hadrien>
 <20170104110750.dtu54t74qkuuvkvq@piout.net>
 <alpine.DEB.2.20.1701041242080.3073@hadrien>
 <20170104121425.GP14217@n2100.armlinux.org.uk>
 <alpine.DEB.2.20.1701041320140.3073@hadrien>
 <20170104130628.GQ14217@n2100.armlinux.org.uk>
Message-ID: <alpine.DEB.2.20.1701041441020.3073@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, 4 Jan 2017, Russell King - ARM Linux wrote:

> On Wed, Jan 04, 2017 at 01:23:41PM +0100, Julia Lawall wrote:
> > Basically, the strategy of the patch is that one may consider it
> > preferable to duplicate the structure for the different alternatives,
> > rather than use __ro_after_init.  Perhaps if the structure were larger,
> > then __ro_after_init would be a better choice?
>
> It depends on not just the size, but how many members need to be
> modified, and obviously whether there are likely to be more than one
> user of the structure as well.
>
> So I'd say __ro_after_init rarely makes sense for an operations
> structure - the only case I can see is:
>
> - a large structure
> - only a small number of elements need to be modified
> - it is only single-use
>
> which is probably quite rare - this one falls into two out of those
> three.
>
> There's another consideration (imho) too - we may wish, at a later
> date, to make .text and .rodata both read-only from the start of the
> kernel to harden the kernel against possibly init-time exploitation.
> (Think about a buggy built-in driver with emulated hardware - much the
> same problem that Kees is trying to address in one of his recent patch
> sets but with hotplugged hardware while a screen-saver is active.)
> Having function pointers in .rodata rather than the ro-after-init
> section would provide better protection.

OK, thanks for the explanations.

julia
