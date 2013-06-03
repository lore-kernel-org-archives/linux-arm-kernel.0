From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jun 2013 11:18:09 +0100
Subject: A bug about system call on ARM
In-Reply-To: <20130530114112.GH7483@mudshark.cambridge.arm.com>
References: <35FD53F367049845BC99AC72306C23D1610991B85B@CNBJMBX05.corpusers.net>
 <CAFLxGvy39xWdZmtiVHP+y=zH1coCVmMuREcmD25wSb=w-VK7Xg@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D1610991B85D@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B85E@CNBJMBX05.corpusers.net>
 <CAFLxGvyy=73dGQqG8W6SXZah7WQZ4gJAeeHXN8opKaOuG-5yUQ@mail.gmail.com>
 <20130529094826.GD13095@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B865@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B866@CNBJMBX05.corpusers.net>
 <20130530090949.GC7483@mudshark.cambridge.arm.com>
 <20130530114112.GH7483@mudshark.cambridge.arm.com>
Message-ID: <20130603101809.GK18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 12:41:12PM +0100, Will Deacon wrote:
> +#if defined(CONFIG_OABI_COMPAT) || !defined(CONFIG_AEABI)
> +	/*
> +	 * We may have faulted trying to load the SWI instruction due to
> +	 * concurrent page aging on another CPU. In this case, return
> +	 * back to the swi instruction and fault the page back.
> +	 */
> +9001:
> +	sub	lr, lr, #4
> +	str	lr, [sp, #S_PC]
> +	b	ret_fast_syscall
> +#endif

The comment is wrong.  If we get here, it means that the fault from
trying to loading the instruction can't be fixed up.  Arguably, that
should result in a SIGSEGV being sent immediately, but we'll get to
that when we then try to re-load the instruction.

What it means is that the page we were trying to execute has been
unmapped beneath us.

BTW, I notice that the kernel oops was never posted to the list, so it's
impossible for other people following this thread to see what the real
problem is...
