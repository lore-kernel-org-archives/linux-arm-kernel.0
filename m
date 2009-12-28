From: andy@warmcat.com (Andy Green)
Date: Mon, 28 Dec 2009 20:46:57 +0000
Subject: Ethernet in a cold climate / SMDK6410
In-Reply-To: <20091228202123.GA16524@sirena.org.uk>
References: <4B38FB80.9050609@warmcat.com>
	<20091228190009.GB14799@sirena.org.uk> <4B3901E3.20004@warmcat.com>
	<20091228192244.GD14799@sirena.org.uk>
	<4B390AC3.2060702@warmcat.com>
	<20091228202123.GA16524@sirena.org.uk>
Message-ID: <4B391941.6000906@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28/09 20:21, Somebody in the thread at some point said:

Hi -

>> I went and looked at the sources for that I got from Samsung, it talks
>> only about CS8900.
>
> That's...  interesting.  To be honest I don't think I've ever seen the
> source code for the bootloaders, but none of the SMDK boards I've had
> have defaulted to using the CS8900 - I've never actually seen software
> that talked to it to my knowledge, the Samsung bootloaders and kernels
> were all using the SMSC chip and obviously that's what mainline has been
> doing too.

Well it's a fact.  I sent you a link these GPL'd sources separately.

>> I meant mach-smdk6410.c, since it wants to configure Linux to use stuff
>> that has dependencies it doesn't control.  If it's going to claim
>> something is there at 0x18000000 for a particular machine then it's at
>> least arguable it should configure any soft prerequisites (nCS)
>> accordingly and document the ones out of its control.
>
> Oh, sure - you were saying it should configure stuff and obviously most
> of these things are completely out of scope for software which wasn't
> very clear at all.  I quite frankly wasn't aware that there were any
> relevant soft controls at all.

I would suggest that relying on (mysterious, changeable) bootloader to 
set up stuff like nCS timing and which nCS would be a dependency that 
would be good to avoid.  People are trying to use the dev board as a 
basis for their own designs and they have to ship an actual 
non-quantum-mist bootloader with that.

> By the way, the other thing to watch out for with the Samsung boards is
> that as well as the DIP switches there's a bunch of resistor fit options
> that can be changed as well.

Yeah, I saw it on SPI0 before (I want to use this as an SPI peripheral 
meddling platform at the moment).  The socket is sitting there with NC 
resistor pack so no signals.

> It sounds like you've at least got a completely different bootloader (or
> the source is highly misleading).  The other thing to check is which rev
> of the board you have, there have been several revisions though I don't
> recall any changes in the networking.

Right I wrote Qi bootloader support for s3c6410.  This allows true SD 
boot from SMDK.  "True SD boot" means that the bootloader itself is on 
SD Card and is brought over into RAM by the CPU ROM, so there is nothing 
to brick on the device itself.

If anyone is interested see the txtr branch of

  http://git.warmcat.com/cgi-bin/cgit/qi/

SMDK6410 docs tell the following to enable SD Card boot:

CFGB1 - CFG4 (under the LCD)

~____ __~_ ~___ ____ ____ ____ ~_ ~~~_ __~_ ____ ____

CFG3

[
[
[
[
[
  ]

CFG4

  ]
  ]
[
[

CFG1

  ]
[
[
[

J8: 1-2
J7: 1-2
J6: 1-2

You also need a particular ROM revision in your SMDK but this one is 
over a year old so I guess it's common now.

-Andy
