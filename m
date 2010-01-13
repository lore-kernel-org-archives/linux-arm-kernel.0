From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 13 Jan 2010 16:32:28 -0500
Subject: Question: __ARM_EABI__
In-Reply-To: <20100113211725.GH28292@n2100.arm.linux.org.uk>
References: <BD79186B4FD85F4B8E60E381CAEE190902089C63@mi8nycmail19.Mi8.com>
	<19278.11469.95923.629825@pilspetsen.it.uu.se>
	<BD79186B4FD85F4B8E60E381CAEE190902089C95@mi8nycmail19.Mi8.com>
	<20100113210503.GG28292@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE190902089C9B@mi8nycmail19.Mi8.com>
	<20100113211725.GH28292@n2100.arm.linux.org.uk>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902089CA8@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 13, 2010 2:17 PM, Russell King wrote:
> On Wed, Jan 13, 2010 at 04:10:41PM -0500, H Hartley Sweeten wrote:
>> I'll take your word on that.
>> 
>> But, based on the code I would not expect to see the message at all:
>> 
>> #if !defined (__ARM_EABI__)
>> #warning Your compiler does not have EABI support.
>> #warning    ARM unwind is known to compile only with EABI compilers.
>> #warning    Change compiler or disable ARM_UNWIND option.
>> #elif (__GNUC__ == 4 && __GNUC_MINOR__ <= 2)
>> #warning Your compiler is too buggy; it is known to not compile ARM unwind support.
>> #warning    Change compiler or disable ARM_UNWIND option.
>> #endif
>> 
>> I'm getting this during the compile:
>> 
>>   CHECK   arch/arm/kernel/unwind.c
>> arch/arm/kernel/unwind.c:30:2: warning: Your compiler does not have EABI support.
>> arch/arm/kernel/unwind.c:31:2: warning: ARM unwind is known to compile only with EABI compilers.
>> arch/arm/kernel/unwind.c:32:2: warning: Change compiler or disable ARM_UNWIND option.
>
> If you get an oops with your compiler version and you have unwind
> support enabled, you _will_ _not_ get a backtrace.  That's because
> EABI support in gcc 4.3.2 is incomplete.

OK.  The #elif test should probably be updated to reflect this.

> As the message says, either use a later compiler or disable unwind
> support.

But, I'm actually getting the wrong message.

Alessandro Rubini pointed out that I could use "-dM" in the preprocessor
to dump the defines.  My toolchain has these particular defines:

#define __GNUC__ 4
#define __GNUC_MINOR__ 3
#define __ARM_EABI__ 1

4.3.2 might not support unwinding correctly but I still should not get
any of the warning messages.

Confused...

Regards,
Hartley
