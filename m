From: dalias@libc.org (Rich Felker)
Date: Fri, 27 Jun 2014 17:37:43 -0400
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <53ADC5B1.6080905@amacapital.net>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
Message-ID: <20140627213743.GB16724@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 12:27:45PM -0700, Andy Lutomirski wrote:
> Hi ARM people and Kees-
> 
> The "vectors" page appears to be an abomination that's a lot like the
> x86_64 vsyscall page.  IMO it should be phased out.

I'm not a fan of this extreme approach, but if it's taken, there needs
to be some way to continue to make universal binaries which work
safely on:

- Pre-v6, v6, and v7+ hardware.

- Pre-removal and post-removal kernels.

> Step 1: Add an auxvec entry ASAP indicating the address of the vectors
> page if present.  Possibly give some other positive indication if the
> vectors page is *not* present, too.

There should definitely be a positive indication of the absence of the
vectors page if it's removed, and it would also be nice to transition
to having the address non-fixed. What about reusing AT_SYSINFO with:

- AT_SYSINFO undefined having the current meaning: kuser page at the
  legacy fixed location.

- AT_SYSINFO defined as (void *)-1: kuser page disabled; this
  inherently indicates a cpu that supports TLS register and
  ldrex/strex and dmb.

- AT_SYSINFO defined as (void *)-2: kuser page disabled; this
  inherently indicates a cpu that supports TLS register and
  ldrex/strex but requires the old mcr-based barrier.

- AT_SYSINFO defined as any other value: the definition is the base
  address of the "vector page" (kuser helpers).

Disabling the vector page should not be possible at all on pre-v6, but
if you really want to make that possible, the atomic CAS syscall needs
to be made into a public API so we can make a syscall for CAS...

If the multiple values for "kuser page disabled" are deemed to be too
much of a hack, the equivalent information should be encoded in
AT_HWCAP. It's rather ridiculous how much useless information is in
AT_HWCAP while the most useful pieces of information -- whether
hardware atomics work -- is missing. HWCAP_TLS is an approximation for
this, but it's not the same; there are some corner-case CPUs that have
the one but not the other. And it also doesn't address the case where
the kernel traps and emulates the features (which is probably horribly
undesirable from a performance standpoint, but would be a viable
configuration alternative to having the vector page).

> Step 2: Add a config option, off by default, to make the vectors page be
> a normal VMA.  Use _install_special_mapping for it.  See 3.16-rc2 on x86
> for a very simple example.  arm/kernel/process.c has code for this, too,
> but x86's is nicer (no arch_vma_name crap).  Embedded things (and
> Chromium?) can enable this.
> 
> Step 3: Implement an emulated vectors page, just like x86_64 uses for
> vsyscalls now.  This is conceptually simple, but it's a royal PITA for a
> few reasons that I can do into detail about (and help fix!).

What is the difference between an "emulated vectors page" and the
real one?

> Step 4: Eventually convert ARM to use a vDSO instead.  Get rid of
> sigpage and the "vectors" page.  Preserve compatibility by updating the
> auxvec interface.  Provide both AT_SYSINFO_EHDR and AT_VDSO_FINDSYM
> (which is a candidate interface that I might try to push for 3.17).

This would also be okay.

> If anyone does this, merging it with the fancy new x86 vdso code would
> probably be worthwhile.
> 
> The end game would be that systems with new kernels but old userspace
> still work with degraded performance.  New kernels and new userspace are
> quite happy.  New userspace on old kernels won't use the vectors page.

New userspace should be able to run on old kernels. There are plenty
of devices out there where the kernel is not upgradable (e.g. due to
proprietary drivers, or abandoned free ones, that don't work on new
kernels), and one of the big usage cases of musl is to be able to make
static-linked binaries that you can put on such devices to extend
them.

Rich
