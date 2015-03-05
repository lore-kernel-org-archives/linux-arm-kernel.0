From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 05 Mar 2015 22:34:30 +0000
Subject: [PATCH v1 3/6] eeprom: Add bindings for simple eeprom framework
In-Reply-To: <CAL_Jsq+wrZYn82otDfLsTVpgmhLFWtzRHQ4v+qn-Ks--ZpXR8Q@mail.gmail.com>
References: <1425548685-12887-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1425548765-13019-1-git-send-email-srinivas.kandagatla@linaro.org>
 <CAL_Jsq+wrZYn82otDfLsTVpgmhLFWtzRHQ4v+qn-Ks--ZpXR8Q@mail.gmail.com>
Message-ID: <54F8D9F6.3040003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +
>> +For example:
>> +
>> +       /* Provider */
>> +       qfprom: qfprom at 00700000 {
>> +               compatible      = "qcom,qfprom";
>> +               reg             = <0x00700000 0x1000>;
>> +               ...
>> +
>> +               /* Data cells */
>> +               tsens_calibration: calib at 404 {
>> +                       reg = <0x404 0x10>;
>> +               };
>> +
>> +               serial_number: sn {
>> +                       reg = <0x104 0x4>, <0x204 0x4>, <0x30c 0x4>;
>> +
>> +               };
>> +               ...
>> +       };
>> +
>> += Data consumers =
>> +Are drivers which consume eeprom data cells.
>
> s/drivers/device nodes/
>
Thats true, "device nodes" makes sense.
>> +
>> +Required properties:
>> +
>> +eeproms: List of phandle and data cell the device might be interested in.
>> +
>> +Optional properties:
>> +
>> +eeprom-names: List of data cell name strings sorted in the same order
>> +             as the resets property. Consumers drivers will use
>
> resets?
Opps..
I remember fixing this, I will take care of it in next version.
>
>> +             eeprom-names to differentiate between multiple cells,
>> +             and hence being able to know what these cells are for.
>
> Is this still needed? The sub-node name defines the name. Or you can
> use reg-names with-in the sub-node.
Yes, eeprom-names is needed in the consumer nodes, where there are 
multiple eeproms cells, its easy to lookup by name rather than 
index,which depends on the order of the entries.

reg-names inside the "data cells" is ok, but I can't think of its use 
immediately. May be useful for debug?

--srini
 >
>
> Rob
>
>> +
>> +For example:
>> +
>> +       tsens {
>> +               ...
>> +               eeproms = <&tsens_calibration>;
>> +               eeprom-names = "calibration";
>> +       };
>> --
>> 1.9.1
>>
