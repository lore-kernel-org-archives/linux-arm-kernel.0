From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 25 Feb 2010 14:24:01 -0500 (EST)
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <20100225122429.GA3101@n2100.arm.linux.org.uk>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
	<20100224223418.GB25587@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>
	<20100224234215.GA21985@n2100.arm.linux.org.uk>
	<4B85BCE0.7000903@marcansoft.com>
	<20100225000114.GB21985@n2100.arm.linux.org.uk>
	<4B85C4A4.4060005@marcansoft.com>
	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>
	<20100225093859.GA19870@n2100.arm.linux.org.uk>
	<20100225122429.GA3101@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1002251420160.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Feb 2010, Russell King - ARM Linux wrote:

> And here's the patch - not run tested yet, but compile-tested for
> gzip and LZO in both ROM=y and ROM=n modes.
> 
>     ARM: Eliminate decompressor -Dstatic= PIC hack
> 
>     We used to build decompressors with -Dstatic= to avoid any local data
>     being generated.  The problem is that local data generates GOTOFF
>     relocations, which means we can't relocate the data relative to the
>     text segment.
> 
>     Global data, on the other hand, goes through the GOT, and can be
>     relocated anywhere.
> 
>     Unfortunately, with the new decompressors, this presents a problem
>     since they declare static data within functions, and this leads to
>     stack overflow.
> 
>     Fix this by separating out the decompressor code into a separate file,
>     and removing 'static' from BSS data in misc.c.
> 
>     Also, discard the .data section - this means that should we end up
>     with read/write initialized data, the decompressor will fail to link
>     and the problem will be obvious.
> 
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

However...

> @@ -14,6 +14,7 @@ SECTIONS
>    /DISCARD/ : {
>      *(.ARM.exidx*)
>      *(.ARM.extab*)
> +    *(.data)
>    }

I'd put a comment there, otherwise lots of people will go WTF when 
coming across this.


Nicolas
