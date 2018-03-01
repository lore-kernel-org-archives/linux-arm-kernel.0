From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 01 Mar 2018 18:06:59 +0000
Subject: [PATCH 02/11] ACPI / APEI: Generalise the estatus queue's
 add/remove and notify code
In-Reply-To: <20180301150144.GA4215@pd.tnic> (Borislav Petkov's message of
 "Thu, 1 Mar 2018 16:01:44 +0100")
References: <20180215185606.26736-1-james.morse@arm.com>
 <20180215185606.26736-3-james.morse@arm.com>
 <20180301150144.GA4215@pd.tnic>
Message-ID: <87sh9jbrgc.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

Borislav Petkov <bp@alien8.de> writes:

> On Thu, Feb 15, 2018 at 06:55:57PM +0000, James Morse wrote:
>> Keep the oops_begin() call for x86,
>
> That oops_begin() in generic code is such a layering violation, grrr.
>
>> arm64 doesn't have one of these,
>> and APEI is the only thing outside arch code calling this..
>
> So looking at:
>
> arch/arm/kernel/traps.c:die()
>
> it does call oops_begin() ... oops_end() just like the x86 version of
> die().

You're looking at support for the 32-bit ARM systems. The 64-bit support
lives in arch/arm64 and the die() there doesn't contain an
oops_begin()/oops_end(). But the lack of oops_begin() on arm64 doesn't
really matter here.

>
> I'm wondering if we could move the code to do die() in a prepatch? My
> assumption is that all the arches should have die()... A quick grep does
> show a bunch of other arches having die()...

One issue I see with calling die() is that it is defined in different
includes across various architectures, (e.g., include/asm/kdebug.h for
x86, include/asm/system_misc.h in arm64, etc.)
