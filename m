From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 3 Sep 2014 13:12:23 -0700
Subject: [PATCH v9 0/6] ARM: VDSO
In-Reply-To: <540773FA.5020108@mentor.com>
References: <1408744351-7814-1-git-send-email-nathan_lynch@mentor.com>
 <53FE4448.9070708@codeaurora.org> <5406AA1B.3050506@mentor.com>
 <CALCETrX7Q34nyU7YZfQYnYFPVSaquJ5WzO-AVPnW5PJUCNqopQ@mail.gmail.com>
 <540773FA.5020108@mentor.com>
Message-ID: <CALCETrU-PwPqWtFK0gyW9eVgOMNRsfaXzaCKrrz0gN473dikbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 3, 2014 at 1:03 PM, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
> On 09/03/2014 11:59 AM, Andy Lutomirski wrote:
>> On Sep 2, 2014 10:44 PM, "Nathan Lynch" <Nathan_Lynch@mentor.com> wrote:
>>>
>>> On 08/27/2014 03:49 PM, Christopher Covington wrote:
>>>>
>>>> It appears to me that there is code in several architecture subdirectories
>>>> (I'm aware of x86, arm64, and with these patches arm[32] and I would be
>>>> surprised if there weren't more) doing largely the same setup of special
>>>> mappings at randomized offsets, checking ELF magic etc. Not that these patches
>>>> should necessarily do it, but is there a reasonable amount of consolidation
>>>> that could be done, or am I underestimating how much of this really does vary
>>>> per architecture?
>>>
>>> Sorry to not respond to this promptly, was distracted by some other work.
>>>
>>> As Andy said, the possibility for consolidating some aspects of VDSO support
>>> is there, but it would be a fair bit of work.
>>>
>>> For example, arch_setup_additional_pages tends to have the general form of:
>>>
>>> lock mmap_sem
>>> get_unmapped_area
>>> install_special_mapping (or _install_special_mapping, preferably)
>>> stash vdso address in mmu context
>>> release mmap_sem
>>>
>>> But there are a lot of implementation details that differ:
>>>
>>>          +----------------------------------------------------------------
>>>          | Number of VMAs installed
>>>          |   +------------------------------------------------------------
>>>          |   | Considers uses_interp
>>>          |   |     +------------------------------------------------------
>>>          |   |     | Uses _install_special_mapping
>>>          |   |     |     +------------------------------------------------
>>>          |   |     |     | Performs additional work (e.g. remap_pfn_range)
>>>          |   |     |     |     +------------------------------------------
>>>          |   |     |     |     | Randomizes VDSO offset vs stack and libs
>>>          |   |     |     |     |     +------------------------------------
>>>          |   |     |     |     |     | Records VDSO address in mmu context
>>>          |   |     |     |     |     |     +------------------------------
>>>          |   |     |     |     |     |     | Supports compat VDSO
>>>          |   |     |     |     |     |     |     +------------------------
>>>          |   |     |     |     |     |     |     | Supports disabling VDSO
>>>          |   |     |     |     |     |     |     | at boot (e.g. vdso=off)
>>>          |   |     |     |     |     |     |     |     +------------------
>>>          |   |     |     |     |     |     |     |     | Can disable VDSO
>>>  arch    |   |     |     |     |     |     |     |     | via Kconfig
>>> ---------+---+-----+-----+-----+-----+-----+-----+-----+------------------
>>>  arm*    | 3 | no  | yes | no  | yes | yes | no  | no  | yes
>>>  arm64   | 2 | no  | yes | no  | no  | yes | no  | no  | no
>>>  hexagon | 1 | no  | no  | no  | no  | yes | no  | no  | no
>>>  mips    | 1 | no  | no  | no  | no  | yes | no  | no  | no
>>>  powerpc | 1 | no  | no  | no  | no  | yes | yes | no  | no
>>>  s390    | 1 | yes | no  | no  | no  | yes | yes | yes | no
>>>  sh      | 1 | no  | no  | no  | no  | yes | no  | yes | yes
>>>  tile    | 1 | no  | no  | yes | no  | yes | no  | yes | no
>>>  x86     | 2 | no  | yes | yes | yes | yes | yes | yes | no
>>>
>>> * With VDSO patches from this thread, of course.
>>>
>>> I think pushing the mmap_sem lock/unlock up into the ELF loader might be
>>> of some benefit (slightly reduced complexity in the arch code).  But
>>> any generic replacement for arch_setup_additional_pages will have to
>>> account for all the differences above, and probably a few more I've
>>> missed.
>>>
>>
>> Wow, nice table!  I think that we should eventually get rid of most of
>> these differences.
>
> Thanks, and agreed.
>
>
>> Christopher, since you seem to be interested in CRIU, one thing to
>> note is that any architecture that shoves a pointer to the vdso into
>> the mmu context is likely to fail if the vdso is mremapped.  CRIU
>> needs to mremap the vdso, so this is a problem.
>>
>> x86_64 is an exception: it doesn't use that pointer for anything.
>
> Hmm, I would expect architectures that implement arch_vma_name like so
> to experience problems with CRIU:
>
> const char *arch_vma_name(struct vm_area_struct *vma)
> {
>         if (vma->vm_mm && vma->vm_start == vma->vm_mm->context.vdso_base)
>                 return "[vdso]";
>         return NULL;
> }
>
> Is this what you're referring to?

I never entirely understood why this wasn't a bigger problem.  I think
it only really caused problems when checkpointing, restoring,
checkpointing *again*, and getting unlucky.

>
> Looking at 3.17-rc3, every arch uses mm_context_t->vdso_base or
> similar to provide a value for AT_SYSINFO_EHDR at exec time.
> Is this also problematic?
>

This one's fine, since it's very hard to mremap between mapping the
vdso and having exec return.

The ones that are serious problems (on x86 32-bit userspace, at least)
are the vdso sigreturn trampoline and, even worse, the vdso sysexit
trampoline.  The latter will cause every syscall on any native 32-bit
system or on any 32-bit compat code running on an Intel CPU to
segfault immediately upon mremapping the vdso.

--Andy
