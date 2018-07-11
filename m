From: osandov@osandov.com (Omar Sandoval)
Date: Wed, 11 Jul 2018 09:24:23 -0700
Subject: [PATCH] arm64/mm: Introduce a variable to hold base address of
 linear region
In-Reply-To: <CACi5LpMRSuLEA0BSnbaxmQNZOdyp19XZEJK1AHntxTvnuquj_g@mail.gmail.com>
References: <20180619094045.GD13984@arm.com>
 <a720d91be20844cd9ed84728268300d9@HXTBJIDCEMVIW02.hxtcorp.net>
 <09260c7e-8b9d-bc3c-5bca-0fd75417f552@arm.com>
 <CACi5LpMoKP4eG5XhYe5hf5VC9MOY8KuHK=j0ujb8GFpyjAuAww@mail.gmail.com>
 <b0d40351-8d78-fd69-cc87-d5ea5eaabd2a@arm.com>
 <CACi5LpM2GV-vwcEGeCE20QW0PVmDcKnjz017sYBAwYRfZ24AzA@mail.gmail.com>
 <51cf54d6a19f4837b74218b000cc23bc@HXTBJIDCEMVIW02.hxtcorp.net>
 <CACi5LpMXpSWUP97R2VWjf==LdxPBCKTcpKjQjCs4j3Kz9SzYGg@mail.gmail.com>
 <cb5cf891-cf46-3afc-0c77-6667165caf7a@arm.com>
 <CACi5LpMRSuLEA0BSnbaxmQNZOdyp19XZEJK1AHntxTvnuquj_g@mail.gmail.com>
Message-ID: <20180711162423.GA27477@vader>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 09:06:27PM +0530, Bhupesh Sharma wrote:
> Hi James,
> 
> On Wed, Jul 11, 2018 at 6:54 PM, James Morse <james.morse@arm.com> wrote:
> > Hi Bhupesh,
> >
> > (CC: +Omar)
> >
> > On 20/06/18 08:26, Bhupesh Sharma wrote:
> >> On Wed, Jun 20, 2018 at 7:46 AM, Jin, Yanjiang
> >> <yanjiang.jin@hxt-semitech.com> wrote:
> >>>> From: Bhupesh Sharma [mailto:bhsharma at redhat.com]
> >>>> On Tue, Jun 19, 2018 at 4:56 PM, James Morse <james.morse@arm.com> wrote:
> >>>>> I'm suggesting adding the contents of vmcoreinfo as a PT_NOTE section
> >>>>> of /proc/kcore's ELF header. No special knowledge necessary, any
> >>>>> elf-parser should be able to dump the values.
> >
> > [..]
> >>>> I am working on fixes on the above lines for kernel and user-space tools (like
> >>>> makedumpfile, crash-utility and kexec-tools).
> >>>>
> >>>> I will post some RFC patches on the same lines (or come back in case I get stuck
> >>>> somewhere) shortly.
> >
> > I spotted this series from Omar:
> > https://lkml.org/lkml/2018/7/6/866
> >
> > Hopefully it does what you need?
> 
> Thanks a lot for sharing this useful series.
> 
> BTW, I am sorry for taking a long time to reply to this thread, but I
> was reading some x86_64/ppc legacy code and also experimenting with
> approaches in both user-space and kernel-space and have some
> interesting updates.
> 
> Just to recap, there are two separate issues we are seeing with arm64
> with user-space utilities which are used for debugging live systems or
> crashed kernels:
> 
> - Availability of PHYS_OFFSET in user-space (both for KASLR and
> non-KASLR boot cases):
> 
> I see two approaches to fix this issue:
> 1. Fix inside Kernel:
> a). See <https://www.spinics.net/lists/kexec/msg20847.html> for
> background details. Having PHY_OFFSET added to the '/proc/kcore' as a
> PT_NOTE (it is already added to vmcore as a NUMBER) would suffice.
> 
> b). Omar's series add the vmcoreinfo to the kcore itself, so it would
> be sufficient for the above case as well, since PHYS_OFFSET is already
> added to the vmcoreinfo inside 'arch/arm64/kernel/machine_kexec.c':
> 
> void arch_crash_save_vmcoreinfo(void)
> {
>     <..snip..>
>     vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
>                         PHYS_OFFSET);
>     <..snip..>
> }
> 
> c). This will help the cases where we are debugging a 'live' (or
> running system).
> 
> 2. Fix inside user-space:
> a). See as an example a flaky reference implementation in
> 'kexec-tools': See
> <https://github.com/bhupesh-sharma/kexec-tools/commit/e8f920158ce57399c770c7160711a72fc740f1d6>
>  - Note that the calculation of 'ARM64_MEMSTART_ALIGN' value in
> user-space is quite tricky (as is evident from the above
> implementation and I took an easy route for my specific PAGE_SIZE and
> VA_BITS combination).
> 
> b). For some user-space tools like crash and makedumpfile, the
> underlying macros like PMD_SHIFT etc have been added as arch-specific
> code, so they can handle such implementation better.
> 
> c). But this again means adding more arch specific code to user-space,
> which probably not advisable.
> 
> So, we will be better suited to go with a KERNEL fix for this case and
> Omar's series should help. I will go ahead and give it a try for
> arm64.

Thanks, please do take a look. A Reviewed-by (or at least Tested-by)
would help get it merged.

Note that for my use case, the workaround I've been using for now is to
get the physical address and size of vmcoreinfo from
/sys/kernel/vmcoreinfo, then reading from that physical address in
/proc/kcore (assuming that your kernel is new enough to fill in p_paddr
in the /proc/kcore segments).
