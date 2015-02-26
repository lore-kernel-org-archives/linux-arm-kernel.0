From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 26 Feb 2015 19:49:09 +0800
Subject: [PATCH 1/3] mtd: atmel_nand: move the hsmc_clk from nfc node to
 nand node
In-Reply-To: <20150226101857.59104e97@bbrezillon>
References: <1423548885-27589-1-git-send-email-josh.wu@atmel.com>
 <20150226101857.59104e97@bbrezillon>
Message-ID: <C9CC8708-B99A-47F4-AC57-1A92B302E1C9@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Feb 26, 2015, at 5:18 PM, Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> 
> Hi Josh,
> 
> On Tue, 10 Feb 2015 14:14:43 +0800
> Josh Wu <josh.wu@atmel.com> wrote:
> 
>> Also add a new sama5d3_nand compatiable string for sama5d3 nand.
>> 
>> For sama5d3, sama5d4 chip, the pmecc became part of HSMC, they need the
>> HSMC clock enabled to work.
>> The NFC is a sub feature for current nand driver, it can be disabled.
>> But if HSMC clock is controlled by NFC, so disable NFC will also disable
>> the HSMC clock. then, it will make the PMECC fail to work.
>> 
>> So the solution is move the HSMC clock out of NFC to nand node. When
>> nand driver probed, it will check whether the chip has HSMC, if yes then
>> it will require a HSMC clock.
> 
> Do you plan to use the NAND chip without the NFC (I mean, is there a
> reason for not using the NFC to access the NAND ?) ?
> If you don't, why don't you just wait for the NFC before probing the
> NAND chip it is attached to, so that the hmsc clk is properly claimed.
you can as you can have 2 Nand on the d3 but only 1 NFC

Best Regards,
J.
> 
> I'm not convinced that moving a clk reference out of the controller
> node can address the fact that the nand/nand-controller DT
> representation is inappropriate (your embedding controller specific
> information in your NAND chip definition).
> I think we should reconsider this problem with a controller/chip
> approach:
> - which parts are representing the NAND controller: the PMECC engine,
>  the NFC if available, ...
> - which parts are representing the NAND chip: the EBI mem range, the
>  R/B pin, the ALE/CLE information, ...
> 
> And of course, we should take the EBI/SMC rework into account ;-).
> 
> Best Regards,
> 
> Boris
> 
> 
> -- 
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
