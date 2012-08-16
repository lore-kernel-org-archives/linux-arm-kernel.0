From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Aug 2012 12:37:53 +0000
Subject: [PATCH v2 16/31] arm64: ELF definitions
In-Reply-To: <20120816102300.GG31784@mudshark.cambridge.arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <201208151415.39570.arnd@arndb.de>
 <20120816102300.GG31784@mudshark.cambridge.arm.com>
Message-ID: <201208161237.53594.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 August 2012, Will Deacon wrote:
> > This looks wrong: PER_LINUX/PER_LINUX32 decides over the output of the
> > uname system call, while TIF_32BIT decides over the instruction set
> > when returning to user space. You definitely should not set the personality
> > to the value you pass from the elf loader. Instead, just do
> > 
> > #define SET_PERSONALITY(ex) clear_thread_flag(TIF_32BIT);
> > #defined COMPAT_SET_PERSONALITY(ex) set_thread_flag(TIF_32BIT);
> 
> In this case, won't uname be incorrect (aarch64l) for aarch32 tasks (which
> expect something like armv8l)?

No, the uname output is meant to tell you about the system, not the
instruction set that you are using (you already know that in compiled
code).

The main use case is to fool stuff like autoconf into assuming your
architecture is the other one, e.g. when building a 32 bit package
on using a 64 bit /bin/bash to run ./configure or vice versa.

	Arnd
