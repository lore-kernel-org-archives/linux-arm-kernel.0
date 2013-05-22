From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 22 May 2013 10:04:47 +1000
Subject: [PATCH] Finally eradicate CONFIG_HOTPLUG
In-Reply-To: <20130521101349.30660.qmail@stuge.se>
References: <20130521134935.d18c3f5c23485fb5ddabc365@canb.auug.org.au>
 <20130521101349.30660.qmail@stuge.se>
Message-ID: <20130522100447.0f04799ea138a2f391d38850@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, 21 May 2013 12:13:49 +0200 Peter Stuge <peter@stuge.se> wrote:
>
> Are you changing the code to have HOTPLUG always -on- or -off- ?
> 
> From the commit message I had expected always -on-.

Yes, it has been that way for some time.

> Stephen Rothwell wrote:
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -68,14 +68,6 @@
> >   * are handled as text/data or they can be discarded (which
> >   * often happens at runtime)
> >   */
> > -#ifdef CONFIG_HOTPLUG
> > -#define DEV_KEEP(sec)    *(.dev##sec)
> > -#define DEV_DISCARD(sec)
> > -#else
> > -#define DEV_KEEP(sec)
> > -#define DEV_DISCARD(sec) *(.dev##sec)
> > -#endif
> > -
> >  #ifdef CONFIG_HOTPLUG_CPU
> >  #define CPU_KEEP(sec)    *(.cpu##sec)
> >  #define CPU_DISCARD(sec)
> > @@ -182,8 +174,6 @@
> >  	*(.data)							\
> >  	*(.ref.data)							\
> >  	*(.data..shared_aligned) /* percpu related */			\
> > -	DEV_KEEP(init.data)						\
> > -	DEV_KEEP(exit.data)						\
> ..
> > @@ -503,7 +489,6 @@
> >  /* init and exit section handling */
> >  #define INIT_DATA							\
> >  	*(.init.data)							\
> > -	DEV_DISCARD(init.data)						\
> 
> Shouldn't the effect of one of the above remain?

As far as I can tell, all references to devinit and devexit have now been
removed from the kernel, so nothing will generate code in these sections
any more, so the linker script no longer needs to deal with them at all.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130522/177a0623/attachment.sig>
