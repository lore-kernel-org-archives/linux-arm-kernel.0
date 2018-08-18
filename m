From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 18 Aug 2018 20:30:17 +0100
Subject: why TTBR0_EL1/VBAR_EL1 not banked in aarch64
In-Reply-To: <CADUS3okzvPoe_xBNDOPtc+kx=0D=r+Rsh2zXM+vOuGaBiuje3w@mail.gmail.com>
References: <CADUS3onm_h6aq_sQP_pdtrHpbiCok3ofjwd0yTMWFpGxHWstow@mail.gmail.com>
 <5c1fdcd956b1c73d546010add8430f79@www.loen.fr>
 <CADUS3okx-PWqP3N2rCy-WdCMy38oT3sUqtxOqYgbOCbAMmCEpg@mail.gmail.com>
 <CADUS3okzvPoe_xBNDOPtc+kx=0D=r+Rsh2zXM+vOuGaBiuje3w@mail.gmail.com>
Message-ID: <868t53pj5i.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 18 Aug 2018 17:01:33 +0100,
yoma sophian <sophian.yoma@gmail.com> wrote:
> 
> (fix typo)
> > > Switching between EL1_S and EL1_NS implies that EL3 is performing a
> > > full
> > > context switch of the system, similar to EL2 performing a switch
> > > between
> > > guests running at EL1_NS.
> But here EL1_NS can directly modify TTBR0_EL1,
> Since TTRB0_EL1 is accessible by EL1_NS and  it is not banked.
> there is no need for switching to EL1_S at all.

You missed the essential part of my answer: Switching from EL1_S to
EL1_NS (or the other way around) implies that you're transitioning via
EL3, which is entirely responsible for switching all non-banked system
registers, which includes TTBR0_EL1.

EL1_S and EL1_NS do not run concurrently. They are multiplexed by EL3,
which gives the illusion of concurrent execution.

So there is no need for a banked register. All you need is a
save/restore mechanism at EL3.

	M.

-- 
Jazz is not dead, it just smell funny.
