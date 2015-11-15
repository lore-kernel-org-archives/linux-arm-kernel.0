From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 15 Nov 2015 16:18 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <6987238.kVeqDX1hGc@wuerfel>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <CA+=Sn1mQ+1HRS_=X-RN92yRXD6Xt6xk-ATiX+u=c3_KYsWgtKg@mail.gmail.com>
 <6987238.kVeqDX1hGc@wuerfel>
Message-ID: <4020288.s2KSidZP6C@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 November 2015 17:10:44 Arnd Bergmann wrote:
> On Friday 13 November 2015 07:38:49 Andrew Pinski wrote:
> > On Fri, Nov 13, 2015 at 7:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thursday 12 November 2015 14:47:18 Andreas Schwab wrote:
> > >> Arnd Bergmann <arnd@arndb.de> writes:
> > >>
> > >> > On Thursday 12 November 2015 10:44:55 Andreas Schwab wrote:
> > >> >> Arnd Bergmann <arnd@arndb.de> writes:
> > >> >>
> > >> >> > What do you mean with 32-bit off_t?
> > >> >>
> > >> >> An ABI with 32-bit off_t, ie. all currently implemented 32-bit ABIs.
> > >> >>
> > >> >> > Do you mean that glibc emulates a 32-bit off_t on top of the 64-bit
> > >> >> > __kernel_loff_t?
> > >> >>
> > >> >> Glibc is bridging the user-space ABI to the kernel ABI.
> > >> >
> > >> > Ok, but why?
> > >>
> > >> That's how the ABI is defined right now.  I didn't make that up.
> > >
> > > Ok, I guess it will remain a mystery then.
> > 
> > The biggest question is here is how much compatibility do we want with
> > other 32bit ABIs?
> > Do we want off_t to be 32bit or 64bit?
> 
> I would much prefer off_t to be defined as __kernel_loff_t unconditionally,
> with no support for _FILE_OFFSET_BITS == 32. This is at least what I had
> in mind when I wrote the asm-generic/unistd.h header.
> 
> We should probably find out what happened for the other glibc ports that
> were implemented for the architectures using this. It's possible that
> there was a good reason for supporting _FILE_OFFSET_BITS == 32 at the
> time, but I can't think of one and maybe it is one that is no longer
> valid.
> 
> Do you know what x86/x32 does for off_t? Do they also implement both
> _FILE_OFFSET_BITS == 32 and _FILE_OFFSET_BITS == 64 on top of the
> 64-bit __kernel_off_t?

I just did a little bit of digging through glibc history and found that
Chris Metcalf added the files that are now in
sysdeps/unix/sysv/linux/generic/wordsize-32/ and that provide the
implementation for 32-bit off_t in glibc on top of the 64-bit
__kernel_off_t.

Chris, do you remember what led to that? Do you think we still need
to have 32-bit off_t on all new architectures, or could we move
on to making 64-bit off_t the default when adding a port?

	Arnd
