From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Mar 2013 11:30:48 +0000
Subject: [PATCH v1] ARM: keep __my_cpu_offset consistent with generic one
In-Reply-To: <CACVXFVOEvvFT805TJHoppqGRLTRuP18=Wg72LSXryffZD_WH1A@mail.gmail.com>
References: <1362663356-21151-1-git-send-email-tom.leiming@gmail.com>
 <CACVXFVOhr222CVrzkVP_oLgVkdReD9BXXSBg7fmp6Wvx9_peCw@mail.gmail.com>
 <20130312105638.GQ4977@n2100.arm.linux.org.uk>
 <CACVXFVOEvvFT805TJHoppqGRLTRuP18=Wg72LSXryffZD_WH1A@mail.gmail.com>
Message-ID: <20130312113048.GS4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 07:25:28PM +0800, Ming Lei wrote:
> On Tue, Mar 12, 2013 at 6:56 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >>
> >> Looks no one objects the patch, so I has submitted it into Russell's
> >> patch system, and hope it can be pushed to linus tree soon and
> >> make LOCK_STAT/DEBUG_LOCKDEP usable on ARMv7.
> >
> > I'm not convinced it is correct.  Is the percpu data as stored in the
> > kernel image (in other words, at offset zero) supposed to be read only?
> 
> It should have been used after setup_per_cpu_areas().
> 
> > If so, the above means that we'll be accessing that rather than the
> > copy of the percpu data we should be accessing.
> 
> I admit the patch is a work around for the problem, but it is harmless
> to make lockdep workable on arm at least.
> 
> > The percpu data areas are allocated by setup_per_cpu_areas() - that's
> > where we should be initializing this, just like it's done on PowerPC.
> 
> >From the entry of start_kernel to setup_per_cpu_areas, there are many
> locks which will be acquired/released, so the percpu variable in lock_release
> has to be used early now.  Either disabling lockdep during the period or
> introducing stupid/simple percpu variable inside lockdep may fix the probem,
> but looks both aren't perfect.
> 
> So the workaround is proposed in this patch...
> 
> Ingo and Peter, what is your opinion on the problem?

Having discussed this with Ben Herrenschmidt, it seems that we do need
to have a more complex patch to sort this out - we need to setup our
private pointer inside setup_per_cpu_areas().
