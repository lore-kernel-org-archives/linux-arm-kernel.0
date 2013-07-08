From: ml@communistcode.co.uk (Jack Mitchell)
Date: Mon, 08 Jul 2013 17:00:43 +0100
Subject: socfpga: mmc problems
In-Reply-To: <1373296930.22692.2.camel@linux-builds1>
References: <51D43CB0.4070104@communistcode.co.uk>
 <1372864190.9525.6.camel@linux-builds1>
 <51D532D2.1030709@communistcode.co.uk>
 <1373296930.22692.2.camel@linux-builds1>
Message-ID: <51DAE22B.6000201@communistcode.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On 08/07/13 16:22, Dinh Nguyen wrote:
> Hi Jack,
>
> On Thu, 2013-07-04 at 09:31 +0100, Jack Mitchell wrote:
>> Morning Dinh,
>>
>> On 03/07/13 16:09, Dinh Nguyen wrote:
>>> Hi Jack,
>>>
>>> On Wed, 2013-07-03 at 16:01 +0100, Jack Mitchell wrote:
>>>> Having received one of the new Arrow SoCkit boards at a recent training
>>>> day I set about seeing how far mainline was in successfully booting this
>>>> board.
>>>>
>>>> As I wanted to boot from mmc, I first checked out linux-next [1] in
>>>> order to get the newly merged mmc driver, I then applied the device-tree
>>>> enablement series [2] on top before finally attempting to boot. I then
>>>> found that the standard socfpga_defconfig didn't enable the MMC drivers,
>>>> which I also did (should this be part of the socfpga_defconfig...?).
>>>
>>> I was going to update this when I enable ethernet as well to avoid less
>>> churn on the defconfig.
>>
>> That's great!
>>
>>>
>>>>
>>>> However, the boot hangs at:
>>>>
>>>> Synopsys Designware Multimedia Card Interface Driver
>>>> dwmmc_socfpga ff704000.dwmmc0: Using internal DMA controller.
>>>> dwmmc_socfpga ff704000.dwmmc0: DW MMC controller at irq 171, 32 bit host
>>>> data width, 1024 deep fifo
>>>>
>>>> To fix this I checked out the diff between the Altera vendor mmc driver
>>>> and the mainline driver and found that if I added this small change:
>>>>
>>>>
>>>>      if (of_property_read_u32(dev->of_node, "pwr-en", &pwr_en)) {
>>>>        dev_info(dev, "couldn't determine pwr-en, assuming pwr-en = 0\n");
>>>>        pwr_en = 0;
>>>>      }
>>>>
>>>>      /* Set PWREN bit */
>>>>      mci_writel(host, PWREN, pwr_en);
>>>
>>> I tested this on my devkit, which was not made by Arrow, but is _almost_
>>> the same. I'll try to see if I can get my hands on an Arrow board to
>>> reproduce.
>>
>> Now, I think I made a _slight_ mistake, in that I accidentally copied
>> the Altera vendor kernel onto the sdcard instead of the linux-next
>> kernel. Re-testing this morning with a fresh mind, I checked the config
>> again and now I find the Arrow board still won't boot from MMC, even
>> with the above change, with the code hanging at the same place.
>>
>> I know you don't have an Arrow board, but if you have a tree which I
>> could pull from with your amalgamated changes; that would rule out me
>> missing any patches and it actually being a board problem. I can't seem
>> to see if the V8 device tree patches were pulled into anyones tree,
>> otherwise I would just wait till they appeared in 3.11-rc1...?
>
> Unfortunately, the device tree bindings for the SD/MMC did not make it
> into the arm-soc tree for 3.11, only the sd/mmc platform driver. Will
> try for 3.12.
>
> I'm sure you have seen git.rocketboards.org?

Yes, I have the 3.9 rocketboards kernel compiling and working so I'm not 
stuck; just interested in keeping up to date with how mainline is 
progressing and helping with testing (and nit picking!).

Cheers,
Jack.

>
> Dinh
>>
>> Sorry for the confusion!
>>
>>>
>>>>
>>>> In the dw_mci_socfpga_priv_init function, the board would boot.
>>>>
>>>> Synopsys Designware Multimedia Card Interface Driver
>>>> dwmmc_socfpga ff704000.dwmmc0: couldn't determine pwr-en, assuming
>>>> pwr-en = 0
>>>> dwmmc_socfpga ff704000.dwmmc0: Using internal DMA controller.
>>>> dwmmc_socfpga ff704000.dwmmc0: DW MMC controller at irq 171, 32 bit host
>>>> data width, 1024 deep fifo
>>>> mmc_host mmc0: Bus speed (slot 0) = 100000000Hz (slot req 400000Hz,
>>>> actual 400000HZ div = 125)
>>>> dwmmc_socfpga ff704000.dwmmc0: 1 slots initialized
>>>> dwmmc_socfpga ff704000.dwmmc0: Version ID is 240a
>>>> .....
>>>> .....
>>>> .....
>>>>
>>>>
>>>> Has this been overlooked, or are there some other changes elsewhere that
>>>> I haven't yet come across which addresses this?
>>>
>>> I'm not aware of any other changes.
>>>
>>> Dinh
>>>>
>>>> Cheers,
>>>>
>>>> [1] fa1383200d289afdff2f5678eb89483daa537465
>>>> [2] http://comments.gmane.org/gmane.linux.ports.arm.kernel/243529
>>>>
>>>
>>>
>>>
>>
>>
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>


-- 

   Jack Mitchell (jack at embed.me.uk)
   Embedded Systems Engineer
   http://www.embed.me.uk

--
