From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 11 Jul 2011 22:25:21 +0300
Subject: [PATCH 3/4] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <CACTFLAPMh+XMpOPPqkDTaEZppSkWxVxFMH3RALTmqOCNk8WAvw@mail.gmail.com>
References: <1309319494-17951-1-git-send-email-leiwen@marvell.com>	<1309771536-10597-4-git-send-email-leiwen@marvell.com>	<4E1411BB.4010000@compulab.co.il>	<CACTFLAOmRMDH_6qo_WkndoWX-HPw9RTqbtsURDfw22sWEFS2wg@mail.gmail.com>	<4E1B3ECC.5080308@compulab.co.il>
	<CACTFLAPMh+XMpOPPqkDTaEZppSkWxVxFMH3RALTmqOCNk8WAvw@mail.gmail.com>
Message-ID: <4E1B4E21.1090507@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/11/11 21:53, Daniel Mack wrote:

> On Mon, Jul 11, 2011 at 8:19 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> On 07/11/11 17:49, Daniel Mack wrote:
>>> Lei, any ideas, can you reproduce this? To avoid further regressions
>>> of this driver, you really should have a system on which you can test
>>> suspend and resume after each commit.
>> I think the problem is that on PXA3xx resume from S2/S3 involves bootloader.
>> If I remember correctly, the BootROM reads the bootloader from the boot device
>> regardless of the reset cause (S2/S3 resume is kind a reset for PXA3xx).
> At least not in our case. The first level bootloader is entered on
> resume just as it is on a POR event, with the exception that the D3S
> bit in the ASCR register is set in this case.

You say "first level boot loader is entered"... who is loading it and where from?
Indeed, it should happen as in POR case, but again, it resides on some non-volatile
storage, isn't it? What storage does it reside on?

> We unconditionally
> initialize the static and dynamic memory controllers and then either
> jump to the routine that initializes the NAND controller, read the 2nd
> level loader and pass control to it. Or (in the resume case) we just
> jump to the address stored at the RAM address 0x80000000 (which has
> been set to cpu_resume previously) and thus enter the kernel again. No
> NAND operations in the game in this case, and this has always worked
> fine.

Except those to read the first stage boot loader... (if it resides on NAND).
Well, our case is working similarly and both the first stage bootloader (OBM)
and the second stage bootloader (U-Boot) reside on the NAND flash,
therefore BootROM has to reconfigure the NAND flash, so it can boot (resume).


>> Then the bootloader must decide what should be done according to the reset cause.
>> This means, that the BootROM already configures the NAND flash
>> (if it is the boot device) and pxa3xx_nand driver should just get on with it
>> and don't try to reconfigure?
> I think the problem is just the opposite. The driver expects the setup
> registers to retain their state over suspend, and doesn't write them
> again, and this causes operations to fail after resume.

Well, according to Lei, the driver writes back the configuration that is stored prior
to suspend and that's why I agreed that it should work...

http://www.spinics.net/lists/arm-kernel/msg131942.html



-- 
Regards,
Igor.
