From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Thu, 22 Nov 2012 21:53:28 -0800
Subject: [PATCH 10/10] ARM: FIQ: Get rid of init_FIQ()
In-Reply-To: <1353642030.851395840@f20.mail.ru>
References: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
 <1353631803-4853-10-git-send-email-anton.vorontsov@linaro.org>
 <1353642030.851395840@f20.mail.ru>
Message-ID: <20121123055328.GA21566@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 07:40:30AM +0400, Alexander Shiyan wrote:
[...]
> >  static unsigned long no_fiq_insn;
> > +static int got_no_fiq_insn;
> > @@ -78,11 +79,14 @@ void show_fiq_list(struct seq_file *p, int prec)
> >  
> >  void set_fiq_handler(void *start, unsigned int length)
> >  {
> > -#if defined(CONFIG_CPU_USE_DOMAINS)
> > -	memcpy((void *)0xffff001c, start, length);
> > -#else
> > -	memcpy(vectors_page + 0x1c, start, length);
> > +	unsigned long *addr = (void *)0xffff001c;
> > +
> > +#ifndef CONFIG_CPU_USE_DOMAINS
> > +	addr = vectors_page + 0x1c;
> >  #endif
> > +	if (!cmpxchg(&got_no_fiq_insn, 0, 1))
> > +		no_fiq_insn = *addr;
> > +	memcpy(addr, start, length);
> >  	flush_icache_range(0xffff001c, 0xffff001c + length);
> >  	if (!vectors_high())
> >  		flush_icache_range(0x1c, 0x1c + length);
> > @@ -126,8 +130,3 @@ EXPORT_SYMBOL(__set_fiq_regs);	/* defined in fiqasm.S */
> > -
> > -void __init init_FIQ(void)
> > -{
> > -	no_fiq_insn = *(unsigned long *)0xffff001c;
> 
> it seems that this is wrong. In this case we have an uninitialized variable and
> sequential call claim_fiq and release_fiq could be fatal. FIXME please.

Um... I don't think I understand, can you please elaborate?

Thanks,
Anton.
