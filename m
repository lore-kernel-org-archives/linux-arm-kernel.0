From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 28 Feb 2012 10:25:15 -0300
Subject: [PATCH] ARM: mx51: Fix build error due to missing include of
 <linux/bug.h>
In-Reply-To: <20120228132108.GB3617@n2100.arm.linux.org.uk>
References: <1330431110-22020-1-git-send-email-fabio.estevam@freescale.com>
 <20120228125336.GA3617@n2100.arm.linux.org.uk>
 <CAOMZO5ByrmWHYnahEm7PN=AxM2LygtytW5XRwUKMbngDUhKshA@mail.gmail.com>
 <20120228132108.GB3617@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5AD5-Fn9MjV1UM1OteBsCne2cmnkdMJgHffH2LgwSy41w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/28/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Tue, Feb 28, 2012 at 10:03:33AM -0300, Fabio Estevam wrote:
>> On Tue, Feb 28, 2012 at 9:53 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>
>> > I think having the asm/bug.h replaced with linux/bug.h in linux/kernel.h
>> > would be a better solution.
>>
>> commit 6f863554 (kernel.h: doesn't explicitly use bug.h, so don't
>> include it. ), which appears in linux-next, has removed asm/debug.h
>> from linux/kernel.h.
>>
>> I should have pointed this commit ID in my commit log.
>
> No, this is not a fix, and it probably makes things worse.
>
> linux/kernel.h _does_ use bug stuff - in ARRAY_SIZE().
>
> ARRAY_SIZE() uses __must_be_array(), which is defined in
> linux/compiler-gcc.h,
> which is obtained via linux/compiler.h and linux/linkage.h.
>
> linux/compiler-gcc.h defines __must_be_array() to be:
> #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>
> and BUILD_BUG_ON_ZERO used to be in linux/kernel.h but got moved to
> linux/bug.h.
>
> Hence why people are seeing build breakage with ARRAY_SIZE().
>
> The answer is not to start scattering lots of .c files with linux/bug.h
> includes, but to fix linux/kernel.h.

This makes sense, thanks.

Will submit a patch for lkml shortly.
