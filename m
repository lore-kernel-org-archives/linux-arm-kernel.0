From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 11:03:55 +0100
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20151202002430.GB23156@yury-N73SV>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1608639.5Yic1PH469@wuerfel> <20151202002430.GB23156@yury-N73SV>
Message-ID: <2307165.72VALbNc43@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 03:24:30 Yury Norov wrote:
> On Tue, Dec 01, 2015 at 12:30:56PM +0100, Arnd Bergmann wrote:
> > On Tuesday 01 December 2015 12:01:12 Andreas Schwab wrote:
> > > Arnd Bergmann <arnd@arndb.de> writes:
> > > 
> > > > On Tuesday 01 December 2015 10:20:59 Andreas Schwab wrote:
> > > >> Yury Norov <ynorov@caviumnetworks.com> writes:
> > > >> 
> > > >> > There's a tricky bug with signal stack, that Andreas also discovered.
> > > >> 
> > > >> That was only a confusion about the compat state of sys_rt_sigaction.
> > > >> It just requires making sure glibc uses the correct (64bit layout)
> > > >> struct kernel_sigaction.
> > > >
> > > > I don't think we need to use the 64-bit version of sigaction, both
> > > > kernel and libc are simpler if we use the normal 32-bit version.
> > > 
> > > Since glibc has to do the conversion anyway (due to sigset_t), using the
> > > 64bit layout avoids a second conversion in the kernel.
> > 
> > I don't get the part about sigset_t. Why would glibc want to use the
> > 64-bit layout? This one looks like one of the cases where we absolutely
> > want to use the 32-bit layout or otherwise get into big trouble if
> > we ever want to support native ILP32 kernels.
> > 
> >       Arnd
> 
> So, we drop patch #6, and use 32-bit layout for all signal structures.
> 
> Correct?

If the 32-bit layout is sane, yes. Andrew can surely judge this better
than I can. The goal should be to have the most straightforward
implementation for both kernel and libc, and reuse either the compat
signal handling or the native one as much as we can.

Looking at the API, I find that ARM fortunately uses all the standard
definitions for sigset_t, struct siginfo/siginfo_t, union sigval/sigval_t,
struct sigaction, struct sigaltstack/stack_t. It took me a while to
figure out that the definitions in the uapi headers are different but
actually unused (probably remaining from libc5 days or earlier).
The signal numbers are all the same, and so are the 

The SA_* flags are all the same too, except for SA_THIRTYTWO, but
that is not implemented by the compat handling because we do not
support 26 bit tasks anyway.

struct sigcontext is obviously different because of the changed
register set, and we will have to deal with that in some form in the
compat code. struct ucontext and struct rt_sigframe includes that,
which I assume is the main part we need to handle correctly
by having ilp32 specific setup_rt_frame/sys_rt_sigreturn functions.

One small difference is the handling of MINSIGSTKSZ, which would
currently work for ilp32, but I noticed that commit c9692657c032
("arm64: Fix MINSIGSTKSZ and SIGSTKSZ") from Manjeet Pawar broke
compat mode: Any 32-bit (aarch32) task that passes an altstack smaller
than 5120 bytes now gets rejected by the kernel, whereas the native
32-bit kernel checks for 2048 bytes instead. We need to fix the
existing compat case here without breaking the ilp32 case.

With all that said, I would assume that just having separate
sigcontext/ucontext/rt_sigframe and reusing the compat code otherwise,
we are overall better off than with using the native 64-bit signal
handling with everything that ties in (waitid, epoll_pwait,
signalfd, ppoll, ...), but we can discuss this further if someone
sees major downsides of that compared to your existing approach.
In particular, I don't know what the difference means for gdb,
glibc or strace.


	Arnd
