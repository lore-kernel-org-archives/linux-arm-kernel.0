From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Mar 2011 14:11:13 +0000
Subject: [RFC PATCH] ARM: Use generic BUG() handler
In-Reply-To: <20110302105930.GA2363@arm.com>
References: <1298939263-16421-1-git-send-email-sjg@chromium.org>
	<20110301084949.GA16733@n2100.arm.linux.org.uk>
	<20110301085911.GB16733@n2100.arm.linux.org.uk>
	<19820.47240.801312.507393@pilspetsen.it.uu.se>
	<20110301100306.GA18007@n2100.arm.linux.org.uk>
	<AANLkTinMnZAupxn7oYFhqkN1Y0OD-eyN=UeRpw96no9r@mail.gmail.com>
	<20110302105930.GA2363@arm.com>
Message-ID: <20110303141113.GF25891@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2011 at 10:59:50AM +0000, Dave Martin wrote:
> +	asm volatile("1:\t" __bug_instr "\n"		q	\
> +		     ".pushsection .rodata.str, \"a\"\n"	\
> +		     "2:\t.asciz \"" #__file "\"\n"		\
> +		     ".popsection\n"				\ 

Doesn't this mean we end up with multiple file names?

> +		     ".pushsection __bug_table,\"a\"\n"		\
> +		     "3:\t.word 1b, 2b\n"			\
> +		     "\t.hword " #__line ", 0\n"		\
> +		     ".popsection"				\
> +	unreachable();						\
> +} while (0)

Second problem is that the above produces this:

        1:      .word 0xec000000
.pushsection .rodata.str, "a"
2:      .asciz "__FILE__"
.popsection
.pushsection __bug_table,"a"
3:      .word 1b, 2b
        .hword __LINE__, 0
.popsection

which is clearly not what we want.  Adding another level of indirection
starts to get closer to what we desire:

        1:      .word 0xec000000
.pushsection .rodata.str, "a"
2:      .asciz ""t.c""
.popsection
.pushsection __bug_table,"a"
3:      .word 1b, 2b
        .hword 19, 0
.popsection

but we're still ending up with multiple strings containing the filename,
which is going to excessively bloat the kernel no end.
