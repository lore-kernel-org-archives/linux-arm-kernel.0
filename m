From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Fri, 7 Sep 2018 18:48:10 +0300
Subject: [PATCH] arm64: lib: use C string functions with KASAN enabled.
In-Reply-To: <20180907145605.GE12788@arm.com>
References: <20180906170534.20726-1-aryabinin@virtuozzo.com>
 <20180907145605.GE12788@arm.com>
Message-ID: <9634affa-b210-d931-e40b-6e8a20f105fc@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/07/2018 05:56 PM, Will Deacon wrote:
> On Thu, Sep 06, 2018 at 08:05:33PM +0300, Andrey Ryabinin wrote:
>> ARM64 has asm implementations of memchr(), memcmp(), str[r]chr(),
>> str[n]cmp(), str[n]len(). KASAN don't see memory accesses in asm
>> code, thus it can potentially miss many bugs.
>>
>> Ifdef out __HAVE_ARCH_* defines of these functions when KASAN is
>> enabled, so the generic implementations from lib/string.c will be used.
>>
>> Declare asm functions as weak instead of removing them because they
>> still can be used by efistub.
> 
> I don't understand this bit: efistub uses the __pi_ prefixed versions of the
> routines, so why do we need to declare them as weak?

Weak needed because we can't have two non-weak functions with the same name.

Alternative approach would be to never use e.g. "strlen" name for asm implementation of strlen() under CONFIG_KASAN=y.
But that would require adding some special ENDPIPROC_KASAN() macro since we want __pi_strlen() to point
to the asm_strlen().

Using weak seems like a way better solution to me.

> 
> Will
> 
