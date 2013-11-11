From: lho@apm.com (Loc Ho)
Date: Mon, 11 Nov 2013 09:50:05 -0800
Subject: [PATCH v2 5/5] Documentation: Add documentation for APM X-Gene
 SATA DTS binding
In-Reply-To: <201311102139.10082.arnd@arndb.de>
References: <1383980431-6572-1-git-send-email-lho@apm.com>
 <1383980431-6572-5-git-send-email-lho@apm.com>
 <1383980431-6572-6-git-send-email-lho@apm.com>
 <201311102139.10082.arnd@arndb.de>
Message-ID: <CAPw-ZT=pBmDERDkaX66qStqVB2bD95248GKQpVQZWjmryA4uxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

>> ---
>>  .../devicetree/bindings/ata/apm-xgene.txt          |   84 ++++++++++++++++++++
>
> Please Cc the devicetree-discuss mailing list for the binding submission.
[Loc Ho]
I did cc on the first version. But this email
'devicetree-discuss at lists.ozlabs.org' bounced on me.

>> +- interrupt-parent   : Interrupt controller
>> +- interrupts         : Interrupt mapping for SATA IRQ
>> +- #clock-cells               : Shall be value of 1
>
> Why is there a #clock-cells entry here?
[Loc Ho]
Okay... Let me see if I can get rip of this.

>
>> +- clocks             : Reference to the clock entry
>> +- clock-names                : Shall be "eth01clk", "eth23clk", or "eth45clk".
>
> This makes no sense. The clock-names property needs to have a fixed
> string according to the name of the clock input signal of the hardware,
> not a name of the clock provider.
[Loc Ho]
The clock "eth01clk", "eth23clk", and "eth45clk" are the internal
divider clock. They are not the physical input clock. It sounds like
we don't need the "clock-names" are all.

>
>> +- serdes-diff-clk    : Shall be 0 for external, 1 internal differential,
>> +                       or 2 internal single ended clock. Default is 0.
>> +- gen-sel            : Shall be 1 (force Gen1), 2 (Force Gen2, or 3 Gen3).
>> +                       Default is 3.
>> +- EQA1                       : Serdes EQ parameter for A1 chip. Default is 9.
>> +- EQ                 : Serdes EQ parameter for non-A1 chip. Default is 2.
>> +- GENAVG             : Enable averaging Serdes calculation. Default is 0 for
>> +                       A1 chip and 1 for non-A1 chip.
>> +- LBA1                       : Serdes loopback buffer for A1 chip. Default is 1;
>> +- LB                 : Serdes loopback buffer for non-A1 chip. Default is 0;
>> +- LCA1                       : Serdes loopback enable control for A1 chip. Default
>> +                       is 1;
>> +- LC                 : Serdes loopback enable control for non-A1 chip.
>> +                       Default is 0;
>> +- CDRA1                      : Serdes SPD select CDR for A1 chip. Default is 5.
>> +- CDR                        : Serdes SPD select CDR for non-A1 chip. Default is 5.
>> +- PQA1                       : Serdes PQ for A1 chip. Default is 8.
>> +- PQ                 : Serdes PQ for non-A1 chip. Default is 0xA.
>> +- coherent           : Enable coherent (1 = enable, 0 = disable).
>> +                       Default is 1.
>
> This looks like a really bad binding. I would suggest that instead of having
> individual register values in here, you hardwire the settings in the driver
> based on the compatible string. It's pretty crazy to put register-level configuration
> in the DT like this.
[Loc Ho]
If I hardwire them in the driver, it will NOT scale across multiple
board. I guess if I moved it out to the PHY driver, then we can
discuss in that driver.

>
> Further, you should probably use the generic PHY binding to create a separate driver
> for the serdes PHY,
>
[Loc Ho]
I will look into this.

-Loc
