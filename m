From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 27 Jun 2014 12:27:45 -0700
Subject: Thread pointer changes
In-Reply-To: <20140611145533.GT179@brightrain.aerifal.cx>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
Message-ID: <53ADC5B1.6080905@amacapital.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2014 07:55 AM, Rich Felker wrote:
> On Tue, Jun 10, 2014 at 03:28:35AM -0400, Rich Felker wrote:
>> For ARM, I think we should revisit the thread-pointer/atomic inlining
>> work that was done as a sloppy workaround for kernels without the
>> kuser_helper page. If the set_thread_area syscall fails (due to an old
>> kernel that doesn't support it), we can setup a function pointer for
>> the __aeabi_read_tp function that only supports a single main thread
>> and returns its thread pointer. Likewise at this stage we could detect
>> the presence or absence of the kuser_helper page and substitute our
>> own fallbacks (using the instructions directly) if needed. One thing
>> that should be checked though is whether there are any kernel versions
>> which support EABI syscalls but not the thread-pointer setup syscall.
>> If not, there's really no use in having a fallback for that. These
>> slides look like they might shed some light on the history:
>> http://wookware.org/talks/armeabidebconf.pdf
> 
> According to those slides, the EABI-form syscall convention (which
> musl requires) was not added to Linux until 2.6.15. The kuser helpers
> (just thread pointer and atomic cas) were originally added in 2.6.12.
> Since we already have a bigger reason not to support pre-2.6.15
> kernels on ARM, there's no need to worry about whether TLS is
> supported by the kernel; we can just assume __set_thread_area will
> always work.
> 
> As for whether the kuser helper page exists, there are three cases:
> 
> 1. Normal kuser page - everything available and works.
> 
> 2. Mainline kernel CONFIG_KUSER_HELPERS disabled - the page is present
>    but filled with a HCF instruction. This is easy to detect.
> 
> 3. Hardened grsec kernels - the page is completely missing, so
>    attempts to access it fault. And worse yet, most syscalls report
>    EFAULT even if it's present because it's above the task size
>    address limit (in the kernel address range). So far the only way
>    I've found to detect it is process_vm_readv which was not added
>    until 3.2; I'm not sure if there are relevant pre-3.2 grsec kernels
>    with kuser helpers disabled.

Hi ARM people and Kees-

The "vectors" page appears to be an abomination that's a lot like the
x86_64 vsyscall page.  IMO it should be phased out.  I'm not going to do
it (I don't know enough about ARM, and I'm not really able to test),
but, having gone through cleaning up the vsyscall mess a couple of years
ago, I'd be happy to help if anyone is interested in doing it.

I'd suggest:

Step 1: Add an auxvec entry ASAP indicating the address of the vectors
page if present.  Possibly give some other positive indication if the
vectors page is *not* present, too.

Step 2: Add a config option, off by default, to make the vectors page be
a normal VMA.  Use _install_special_mapping for it.  See 3.16-rc2 on x86
for a very simple example.  arm/kernel/process.c has code for this, too,
but x86's is nicer (no arch_vma_name crap).  Embedded things (and
Chromium?) can enable this.

Step 3: Implement an emulated vectors page, just like x86_64 uses for
vsyscalls now.  This is conceptually simple, but it's a royal PITA for a
few reasons that I can do into detail about (and help fix!).

Step 4: Eventually convert ARM to use a vDSO instead.  Get rid of
sigpage and the "vectors" page.  Preserve compatibility by updating the
auxvec interface.  Provide both AT_SYSINFO_EHDR and AT_VDSO_FINDSYM
(which is a candidate interface that I might try to push for 3.17).

If anyone does this, merging it with the fancy new x86 vdso code would
probably be worthwhile.

The end game would be that systems with new kernels but old userspace
still work with degraded performance.  New kernels and new userspace are
quite happy.  New userspace on old kernels won't use the vectors page.


Thoughts?  Any takers?

--Andy
