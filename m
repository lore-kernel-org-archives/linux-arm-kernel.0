From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 26 Feb 2015 14:56:52 +0000
Subject: [RFC PATCH 1/3] eeprom: Add a simple EEPROM framework
In-Reply-To: <20150226132107.GH29241@lukather>
References: <1424365708-26681-1-git-send-email-srinivas.kandagatla@linaro.org>
 <CAL_Jsq+SeuoojgTpv1y_aPJ_jzDr3HqZhYEBQ3_vYGBHvcccug@mail.gmail.com>
 <54E78A31.9020306@linaro.org>
 <CAL_Jsq+mvpRjYfL_8OseTDCB-6aBhwhNKLBQXXJeVQLDwWm8Nw@mail.gmail.com>
 <20150222143211.GX25269@lukather>
 <CAL_JsqLqqw5DyUqCaOTSKPwF-Ms5EU4f_OPoW9YVpMCo8A_bbw@mail.gmail.com>
 <54EBB3AC.30000@codeaurora.org> <20150224092155.GO25269@lukather>
 <20150225013049.GJ24928@codeaurora.org> <54EEE46B.6090905@linaro.org>
 <20150226132107.GH29241@lukather>
Message-ID: <54EF3434.6040003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/02/15 13:21, Maxime Ripard wrote:
> On Thu, Feb 26, 2015 at 09:16:27AM +0000, Srinivas Kandagatla wrote:
>> I think we are making simple eeprom framework too smart which will
>> break in future.
>>
>> IMHO, Anything on top of eeprom interface that interprets the data should
>> not go into the eeprom framework itself, it can either live some parsers/SOC
>> specific drivers/interfaces.
>
> True, but that doesn't mean that this parser support can't be built
> within the framework itself.
I was more of thinking parsers/interpreters as a layer on top of this 
framework. Allowing the simplest users direct access to framework. Also 
just eeprom_read() apis would not cater for all the parsers and I think 
it would be very difficult to come up with abstracted consumer apis for 
all the parsers which could be iterator or link-lists parsers or 
something very different.

>
>> As Stephen pointed out earlier lets start with something like this, which
>> would provide a better abstraction to the discussed use cases like
>> serial-number and packed data in eeprom.
>>
>>     qfprom at 1000000 {
>>        reg = <0x1000000 0x1000>;
>>        ranges = <0 0x1000000 0x1000>;
>>        compatible = "qcom,qfprom-msm8960"
>>
>>        pvs-data: pvs-data at 40 {
>>              compatible = "qcom,pvs-a";
>>              reg = <0x40 0x20>,
>>        };
>>
>>         tsens-data: tmdata at 10 {
>>              reg = <0x10 40>;
>>        };
>>
>>        serial-number: serial at 50 {
>>              compatible = "qcom,serial-msm8960";
>>              reg = <0x50 4>, <0x60 4>;
>>        };
>>
>>     };
>
> And I'm sorry, but I still don't get why the compatibles are needed
> here.
This is an optional property, only purpose of this would be to serve as 
parser/soc-specific identifier.

>
>> and then on the consumer side:
>>
>> 	device {
>> 		eeproms = <&serial-number>;
>> 		eeprom-names = "soc-rev-id";
>> 	};
>> 	
>> driver side:
>>
>> 	eeprom_get_cell()
>> 	eeprom_read();
>
> Looks good otherwise.
thanks
--srini
>
> Maxime
>
