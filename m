From: jamienstar@163.com (Jamie Huang)
Date: Wed, 10 Aug 2016 15:24:56 +0800
Subject: About the accuracy of delay loop
Message-ID: <20160810152456.41f6e727@JAMIE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, all.
	I have a question about the commit
	d0a533b18235d36206b9b422efadb7cee444dfdb ARM: 7452/1: delay:
allow timer-based delay implementation to be selected.

	Recently, I found the BogoMIPS info of kernel start-up log is
	not correct.The correct info is as follows:

	Calibrating delay loop... 719.25 BogoMIPS (lpj=3596288)

	But, after the patch above, the info changed as follows:

	Calibrating delay loop... 478.41 BogoMIPS (lpj=2392064)

	I find the difference from assembly code.
	Before the patch:
	  __delay(loops_per_jiffy);
             c002bcf0:       e50b3034   str r3, [fp, #-52]  ; 0x34
             c002bcf4:       e50b2030   str r2, [fp, #-48]  ; 0x30
             c002bcf8:       eb06ddd8   bl c01e3460 <__delay>

	After the patch:
          __delay(loops_per_jiffy);
             c04add08:       e5932000   ldr r2, [r3]
             c04add0c:       e50b105c   str r1, [fp, #-92]  ; 0x5c
             c04add10:       e50b3060   str r3, [fp, #-96]  ; 0x60
             c04add14:       e50bc064   str ip, [fp, #-100] ; 0x64
             c04add18:       e12fff32   blx r2

 	There are two additional instructions, and these will
 	influence calibration of delay loop. I also worry that this
 	new implementation will influence the accuracy of udelay. Does
 	any one know this problem?
