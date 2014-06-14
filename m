From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 14 Jun 2014 17:47:47 +0200
Subject: [PATCH v4 12/14] ARM64: KVM: vgic_elrsr and vgic_eisr need to be
 byteswapped in BE case
In-Reply-To: <CAA3XUr3dApGFWmr36rpme+2TRMpFdGp=aCbbk_930jeZ-Eyjuw@mail.gmail.com>
References: <1402590613-3341-1-git-send-email-victor.kamensky@linaro.org>
 <1402590613-3341-13-git-send-email-victor.kamensky@linaro.org>
 <20140614150459.GH14023@lvm>
 <CAA3XUr3dApGFWmr36rpme+2TRMpFdGp=aCbbk_930jeZ-Eyjuw@mail.gmail.com>
Message-ID: <20140614154747.GA18355@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 14, 2014 at 08:42:58AM -0700, Victor Kamensky wrote:
> On 14 June 2014 08:04, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Thu, Jun 12, 2014 at 09:30:11AM -0700, Victor Kamensky wrote:
> >> On arm64 'u32 vgic_eisr[2];' and 'u32 vgic_elrsr[2]' are accessed as
> >> one 'unsigned long *' bit fields, which has 64bit size. So we need to
> >> swap least significant word with most significant word when code reads
> >> those registers from h/w.
> >>
> >> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> >> ---
> >>  arch/arm64/kvm/hyp.S | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> >> index 0620691..5035b41 100644
> >> --- a/arch/arm64/kvm/hyp.S
> >> +++ b/arch/arm64/kvm/hyp.S
> >> @@ -415,10 +415,17 @@ CPU_BE( rev     w11, w11 )
> >>       str     w4, [x3, #VGIC_CPU_HCR]
> >>       str     w5, [x3, #VGIC_CPU_VMCR]
> >>       str     w6, [x3, #VGIC_CPU_MISR]
> >> +#ifndef CONFIG_CPU_BIG_ENDIAN
> >>       str     w7, [x3, #VGIC_CPU_EISR]
> >>       str     w8, [x3, #(VGIC_CPU_EISR + 4)]
> >>       str     w9, [x3, #VGIC_CPU_ELRSR]
> >>       str     w10, [x3, #(VGIC_CPU_ELRSR + 4)]
> >> +#else
> >> +     str     w7, [x3, #(VGIC_CPU_EISR + 4)]
> >> +     str     w8, [x3, #VGIC_CPU_EISR]
> >> +     str     w9, [x3, #(VGIC_CPU_ELRSR + 4)]
> >> +     str     w10, [x3, #VGIC_CPU_ELRSR]
> >> +#endif
> >>       str     w11, [x3, #VGIC_CPU_APR]
> >>
> >>       /* Clear GICH_HCR */
> >> --
> >> 1.8.1.4
> >>
> > I thought Marc had something here which allowed you to deal with the
> > conversion in the accessor functions and avoid this patch?
> 
> Christoffer, I appreciate your review comments.
> 
> I think I was missing something. Yes, Marc mentioned in [1] about
> his new changes in vgic3 series. But just after rereading it now, I
> realized that he was suggesting to pick up his commits and add
> them to this series. Is it my right understanding that they should
> be [2] and [3] ... looking a bit closer to it, it seems that [4] is needed
> as well. I am concerned that I don't understand all dependencies
> and impact of those. Wondering about other way around. When vgic3
> series introduced could we just back off above change and do it in
> new right way?
> 
> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009618.html
> [2] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009475.html
> [3] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009472.html
> [4] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009473.html
> 
> Other question: I was testing all this directly on vanilla v3.15, should I
> use some other armkvm specific integration branch to make sure it works
> with all other in a queue armkvm changes.
> 
> In mean time I will try to pick up [4], [2], and [3] into v3.15 and see
> how it goes.
> 
ok, thanks.  I'm ok with potentially adjusting this later if it turns
out to be a pain, depends on what Marc says.

I can probably fix up any conflicts when I apply the patches, but I do
appreciate getting patches that apply to the next branch in [1].  (But
wait until the next branch merges 3.16-rc1).

-Christoffer

[1]: https://git.kernel.org/cgit/linux/kernel/git/kvmarm/kvmarm.git/
