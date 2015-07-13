From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 13 Jul 2015 11:21:58 +0100
Subject: [PATCH v7 4/9] nvmem: Add bindings for simple nvmem framework
In-Reply-To: <CAL_JsqKYT-+T=D=TKCb1TcydOvBTE8_yc-EEe1cwdmhr1B0dHQ@mail.gmail.com>
References: <1436521427-10568-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1436521513-10838-1-git-send-email-srinivas.kandagatla@linaro.org>
 <CAL_JsqKYT-+T=D=TKCb1TcydOvBTE8_yc-EEe1cwdmhr1B0dHQ@mail.gmail.com>
Message-ID: <55A39146.4080207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thanks Rob for quick review,

On 10/07/15 20:04, Rob Herring wrote:
> On Fri, Jul 10, 2015 at 4:45 AM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> This patch adds bindings for simple nvmem framework which allows nvmem
>> consumers to talk to nvmem providers to get access to nvmem cell data.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> [Maxime Ripard: intial version of eeprom framework]
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/nvmem/nvmem.txt | 85 +++++++++++++++++++++++
>>   1 file changed, 85 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem.txt
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.txt b/Documentation/devicetree/bindings/nvmem/nvmem.txt
>> new file mode 100644
>> index 0000000..849f1e1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.txt
>> @@ -0,0 +1,85 @@
>> += NVMEM(Non Volatile Memory) Data Device Tree Bindings =
>> +
>> +This binding is intended to represent the location of hardware
>> +configuration data stored in NVMEMs like eeprom, efuses and so on.
>> +
>> +On a significant proportion of boards, the manufacturer has stored
>> +some data on NVMEM, for the OS to be able to retrieve these information
>> +and act upon it. Obviously, the OS has to know about where to retrieve
>> +these data from, and where they are stored on the storage device.
>> +
>> +This document is here to document this.
>> +
>> += Data providers =
>> +Contains bindings specific to provider drivers and data cells as children
>> +of this node.
>
> #address-cells and #size-cells are required here.
>
>> +
>> +Optional properties:
>> + read-only: Mark the provider as read only.
>
> Couldn't this be per field rather than global?
>
Not ATM, The reason for making this property global is to mark the 
complete nvmem to be readonly/read-write. Which most of the use-cases 
will have. Currently this property is used for setting permissions on 
the sysfs binary file, also it would be impossible to apply per field 
read-only property to such file.

Am also planning to send few patches on top of these to expose fields in 
sysfs which would then allow us to use per field read-only property.
Again not sure how the direct access to nvmem would fit in with such 
requirements. Need to evaluate this option in more detail though. :-)

>> +
>> += Data cells =
>> +These are the child nodes of the provider which contain data cell
>> +information like offset and size in nvmem provider.
>> +
>> +Required properties:
>> +reg:   specifies the offset in byte within that storage device, start bit
>> +       in the byte and the length in bytes of the data we care about.
>> +       There could be more than one offset-length pairs in this property.
>> +
>> +Optional properties:
>> +
>> +bit-offset: specifies the offset in bit within the address range specified
>> +       by reg property. Can take values from 0-7.
>> +nbits: specifies number of bits this cell occupies starting from bit-offset.
>
> How about just: "bits = <<offset> <size>>"
>
Thats another possible way to specify the same info, Only reason I came 
up with bit-offset and nbits is due to the fact that similar properties 
were seen in other device DT bindings.

I will try your suggestion and see how it looks before I send new version.

> Then the bit specification is more aligned with the byte location
> (i.e. reg property).
>
> You could also do this all in the reg property with 2 address cells
> for byte and bit position and then size can be in bits. reg doesn't
> have to match a memory mapped bus addressing meanings. If you wanted
> to handle ranges and address translation, then you would need custom
> functions like PCI does. I'm not sure you would need that.
I wanted to keep things simple for this first version.
>

--srini
