From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Aug 2010 17:27:01 -0700
Subject: [PATCH] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <20100810225519.GF7702@n2100.arm.linux.org.uk>
References: <1280890950-19174-1-git-send-email-sboyd@codeaurora.org>
	<4C61D6E3.1030603@codeaurora.org>
	<20100810225519.GF7702@n2100.arm.linux.org.uk>
Message-ID: <4C61EE55.5030506@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2010 03:55 PM, Russell King - ARM Linux wrote:
>
> Unfortunately, there's quite a dearth of information on this patch,
> so I can't say.  I think it needs some testing before a decision can
> be made.

Ok. I'll add more info and resend. Do you mind testing ;-)

>
> What compilers have been tested with this?

So far I've tested it with gcc-4.4.0 and 4.3.1

>
> As the help comments intimate that it needs at least gcc 4.4, and
> you've changed it to produce a compile time warning if the option is
> disabled, what's the implications for older compilers?

With older compilers (pre 4.4) __compiletime_object_size() will be 
replaced with -1 causing this code to be optimized away. Also, 
__compiletime_warning() and __compiletime_error() aren't defined to be 
anything except in include/linux/compiler-gcc4.h so users of older 
compilers shouldn't see any warnings or errors regardless of the config 
option being enabled.

People will start seeing warnings if they use gcc 4.4 or later though.
It's debatable whether or not to have both the warning and the error 
when you consider -Werror. I went this way since x86 and parisc opted 
for warnings and errors. Furthermore, I don't see any warnings or errors 
with this patch in my builds.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
