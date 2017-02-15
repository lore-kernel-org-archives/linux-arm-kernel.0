From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Feb 2017 12:37:22 +0100
Subject: [PATCH] arm64: define BUG() instruction without CONFIG_BUG
In-Reply-To: <20170215112253.GB9630@arm.com>
References: <20170214213941.3026318-1-arnd@arndb.de>
 <20170215112253.GB9630@arm.com>
Message-ID: <CAK8P3a0Lo1nZRouK4xYQ3WScg6AvDjWtRRhkx6q7nf3NeXLvxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 12:22 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Feb 14, 2017 at 10:39:28PM +0100, Arnd Bergmann wrote:
>> @@ -57,6 +58,14 @@ _BUGVERBOSE_LOCATION(__FILE__, __LINE__)           \
>>
>>  #define __WARN_TAINT(taint) _BUG_FLAGS(BUGFLAG_TAINT(taint))
>>
>> +#else
>> +
>> +#define BUG() do {                                   \
>> +     asm volatile("brk %[imm]"                       \
>> +                  :: [imm] "i" (BUG_BRK_IMM));       \
>> +     unreachable();                                  \
>> +} while (0)
>
> Do we need to duplicate the asm, or can we reuse the existing BUG
> definition in this header? The only extra thing we do is push a __bug_table
> entry, but I can't see why that would be a problem.

The only reason for turning off CONFIG_BUG is to save a little extra space
in the kernel image, so I think we really don't want the __bug_table to be
generated.

However, we could split the existing asm in two and have only one definition
for the asm containing the brk instruction.

     Arnd
