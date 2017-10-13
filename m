From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 14 Oct 2017 01:04:17 +0900
Subject: [PATCH v2 1/3] dt-bindings: nvmem: add description for UniPhier
 eFuse
In-Reply-To: <20171013134902.7gvmkvxvwnjlmstp@rob-hp-laptop>
References: <1507266180-11840-1-git-send-email-hayashibara.keiji@socionext.com>
 <1507266180-11840-2-git-send-email-hayashibara.keiji@socionext.com>
 <20171013134902.7gvmkvxvwnjlmstp@rob-hp-laptop>
Message-ID: <CAK7LNARg6G152joHq06RkPab=NoWEkFArvF+Ccc1behdXFokmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


2017-10-13 22:49 GMT+09:00 Rob Herring <robh@kernel.org>:
> On Fri, Oct 06, 2017 at 02:02:58PM +0900, Keiji Hayashibara wrote:
>> Add uniphier-efuse dt-bindings documentation.
>>
>> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
>> ---
>>  .../devicetree/bindings/nvmem/uniphier-efuse.txt   | 49 ++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt b/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
>> new file mode 100644
>> index 0000000..1a394e5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
>> @@ -0,0 +1,49 @@
>> += UniPhier eFuse device tree bindings =
>> +
>> +This UniPhier eFuse must be under soc-glue.
>> +
>> +Required properties:
>> +- compatible: should be "socionext,uniphier-efuse"
>> +- reg: should contain the register location and length
>> +
>> += Data cells =
>> +Are child nodes of efuse, bindings of which as described in
>> +bindings/nvmem/nvmem.txt
>> +
>> +Example:
>> +
>> +     soc-glue at 5f900000 {
>> +             compatible = "socionext,uniphier-ld20-soc-glue-debug",
>> +                          "simple-mfd";
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             ranges = <0x0 0x5f900000 0x2000>;
>> +
>> +             efuse at 100 {
>> +                     compatible = "socionext,uniphier-efuse";
>> +                     reg = <0x100 0x28>;
>> +             };
>> +
>> +             efuse at 200 {
>> +                     compatible = "socionext,uniphier-efuse";
>> +                     reg = <0x200 0x68>;
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +
>> +                     /* Data cells */
>> +                     usb_mon: usb_mon {
>
> Don't use '_' and needs a unit-address. Build your dtb with W=2 option
> and you'll get these warnings.


Do you mean "usb_mon: usb-mon at 54" ?


DT files in kernel sprinkle tons of warnings even with W=1.

I always eliminate W=1, so I agree with "@54".

I do not care W=2 much.
If you see arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi,
yeah, I generally use '-' for node names, but I see some exceptions.

You admitted -Wnode_name_chars_strict is "subjective"
in commit 8654cb8d0371.

If you are unhappy about it, we can fix,
but I am not sure how picky we should be.





>> +                             reg = <0x54 0xc>;
>
> Without ranges above, this is address 5f900054. I think you want
> 5f900254. You need:
>
> ranges = <0x0 0x200 0x68>;


I do not get it.

The parent is an efuse, not any kind of bus.

<0x54, 0c> just represents the offset and size
within the efuse device, so this is not mapped in
CPU address view.
The is apparent from of_nvmem_cell_get().

Some efuse devices _may_ be directly accessed
as MMIO from CPU, but it is abstracted under an efuse driver.

I believe missing "ranges" is correct.





>> +                     };
>> +             };
>> +     };
>> +
>> += Data consumers =
>> +Are device nodes which consume nvmem data cells.
>> +
>> +Example:
>> +
>> +     usb {
>> +             ...
>> +             nvmem-cells = <&usb_mon>;
>> +             nvmem-cell-names = "usb_mon";
>> +     }
>> --
>> 2.7.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
