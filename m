From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 3 Sep 2014 00:41:47 -0500
Subject: [PATCH v9 0/6] ARM: VDSO
In-Reply-To: <53FE4448.9070708@codeaurora.org>
References: <1408744351-7814-1-git-send-email-nathan_lynch@mentor.com>
 <53FE4448.9070708@codeaurora.org>
Message-ID: <5406AA1B.3050506@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2014 03:49 PM, Christopher Covington wrote:
> 
> It appears to me that there is code in several architecture subdirectories
> (I'm aware of x86, arm64, and with these patches arm[32] and I would be
> surprised if there weren't more) doing largely the same setup of special
> mappings at randomized offsets, checking ELF magic etc. Not that these patches
> should necessarily do it, but is there a reasonable amount of consolidation
> that could be done, or am I underestimating how much of this really does vary
> per architecture?

Sorry to not respond to this promptly, was distracted by some other work.

As Andy said, the possibility for consolidating some aspects of VDSO support
is there, but it would be a fair bit of work.

For example, arch_setup_additional_pages tends to have the general form of:

lock mmap_sem
get_unmapped_area
install_special_mapping (or _install_special_mapping, preferably)
stash vdso address in mmu context
release mmap_sem

But there are a lot of implementation details that differ:

         +----------------------------------------------------------------
         | Number of VMAs installed
         |   +------------------------------------------------------------
         |   | Considers uses_interp
         |   |     +------------------------------------------------------
         |   |     | Uses _install_special_mapping
         |   |     |     +------------------------------------------------
         |   |     |     | Performs additional work (e.g. remap_pfn_range)
         |   |     |     |     +------------------------------------------
         |   |     |     |     | Randomizes VDSO offset vs stack and libs
         |   |     |     |     |     +------------------------------------
         |   |     |     |     |     | Records VDSO address in mmu context
         |   |     |     |     |     |     +------------------------------
         |   |     |     |     |     |     | Supports compat VDSO
         |   |     |     |     |     |     |     +------------------------
         |   |     |     |     |     |     |     | Supports disabling VDSO
         |   |     |     |     |     |     |     | at boot (e.g. vdso=off)
         |   |     |     |     |     |     |     |     +------------------
         |   |     |     |     |     |     |     |     | Can disable VDSO
 arch    |   |     |     |     |     |     |     |     | via Kconfig
---------+---+-----+-----+-----+-----+-----+-----+-----+------------------
 arm*    | 3 | no  | yes | no  | yes | yes | no  | no  | yes
 arm64   | 2 | no  | yes | no  | no  | yes | no  | no  | no
 hexagon | 1 | no  | no  | no  | no  | yes | no  | no  | no
 mips    | 1 | no  | no  | no  | no  | yes | no  | no  | no
 powerpc | 1 | no  | no  | no  | no  | yes | yes | no  | no
 s390    | 1 | yes | no  | no  | no  | yes | yes | yes | no
 sh      | 1 | no  | no  | no  | no  | yes | no  | yes | yes
 tile    | 1 | no  | no  | yes | no  | yes | no  | yes | no
 x86     | 2 | no  | yes | yes | yes | yes | yes | yes | no

* With VDSO patches from this thread, of course.

I think pushing the mmap_sem lock/unlock up into the ELF loader might be
of some benefit (slightly reduced complexity in the arch code).  But
any generic replacement for arch_setup_additional_pages will have to
account for all the differences above, and probably a few more I've
missed.
