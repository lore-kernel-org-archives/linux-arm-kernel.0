From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Dec 2015 23:13:33 +0100
Subject: [PATCH v6 12/20] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <4753CD2F-914D-44D5-BD18-8DF94068315D@theobroma-systems.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <2334903.IjsQ1BK3JF@wuerfel>
 <4753CD2F-914D-44D5-BD18-8DF94068315D@theobroma-systems.com>
Message-ID: <201512212313.34114.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 December 2015, Dr. Philipp Tomsich wrote:
> 
> > On 18 Dec 2015, at 13:47, Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> >> 3. Follow the PCS up to glibc but always pass syscall arguments in W
> >>   registers, like AArch32 compat support (the least preferred option,
> >>   the only advantage is a single wrapper for all syscalls but it would
> >>   be doing unnecessary zeroing even for syscalls where it isn't needed)
> > 
> > This would mean we cannot pass 64-bit arguments in registers, right?
> 
> Note that there?s no 32bit registers (the ?w?-form always refers to the lower
> 32bits of a 64bit register, with implicit zero-extension)? and load/store
> instructions always use the full base-register (?x?-form) for address calculation.
> I.e. a load/store would inadvertently pickup ?random garbage? in the upper 
> 32bits, if no explicit zero-extension is applied.
> 
> In other words: all zero-extensions for 32bit arguments should be explicit
> on the kernel side.

I think that is what Catalin meant with the single wrapper in the description:
the kernel always zeroes out the upper 32 bits in the initial trap, and then
we only need to do sign-extensions for the few cases that need it, and pass 64-bit
arguments in two lower halves. In contrast, approach 1 adds a separate wrapper
for each syscall that takes care of both sign-extending where necessary and
zero-extending all othe 32-bit arguments but not the 64-bit arguments.

	Arnd
