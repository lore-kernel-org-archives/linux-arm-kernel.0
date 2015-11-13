From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Nov 2015 17:10:44 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <CA+=Sn1mQ+1HRS_=X-RN92yRXD6Xt6xk-ATiX+u=c3_KYsWgtKg@mail.gmail.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <3810107.ZiMyX4Iloo@wuerfel>
 <CA+=Sn1mQ+1HRS_=X-RN92yRXD6Xt6xk-ATiX+u=c3_KYsWgtKg@mail.gmail.com>
Message-ID: <6987238.kVeqDX1hGc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 November 2015 07:38:49 Andrew Pinski wrote:
> On Fri, Nov 13, 2015 at 7:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 12 November 2015 14:47:18 Andreas Schwab wrote:
> >> Arnd Bergmann <arnd@arndb.de> writes:
> >>
> >> > On Thursday 12 November 2015 10:44:55 Andreas Schwab wrote:
> >> >> Arnd Bergmann <arnd@arndb.de> writes:
> >> >>
> >> >> > What do you mean with 32-bit off_t?
> >> >>
> >> >> An ABI with 32-bit off_t, ie. all currently implemented 32-bit ABIs.
> >> >>
> >> >> > Do you mean that glibc emulates a 32-bit off_t on top of the 64-bit
> >> >> > __kernel_loff_t?
> >> >>
> >> >> Glibc is bridging the user-space ABI to the kernel ABI.
> >> >
> >> > Ok, but why?
> >>
> >> That's how the ABI is defined right now.  I didn't make that up.
> >
> > Ok, I guess it will remain a mystery then.
> 
> The biggest question is here is how much compatibility do we want with
> other 32bit ABIs?
> Do we want off_t to be 32bit or 64bit?

I would much prefer off_t to be defined as __kernel_loff_t unconditionally,
with no support for _FILE_OFFSET_BITS == 32. This is at least what I had
in mind when I wrote the asm-generic/unistd.h header.

We should probably find out what happened for the other glibc ports that
were implemented for the architectures using this. It's possible that
there was a good reason for supporting _FILE_OFFSET_BITS == 32 at the
time, but I can't think of one and maybe it is one that is no longer
valid.

Do you know what x86/x32 does for off_t? Do they also implement both
_FILE_OFFSET_BITS == 32 and _FILE_OFFSET_BITS == 64 on top of the
64-bit __kernel_off_t?

> > Should we perhaps define __ARCH_WANT_SYSCALL_OFF_T for the unistd.h
> > file then, so we provide both the off_t and the loff_t based syscalls?
> 
> I think that is backwards ...
> 
> >
> > That would avoid the extra wrapper in glibc when using a 32-bit
> > off_t if that is the preferred mode for user space.
> 
> 
> Other targets like tilegx does not do that and has a pure 32bit mode.
> Only score does that.

score was unintentional, it was the first port that got done after we
introduced the generic headers, and they said at the time that they
would change their libc to remove the dependency on the legacy syscalls,
but when I tried to remove them later, they had already shipped it
with them enabled. After that, I told people to never enable the
symbols in an upstream port and only use them for porting their libc
internally. We could actually now move all the legacy syscall stuff
to arch/score/include/uapi/asm/unistd.h, to prevent anyone else from
using it any longer, as glibc works fine without them these days.

The __ARCH_WANT_SYSCALL_OFF_T define might be an exception. If the glibc
developers want to keep using 32-bit off_t by default on all new
architecture, we could include those calls again by default.

	Arnd
