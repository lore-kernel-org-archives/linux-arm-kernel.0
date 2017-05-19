From: pmladek@suse.com (Petr Mladek)
Date: Fri, 19 May 2017 15:02:23 +0200
Subject: [PATCH v2] printk: Use the main logbuf in NMI when logbuf_lock
 is available
In-Reply-To: <20170519043815.GB593@jagdpanzerIV.localdomain>
References: <1493912763-24873-1-git-send-email-pmladek@suse.com>
 <20170519025803.GA593@jagdpanzerIV.localdomain>
 <20170519043815.GB593@jagdpanzerIV.localdomain>
Message-ID: <20170519130223.GB12489@pathway.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2017-05-19 13:38:15, Sergey Senozhatsky wrote:
> On (05/19/17 11:58), Sergey Senozhatsky wrote:
> > >  void printk_nmi_exit(void)
> > >  {
> > > -	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
> > > +	this_cpu_and(printk_context,
> > > +		     ~(PRINTK_NMI_CONTEXT_MASK ||
> > > +		       PRINTK_NMI_DEFERRED_CONTEXT_MASK));
> > >  }
> 
> [..]
> 
> > the problem is that
> > 
> > 	`PRINTK_NMI_CONTEXT_MASK || PRINTK_NMI_DEFERRED_CONTEXT_MASK' is 0x01
> 
> d'oh... forgot to copy-paste this...

Grrr, thanks a lot for chasing this down and I am sorry for the troubles.

> ---
> 
> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index 6fec9cfb9a69..b6ff3fe4370a 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -324,7 +324,7 @@ void printk_nmi_enter(void)
>  void printk_nmi_exit(void)
>  {
>         this_cpu_and(printk_context,
> -                    ~(PRINTK_NMI_CONTEXT_MASK ||
> +                    ~(PRINTK_NMI_CONTEXT_MASK |
>                        PRINTK_NMI_DEFERRED_CONTEXT_MASK));
>  }

I have rebased both for-4.13 and for-next branches in printk.git
with this fix. I wanted to get rid of this bug in linux-next
ASAP. Please, let me know if you would prefer to handle
this another way in the future.

Best Regards,
Petr
