From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 23 Nov 2012 10:27:51 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCAxMC8xMF0gQVJNOiBGSVE6IEdldCByaWQgb2YgaW5p?=
 =?UTF-8?B?dF9GSVEoKQ==?=
In-Reply-To: <20121123055328.GA21566@lizard>
References: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
 <1353642030.851395840@f20.mail.ru> <20121123055328.GA21566@lizard>
Message-ID: <1353652071.755665772@f76.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Nov 23, 2012 at 07:40:30AM +0400, Alexander Shiyan wrote:
> [...]
> > >  static unsigned long no_fiq_insn;
> > > +static int got_no_fiq_insn;
> > > @@ -78,11 +79,14 @@ void show_fiq_list(struct seq_file *p, int prec)
> > >  
> > >  void set_fiq_handler(void *start, unsigned int length)
> > >  {
> > > -#if defined(CONFIG_CPU_USE_DOMAINS)
> > > -	memcpy((void *)0xffff001c, start, length);
> > > -#else
> > > -	memcpy(vectors_page + 0x1c, start, length);
> > > +	unsigned long *addr = (void *)0xffff001c;
> > > +
> > > +#ifndef CONFIG_CPU_USE_DOMAINS
> > > +	addr = vectors_page + 0x1c;
> > >  #endif
> > > +	if (!cmpxchg(&got_no_fiq_insn, 0, 1))
> > > +		no_fiq_insn = *addr;
> > > +	memcpy(addr, start, length);
> > >  	flush_icache_range(0xffff001c, 0xffff001c + length);
> > >  	if (!vectors_high())
> > >  		flush_icache_range(0x1c, 0x1c + length);
> > > @@ -126,8 +130,3 @@ EXPORT_SYMBOL(__set_fiq_regs);	/* defined in fiqasm.S */
> > > -
> > > -void __init init_FIQ(void)
> > > -{
> > > -	no_fiq_insn = *(unsigned long *)0xffff001c;
> > 
> > it seems that this is wrong. In this case we have an uninitialized variable and
> > sequential call claim_fiq and release_fiq could be fatal. FIXME please.
> 
> Um... I don't think I understand, can you please elaborate?

OK, I'll try to explain it.
At the end of the release_fiq function we have a call fiq_op. For the default
handler - is a fiq_def_op function, and we call this function with the option
"relinquish = 0", i.e. we want to restore old fiq_handler. But if we do not call
set_fiq_handler never before, we will have an uninitialized no_fiq_insn variable.

---
