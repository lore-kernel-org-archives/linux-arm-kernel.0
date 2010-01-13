From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 13 Jan 2010 16:10:41 -0500
Subject: Question: __ARM_EABI__
In-Reply-To: <20100113210503.GG28292@n2100.arm.linux.org.uk>
References: <BD79186B4FD85F4B8E60E381CAEE190902089C63@mi8nycmail19.Mi8.com>
	<19278.11469.95923.629825@pilspetsen.it.uu.se>
	<BD79186B4FD85F4B8E60E381CAEE190902089C95@mi8nycmail19.Mi8.com>
	<20100113210503.GG28292@n2100.arm.linux.org.uk>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902089C9B@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 13, 2010 2:05 PM, Russell King wrote:
> On Wed, Jan 13, 2010 at 03:57:12PM -0500, H Hartley Sweeten wrote:
>> On Wednesday, January 13, 2010 1:28 PM, Mikael Pettersson wrote:
>>> H Hartley Sweeten writes:
>>>> Hello all,
>>>> 
>>>> The following commit added a check for __ARM_EABI__ and raises a
>>>> warning if it's not defined.
>>>> 
>>>> commit 6603a4fd5195a004dec5f9568e38ff76bae630c1
>>>> Author: Claudio Scordino <claudio@evidence.eu.com>
>>>> Date:   Fri Oct 30 12:06:05 2009 +0100
>>>> 
>>>>     ARM: 5776/1: Check compiler version and EABI support when adding ARM unwind support.
>>>> 
>>>> Where is this definition supposed to come from?
>>>
>>> The C compiler used to compile the kernel.
>> 
>> OK.  I'm using a gcc-4.3.2 compiler created with crosstool-NG:
>
> 4.3.2 doesn't generate proper unwind information, so the warning is
> actually correct - it doesn't support EABI unwind information.

I'll take your word on that.

But, based on the code I would not expect to see the message at all:

#if !defined (__ARM_EABI__)
#warning Your compiler does not have EABI support.
#warning    ARM unwind is known to compile only with EABI compilers.
#warning    Change compiler or disable ARM_UNWIND option.
#elif (__GNUC__ == 4 && __GNUC_MINOR__ <= 2)
#warning Your compiler is too buggy; it is known to not compile ARM unwind support.
#warning    Change compiler or disable ARM_UNWIND option.
#endif

I'm getting this during the compile:

  CHECK   arch/arm/kernel/unwind.c
arch/arm/kernel/unwind.c:30:2: warning: Your compiler does not have EABI support.
arch/arm/kernel/unwind.c:31:2: warning: ARM unwind is known to compile only with EABI compilers.
arch/arm/kernel/unwind.c:32:2: warning: Change compiler or disable ARM_UNWIND option.

Regards,
Hartley
