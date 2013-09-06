From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Sep 2013 12:12:21 +0100
Subject: [RFC 0/4] Create infrastructure for running C code from SRAM.
In-Reply-To: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
Message-ID: <20130906111221.GH25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 09:44:21AM -0700, Russ Dill wrote:
> SRAM handling code is in the process of being moved from arch directories
> into drivers/misc/sram.c using device tree and genalloc [1] [2]. This RFC
> patchset builds on that, including the limitation that the SRAM address is
> not known at compile time. Because the SRAM address is not known at compile
> time, the code that runs from SRAM must be compiled with -fPIC. Even if
> the code were loaded to a fixed virtual address, portions of the code must
> often be run with the MMU disabled.

What are you doing about the various gcc utility functions that may be
implicitly called from C code such as memcpy and memset?

> The general idea is that for each SRAM user (such as an SoC specific
> suspend/resume mechanism) to create a group of sections. The section group
> is created with a single macro for each user, but end up looking like this:
> 
> .sram.am33xx : AT(ADDR(.sram.am33xx) - 0) {
>   __sram_am33xx_start = .;
>   *(.sram.am33xx.*)
>   __sram_am33xx_end = .;
> }
> 
> Any data or functions that should be copied to SRAM for this use should be
> maked with an appropriate __section() attribute. A helper is then added for
> translating between the original kernel symbol, and the address of that
> function or variable once it has been copied into SRAM. Once control is
> passed to a function within the SRAM section grouping, it can access any
> variables or functions within that same SRAM section grouping without
> translation.

What about the relocations which will need to be fixed up - eg, addresses
in the literal pool, the GOT table contents, etc?  You say nothing about
this.
