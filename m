From: Noel.Vellemans@visionBMS.com (Vellemans, Noel)
Date: Thu, 20 Jul 2017 13:13:10 +0000
Subject: IMX53 on recent 4.4.x kernels
In-Reply-To: <20170720123933.rioxhsthaaby4cnl@pengutronix.de>
References: <D24E577EA1E37B4788A3BFBC418F14A707591D67@wetsrvex01.loepfe.com>
 <20170720123933.rioxhsthaaby4cnl@pengutronix.de>
Message-ID: <D24E577EA1E37B4788A3BFBC418F14A707592381@wetsrvex01.loepfe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


>>Please try a more recent kernel first. 4.4 is quite ancient, and MX53 is well supported on 4.12 or 4.13+.
>>Regards,
>>Robert

I' already did ( maybe I was not clear enough in the previous mail , did test  4.4.x series and 4.12  kernel ! ) 

4.12 Has the exactly same problem  ( ONFI parameter page can not be read , on ONE of the boards)

=>  nand: Could not find valid ONFI parameter page; aborting
=>  nand: No NAND device found

When logging (added couple of printk's) I show me the exact same failure ( But as said before... on 1 test board..., all other boards are working with this 4.12 ( and / or 4.4.x) kernels)

* For the bad-one ( on kernel 4.12 / 4.4.x , but working on 2.6.35). I get this DUMP of the ONFI-parameters-read-back
 

[    1.819926] NAND_CMD_PARAM- data[0] = 0x4E =>N
[    1.824666] NAND_CMD_PARAM- data[1] = 0x46 => F
[    1.829405] NAND_CMD_PARAM- data[2] = 0x49 => I
[    1.834143] NAND_CMD_PARAM- data[3] = 0x1E
[    1.838882] NAND_CMD_PARAM- data[4] = 0x00
[    1.843619] NAND_CMD_PARAM- data[5] = 0x58
... some bytes/lines are stripped here
..
[   3.053545] NAND_CMD_PARAM- data[253] = 0x20 ????? ( crc byte also on the wrong offset!!!)
[    3.058458] NAND_CMD_PARAM- data[254] = 0x12 (crc is/or should be here on this offset)
[    3.063371] NAND_CMD_PARAM- data[255] = 0x4F ( O of the second ONFI parameter block)

THIS IS WRONG ( all is shifted one byte)  !! ( O is missing , the FIRST byte should be 'O') 


Just For Info ..  I've been logging/debugging in this recent "mxc_nand" driver all I can imagine, but the very strange thing is that the BYTES read by the IMX-NAND-FLASH controller... are shifted one byte into the 'RAM-area' of the NAND-FLASH controller... ( on one  1-bad behaving board/cpu, but working on 9 identical boards)  !

As said before, when double checking all registers on the NAND-Controller all seems to be initialized correctly , what means . I'm running out of options on things I can check ! What worries me the most is that even this BAD-behaving board is running FINE on the OLDER kernel 2.6.35 !


Regards
Noel


_______________________
Noel Vellemans
BMS bvba

-----Original Message-----
From: Robert Schwebel [mailto:r.schwebel at pengutronix.de] 
Sent: Thursday, July 20, 2017 2:40 PM
To: Vellemans, Noel
Cc: linux-arm-kernel at lists.infradead.org
Subject: Re: IMX53 on recent 4.4.x kernels

Hi,

On Thu, Jul 20, 2017 at 06:57:37AM +0000, Vellemans, Noel wrote:
> I'm facing a PERFORMANCE problem on recent ARM/IMX  kernels !  ? I 
> have ported a recent kernel (4.4.x branch) to one of our custom ARM ( 
> imx53-based ) boards. This board has been running kernel 2.6.35.x for 
> some years, and at this time we decided we needed newer kernel ( for 
> wifi operation), so far so good.

Please try a more recent kernel first. 4.4 is quite ancient, and MX53 is well supported on 4.12 or 4.13+.

Regards,
Robert
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
