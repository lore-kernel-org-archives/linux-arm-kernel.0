From: andy@warmcat.com (Andy Green)
Date: Mon, 28 Dec 2009 18:40:00 +0000
Subject: Ethernet in a cold climate / SMDK6410
Message-ID: <4B38FB80.9050609@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi -

I broke out my old SMDK6410 last night and tried linux-next then Ben's 
git on it (currently next-s3c64xx-updates) started from s3c6410 Qi / SD 
Card boot.

It's basically happy but OTG doesn't seem workable for Ethernet gadget. 
  Well it's dumping a lot of debug messages so I guess maybe that's 
where it got up to, fair enough.

I eyeballed the back of the SMDK and I see a CS8900A and a SMSC LAN9115 
both sitting there, coming out on separate RJ45s.  When I look at the 
machine init file, I see Mark added

static struct resource smdk6410_smsc911x_resources[] = {
	[0] = {
		.start = 0x18000000,
		.end   = 0x18000000 + SZ_64K - 1,
		.flags = IORESOURCE_MEM,
	},
...

What is the deal with that in terms of SDMK settings and assumptions 
about bootloader prepping nCS signals?  SMDK docs I have let me twiddle 
switches and get "ethernet" connected to various selects.  What does 
0x18000000 represent and how should the board be set so CS8900A doesn't 
crash the party?

After some debug-by-printk, I see smsc911x probe is failing with:

smsc911x: BYTE_TEST: 0xFFFFFFFF
smsc911x: top 16 bits equal to bottom 16 bits
smsc911x: This may mean the chip is set for 32 bit while the bus is 
reading 16 bit
smsc911x: init failed

So I am guessing the nCS pin is not configured, something is missing a 
clock... one of the dozens of mini DIP switches is "wrong"?

-Andy
