From: zonque@gmail.com (Daniel Mack)
Date: Thu, 25 Oct 2012 10:00:27 +0200
Subject: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <508895D8.5000701@ti.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com>
 <1350935758-9215-5-git-send-email-zonque@gmail.com> <508895D8.5000701@ti.com>
Message-ID: <5088F19B.7050606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

many thanks for your time to look at this.

On 25.10.2012 03:28, Jon Hunter wrote:
> On 10/22/2012 02:55 PM, Daniel Mack wrote:
>> diff --git a/Documentation/devicetree/bindings/bus/gpmc.txt b/Documentation/devicetree/bindings/bus/gpmc.txt
>> new file mode 100644
>> index 0000000..ef1c6e1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/bus/gpmc.txt
>> @@ -0,0 +1,59 @@
>> +Device tree bindings for OMAP general purpose memory controllers (GPMC)
>> +
>> +The actual devices are instantiated from the child nodes of a GPMC node.
>> +
>> +Required properties:
>> +
>> + - compatible: Should be set to "ti,gpmc"
> 
> Is this the only required property? I think that "reg" and "ti,hwmods"
> are probably also required.

Well yes, but at least "reg" is commonly omitted as it's part of a more
"generic" set of properties. But ok, I can add these.

> Also given that we are describing the hardware, I am wondering if the
> number of chip-selects and wait signals should be defined here too. I
> recall that different devices had different number of wait pins available.

Hmm, that number is currently hard-coded in GPMC_CS_NUM. It would take
some effort to make that dynamic but I agree that this would be a good
thing to have. Afzal?

>> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> new file mode 100644
>> index 0000000..6790fcf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> @@ -0,0 +1,65 @@
>> +Device tree bindings for GPMC connected NANDs
>> +
>> +GPMC connected NAND (found on OMAP boards) are represented as child nodes of
>> +the GPMC controller with a name of "nand".
>> +
>> +All timing relevant properties are explained in a separate documents - please
>> +refer to Documentation/devicetree/bindings/bus/gpmc.txt
>> +
>> +Required properties:
>> +
>> + - reg: The CS line the peripheral is connected to
> 
> Is this the only required property? I would have thought that bus-width
> is needed too.

I described bus-with in the nand bindings and stated there that it
defaults to 8 and the only meaningful other value us 16. I did that
because the value is in fact parsed in the NAND code, but I can as well
move this around in the documentation.

> In general, I am wondering if this should be broken into two patches as
> you are creating the binding for the gpmc and nand here.

Yes, I thought so too. The thing is that I wanted to keep documentation
and implementation tightly together, and only the generic parser bits in
the code doesn't make much sense without any users. Also, the two
Documentations reference each other, so I thought having them in one
piece could make reviewing easier. But I can of course also split it if
that helps.


Thanks,
Daniel
