From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Sep 2014 16:19:48 +0100
Subject: [PATCH] arm: kprobes-test: Fix compile error "bad immediate
 value for offset"
In-Reply-To: <1411743864.1529.36.camel@linaro1.home>
References: <1411743864.1529.36.camel@linaro1.home>
Message-ID: <20140926151947.GV5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 04:04:24PM +0100, Jon Medhurst (Tixy) wrote:
> When compiling kprobes-test-arm.c the following error has been observed
> 
> /tmp/ccoT403o.s:21439: Error: bad immediate value for offset (4168)
> 
> This is caused by the compiler spilling it's literal pool too far away
> from the site which is trying to reference it with a PC relative load.
> This arises because the compiler is underestimating the size of the
> inline assembler code present, which apparently it approximates as 4
> bytes per line or instruction.
> 
> We fix this problem by moving the operations which generate more than
> 4 bytes out of the text section. Specifically, moving the .ascii
> directives to the .rodata section.
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> ---
> 
> Russell, OK to add your 'reported-by' here (or should it be Olof)?

I suspect it should be Olof - I'm just the middle man, spotting errors
in Olof's build results... though it did help that it was my for-next
branch which was being built.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
