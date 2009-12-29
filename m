From: andy@warmcat.com (Andy Green)
Date: Tue, 29 Dec 2009 12:50:52 +0000
Subject: Ethernet in a cold climate / SMDK6410
In-Reply-To: <20091229123348.GB5784@opensource.wolfsonmicro.com>
References: <4B38FB80.9050609@warmcat.com>
	<20091228190009.GB14799@sirena.org.uk> <4B3901E3.20004@warmcat.com>
	<20091228192244.GD14799@sirena.org.uk>
	<4B390AC3.2060702@warmcat.com>
	<20091228202123.GA16524@sirena.org.uk>
	<4B391941.6000906@warmcat.com>
	<20091228224435.GA23617@sirena.org.uk>
	<4B39D439.9070909@warmcat.com>
	<20091229123348.GB5784@opensource.wolfsonmicro.com>
Message-ID: <4B39FB2C.4010608@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/29/09 12:33, Somebody in the thread at some point said:

Hi -

>> Like I say it sets up a magic nCS signal in the bootloader init, it
>> talks about it as CS8900A but elsewhere they talk about "ethernet",
>> so it may simply use this nCS to get to both ethernet chips, I
>> didn't look at the schematic yet.
>
> I'd assume so given that the board has a physical switch selecting between
> the two ethernet controllers.

Yeah I found that thismorning, CFG6.  I added a comment about that and 
the (discovered by trial and error) requirement that it's nCS1 
specifically needed to drive it to work with the 0x18000000 magic number.

I found that the nCS1 bus width defaults to 8-bit in the CPU, otherwise 
it's now addressable.  So I am adding some constants for s3c64xx SROM 
unit in the platform stuff and will set it up in mach-smdk6410.c.

>>> Qi would be a massive step back for me in terms of usability
>>> unfortunately - having to transfer things to an SD card to boot them
>>> would add a lot to my edit, compile run cycle compared to netboot.
>
>> You seem pretty sure about that, so much so I guess you never tried
>> this workflow.
>
> Really, I've tried this and similar workflows.  Network boot beats
> everything else I've tried.
>
>> 1) you screwed your kernel and it blows chunks on boot.  In that
>> case, you either have to make arrangements in the bootloader to
>> check a button and use a backup kernel if pressed (Qi supports this
>> generically), or pop the SD card and write the kernel on the host.
>> In the button case, you just reset with that button down and use a
>> host build script to ssh / rsync over your next kernel try without
>> touching the SD Card.
>
> Either physically swapping the SD card or having to dance with the
> bootloader to revert to a known good configuration then refresh are very
> involved relative to flipping the power switch and booting, partly
> because they do actually take a relatively long time and partly because
> they aren't the same routine normally used to boot and so require more
> attention and thought (not much, but enough).

Yeah.  All I can say is that constant testing of kernels that fail to 
boot is a somewhat specialized case.  You would be into pressing a 
button or popping the card.

>> 2) you are working on a driver that can be done modular while
>> there's risk of it blowing chunks.  In this case your build script
>> can build the kernel on the host and update the module over ssh /
>> rsync.  You then modprobe -r / modprobe it without touching the SD
>> Card or even resetting.
>
> This is what I'm actually doing - things that can be built modular
> generally are, but there's always things that won't allow that.

Sure.  In the ones you build modular, there's no cost to the SD flow.

>> I don't see those workflows as any "massive step back"; compared to
>> raw NAND being able to pop and rewrite the SD card in an emergency
>> is certainly a massive step forward.
>
> Compared to NAND removable media can be a win, yes, though with fast
> JTAG having to rewrite the flash needn't be any slower so it's not quite
> that clear cut.

Right, but if you can eliminate JTAG in the flow, especially at the 
factory, that is a major simplification.

SD + Qi has the advantage it eliminates completely "board bringup" at 
the factory.  Qi has no state stored on the board that changes boot 
flow.  So you can give a virgin board an SD and it brings itself up with 
no special gear or processing steps.

>> There's another reason to not act special towards the device with
>> stuff that does not represent what will ship, as the developer
>> you're the first user of it and if you're not hammering on,
>> experiencing and optimizing the boot flow that ships, nobody else
>> will.
>
> With what I do it is relatively rare for me to work directly on
> production systems - the majority of the systems I'm using for driver
> development involve lots of flying wires and never see the light of
> anything except my desk, the end result being either core kernel changes
> or chip-specific drivers.  Where I am working on production systems
> generally either it's not possible to do anything except JTAG onto the
> flash or the only thing changed by netboot is where the kernel image is
> loaded from.

Yeah understood.

Again all I can say is it's specialized case.  For normal dev work SD is 
either painless or hugely advantageous.

-Andy
