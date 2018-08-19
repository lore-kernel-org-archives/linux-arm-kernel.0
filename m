From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 19 Aug 2018 11:29:36 +0100
Subject: why TTBR0_EL1/VBAR_EL1 not banked in aarch64
In-Reply-To: <CADUS3o=getrG8E+CF9PC5sdcPQwxE3r2XWfSy=H_-mYEacaLdQ@mail.gmail.com>
References: <CADUS3onm_h6aq_sQP_pdtrHpbiCok3ofjwd0yTMWFpGxHWstow@mail.gmail.com>
 <5c1fdcd956b1c73d546010add8430f79@www.loen.fr>
 <CADUS3okx-PWqP3N2rCy-WdCMy38oT3sUqtxOqYgbOCbAMmCEpg@mail.gmail.com>
 <CADUS3okzvPoe_xBNDOPtc+kx=0D=r+Rsh2zXM+vOuGaBiuje3w@mail.gmail.com>
 <868t53pj5i.wl-marc.zyngier@arm.com>
 <CADUS3o=getrG8E+CF9PC5sdcPQwxE3r2XWfSy=H_-mYEacaLdQ@mail.gmail.com>
Message-ID: <867ekmps33.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 19 Aug 2018 05:45:03 +0100,
yoma sophian <sophian.yoma@gmail.com> wrote:
> 
> hi marc:
> > On Sat, 18 Aug 2018 17:01:33 +0100,
> > You missed the essential part of my answer: Switching from EL1_S to
> > EL1_NS (or the other way around) implies that you're transitioning via
> > EL3, which is entirely responsible for switching all non-banked system
> > registers, which includes TTBR0_EL1.
> >
> > EL1_S and EL1_NS do not run concurrently. They are multiplexed by EL3,
> > which gives the illusion of concurrent execution.
> so you mean:
> a) EL1_NS modify TTBR0_EL1
> b) SMC to EL3
> c) EL3 will restore TTBR0_EL1 of EL1_S

Only if it has to switch to EL1_S. Services that are handled at EL3
directly do not need any additional save/restore.

> EL1_S will always using its own TTBR0_EL1 that saved by EL3, right?
> if so, that mean EL3 has also need to restore back EL1_S's VBAR_EL1.
> Since both TTBR0_EL1 and VBAR_EL1 are not banked.

Exactly. Together with TTBR1_EL1 and all similar registers. In
general, AArch64 doesn't offer banked registers, as all the switching
can be handled in SW.

> Why aarch64 not just follow aarch32's design for banking TTBR0_EL1
> and VBAR_EL1?  ( that will saving time on context switching between
> S and NS right?)

These registers are banked on AArch32 because there is no EL3 with its
own translation regime, meaning that both S and NS TTBRs have to be
live at the same time for the exception to be handled.

Having the monitor mode turned into a proper exception level has
allowed to remove that constraint, making the architecture simpler
(which is a very important goal for both HW and SW).

As for "saving time", if context switching system registers becomes
the bottleneck on your system, then you're doing something that is
pathologically wrong.

	M.

-- 
Jazz is not dead, it just smell funny.
