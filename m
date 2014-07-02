From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 2 Jul 2014 08:54:39 -0700
Subject: [PATCH v7 8/9] ARM: vdso initialization, mapping,
 and synchronization
In-Reply-To: <20140702144050.GD24879@arm.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-9-git-send-email-nathan_lynch@mentor.com>
 <53B1D8AC.7060104@mit.edu> <20140701090309.GC28164@arm.com>
 <53B2C178.30607@mentor.com> <20140701141541.GP28164@arm.com>
 <CALCETrWeTeeuz4vW6wrhtDrdg54O-hhFbspfKEEunRZ0zf7ZBg@mail.gmail.com>
 <20140702144050.GD24879@arm.com>
Message-ID: <CALCETrUVa-Yt7qZpzkpiAGVf+sYeasNq_YS1MuH6CFfWCcW6BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 2, 2014 at 7:40 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Andy,
>
> On Tue, Jul 01, 2014 at 03:17:23PM +0100, Andy Lutomirski wrote:
>> On Tue, Jul 1, 2014 at 7:15 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Jul 01, 2014 at 03:11:04PM +0100, Nathan Lynch wrote:
>> >> I believe Andy is suggesting separate VMAs (with different VM flags) for
>> >> the VDSO's data and code.  So, breakpoints in code would work, but
>> >> attempts to modify the data page via ptrace() would fail outright
>> >> instead of silently COWing.
>> >
>> > Ah, yes. That makes a lot of sense for the data page -- we should do
>> > something similar on arm64 too, since the CoW will break everything for the
>> > task being debugged. We could also drop the EXEC flags too.
>>
>> If you do this, I have a slight preference for the new vma being
>> called "[vvar]" to match x86.  It'll make the CRIU people happy if and
>> when they port it to ARM.
>
> I quickly hacked something (see below) and now I see the following in
> /proc/$$/maps:
>
> 7fa1574000-7fa1575000 r-xp 00000000 00:00 0                              [vdso]
> 7fa1575000-7fa1576000 r--p 00000000 00:00 0                              [vvar]
>
> Is that what you're after?

Yes, with caveats.

Caveat 1: (minor) if you use _install_special_mapping, then you'll fix
an mremap bug and most of arch_vma_name can go away.

Caveat 2: (major) I'm kind of surprised that this, or the current
code, works reliably.  You're doing something that I tried briefly for
x86_64:

        _end = .;
        PROVIDE(end = .);

        . = ALIGN(PAGE_SIZE);
        PROVIDE(_vdso_data = .);

This sounds great, except that you're assuming that vdso_end -
vdso_start == ALIGN(_end, PAGE_SIZE) - (vdso base address).

If you *fully* strip the vdso (eu-strip --strip-sections), then this
is true: eu-strip --strip-sections outputs just the PT_LOAD piece of
the vdso.  But any binutils-generated incompletely stripped ELF image
contains a section table and possible non-allocatable sections at the
end.  If these exceed the amount of unused space in the last PT_LOAD
page, then they'll spill into the next page, and _vdso_data in the
vdso will no longer match the address at which vdso.c loads it.  Boom!

I bet you're getting away with this because the whole arm64 vdso seems
to be written in assembly, so it seems extremely unlikely to exceed
one page minus a few hundred bytes.  But if you start adding
complexity, you might get unlucky.

The x86_32 solution in v3.15 was to simply reverse the order: stick
the data page before the vdso instead of after it.  This seems to work
fine.

The x86 (all variants) solution in v3.16-rc1 was to fully strip the
vdso.  This broke gdb (and Go, but you won't have that particular
problem on ARM).  In v3.16-rc3, we're using a hack that moves the
section table into an actual allocated section -- this works, and if
the kernel builds then it's guaranteed to work, but I'm now fighting
with weird output from various binutils versions, and at least one
version of binutils can't build 3.16-rc3 for x86_64.

Anyway, all solutions are messy, but the arm64 one has the particular
disadvantage of failing silently.  I think I just got lucky on x86_64
in that I happened to trigger the failure myself before I ever sent
out the patches.

--Andy
