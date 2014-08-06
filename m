From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 6 Aug 2014 13:30:54 +0200
Subject: [RFC PATCH 3/9] irqchip: GIC: Convert to EOImode == 1
In-Reply-To: <CAFEAcA_naeGVc+Rsec=Ds6Lzf345nzFj3Wg2RWY-6LWYv3euNQ@mail.gmail.com>
References: <1403688530-23273-1-git-send-email-marc.zyngier@arm.com>
 <1403688530-23273-4-git-send-email-marc.zyngier@arm.com>
 <CAFEAcA_naeGVc+Rsec=Ds6Lzf345nzFj3Wg2RWY-6LWYv3euNQ@mail.gmail.com>
Message-ID: <20140806113054.GB14205@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 03:06:33PM +0100, Peter Maydell wrote:
> On 25 June 2014 10:28, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > For this case, the GIC architecture provides EOImode == 1, where:
> > - A write to the EOI register drops the priority of the interrupt and leaves
> > it active. Other interrupts at the same priority level can now be taken,
> > but the active interrupt cannot be taken again
> > - A write to the DIR marks the interrupt as inactive, meaning it can
> > now be taken again.
> >
> > We only enable this feature when booted in HYP mode. Also, as most device
> > trees are broken (they report the CPU interface size to be 4kB, while
> > the GICv2 CPU interface size is 8kB), output a warning if we're booted
> > in HYP mode, and disable the feature.
> 
> Does that mean you guarantee not to write to the DEACTIVATE
> register if not booted in Hyp mode? I ask because QEMU's
> GIC emulation doesn't emulate that register, so it would be
> useful to know if this patch means newer kernels are going to fall
> over under TCG QEMU...
> 
> (The correct fix, obviously, is to actually implement the QEMU
> support for split prio-drop and deactivate. Christoffer, you're our
> GIC emulation expert now, right? :-) )
> 
Missed this.  Sure, I can have a go at that some time, there are a
number of things I've been meaning to look at in the QEMU GIC emulation
code.

-Christoffer
