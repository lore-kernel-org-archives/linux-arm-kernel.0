From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 7 Oct 2011 12:25:16 +0100
Subject: [PATCH 1/3 v3] ARM Realview PCIX map include file changes
In-Reply-To: <F01D8B85CFF58440B2A13965FBA90CA47375AC17BD@GEORGE.Emea.Arm.com>
References: <20110822130507.23830.26191.stgit@e102602-lin.cambridge.arm.com>
	<20110822130942.23830.4767.stgit@e102602-lin.cambridge.arm.com>
	<201109051635.59927.arnd@arndb.de>
	<F01D8B85CFF58440B2A13965FBA90CA47375AC1794@GEORGE.Emea.Arm.com>
	<20111006142350.GD26349@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA47375AC17BD@GEORGE.Emea.Arm.com>
Message-ID: <CAHkRjk5MQUWiF3jmZJ_SBHdtmunoajR4eHftwdnFCKjeDxQDKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 October 2011 15:50, Colin Tuckley <Colin.Tuckley@arm.com> wrote:
>> -----Original Message-----
>> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
>> Subject: Re: [PATCH 1/3 v3] ARM Realview PCIX map include file changes
>
>> All the points in this email all go together.
>
> Ah, that wasn't clear from the original email - I was making the changes incrementally and testing as I went.
>
>> This is how it works:
>>
>> 1. The PCI IO window is _supposed_ to be 64K in size.
>
> Yes, that bit was obvious after a bit of thought. I suspect the original value was just a cut 'n paste error.
>
>> 2. "pcibios_min_io" sets the minimum offset into the PCI IO window
>> which
>> ? ?PCI IO BARs should be assigned. ?It is assumed that a PCI IO BAR
>> value
>> ? ?of 0 corresponds with the virtual base address of this window.
>> 3. inb() et.al. take the PCI IO offset and _not_ the physical address
>> nor the virtual address of the desired access.
>
> That seems sensible.
>
> However, after changing both __io() and pcibios_min_io as Arnd suggested the boot still hangs after " Uncompressing Linux... done, booting the kernel."

I haven't followed the patch series in detail but the __io() is also
used by __io_address() in the RealView code and the former is just
expected to do some type casting. By doing some arithmetic on the
pointer, the static mappings for various peripherals (GIC etc.) are
wrong.

So if you convert __io() as per Arnd's suggestion, make sure that
__io_address() is redefined, something like below:

#define __io_address(n)		__typesafe_io(IO_ADDRESS(n))

Alternatively we could leave __io() as in the original kernel and
define RealView specific in*/out* macros.

-- 
Catalin
