From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jul 2018 11:47:20 +0100
Subject: [PATCHv4 00/19] arm64: invoke syscalls with pt_regs
In-Reply-To: <20180710103901.GA31318@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
 <20180710103901.GA31318@arm.com>
Message-ID: <20180711104720.3h65gkbsphaugqht@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 11:39:02AM +0100, Will Deacon wrote:
> On Mon, Jul 02, 2018 at 12:03:56PM +0100, Mark Rutland wrote:
> > This series reworks arm64's syscall handling to minimize the propagation
> > of user-controlled register values into speculated code paths. As with
> > x86 [1], a wrapper is generated for each syscall, which extracts the
> > argument from a struct pt_regs. During kernel entry from userspace,
> > registers are zeroed.
> > 
> > The arm64 kernel code directly invokes some syscalls which the x86 code
> > doesn't, so I've added ksys_* wrappers for these, following the x86
> > example. The rest of the series is arm64-specific.
> > 
> > I've pushed the series out to my arm64/syscall-regs branch [2] on
> > kernel.org.
> 
> One thing I noticed with this series applied is that our sys_call_table
> declarations all get a bit muddled:
> 
> arm64/kernel/sys.c:		void * const sys_call_table[]
> arm64/kernel/sys32.c:		void * const compat_sys_call_table[]
> arm64/kernel/syscall.c:		extern syscall_fn_t sys_call_table[];
> 				extern syscall_fn_t compat_sys_call_table[];
> arm64/include/asm/syscall.h:	extern const void *sys_call_table[];
> 
> Can we tidy this up so that syscall.h provides a declaration using
> syscall_fn_t, allowing us to drop the additional externs?

Sure; done.

As a result, I've had to fold a few more consts into function prototypes
in subsequent patches, but that's probably a good thing.

This also makes me realise that once the generation of the table address
is converted to C, we can drop the alignment on the tables. That was
solely to simplify the asm invoking the syscall, allowing it to generate
the address with an adrp. The C code never relied on this, since the
alignment was not in the declaration of the tables.

I've spun an additional patch for that, too.

I've pushed hte result out to my arm64/syscall-regs branch. I guess I'll
post a v5 once that's seen some testing.

Thanks,
Mark.
