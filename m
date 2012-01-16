From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jan 2012 18:17:12 +0000
Subject: [PATCH] ARM: tls: remove covert channel via TPIDRURW
In-Reply-To: <CAHXqBF+ZhY57875zsv6C3M_gHPiFLL+FbvoJqi0H2Ow1Cgx+Vg@mail.gmail.com>
References: <1326728815-10236-1-git-send-email-will.deacon@arm.com>
 <CAHXqBF+ZhY57875zsv6C3M_gHPiFLL+FbvoJqi0H2Ow1Cgx+Vg@mail.gmail.com>
Message-ID: <20120116181711.GB11088@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 06:14:27PM +0000, Micha? Miros?aw wrote:
> 2012/1/16 Will Deacon <will.deacon@arm.com>:
> > TPIDRURW is a user read/write register forming part of the group of
> > thread registers in more recent versions of the ARM architecture (~v6+).
> >
> > Currently, the kernel does not touch this register, which allows tasks
> > to communicate covertly by reading and writing to the register without
> > context-switching affecting its contents.
> >
> > This patch clears TPIDRURW when TPIDRURO is updated via the set_tls
> > macro, which is called directly from __switch_to. Since the current
> > behaviour makes the register useless to userspace as far as thread
> > pointers are concerned, simply clearing the register (rather than saving
> > and restoring it) will not cause any problems to userspace.
> 
> So why not fix it instead of leaving it useless?

Could do, but since nobody is asking for it and it would become part of the
user-ABI if we did preserve it, I don't see the need right now.

Do you have a compelling use-case for this register?

Will
