From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 28 Nov 2017 18:37:30 +0000
Subject: [PATCH v3 2/2] arm64: ftrace: emit ftrace-mod.o contents through
 code
In-Reply-To: <20171128183121.GN9266@arm.com>
References: <20171120174130.28626-1-ard.biesheuvel@linaro.org>
 <20171120174130.28626-2-ard.biesheuvel@linaro.org>
 <20171128183121.GN9266@arm.com>
Message-ID: <CAKv+Gu9x0zXJVSwOr-M9K2+r3_A=GmNG4Ljx3dLP5tNB5asWHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 November 2017 at 18:31, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Nov 20, 2017 at 05:41:30PM +0000, Ard Biesheuvel wrote:
>> When building the arm64 kernel with both CONFIG_ARM64_MODULE_PLTS and
>> CONFIG_DYNAMIC_FTRACE enabled, the ftrace-mod.o object file is built
>> with the kernel and contains a trampoline that is linked into each
>> module, so that modules can be loaded far away from the kernel and
>> still reach the ftrace entry point in the core kernel with an ordinary
>> relative branch, as is emitted by the compiler instrumentation code
>> dynamic ftrace relies on.
>>
>> In order to be able to build out of tree modules, this object file
>> needs to be included into the linux-headers or linux-devel packages,
>> which is undesirable, as it makes arm64 a special case (although a
>> precedent does exist for 32-bit PPC).
>>
>> Given that the trampoline essentially consists of a PLT entry, let's
>> not bother with a source or object file for it, and simply patch it
>> in whenever the trampoline is being populated, using the existing
>> PLT support routines.
>
> I'll pick these two up for 4.15. Do you think they need to go to stable as
> well?
>

It is either that, or the distros need to backport themselves. Not
sure whether it matters much tbh.
