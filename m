From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 6 Jul 2016 07:34:58 +0200
Subject: [Question] Memory attribute reserved by Device Tree?
In-Reply-To: <CAK7LNAQJNYVFjZyMH=kU+VJLfUCr2EwKc51HB4knZ=XM7s+MQg@mail.gmail.com>
References: <CAK7LNATGoP-Wn-wiK_CgD_v=rQXyt937qRvr8LkUQ06jHB7FAA@mail.gmail.com>
 <577504D7.7080106@arm.com> <20160630122554.GC20363@leverpostej>
 <CAK7LNAQJNYVFjZyMH=kU+VJLfUCr2EwKc51HB4knZ=XM7s+MQg@mail.gmail.com>
Message-ID: <CAKv+Gu_iF31mBbg1pMawq+7fPDo4iXdGWJT_nWV4Oy+AqDpFOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 July 2016 at 06:10, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> 2016-06-30 21:26 GMT+09:00 Mark Rutland <mark.rutland@arm.com>:
>> On Thu, Jun 30, 2016 at 12:39:03PM +0100, Robin Murphy wrote:
>>> On 30/06/16 12:10, Masahiro Yamada wrote:
>>> > Hello.
>>> >
>>> > Which memory attribute will ARM/ARM64 Linux
>>> > set to the memory region reserved by
>>> > /memreserve/ of Device Tree?
>>> >
>>> >
>>> > Normal memory non-cacheable?
>>> > Or, cacheable?
>>> > Or, not defined?
>>> >
>>> > Perhaps actual behavior depends on whether the reserved area is
>>> > located in the low-memory region?
>>>
>>> Isn't the point of memreserve that the kernel avoids mapping it at all?
>>
>> Not quite. A /memreserve/ allows the kernel to map a region, so long as
>> it doesn't use the region for general allocation.
>>
>> While not strictly defined for arm64 today, in practice the kernel may
>> map a region with Normal Inner-Shareable Inner-WB Outer-WB attributes,
>> following similar behaviour for PPC as defined in ePAPR.
>>
>> Generally I would advise against the use of a memreserve, and favour
>> carving memory out of memory nodes as required, as that imposes stricter
>> requirements.
>>
>>> If a reserved region is later mapped in by a driver using
>>> dma_declare_coherent_memory(), ioremap(), memremap() or whatever else,
>>> then the attributes will vary depending on the exact method used.
>>
>> Indeed. This applies even with the above.
>
>
> Hi Robin, Mark,
>
>
> Thanks for clarification!
>
>
> My motivation is to try my own implementation of PSCI for my ARMv7 SoC.
>
> I put my PSCI firmware somewhere in the DRAM region and
> protected it with /memreserve/, but I was not sure what kind of memory attribute
> is used for the area.
>

As Mark implies, /memreserve/ entries are not suitable for this, and
you should create an entry under /reserved-memory instead (please
check the bindings under Documentation/ for details). This not only
allows you to add a no-map attribute to prevent the kernel from
mapping it (which allows you to map it any way you like), it also
guarantees that the reservation is honoured even when booting via
UEFI, as /memreserve/s are ignored in this case.

Note that the difference between the handling of /memreserve/ and
/reserved-memory under UEFI is arbitrary, and should be fixed imo.

Original issue is here, as yet unresolved:
http://thread.gmane.org/gmane.linux.kernel.efi/6464
