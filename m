From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jan 2012 18:56:45 +0000
Subject: [PATCH] ARM: tls: remove covert channel via TPIDRURW
In-Reply-To: <CAHXqBFLhTq_mJ+SV+STDOwdxACGkiuk4-W_v2LKw1J_YnTS5vw@mail.gmail.com>
References: <1326728815-10236-1-git-send-email-will.deacon@arm.com>
 <CAHXqBF+ZhY57875zsv6C3M_gHPiFLL+FbvoJqi0H2Ow1Cgx+Vg@mail.gmail.com>
 <20120116181711.GB11088@mudshark.cambridge.arm.com>
 <CAHXqBFLhTq_mJ+SV+STDOwdxACGkiuk4-W_v2LKw1J_YnTS5vw@mail.gmail.com>
Message-ID: <20120116185644.GE11088@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 06:25:48PM +0000, Micha? Miros?aw wrote:
> W dniu 16 stycznia 2012 19:17 u?ytkownik Will Deacon
> <will.deacon@arm.com> napisa?:
> > On Mon, Jan 16, 2012 at 06:14:27PM +0000, Micha? Miros?aw wrote:
> >> 2012/1/16 Will Deacon <will.deacon@arm.com>:
> >> > TPIDRURW is a user read/write register forming part of the group of
> >> > thread registers in more recent versions of the ARM architecture (~v6+).
> >> >
> >> > Currently, the kernel does not touch this register, which allows tasks
> >> > to communicate covertly by reading and writing to the register without
> >> > context-switching affecting its contents.
> >> >
> >> > This patch clears TPIDRURW when TPIDRURO is updated via the set_tls
> >> > macro, which is called directly from __switch_to. Since the current
> >> > behaviour makes the register useless to userspace as far as thread
> >> > pointers are concerned, simply clearing the register (rather than saving
> >> > and restoring it) will not cause any problems to userspace.
> >> So why not fix it instead of leaving it useless?
> > Could do, but since nobody is asking for it and it would become part of the
> > user-ABI if we did preserve it, I don't see the need right now.
> >
> > Do you have a compelling use-case for this register?
> 
> Not really.

Ok, it would be interesting to know if anybody has a good application for
this though. Until then, I don't think it's worth the extra space in our
thread_info structure.

> Clearing the register will allow a thread to notice when it gets
> switched. I don't know if that's an issue, though.

Yes, that's definitely worth bearing in mind, although I don't think it's a
problem (and if it is, it's certainly better than what we had before!).

Will
