From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2016 22:43:59 +0200
Subject: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <20160428191914.GA28527@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <20160426165701.GE8525@e104818-lin.cambridge.arm.com>
 <20160428191914.GA28527@yury-N73SV>
Message-ID: <2760348.qmm1L3yQch@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2016 22:19:14 Yury Norov wrote:
> 
> Yes, we need. Otherwise we have circular dependency like this:
> arch/arm64/kernel/sys_ilp32.c:60:0: warning: "__SC_WRAP" redefined
>  #define __SC_WRAP(nr, sym) [nr] = compat_##sym,
>   ^
>   In file included from include/asm-generic/unistd.h:1:0,
>                    from ./arch/arm64/include/uapi/asm/unistd.h:16,
>                    from ./arch/arm64/include/asm/unistd.h:62,
>                    from ./include/uapi/linux/unistd.h:7,
>                    from include/linux/syscalls.h:23,
>                    from arch/arm64/kernel/sys_ilp32.c:30:
> include/uapi/asm-generic/unistd.h:33:0: note: this is the location of the previous definition
>  #define __SC_WRAP __SYSCALL
> 
> Defining __SYSCALL_COMPAT at the top of the file does not help much.

Hmm, this sounds like something that we should fix in the asm-generic/unistd.h
file. Is it just for __SC_WRAP, or also the other macros?

	Arnd
