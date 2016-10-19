From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Oct 2016 17:30:49 +0200
Subject: [PATCH 2/3] ARM: convert to generated system call tables
In-Reply-To: <E1bwa6s-0004ZY-4k@rmk-PC.armlinux.org.uk>
References: <E1bwa6s-0004ZY-4k@rmk-PC.armlinux.org.uk>
Message-ID: <13702107.LdHY4HTXyY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 18, 2016 8:31:38 PM CEST Russell King wrote:
> Convert ARM to use a similar mechanism to x86 to generate the unistd.h
> system call numbers and the various kernel system call tables.  This
> means that rather than having to edit three places (asm/unistd.h for
> the total number of system calls, uapi/asm/unistd.h for the system call
> numbers, and arch/arm/kernel/calls.S for the call table) we have only
> one place to edit, making the process much more simple.
> 
> The scripts have knowledge of the table padding requirements, so there's
> no need to worry about __NR_syscalls not fitting within the immediate
> constant field of ALU instructions anymore.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Ah, very nice!

I have some vague plans to do something like this for all architectures,
so having it done for one of the more complex examples (there are very
few architectures with more than one table) simplifies it a lot.

The next step is probably to do it for asm-generic/unistd.h, which
covers a lot of architectures, and then we can introduce a shared
table for all future additions so we only have to add the new calls
in one place, and change the scripts so they can merge two input
files into one.

> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> new file mode 100644
> index 000000000000..62285cbd09c0
> --- /dev/null
> +++ b/arch/arm/tools/syscall.tbl
> @@ -0,0 +1,428 @@
> +#
> +# Linux system call numbers and entry vectors
> +#
> +# The format is:
> +# <num>	<abi>	<name>			<entry point>			<oabi compat entry point>
> +#
> +# Where abi is:
> +#  common - for system calls shared between oabi and eabi
> +#  oabi   - for oabi-only system calls (may have compat)
> +#  eabi   - for eabi-only system calls

Why do we need all three? I would have guessed that these two are
sufficient to cover all cases:

arm	- one entry for eabi, optional second entry for oabi if different
oabi	- only one entry for oabi, syscall is not used on eabi

> +180	oabi	pread64			sys_pread64		sys_oabi_pread64
> +180	eabi	pread64			sys_pread64
> +181	oabi	pwrite64		sys_pwrite64		sys_oabi_pwrite64
> +181	eabi	pwrite64		sys_pwrite64

That would avoid having to list those numbers twice, which looks
a bit odd here, and is inconsistent with how x86 handles their
compat table for x32

> diff --git a/arch/arm/tools/syscallhdr.sh b/arch/arm/tools/syscallhdr.sh
> new file mode 100644
> index 000000000000..72d4b2e3bdec
> --- /dev/null
> +++ b/arch/arm/tools/syscallhdr.sh

The scripts are still very similar to the x86 version. Any chance
we can move them to a top-level scripts/syscall/ directory and make
them work for both architectures? It would be good to avoid duplicating
them for all the other architectures too, so starting out with a common
version could make that easier.

If necessary, I can do that once I get to the following stage of
doing the asm-generic/unistd.h replacement.

	Arnd
