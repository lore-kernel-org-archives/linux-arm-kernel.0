From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 28 Jun 2013 15:46:00 +0200
Subject: [PATCH v2 3/5] ARM: add support for kernel mode NEON
In-Reply-To: <CAKv+Gu_NZNAcW13CBP=QJQ8KXD6H9zx_T6ZQPsWuagRm3n6Okg@mail.gmail.com>
References: <1372191891-24574-1-git-send-email-ard.biesheuvel@linaro.org>
 <1372191891-24574-4-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_NZNAcW13CBP=QJQ8KXD6H9zx_T6ZQPsWuagRm3n6Okg@mail.gmail.com>
Message-ID: <20130628134600.GC21034@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:55 Wed 26 Jun     , Ard Biesheuvel wrote:
> Replying to self:
> 
> On 25 June 2013 22:24, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > +void kernel_neon_end(void)
> > +{
> > +       /* Disable the NEON/VFP unit. */
> > +       fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
> > +       barrier();
> > +       dec_preempt_count();
> > +}
> > +EXPORT_SYMBOL(kernel_neon_end);
> 
> Meh. This is not going to please the RT crowd, as preempt_schedule()
> will not be called on PREEMPT builds in this case.
> 
> Propose to replace it with
> 
>     preempt_enable();
> #ifndef CONFIG_PREEMPT_COUNT
if (IS_ENABLED(CONFIG_xxx)) at least
>     /* in this case, the preempt_enable() right above is just a barrier() */
>     dec_preempt_count();
> #endif

but why do you need to call inc_preempt and dec directly?

Best Regards,
J.
