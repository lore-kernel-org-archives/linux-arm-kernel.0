From: mirza.krak@gmail.com (Mirza Krak)
Date: Tue, 23 Aug 2016 12:33:09 +0200
Subject: [PATCH 3/6] dt/bindings: Add bindings for Tegra GMI controller
In-Reply-To: <901be576-a810-c630-9b83-de922e945df0@nvidia.com>
References: <1470512452-8322-1-git-send-email-mirza.krak@gmail.com>
 <1470512452-8322-4-git-send-email-mirza.krak@gmail.com>
 <901be576-a810-c630-9b83-de922e945df0@nvidia.com>
Message-ID: <CALw8SCV9AyaAPKpRwRp72-dUz=cW2QZyywqjzS1noonTyGDYag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-08-08 16:44 GMT+02:00 Jon Hunter <jonathanh@nvidia.com>:
>> +
>> +  gmi at 70090000 {
>> +    #address-cells = <1>;
>> +    #size-cells = <1>;
>
> I think 0 for size makes sense. I know that caused you problems before,
> but I am wondering if ...
>
>> +    ranges;
>
> ... ranges is needed here? If we do have it, I am wondering if it should
> be a single entry for the chip-select that is being used. For now we
> could only support a ranges with one entry.
>
>         #address-cells = <1>;
>         #size-cells = <1>;
>         ranges = <4 0x48000000 0x00040000>;
>
>> +    nvidia,snor-mux-mode;
>> +    nvidia,snor-adv-inv;
>> +    nvidia,snor-cs-select = <4>;
>
> I would have expected these under bus at X node as they are specific to the
> GMI CS.
>
> I would also expect that the actual chip-select number is encoded in the
> reg property.
>
>> +
>> +    bus at 0,0 {
>
> bus at 4
>
> No mention of this bus node in the above documentation.
>
>> +      compatible = "simple-bus";
>> +      reg = <0 0>;
>
> reg = <4>;
>
> We should look up the chip-select from the reg property.
>
>> +      ranges;
>> +
>> +      #address-cells = <1>;
>> +      #size-cells = <1>;
>> +
>> +      can at 48000000 {
>> +        reg = <0x48000000 0x100>;
>> +        ...
>> +      };
>> +
>> +      can at 48040000 {
>> +        reg = <0x48040000 0x100>;
>> +        ...
>> +      };
>
> If we use ranges we could have ...
>
>         can at 0 {
>                 reg = <0x0 0x100>;
>                 ...
>         };
>
>         can at 40000 {
>                 reg = <0x40000 0x100>;
>                 ...
>         };
>

Hi.

Like we discussed I am now trying to implement this but without
success and I am starting to think that it is not that simple unless I
am missing something.

Below tree

gmi at 70009000 {
     status = "okay";
     #address-cells = <1>;
     #size-cells = <1>;
     ranges = <4 0x48000000 0x7ffffff>;

     bus at 4 {
          compatible = "simple-bus";
          reg = <4 0>;
          #address-cells = <1>;
          #size-cells = <1>;
         nvidia,snor-mux-mode;
         nvidia,snor-adv-inv;

        can at 0 {
              compatible = "nxp,sja1000";
              reg = <0 0x100>;
              ....
     };

     can at 40000 {
           compatible = "nxp,sja1000";
           reg = <0x40000 0x100>;
           ....
    };
};
};

results in:

[    8.472509]    create child: /gmi at 70009000/bus at 4/can at 0
[    8.472561] OF: ** translation for device /gmi at 70009000/bus at 4/can at 0 **
[    8.472577] OF: bus is default (na=1, ns=1) on /gmi at 70009000/bus at 4
[    8.472589] OF: translating address: 00000000
[    8.472624] OF: parent bus is default (na=1, ns=1) on /gmi at 70009000
[    8.472641] OF: no ranges; cannot translate
[    8.472668] of_irq_parse_one: dev=/gmi at 70009000/bus at 4/can at 0, index=0
[    8.472687]  intspec=13 intlen=2
[    8.472726]  intsize=2 intlen=2
[    8.472740] of_irq_parse_raw:  /gpio at 6000d000:0000000d,00000001
[    8.493718] of_irq_parse_raw: ipar=/gpio at 6000d000, size=2
[    8.493737]  -> addrsize=1
[    8.493743]  -> got it !
[    8.493755] of_irq_parse_one: dev=/gmi at 70009000/bus at 4/can at 0, index=1
[    8.493771]  intspec=13 intlen=2
[    8.493790]  intsize=2 intlen=2
[    8.493800] of_irq_parse_one: dev=/gmi at 70009000/bus at 4/can at 0, index=0
[    8.493805]  intspec=13 intlen=2
[    8.493812]  intsize=2 intlen=2
[    8.493824] of_irq_parse_raw:  /gpio at 6000d000:0000000d,00000001
[    8.493829] of_irq_parse_raw: ipar=/gpio at 6000d000, size=2
[    8.493834]  -> addrsize=1
[    8.493837]  -> got it !
[    8.493869] OF: ** translation for device /gmi at 70009000/bus at 4/can at 0 **
[    8.493885] OF: bus is default (na=1, ns=1) on /gmi at 70009000/bus at 4
[    8.493892] OF: translating address: 00000000
[    8.493902] OF: parent bus is default (na=1, ns=1) on /gmi at 70009000
[    8.493906] OF: no ranges; cannot translate
[    8.493918] OF: ** translation for device /gmi at 70009000/bus at 4 **
[    8.493924] OF: bus is default (na=1, ns=1) on /gmi at 70009000
[    8.493930] OF: translating address: 00000004
[    8.493938] OF: parent bus is default (na=1, ns=1) on /
[    8.493944] OF: walking ranges...
[    8.493952] OF: default map, cp=4, s=7ffffff, da=4
[    8.493973] OF: parent translation for: 48000000
[    8.493978] OF: with offset: 0
[    8.493986] OF: one level translation: 48000000
[    8.493989] OF: reached root node
[    8.494011] of_dma_get_range: no dma-ranges found for
node(/gmi at 70009000/bus at 4/can at 0)
[    8.494037] platform 48000000.bus:can at 0: device is not dma coherent
[    8.494048] platform 48000000.bus:can at 0: device is not behind an iommu
[    8.495209] sja1000 probe entered
[    8.495212] sja1000 probe entered1

sja1000 probe fails because resource address is NULL.

The result is the same for the second child device.

I also attempted to add "ranges;" property to the bus child node,
which results in the same error on can at 0, and can at 4000 is actually
translated but it is not what I expect it to be (0x4803fff8).

And I am not quite sure how to get around this in a simple way. I can
not wrap my head around how the ranges property actually works really.

Any suggestions would be really helpful.

Best Regards
Mirza
