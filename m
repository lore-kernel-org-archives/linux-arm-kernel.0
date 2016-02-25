From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 25 Feb 2016 08:49:47 +0100
Subject: [RFC PATCH 1/2] memremap: add arch specific hook for MEMREMAP_WB
 mappings
In-Reply-To: <87twkzukup.fsf@belgarion.home>
References: <1456149728-16706-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456149728-16706-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAPcyv4ivN9c8PHBR77vd36ovB28OETJUr6VYf_8gNtXgqEmATw@mail.gmail.com>
 <CAKv+Gu9OWVgo+Qm85jPjY7xJ1UELm-4LYORHKF8Yy+_HuzmtGw@mail.gmail.com>
 <20160222200227.GF19428@n2100.arm.linux.org.uk>
 <CAKv+Gu9gwnuu7hnYpjv7ozuKYmC8ApMakSJmYvQMaevNEd5zvA@mail.gmail.com>
 <20160223115835.GI19428@n2100.arm.linux.org.uk>
 <CAKv+Gu8oCnu6kv5SxUAdWE_Z0V+PMAKDgM6MxTi4mTm5z6EFqA@mail.gmail.com>
 <CAKv+Gu_iEOC6E+N28pp9eEJxWFYTgLaQcBYEy1SvTUHT=cybYA@mail.gmail.com>
 <CAPcyv4h86uzieFV4HM-tZoWSVZ7GY2GKEUk334J+5sD_GyzWKg@mail.gmail.com>
 <87twkzukup.fsf@belgarion.home>
Message-ID: <CAKv+Gu9uLmpW9isw9e8bQ8=tsA1VAGiLjm795dWjgicyueSzcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 February 2016 at 23:23, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
>
>> On Tue, Feb 23, 2016 at 4:26 AM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 23 February 2016 at 13:03, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>>> On 23 February 2016 at 12:58, Russell King - ARM Linux
>>>> <linux@arm.linux.org.uk> wrote:
>>>>> On Mon, Feb 22, 2016 at 09:35:24PM +0100, Ard Biesheuvel wrote:
>>> OK, I see what you mean. I find it unfortunate that ioremap_cache()
>>> instances are blindly being replaced with memremap(), and I wonder if
>>> this wasted test by and/or cc'ed to people who can actually test this
>>> driver. Dan?
>
> Actually I have the hardware to test it.
>
> And I also know what is behind :
>  - it's a CFI NOR based memory
>  - these are Intel StrataFlash 28F128J3A chips
>  - as a CFI memory it is mapped on the system bus
>  - from a read perspective, it behaves like a normal memory
>  - but once the first write reaches the CFI, everything changes (the address
>    space layout doesn't have the same meaning, be that becoming a status code or
>    something else).
>    In these conditions reordering of writes versus reads, merging reads after
>    a write or coalescing writes is a recipe for disaster.
>
> All of this to say I can make a small discrete number of tests (less than 10
> write or erase ones to preserve the precious NOR).
>

Thanks Robert.

But to be honest, I think we should simply revert the change, after
which we can wire up memremap() for ARM properly. And while I agree
that ioremap_cache() is often abused for mapping things like ACPI
tables in RAM (which forces you to cast away the __iomem annotation),
using ioremap_cache() to map NOR flash is totally different IMO, even
if it has memory semantics while in array mode.
