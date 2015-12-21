From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Mon, 21 Dec 2015 19:39:35 +0100
Subject: [PATCH v6 12/20] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <2334903.IjsQ1BK3JF@wuerfel>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <CA+=Sn1ktUCa_8MzMvZtQhE+fUNY5-V9JXTLXKDDe8a0iENgd=w@mail.gmail.com>
 <20151218114219.GA2830@mbp> <2334903.IjsQ1BK3JF@wuerfel>
Message-ID: <4753CD2F-914D-44D5-BD18-8DF94068315D@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 18 Dec 2015, at 13:47, Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> 3. Follow the PCS up to glibc but always pass syscall arguments in W
>>   registers, like AArch32 compat support (the least preferred option,
>>   the only advantage is a single wrapper for all syscalls but it would
>>   be doing unnecessary zeroing even for syscalls where it isn't needed)
> 
> This would mean we cannot pass 64-bit arguments in registers, right?

Note that there?s no 32bit registers (the ?w?-form always refers to the lower
32bits of a 64bit register, with implicit zero-extension)? and load/store
instructions always use the full base-register (?x?-form) for address calculation.
I.e. a load/store would inadvertently pickup ?random garbage? in the upper 
32bits, if no explicit zero-extension is applied.

In other words: all zero-extensions for 32bit arguments should be explicit
on the kernel side.

Regards,
Philipp.
