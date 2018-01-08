From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 8 Jan 2018 16:31:09 +0000
Subject: [PATCH] ARM: realview: remove eb-mp clcd IRQ
In-Reply-To: <CACRpkdbCWZB1ZkrdGe0s0GfNVWEYY+NThy4ce-+SBtU-s=WNbQ@mail.gmail.com>
References: <20171221213146.3146805-1-arnd@arndb.de>
 <CACRpkdbCWZB1ZkrdGe0s0GfNVWEYY+NThy4ce-+SBtU-s=WNbQ@mail.gmail.com>
Message-ID: <3cc1ad94-0a62-2f35-d204-2b89b8ba642b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 21/12/17 22:08, Linus Walleij wrote:
> On Thu, Dec 21, 2017 at 10:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> We get a dtc warning about the CLCD interrupt being invalid:
>>
>> arch/arm/boot/dts/arm-realview-eb-11mp-ctrevb.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd at 10008000
>>
>> According to the datasheet I found and the old board file, this
>> line is not connected, so I'm removing the respective properties here.
>>
>> Link: http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0411d/index.html
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> There is some confusion here. There is CLCD "Color LCD"
> which is just a code name for PrimeCell PL111 and there is the actual
> character LCD which is a hardware thin to talk to a character LCD with
> some characters on.
> 
>> diff --git a/arch/arm/boot/dts/arm-realview-eb-mp.dtsi b/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
> 
> So this DTS is for the ARM 11 MP core tile which is described in
> DUI0318F. It doesn't even list an IRQ for the character LCD.
> 
>>   &charlcd {
>> -       interrupt-parent = <&intc>;
>> -       interrupts = <0  IRQ_TYPE_LEVEL_HIGH>;
> 
> This was probably me thinking to go back and fill in the right
> IRQ and forgetting to actually do it. Sorry :(
> 
>> +       /* CLCD is not connected here */
> 
> Call it character LCD instead to avoid confusion please.
> 
>> +       /delete-property/interrupt-parent;
>> +       /delete-property/interrupts;
> 
> I don't understand this delete-property business (first time
> I see it, but the top level
> DTSI (arm-realview-eb.dtsi) does not define any interrupt
> so can't you just delete this whole &charlcd?
> 
> I do think the reference design has a character LCD, and I
> do think it has an interrupt, it's just undocumented so
> someone with this board would have to test it manually
> to figure out which line it is. Whoever uses this design
> will get to it if ever.

FWIW the EB baseboard is *physically* the same regardless of the CPU, 
it's just flashed with a Core-Tile-specific FPGA bitstream. I've just 
tried firing up an 11MPCore one, and indeed the character LCD does light 
up with the kernel version. I can't convince the recalcitrant beast to 
actually get to userspace, though, so I can't confirm what the 
interrupt's deal is.

The baseboard manual (DUI0303E) says it's interrupt 22 on the 
board-level secondary GICs, and since neither the CT11MP nor its 
corresponding FPGA (AN152) mention any alternate routing direct to the 
Core Tile GIC, I'd guess it probably still is. On the other hand, 
though, it also says this:

   "... However this interrupt signal is reserved for future use and you
    must use a polling routine instead of an interrupt service routine."

So maybe it's appropriate to just remove the interrupt everywhere :/

Robin.
