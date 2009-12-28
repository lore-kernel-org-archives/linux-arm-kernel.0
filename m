From: andy@warmcat.com (Andy Green)
Date: Mon, 28 Dec 2009 19:45:07 +0000
Subject: Ethernet in a cold climate / SMDK6410
In-Reply-To: <20091228192244.GD14799@sirena.org.uk>
References: <4B38FB80.9050609@warmcat.com>
	<20091228190009.GB14799@sirena.org.uk> <4B3901E3.20004@warmcat.com>
	<20091228192244.GD14799@sirena.org.uk>
Message-ID: <4B390AC3.2060702@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28/09 19:22, Somebody in the thread at some point said:

Hi -

>>   - the Samsung U-Boot fork that came with the SMDK?
>
> Yes, whatever was flashed on it when Samsung last had the board.  The
> bootloader does explicitly say it's looking for the SMSC chip when
> setting it up.

I went and looked at the sources for that I got from Samsung, it talks 
only about CS8900.

#define CS8900_Tacs	(0x0)	// 0clk		address set-up
#define CS8900_Tcos	(0x4)	// 4clk		chip selection set-up
#define CS8900_Tacc	(0xE)	// 14clk	access cycle
#define CS8900_Tcoh	(0x1)	// 1clk		chip selection hold
#define CS8900_Tah	(0x4)	// 4clk		address holding time
#define CS8900_Tacp	(0x6)	// 6clk		page mode access cycle
#define CS8900_PMC	(0x0)	// normal(1data)page mode configuration

...

	SROM_BW_REG &= ~(0xf << 4);
	SROM_BW_REG |= (1<<7) | (1<<6) | (1<<4);
	SROM_BC1_REG = 
((CS8900_Tacs<<28)+(CS8900_Tcos<<24)+(CS8900_Tacc<<16)+(CS8900_Tcoh<<12)+(CS8900_Tah<<8)+(CS8900_Tacp<<4)+(CS8900_PMC));

I had a quick grep for corresponding register defines in S3C64xx Linux 
bits but didn't see anything.

>>   - 60+ minidip config was what?
>
> Factory default - I can't immediately visualise which switches you're
> talking about and I'm out of the office until next Monday so I can't
> check with the boards how they're set up.  I don't recall any relevant
> switches.

No worries.  There are a row of mainly 4-switch mini-dips under the LCD 
that control who gets to see which chip select, I'm pretty sure setting 
them wrong will break access to "ethernet" whatever that means.

If we had like S3C6410_PHYS_NCS2 instead of 0x18000000 I could get a 
clue, but I realize you didn't get that from the Samsung tree either.

>> I'm guessing 0x18000000 is on a particular nCS signal that needs
>> configuring (should that really not be the business of the machine
>> definition file?) and the mini DIPs setting to match.
>
> I'd expect so.
>
> I'm not sure what you mean by the "machine definition file" here?  The

I meant mach-smdk6410.c, since it wants to configure Linux to use stuff 
that has dependencies it doesn't control.  If it's going to claim 
something is there at 0x18000000 for a particular machine then it's at 
least arguable it should configure any soft prerequisites (nCS) 
accordingly and document the ones out of its control.

> large number of non-probable and incompatible changes on the Samsung
> boards mean that it's generally best to leave them at factory default
> settings unless you have a particular need to change things since the
> kernel tends to be configured for the default setup.

Yeah.  But again if the successful operation of the file that defines 
how Linux works with the SMDK is dependent on stuff like magic switch 
configuration ideally it would tell what the dependencies are in a 
comment, accepting random changes to boards you don't have are out of 
scope.  That one file anyway mach-smdk6410.c is super-specific to the 
board and is the only place to talk about the dependencies.

I understand that you might be able to get that working and yet not 
understand the intricacies of the dev board, and we're still ahead that 
you managed to get anything working.

My board is as shipped with the switches AFAIK except configured for SD 
Card boot according to Samsung docs.

-Andy
