From: hs@denx.de (Heiko Schocher)
Date: Mon, 05 Dec 2011 12:49:04 +0100
Subject: [PATCH] arm,
 davinci: configure davinci aemif chipselects through OF
In-Reply-To: <4EDB68B7.8080609@mvista.com>
References: <1322991679-20947-1-git-send-email-hs@denx.de>
 <4EDB68B7.8080609@mvista.com>
Message-ID: <4EDCAFB0.1080009@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sergei,

Sergei Shtylyov wrote:
> Hello.
> 
> On 04-12-2011 13:41, Heiko Schocher wrote:
> 
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: grant.likely at secretlab.ca
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Wolfgang Denk <wd@denx.de>
> [...]
> 
>> diff --git a/Documentation/devicetree/bindings/arm/davinci/aemif.txt
>> b/Documentation/devicetree/bindings/arm/davinci/aemif.txt
>> new file mode 100644
>> index 0000000..c9ed551
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/davinci/aemif.txt
>> @@ -0,0 +1,85 @@
>> +* Texas Instruments Davinci AEMIF
>> +
>> +This file provides information, what the device node for the
>> +davinci aemifa interface contain.
> [...]
>> +Example (enbw_cmc board):
>> +    aemif at 60000000 {
>> +        compatible = "ti,davinci-emifa";
>> +        #address-cells = <2>;
>> +        #size-cells = <1>;
>> +        reg = <0x68000000 0x80000>;
>> +        ranges = <2 0 0x60000000 0x02000000
>> +              3 0 0x62000000 0x02000000
>> +              4 0 0x64000000 0x02000000
>> +              5 0 0x66000000 0x02000000>;
>> +        cs2 at 0x60000000 {
> 
>    0x shouldn't be included.

fixed.

>> +            compatible = "ti,davinci-cs";
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            /* all timings in nanoseconds */
>> +            cs = <2>;
>> +            asize = <1>;
>> +            ta = <0>;
>> +            rhold = <7>;
>> +            rstrobe = <42>;
>> +            rsetup = <14>;
>> +            whold = <7>;
>> +            wstrobe = <42>;
>> +            wsetup = <14>;
>> +            ew = <0>;
>> +            ss = <0>;
>> +        };
>> +        flash at 2,0 {
> 
>   Why you have one kind of address for cs2 at 60000000 node and other kind
> for this node?

Typo it must be

cs2 at 68000010 {
[...]
}

As the chipselect registers start @0x68000000 maybe
I should add in ranges a "x 0 0x68000000 0x00080000" line? But
which value has x, as this range has no chipselect? So I could add
subnodes "cs2 at 680000yy" with a reg entry "reg = <x yy 4>;" with
yy = offset from 0x68000000 and drop the "cs" property?

Or are the "ti,davinci-cs" nodes no subnodes from "ti,davinci-emifa",
so I easy can use "reg = <0x68000010 4>;"?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
