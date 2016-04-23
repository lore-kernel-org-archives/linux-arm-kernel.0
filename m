From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 Apr 2016 00:16:50 +0200
Subject: [PATCH] generic syscalls: wire up preadv2 and pwritev2 syscalls
In-Reply-To: <1460366266-29378-1-git-send-email-andre.przywara@arm.com>
References: <1460366266-29378-1-git-send-email-andre.przywara@arm.com>
Message-ID: <3816292.4K8FR7W2O1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 April 2016 10:17:46 Andre Przywara wrote:
> These new syscalls are implemented as generic code, so enable them for
> architectures like arm64 which use the generic syscall table.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 

I've forwarded it now as a pull request. Generally speaking, I'd much prefer
anyone who adds a syscall to update asm-generic/unistd.h as well
(as documented in Documentation/adding-syscalls.txt), there is no
need for me to put those patches into the asm-generic git tree first.

On a related topic, I've been thinking (for years) about coming up with a
way to have all future syscalls just get added to a single file in the
kernel to have them appended to the tables for all architectures. There
are two basic methods that seem appropriate here for avoiding the split
between unistd.h and syscalls.S:

a) The current asm-generic method of interleaving the __NR_* macro definitions
   and the entry in a .c file array, including the header multiple times
   to get all the tables
b) generating both files from an input like x86 does with
   arch/x86/entry/syscalls/ infrastructure

I think we need something similar to b) but with some extensions to allow
extending the architecture specific tables in a nice way, rather than
having to have one file per architecture.

	Arnd
