From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Sun, 27 Jul 2014 07:39:48 +0200
Subject: [RESEND][PATCHv2 0/3] Fix for buggy u-boot memory banks
In-Reply-To: <CAK5sBcFeaHrLLoSYCvrSMBX+eGYWoGPrCH0Uxy3Ao2OAYXoTNA@mail.gmail.com>
References: <1405443816-29917-1-git-send-email-lauraa@codeaurora.org>	<53D3FB9C.9080908@suse.de>
 <CAK5sBcFeaHrLLoSYCvrSMBX+eGYWoGPrCH0Uxy3Ao2OAYXoTNA@mail.gmail.com>
Message-ID: <53D490A4.1060302@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.07.2014 06:28, schrieb Sachin Kamat:
> 
> 
> On Sunday, July 27, 2014, Andreas F?rber <afaerber@suse.de
> <mailto:afaerber@suse.de>> wrote:
> 
>     Hi Laura,
> 
>     Am 15.07.2014 19:03, schrieb Laura Abbott:
>     > This is a resend of the series to fix the uboot bug exposed by the
>     removal
>     > of meminfo. I haven't gotten any acks though.
>     >
>     > Please help with review/acks. Grant/Rob, I'd still like this to go
>     through
>     > the devicetree tree if possible.
> 
>     Sorry for the delay in testing.
> 
>     With this v2 applied on top of kgene's for-next branch (plus
>     https://patchwork.kernel.org/patch/4297431/ as build fix) I get:
> 
>     [    9.699985] Unhandled fault: asynchronous external abort (0x211) at
>     0x00000000
> 
> 
> If this is on Arndale octa board,

It is, sorry, that was the board that prompted the series.

> please try disabling MCPM option.

Interestingly without MCPM I then get:

drivers/built-in.o: In function `bl_enter_powerdown':
/home/andreas/linux/drivers/cpuidle/cpuidle-big_little.c:134: undefined
reference to `mcpm_cpu_powered_up'
drivers/built-in.o: In function `bl_powerdown_finisher':
/home/andreas/linux/drivers/cpuidle/cpuidle-big_little.c:104: undefined
reference to `mcpm_set_entry_vector'
/home/andreas/linux/drivers/cpuidle/cpuidle-big_little.c:111: undefined
reference to `mcpm_cpu_suspend'
Makefile:885: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

ARM_BIG_LITTLE_CPUIDLE seems to be lacking a dependency on MCPM.

Together they resolved the issue, thanks!

Tested-by: Andreas F?rber <afaerber@suse.de>

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
