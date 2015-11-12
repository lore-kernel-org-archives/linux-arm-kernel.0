From: lkp@intel.com (Fengguang Wu)
Date: Thu, 12 Nov 2015 16:20:15 +0800
Subject: [kbuild-all] [PATCH V3 4/4] dma: add Qualcomm Technologies HIDMA
 channel driver
In-Reply-To: <4119660.BobUIRMK6T@wuerfel>
References: <201511090323.GmbQltpW%fengguang.wu@intel.com>
 <563FEC48.2010404@codeaurora.org>
 <20151111022103.GA29459@wfg-t540p.sh.intel.com>
 <4119660.BobUIRMK6T@wuerfel>
Message-ID: <20151112082015.GA9099@wfg-t540p.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Nov 11, 2015 at 09:42:00AM +0100, Arnd Bergmann wrote:
> On Wednesday 11 November 2015 10:21:03 Fengguang Wu wrote:
> > Hi Sinan,
> > 
> > Sorry please ignore this warning -- it's actually a problem specific
> > to the mn10300 arch. I'll disable such warning in mn10300 in future.
> 
> I just tried to find what happened here. mn10300 appears to define
> the type based on the gcc version:
> 
> #if __GNUC__ == 4
> typedef unsigned int    __kernel_size_t;
> typedef signed int      __kernel_ssize_t;
> #else
> typedef unsigned long   __kernel_size_t;
> typedef signed long     __kernel_ssize_t;
> #endif
> 
> while gcc defines it based on whether you are using a Linux targetted
> gcc or a bare-metal one:
> 
> gcc/config/mn10300/linux.h:#undef SIZE_TYPE
> gcc/config/mn10300/mn10300.h:#undef  SIZE_TYPE
> gcc/config/mn10300/mn10300.h:#define SIZE_TYPE "unsigned int"
> 
> I can think of two reasons why it went wrong here:
> 
> a) You are using gcc-5.x, and the check in the kernel should be ">="
>    rather than "==". We should probably fix that regardless
> 
> b) You are using a bare-metal gcc rather than a Linux version.

> I couldn't find an mn10300 gcc on kernel.org, which one do you use?

I used this mn10300 compiler:

https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.9.0/x86_64-gcc-4.9.0-nolibc_am33_2.0-linux.tar.xz

Thanks,
Fengguang
