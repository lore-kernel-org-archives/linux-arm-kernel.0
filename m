From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Mar 2013 10:56:38 +0000
Subject: [PATCH v1] ARM: keep __my_cpu_offset consistent with generic one
In-Reply-To: <CACVXFVOhr222CVrzkVP_oLgVkdReD9BXXSBg7fmp6Wvx9_peCw@mail.gmail.com>
References: <1362663356-21151-1-git-send-email-tom.leiming@gmail.com>
 <CACVXFVOhr222CVrzkVP_oLgVkdReD9BXXSBg7fmp6Wvx9_peCw@mail.gmail.com>
Message-ID: <20130312105638.GQ4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 10:32:21AM +0800, Ming Lei wrote:
> On Thu, Mar 7, 2013 at 9:35 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> > Commit 14318efb(ARM: 7587/1: implement optimized percpu variable access)
> > introduces arm's __my_cpu_offset to optimize percpu vaiable access,
> > which really works well on hackbench, but will cause __my_cpu_offset
> > to return garbage value before it is initialized in cpu_init() called
> > by setup_arch, so accessing percpu variable before setup_arch may cause
> > kernel hang. But generic __my_cpu_offset always returns zero before
> > percpu area is brought up, and won't hang kernel.
> >
> > So the patch tries to clear __my_cpu_offset on boot CPU early
> > to avoid boot hang.
> >
> > At least now percpu variable is accessed by lockdep before
> > setup_arch(), and enabling CONFIG_LOCK_STAT or CONFIG_DEBUG_LOCKDEP
> > can trigger kernel hang.
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Nicolas Pitre <nico@linaro.org>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> > ---
> > V1:
> >         - documents lockdep uses percpu variable early
> 
> Looks no one objects the patch, so I has submitted it into Russell's
> patch system, and hope it can be pushed to linus tree soon and
> make LOCK_STAT/DEBUG_LOCKDEP usable on ARMv7.

I'm not convinced it is correct.  Is the percpu data as stored in the
kernel image (in other words, at offset zero) supposed to be read only?
If so, the above means that we'll be accessing that rather than the
copy of the percpu data we should be accessing.

The percpu data areas are allocated by setup_per_cpu_areas() - that's
where we should be initializing this, just like it's done on PowerPC.
