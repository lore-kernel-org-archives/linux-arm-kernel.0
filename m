From: andy@warmcat.com (Andy Green)
Date: Tue, 29 Dec 2009 10:04:41 +0000
Subject: Ethernet in a cold climate / SMDK6410
In-Reply-To: <20091228224435.GA23617@sirena.org.uk>
References: <4B38FB80.9050609@warmcat.com>
	<20091228190009.GB14799@sirena.org.uk> <4B3901E3.20004@warmcat.com>
	<20091228192244.GD14799@sirena.org.uk>
	<4B390AC3.2060702@warmcat.com>
	<20091228202123.GA16524@sirena.org.uk>
	<4B391941.6000906@warmcat.com>
	<20091228224435.GA23617@sirena.org.uk>
Message-ID: <4B39D439.9070909@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28/09 22:44, Somebody in the thread at some point said:

Hi Mark -

>> I would suggest that relying on (mysterious, changeable) bootloader to
>> set up stuff like nCS timing and which nCS would be a dependency that
>> would be good to avoid.  People are trying to use the dev board as a
>> basis for their own designs and they have to ship an actual
>> non-quantum-mist bootloader with that.
>
> Like I say, I wasn't aware that these were soft configurable in the
> first place - I'd never needed to look beyond the hookup of the device
> in the Samsung kernel plus some detective work with the IRQ polarity
> configuration in the driver since the board miswires it.  I do agree
> that if these things are software configurable then we ought to be doing
> it in the kernel, I strongly suspect that any setup done by the
> bootloader is only being done when booting over the network.

Glad we agree on that.

Bootloaders are kind of out of control of these dev boards, iMX31 
LiteKIT even came with a closed source bootloader.  That destabilizes 
any certainty you can have about basing a design on the dev board, 
because you don't know how dependent successful behaviour will be on 
magic hidden in the bootloader, even if you got a fully working software 
stack on the dev board.

So I think the mach-blah.c files should try to assert the state of 
dependencies themselves for stuff they are saying they support, and make 
no assumption that the bootloader has done anything.  (And indeed I 
don't think the bootloaders should do anything except enough to get 
Linux started, but that's another story).

Like I say it sets up a magic nCS signal in the bootloader init, it 
talks about it as CS8900A but elsewhere they talk about "ethernet", so 
it may simply use this nCS to get to both ethernet chips, I didn't look 
at the schematic yet.

Just a sanity check, it was the case for you too that g_ether is broken 
and although you get a logical usb0 at both sides, they cannot communicate?

>> Right I wrote Qi bootloader support for s3c6410.  This allows true SD
>> boot from SMDK.  "True SD boot" means that the bootloader itself is on
>> SD Card and is brought over into RAM by the CPU ROM, so there is nothing
>> to brick on the device itself.
>
> Qi would be a massive step back for me in terms of usability
> unfortunately - having to transfer things to an SD card to boot them
> would add a lot to my edit, compile run cycle compared to netboot.

You seem pretty sure about that, so much so I guess you never tried this 
workflow.

There are two cases with SD Card boot and kernel work:

1) you screwed your kernel and it blows chunks on boot.  In that case, 
you either have to make arrangements in the bootloader to check a button 
and use a backup kernel if pressed (Qi supports this generically), or 
pop the SD card and write the kernel on the host.  In the button case, 
you just reset with that button down and use a host build script to ssh 
/ rsync over your next kernel try without touching the SD Card.

I guess you see the above case more often than most because of what 
you're doing, but actually I find it's only when I meddle in particular 
areas I run that risk; most things fail to work nicely until fixed or 
OOPS in a way that you can still send over your fixes in that session.

2) you are working on a driver that can be done modular while there's 
risk of it blowing chunks.  In this case your build script can build the 
kernel on the host and update the module over ssh / rsync.  You then 
modprobe -r / modprobe it without touching the SD Card or even resetting.

I don't see those workflows as any "massive step back"; compared to raw 
NAND being able to pop and rewrite the SD card in an emergency is 
certainly a massive step forward.


There's another reason to not act special towards the device with stuff 
that does not represent what will ship, as the developer you're the 
first user of it and if you're not hammering on, experiencing and 
optimizing the boot flow that ships, nobody else will.

In addition if opposed to network boot case you are working on an SD 
image all the time that can be taken as the shipping image, not some 
special tree of files on a host whose speed of access and code paths to 
get to it are completely different.

-Andy
