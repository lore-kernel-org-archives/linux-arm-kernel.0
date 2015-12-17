From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Dec 2015 14:56:24 +0100
Subject: [PATCH v6 09/20] arm64:ilp32: share HWCAP between LP64 and ILP32
In-Reply-To: <20151217105445.GA25232@e104818-lin.cambridge.arm.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <15616150.rsIFodoBKz@wuerfel>
 <20151217105445.GA25232@e104818-lin.cambridge.arm.com>
Message-ID: <9201094.hyFNZIqCTY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 December 2015 10:54:47 Catalin Marinas wrote:
> > > IIUC, we may have a problem with this. elf_hwcap is 64-bit long while
> > > elf_info[n] is 32-bit (Elf32_Addr), so we truncate AT_HWCAP if we ever
> > > go beyond bit 31. The above may need to look something like:
> > > 
> > > #define COMPAT_ELF_HWCAP        \
> > >         (is_a32_compat_task()   \
> > >          ? compat_elf_hwcap     \
> > >          : (u32)elf_hwcap)
> > > 
> > > #define COMPAT_ELF_HWCAP2       \
> > >         (is_a32_compat_task()   \
> > >          ? compat_elf_hwcap2    \
> > >          : (u32)(elf_hwcap >> 32))
> > 
> > Yes, interesting find.
> 
> BTW, we need to make sure this series (primarily the ABI) is big-endian
> safe. I know it is not targeted at this initially but given that the
> reason for doing it is legacy networking code, I wouldn't be surprised
> if someone asks for BE at some point in the future.

Yes, I'm sure that will be needed.

	Arnd
