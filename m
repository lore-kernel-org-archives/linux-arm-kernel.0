From: todd.fujinaka@intel.com (Fujinaka, Todd)
Date: Mon, 2 Jun 2014 16:05:20 +0000
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <CAHH3p5++xjH8+eeerBX468_rhfPeRh=43PsHETTRriA1uJrG7w@mail.gmail.com>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>
 <4893591.dl3XO76euB@wuerfel>
 <CAHH3p5JDXVZAKQUUQ5ao1GzwhNtU-+Hs_afT0tYeaw9oUthu-A@mail.gmail.com>
 <5174568.hMNHACE7UI@wuerfel>
 <CAHH3p5++xjH8+eeerBX468_rhfPeRh=43PsHETTRriA1uJrG7w@mail.gmail.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD653376495@ORSMSX114.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no hardware bug. The PCIe spec allows VDMs. Note Section 2.2.8.6 where there appear to be a couple of options.

- (Receivers) Completers silently discard Vendor_Defined Type 1 Messages which they are not designed to receive ? this is not an error condition.
- (Receivers) Completers handle the receipt of an unsupported Vendor_Defined Type 0 Message as an Unsupported Request, and the error is reported according to Section 6.2.

I think you may have MCTP enabled and you should be able to disable it in the EEPROM. I will need a lot more information about your system and whether the i210 is a LOM (LAD-on-motherboard, soldered onto your motherboard) or a NIC (what we call a plug-in PCIe card). Either way, you probably won't be able to get it changed without a working OS.

If it's a NIC, you can take it out and put it in a non-ARM Linux system and send me a dump of your current EEPROM.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565

-----Original Message-----
From: shiv prakash Agarwal [mailto:chhotu.shiv at gmail.com] 
Sent: Sunday, June 01, 2014 9:54 PM
To: Arnd Bergmann
Cc: linux-arm-kernel at lists.infradead.org; Duyck, Alexander H; Thomas Petazzoni; e1000-devel at lists.sourceforge.net; Jason Gunthorpe; Fujinaka, Todd; Lucas Stach
Subject: Re: [E1000-devel] ARM support for igb driver

Yes its hardware bug. I need to know whether we can disable it from device side? If yes, how?

On Sun, Jun 1, 2014 at 5:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 01 June 2014 11:26:57 shiv prakash Agarwal wrote:
>> I don't see all devices send VDMs, then why Intel I-210?
>
> There is no obligation to do it of course.
>
>> Also, Is it a bug in host bridge hardware or driver? If hardware, how 
>> can we make device not to send it?
>
> If the hardware cannot handle them, it's a hardware bug. If the 
> hardware does handle them correctly but the software doesn't, that is 
> a bug in the bridge driver.
>
> We have a couple of host bridge drivers that register a trap handler 
> and then look at the bridge registers to determine the exact cause.
>
> Which host bridge driver do you use?
>
>         Arnd
