From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 19 Feb 2013 13:43:37 -0500
Subject: [PATCH LINUX v4] xen: event channel arrays are xen_ulong_t and
 not unsigned long
In-Reply-To: <alpine.DEB.2.02.1302191808110.4654@kaball.uk.xensource.com>
References: <1361285327.1051.115.camel@zakaz.uk.xensource.com>
 <1361294951-28633-1-git-send-email-ian.campbell@citrix.com>
 <alpine.DEB.2.02.1302191808110.4654@kaball.uk.xensource.com>
Message-ID: <20130219184337.GB18831@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 06:12:35PM +0000, Stefano Stabellini wrote:
> On Tue, 19 Feb 2013, Ian Campbell wrote:
> > On ARM we want these to be the same size on 32- and 64-bit.
> > 
> > This is an ABI change on ARM. X86 does not change.
> > 
> > Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> > Cc: Jan Beulich <JBeulich@suse.com>
> > Cc: Keir (Xen.org) <keir@xen.org>
> > Cc: Tim Deegan <tim@xen.org>
> > Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: xen-devel at lists.xen.org
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > ---
> > Changes since V3
> >   s/read_evtchn_pending_sel/xchg_xen_ulong/ in a comment.
> > Changes since V2
> >   Add comments about the correct bitops to use, and on the ordering/barrier
> >   requirements on xchg_xen_ulong.
> > Changes since V1
> >   use find_first_set not __ffs
> >   fix some more unsigned long -> xen_ulong_t
> >   use more generic xchg_xen_ulong instead of ...read_evtchn...
> 
> still doesn't apply to 3.8

Weird. It applied to my tree (stable/for-linus-3.9) without fuss.
> 
> 
> >         do {
> > -               unsigned long pending_words;
> > +               xen_ulong_t pending_words;
> > 
> >                 vcpu_info->evtchn_upcall_pending = 0;
> > 
> >                 if (__this_cpu_inc_return(xed_nesting_count) - 1)
> >                         goto out;
> > 
> > -#ifndef CONFIG_X86 /* No need for a barrier -- XCHG is a barrier on x86. */
> > -               /* Clear master flag /before/ clearing selector flag. */
> > -               wmb();
> > -#endif
> > -               pending_words = xchg(&vcpu_info->evtchn_pending_sel, 0);
> > +               /*
> > +                * Master flag must be /before/ clearing selector
> > +                * flag. xchg_xen_ulong must contain an appropriate
> > +                * barrier.
> > +                */
> 
> Master flag must be *cleared* ...
> 
> > +               pending_words = xchg_xen_ulong(&vcpu_info->evtchn_pending_sel, 0);
> > 
> >                 start_word_idx = __this_cpu_read(current_word_idx);
> >                 start_bit_idx = __this_cpu_read(current_bit_idx);
