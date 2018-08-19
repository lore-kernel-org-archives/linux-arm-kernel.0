From: sophian.yoma@gmail.com (yoma sophian)
Date: Sun, 19 Aug 2018 12:45:03 +0800
Subject: why TTBR0_EL1/VBAR_EL1 not banked in aarch64
In-Reply-To: <868t53pj5i.wl-marc.zyngier@arm.com>
References: <CADUS3onm_h6aq_sQP_pdtrHpbiCok3ofjwd0yTMWFpGxHWstow@mail.gmail.com>
 <5c1fdcd956b1c73d546010add8430f79@www.loen.fr>
 <CADUS3okx-PWqP3N2rCy-WdCMy38oT3sUqtxOqYgbOCbAMmCEpg@mail.gmail.com>
 <CADUS3okzvPoe_xBNDOPtc+kx=0D=r+Rsh2zXM+vOuGaBiuje3w@mail.gmail.com>
 <868t53pj5i.wl-marc.zyngier@arm.com>
Message-ID: <CADUS3o=getrG8E+CF9PC5sdcPQwxE3r2XWfSy=H_-mYEacaLdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi marc:
> On Sat, 18 Aug 2018 17:01:33 +0100,
> You missed the essential part of my answer: Switching from EL1_S to
> EL1_NS (or the other way around) implies that you're transitioning via
> EL3, which is entirely responsible for switching all non-banked system
> registers, which includes TTBR0_EL1.
>
> EL1_S and EL1_NS do not run concurrently. They are multiplexed by EL3,
> which gives the illusion of concurrent execution.
so you mean:
a) EL1_NS modify TTBR0_EL1
b) SMC to EL3
c) EL3 will restore TTBR0_EL1 of EL1_S
EL1_S will always using its own TTBR0_EL1 that saved by EL3, right?
if so, that mean EL3 has also need to restore back EL1_S's VBAR_EL1.
Since both TTBR0_EL1 and VBAR_EL1 are not banked.

Why aarch64 not just follow aarch32's design for banking TTBR0_EL1 and VBAR_EL1?
( that will saving time on context switching between S and NS right?)

thanks for your kind help,
>
> So there is no need for a banked register. All you need is a
> save/restore mechanism at EL3.
