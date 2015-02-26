From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Feb 2015 12:11:59 +0100
Subject: [PATCH] irqchip: armada: Fix chained per-cpu interrupts
In-Reply-To: <54EEFB04.8020200@free-electrons.com>
References: <1424944527-16850-1-git-send-email-maxime.ripard@free-electrons.com>
 <54EEF4D4.7060102@free-electrons.com>
 <20150226104710.GB29241@lukather>
 <54EEFB04.8020200@free-electrons.com>
Message-ID: <20150226111159.GD29241@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 11:52:52AM +0100, Gregory CLEMENT wrote:
> >> The following function is called as soon as the MPIC is used as a secondary
> >> interrupt controller. So it will be the case for the Armada 375 and Armada 39x too. It
> >> also seems to not be related to be used in an SoC or an other, so I think that the
> >> function name is misleading. What about just using mpic_secondary_init and
> >> mpic_cpu_notifier ?
> >>
> >> I know we prefixed the mpic function with armada_370_xp or armada_xp, but looking
> >> back, it was a mistake.
> > 
> > I don't know, that code needs to be run only in the cases where the
> > MPIC is a secondary interrupt controller, which rules out the armada
> > 370/XP.
> > 
> > I was trying to make such a distinction, but indeed the wording is
> > quite poor.
> > 
> > Do you have some suggestions?
> 
> Yes using  mpic_secondary_init and  mpic_cpu_notifier, because what is important
> is the fact that the MPIC is used as a secondary interrupt controller.

The thing is, the armada xp notifier is called
armada_xp_mpic_secondary_init, with in this case secondary meaning
secondary CPU. Won't that be really confusing to have another callback
called mpic_secondary_init, what would only be called on !armada
370/XP, and with secondary meaning secondary interrupt controller?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150226/dc3db871/attachment.sig>
