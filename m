From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Feb 2015 15:11:40 -0800
Subject: [RFC PATCH 1/3] eeprom: Add a simple EEPROM framework
In-Reply-To: <CAL_JsqLqqw5DyUqCaOTSKPwF-Ms5EU4f_OPoW9YVpMCo8A_bbw@mail.gmail.com>
References: <1424365639-26634-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424365708-26681-1-git-send-email-srinivas.kandagatla@linaro.org>
 <CAL_Jsq+SeuoojgTpv1y_aPJ_jzDr3HqZhYEBQ3_vYGBHvcccug@mail.gmail.com>
 <54E78A31.9020306@linaro.org>
 <CAL_Jsq+mvpRjYfL_8OseTDCB-6aBhwhNKLBQXXJeVQLDwWm8Nw@mail.gmail.com>
 <20150222143211.GX25269@lukather>
 <CAL_JsqLqqw5DyUqCaOTSKPwF-Ms5EU4f_OPoW9YVpMCo8A_bbw@mail.gmail.com>
Message-ID: <54EBB3AC.30000@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/15 16:57, Rob Herring wrote:
> On Sun, Feb 22, 2015 at 8:32 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> On Fri, Feb 20, 2015 at 04:01:55PM -0600, Rob Herring wrote:
>>> [...]
>>>
>>>>>> += Data consumers =
>>>>>> +
>>>>>> +Required properties:
>>>>>> +
>>>>>> +eeproms: List of phandle and data cell specifier triplet, one triplet
>>>>>> +        for each data cell the device might be interested in. The
>>>>>> +        triplet consists of the phandle to the eeprom provider, then
>>>>>> +        the offset in byte within that storage device, and the length
>>>>>> +        in byte of the data we care about.
>>>>>
>>>>> The problem with this is it assumes you know who the consumer is and
>>>>> that it is a DT node. For example, how would you describe a serial
>>>>> number?
>>>> Correct me if I miss understood.
>>>> Is serial number any different?
>>>> Am hoping that the eeprom consumer would be aware of offset and size of
>>>> serial number in the eeprom
>>>>
>>>> Cant the consumer do:
>>>>
>>>> eeprom-consumer {
>>>>         eeproms = <&at24 0 4>;
>>>>         eeprom-names = "device-serial-number";
>>> Yes, but who is "eeprom-consumer"?
>> Any device that should lookup values in one of the EEPROM.
>>
>>> DT nodes generally describe a h/w block, but it this case, the
>>> consumer depends on the OS, not the h/w.
>> Not really, or at least, not more than any similar binding we
>> currently have.
>>
>> The fact that a MAC-address for the first ethernet chip is stored at a
>> given offset in a given eeprom has nothing to do with the OS.
> So MAC address would be a valid use to link to a h/w device, but there
> are certainly cases that don't correspond to a device.
>
>>> I'm not saying you can't describe where things are, but I don't
>>> think you should imply who is the consumer and doing so is
>>> unnecessarily complicated.
>> If you only take the case of a serial number, indeed. If you take
>> other usage into account, you can't really do without it.
>>
>>> Also, the layout of EEPROM is likely very much platform specific.
>> Indeed, which is why it should be in the DT.
> Agreed. I'm not saying the layout should not be.
>
>>> Some could have a more complex structure perhaps with key ids and
>>> linked list structure.
>> Then just request the size of the whole list, and parse it afterwards
>> in your driver?
>>
>>> I would do something more simple that is just a list of keys and their
>>> location like this:
>>>
>>> device-serial-number = <start size>;
>>> key1 = <start size>;
>>> key2 = <start size>;
>> I'm sorry, but what's the difference?
> It can describe the layout completely whether the fields are tied to a
> h/w device or not.
>
> What I would like to see here is the entire layout described covering
> both types of fields.
>

I was thinking the DT might be like this on the provider side:

   qfprom at 1000000 {
      reg = <0x1000000 0x1000>;
      ranges = <0 0x1000000 0x1000>;
      compatible = "qcom,qfprom-msm8960"

      pvs-data: pvs-data at 40 {
            compatible = "qcom,pvs-a";
            reg = <0x40 0x20>,
	    #eeprom-cells = <0>;
      };

       tsens-data: tmdata at 10 {
            compatible = "qcom,tsens-data-msm8960";
            reg = <0x10 4>, <0x16 4>;
	    #eeprom-cells = <0>;

      };

      serial-number: serial at 50 {
            compatible = "qcom,serial-msm8960";
            reg = <0x50 4>, <0x60 4>;
	    #eeprom-cells = <0>;

      };
   };

and then on the consumer side:

	device {
		eeproms = <&serial-number>;
		eeprom-names = "soc-rev-id";
	};


This would solve a problem where the consumer device is some standard
off-the-shelf IP block that needs to get some SoC specific calibration
data from the eeprom. I may want to interpret the bits differently
depending on which eeprom is connected to my SoC. Sometimes that data
format may be the same across many variations of the SoC (e.g. the
qcom,pvs-a node) or it may be completely different for a given SoC (e.g.
qcom,serial-msm8960 node). I imagine for other SoCs out there it could
be different depending on which eeprom the board manufacturer decides to
wire onto their board and how they choose to program the data.

So this is where I think the eeprom-cells and offset + length starts to
fall apart. It forces us to make up a bunch of different compatible
strings for our consumer device just so that we can parse the eeprom
that we decided to use for some SoC/board specific data. Instead I'd
like to see some framework that expresses exactly which eeprom is on my
board and how to interpret the bits in a way that doesn't require me to
keep refining the compatible string for my generic IP block.

I worry that if we put all those details in DT we'll end up having to
describe individual bits like serial-number-bit-2, serial-number-bit-3,
etc. because sometimes these pieces of data are scattered all around the
eeprom and aren't contiguous or aligned on a byte boundary. It may be
easier to just have a way to express that this is an eeprom with this
specific layout and my device has data stored in there. Then the driver
can be told what layout it is (via compatible or some other string based
means if we're not using DT?) and match that up with some driver data if
it needs to know how to understand the bits it can read with the
eeprom_read() API.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
