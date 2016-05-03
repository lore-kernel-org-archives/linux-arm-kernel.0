From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 3 May 2016 10:00:45 +0100
Subject: [PATCH 24/25] arm64:ilp32: add vdso-ilp32 and use for signal
 return
In-Reply-To: <1554541.oDP7Ro5zB2@wuerfel>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-25-git-send-email-ynorov@caviumnetworks.com>
 <20160429160154.GC30316@e104818-lin.cambridge.arm.com>
 <1554541.oDP7Ro5zB2@wuerfel>
Message-ID: <20160503090045.GB10733@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 07:30:19PM +0200, Arnd Bergmann wrote:
> On Friday 29 April 2016 17:01:55 Catalin Marinas wrote:
> > On Wed, Apr 06, 2016 at 01:08:46AM +0300, Yury Norov wrote:
> > > ILP32 VDSO exports next symbols:
> > >  __kernel_rt_sigreturn;
> > >  __kernel_gettimeofday;
> > >  __kernel_clock_gettime;
> > >  __kernel_clock_getres;
> > 
> > [...]
> > 
> > > +$(obj)/gettimeofday-ilp32.o: $(src)/../vdso/gettimeofday.S
> > > +	$(call if_changed_dep,vdso-ilp32as)
> > 
> > Are struct timeval and timespec the same between ILP32 and LP64? For
> > example, __kernel_gettimeofday() assumes TVAL_TV_SEC offset defined in
> > asm-offsets.c based on the LP64 timeval.
> 
> No, ilp32 uses the generic 32-bit data structures, which have a 32-bit
> time_t. I guess that means it can work for little-endian but not
> big-endian, right?

I don't think it works for little-endian either. The LP64 struct timeval
is 16 bytes while the ILP32 one is 8 bytes. The VDSO gettimeofday is
storing 16 bytes (stp x10, x11, [x0, #TVAL_TV_SEC])

-- 
Catalin
