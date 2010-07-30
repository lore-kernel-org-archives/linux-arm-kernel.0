From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 30 Jul 2010 13:02:46 +0800
Subject: [PATCH 10/13] [ARM] pxa/balloon3: PCMCIA Support
In-Reply-To: <201007300641.51952.marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
	<1280373389-32475-10-git-send-email-marek.vasut@gmail.com>
	<20100729101054.GB4981@dream.aleph1.co.uk>
	<201007300641.51952.marek.vasut@gmail.com>
Message-ID: <AANLkTinHT8sB4VO26DJLDjhpu8WQA0_PcO8C77rpj3XS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> erm. Why move the FPGA/CPLD register definitions out of balloon3.h
>> (along with the others) and put them in balloon3.c?
>> Is that really good kernel form?
>
> They are not used anywhere else so they don't need to be in that file publically
> available.

If the FPGA/CPLD is _not_ solely for the purpose of CF/PCMCIA,
nor it is like an MFD device where the functionality can be clearly
separated from different ranges of registers, I'd agree with Wookey
better to keep them in balloon3.h.

>>
>> And surely keeping the FPGA_VIRT offset makes it clearer where the
>> magic addresses come from?
>
> You mean PHYS offset I believe. That is a good idea, but I'd firstly like to
> distribute all the addresses in balloon3.h into drivers (well all that can be
> distributed) and then flip it over so all registers will be defined by offset
> from some FPGA base address. That's not possible yet so for consistency's sake,
> I do it this way now. The patch flipping it to offsets will be very easy, but
> this cleanup needs a two-stage plan.

And the offsets were a bit different from their originals here?

> - #define BALLOON3_PCMCIA0_REG               (BALLOON3_FPGA_VIRT + 0x00e00008)

And

> +#define      BALLOON3_CF_STATUS_REG          (0x10e00008)

Even the name has been changed?

>>
>> And finally as this code is quite dependent on VHDL version numbers
>> and we know we have a number of incompatible versions around
>> should we add a version check to ensure that we have the same VHDL
>> version as the driver is expecting? I guess it should be of the 'at
>> least n' form, otherwise later VHDL updates would break the driver,
>> probbaly for no good reason.
>
> Yes, the check is in place.
>
> + ? ? ? if (ver > 0x0201)
> + ? ? ? ? ? ? ? pr_warn("The FPGA code, version 0x%04x, is newer than rel-0.3. "
> + ? ? ? ? ? ? ? ? ? ? ? "PCMCIA/CF support might be broken in this version!",
> + ? ? ? ? ? ? ? ? ? ? ? ver);
>
> Actually I'm planning to fix the VHDL if I'll have some time for that.
>
> Cheers
>>
>>
>> Wookey
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
