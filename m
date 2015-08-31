From: robherring2@gmail.com (Rob Herring)
Date: Mon, 31 Aug 2015 16:49:10 -0500
Subject: [PATCH v3 2/5] ARM: NSP: add minimal Northstar Plus device tree
In-Reply-To: <20150831194404.GA28848@broadcom.com>
References: <1440805644-18241-1-git-send-email-jonmason@broadcom.com>
 <55E0FAC4.2040108@broadcom.com> <20150831022417.GA27066@broadcom.com>
 <55E3FFB5.6090703@broadcom.com> <20150831194404.GA28848@broadcom.com>
Message-ID: <CAL_JsqL1=WoaidMgLN4exvhF7bYr4FNGmtMgYO8e-c=NxP3JbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 31, 2015 at 2:44 PM, Jon Mason <jonmason@broadcom.com> wrote:
> On Mon, Aug 31, 2015 at 12:18:13AM -0700, Ray Jui wrote:
>>
>>
>> On 8/30/2015 7:24 PM, Jon Mason wrote:
>> > On Fri, Aug 28, 2015 at 05:20:20PM -0700, Ray Jui wrote:
>> >>
>> >>
>> >> On 8/28/2015 4:47 PM, Jon Mason wrote:
>> >>> Add a very minimalistic set of Northstar Plus Device Tree files which
>> >>> describes the SoC and the BCM958625 implementation.  The perpherials
>> >>> described are:
>> >>>
>> >>> ARM Cortex A9 CPU
>> >>> 2 8250 UARTs
>> >>> ARM GIC
>> >>> PL310 L2 Cache
>> >>> ARM A9 Global timer

[...]

>> >>> + apb {
>> >>> +         compatible = "arm,amba-bus", "simple-bus";
>> >>
>> >> Should "arm,amba-bus" has a separate bus node with AMBA compatible
>> >> devices declared in there (e.g, pl330, spi-pl022, and etc.) in the
>> >> future after they are brought up? To my best knowledge, "ns16550a" UART
>> >> is NOT an AMBA compatible device.

IIRC, "arm,amba-bus" is not documented nor used. It isn't really
needed as there is no s/w visible feature to an AMBA bus. There are
also multiple flavors of AMBA buses, so it is pretty meaningless.

>> > APB is an AMBA bus, so this part is accurate.  The block diagram of
>> > the SoC has the UARTs (and other perpherials) hanging off of the APB
>> > bus.  So, this organization follows the block diagram.
>>
>> Okay so the "apb" node can be used for amba compatible devices
>> (arm,amba-bus) and/or simple platform devices (simple-bus). I guess
>> that's fine and I now see that there are some other dtsi also doing it
>> this way.

I think what is meant here by "amba compatible devices" is really ARM
Primecell peripherals which are the ARM IP with standard ID registers.
These are designated by "arm,primecell" compatible strings for the
device not the bus compatible string.

>>
>> > While the
>> > UART drivers are not AMBA aware, there appears to be no issues with
>> > this layout (as the HW/drivers come up without issue). Unless there
>> > is an unforeseen issue with having non-AMBA aware devices on the DT
>> > AMBA bus, I would think it best to organize it to match the block
>> > disgram.
>> >
>>
>> UART runs fine because you also have "simple-bus" listed as the
>> compatible string so uart is populated as standard platform device.
>>
>> >>> +         interrupt-parent = <&gic>;
>> >>> +         ranges = <0x00000000 0x18000000 0x00001000>;
>> >>
>> >> Does the 'apb' bus mean to cover all peripherals connected through APB?
>> >> If so, the size is only 0x1000 and that seems to be too small...
>> >
>> > This is all that is currently needed.  I was planning on expanding it
>> > as I added more devices.
>>
>> Sure.
>>
>> I haven't checked the datahsheet but based on the layout (which seems
>> quite similar to Cygnus), I assume the range for these devices should be
>> 0x18000000 - 0x18ffffff? Just want to make sure there are no other
>> devices come before 0x18000000 so you don't need to change all these reg
>> offsets in the future.
>
> Based on the devices listed in the block diagram (and not including
> those on the AXI bus):
> i2c 0x18038000
> spi 0x18027200
> gpio 0x18000060
> pwm 0x18031000
> wdt 0x18039000
>
> and a few others.
>
> Looking at the sources, all the ARM IP is 0x19000000 and the rest is
> 0x18000000.  The only part that is a little harry is the clocks, which
> have BCM and ARM (which causes the addresses to be both 0x19000000 and
> 0x18000000).  But, we can handle that when we upstream that part (which
> should be very soon).

If you can tell that 0x19000000 is a separate bus at some level, then
it makes sense to separate it. You can't always tell without detailed
internal bus diagrams.

Rob
