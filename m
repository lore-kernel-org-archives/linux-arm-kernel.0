From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 May 2014 10:05:35 +0100
Subject: [PATCH] arm64: don't set READ_IMPLIES_EXEC for EM_AARCH64
In-Reply-To: <20140514185720.GI26038@redacted.bos.redhat.com>
References: <20140514185720.GI26038@redacted.bos.redhat.com>
Message-ID: <20140515090535.GB27594@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 07:57:21PM +0100, Kyle McMartin wrote:
> current->personality & READ_IMPLIES_EXEC is currently being set for
> AArch64 binaries, resulting in an executable stack, when no explicit
> PT_GNU_STACK header is present.
> 
> [kmcmarti at sedition ~]$ uname -p
> aarch64
> [kmcmarti at sedition ~]$ cat /proc/$$/personality 
> 00400000
> 
> The reason for this is, without an explicit PT_GNU_STACK entry in the
> binary, stk is still set to EXSTACK_DEFAULT (which should be
> non-executable on AArch64.) As a result, elf_read_implies_exec is true,
> and we set READ_IMPLIES_EXEC in binfmt_elf.c:load_elf_binary.
> 
> Fix this to return 0 in the native case, and parrot the logic from
> arch/arm/kernel/elf.c otherwise. With this patch, binaries correctly
> don't have READ_IMPLIES_EXEC set, and we can let PT_GNU_STACK change
> things if it's explicitly requested.

Unfortunately, my understanding is that GCC currently requires this for
nested functions, so this is an effective ABI breakage. On the plus side,
the GCC guys are planning to fix that, so we should see PT_GNU_STACK getting
used more frequently in the future.

Will
