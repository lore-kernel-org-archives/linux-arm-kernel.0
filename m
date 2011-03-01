From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Mar 2011 08:49:49 +0000
Subject: [RFC PATCH] ARM: Use generic BUG() handler
In-Reply-To: <1298939263-16421-1-git-send-email-sjg@chromium.org>
References: <1298939263-16421-1-git-send-email-sjg@chromium.org>
Message-ID: <20110301084949.GA16733@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 04:27:43PM -0800, Simon Glass wrote:
> +	asm volatile("1:\t.word %c3\n"				\
> +		     ".pushsection __bug_table,\"a\"\n"		\
> +		     "2:\t.word 1b, %c0\n"			\
> +		     "\t.hword %c1, 0\n"			\
> +		     "\t.org 2b+%c2\n"				\

%c doesn't work on lots of versions of gcc, which is why we can't use
the generic bug support.  There's no way to reliably generate constants
without many compiler versions spitting out a '#' before them.
