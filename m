From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Jun 2013 12:14:30 +0100
Subject: [PATCH v2 3/5] ARM: add support for kernel mode NEON
In-Reply-To: <CAKv+Gu_NZNAcW13CBP=QJQ8KXD6H9zx_T6ZQPsWuagRm3n6Okg@mail.gmail.com>
References: <1372191891-24574-1-git-send-email-ard.biesheuvel@linaro.org>
 <1372191891-24574-4-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_NZNAcW13CBP=QJQ8KXD6H9zx_T6ZQPsWuagRm3n6Okg@mail.gmail.com>
Message-ID: <20130626111430.GH26142@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 11:55:33AM +0100, Ard Biesheuvel wrote:
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
>     /* in this case, the preempt_enable() right above is just a barrier() */
>     dec_preempt_count();
> #endif
> 
> (and the converse in kernel_neon_begin())

Yuck, that's ugly as sin! How does x86 deal with this? Looking at
kernel_fpu_{begin,end}, they just disable preemption so I guess that they
assume the caller is non-blocking? There's an aside about the use of
preempt-notifiers for KVM, so it does sound like the onus is on the caller
not to shoot themselves in the face.

Will
