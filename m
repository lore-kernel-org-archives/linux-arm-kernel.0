From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 18 Oct 2016 11:40:58 +0100
Subject: [PATCH] ARM: dts: realview: Extend PBX family memory description
In-Reply-To: <20161018102550.GM1041@n2100.armlinux.org.uk>
References: <1476778873-12210-1-git-send-email-linus.walleij@linaro.org>
 <20161018102550.GM1041@n2100.armlinux.org.uk>
Message-ID: <51ce7710-b215-d1d0-7696-6c85293f3d7e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/10/16 11:25, Russell King - ARM Linux wrote:
> On Tue, Oct 18, 2016 at 10:21:13AM +0200, Linus Walleij wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> All three platforms sharing the later RealView Platform Baseboard memory
>> map - PBX-A9, PB-A8 and PB11MPCore, provide 512MB of DDR SDRAM on the
>> baseboard, of which the boot alias at 0x0 maps the first 256MB. Expand
>> the size of the default memory node to reflect that, and describe the
>> full memory regions in each board's DTS, but leave those commented by
>> default to avoid breaking existing bootloaders.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ARM SoC folks: I forgot to send this patch for ARM SoC earlier.
>> As it is a small change I suggest you just apply it to the ARM
>> SoC tree as I do not foresee any other RealView work in the near
>> future. If you think it can go into v4.9 then put it in as a fix,
>> else just push it to the next merge window.
>> Robin: sorry for screwing up :(
> 
> Normally, memory nodes describe different regions of unique memory.
> This is not unique memory, but is an alias of some already-described
> memory.

Well, really, this is _the_ memory, and the 256MB at 0 is the alias, but
only the separate PB11MPCore DTS has the luxury of being correct from
the off, thanks to the precedent of the QEMU PB-A8 model being popular
and expecting to use the low alias.

> The problem with adding the aliased memory addresses is that we end
> up needing platform knowledge to reject the "other alias" from the
> memory description, which really isn't good.
> 
> The only reason it works is that we reject memory nodes where the
> physical address < PHYS_OFFSET.  That works provided the alias is
> below PHYS_OFFSET, but that isn't always the case.

Look again ;) It works perfectly because whilst the information is in
the DTS for completeness, as-is it's not in the DTB that the kernel
gets. And if someone _does_ adjust their kernel load address and
uncomment the .dts node accordingly, the "reg" property from the .dtsi
node gets overridden, not added to, so it's still fine.

Robin.

> 
> So, I think it is completely wrong to describe the aliased memory
> regions in DT.
> 
