From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Oct 2012 00:09:57 +0100
Subject: [PATCH] arm: include linux/sched.h in syscall.h
In-Reply-To: <20121002155255.GJ11278@mudshark.cambridge.arm.com>
References: <5069F8A0.5020801@mentor.com>
 <20121002122124.GB11278@mudshark.cambridge.arm.com>
 <506B0BB0.5060707@mentor.com>
 <20121002155255.GJ11278@mudshark.cambridge.arm.com>
Message-ID: <20121004230957.GC4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2012 at 04:52:55PM +0100, Will Deacon wrote:
> On Tue, Oct 02, 2012 at 04:43:44PM +0100, Wade Farnsworth wrote:
> > > On Mon, Oct 01, 2012 at 09:10:08PM +0100, Wade Farnsworth wrote:
> > >> task_thread_info() is defined in linux/sched.h.  Explicitly include this
> > >> file in arch/arm/include/asm/syscall.h.  This fixes an lttng-modules compile error.
> > >
> > > Can you be more specific about the error? From your description, it sounds
> > > like it should be fixed in lttng rather than here.
> > >
> > My apologies for the lack of clarity.
> > 
> > My syscall tracing patch introduces a compile bug in lttng-modules when 
> > the latter calls syscall_get_nr(), similar to the following:
> > 
> > <path-to-linux>/arch/arm/include/asm/syscall.h:21:2: error: implicit 
> > declaration of function 'task_thread_info' 
> > [-Werror=implicit-function-declaration]
> > 
> > The issue is that we are using task_thread_info() in the 
> > syscall_get_nr() function in asm/syscall.h, but not explicitly including 
> > sched.h from this file, so we can expect this bug might surface any time 
> > that syscall_get_nr() is called.
> > 
> > Hopefully that clarifies things somewhat.
> 
> Yep, thanks. Your patch sounds like the right thing to do, but please
> include the compiler error in your commit log.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

>From what I can tell, the original commit went in during the 3.4..3.5
timeframe, so doesn't this patch need to be applied to v3.5-stable
as well as 3.6-stable and for 3.7 ?
