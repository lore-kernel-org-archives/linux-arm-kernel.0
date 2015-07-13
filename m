From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 13 Jul 2015 22:39:46 +0100
Subject: [PATCH v7 0/9] Add simple NVMEM Framework via regmap.
In-Reply-To: <139301016.164015.1436818270753.JavaMail.open-xchange@oxbsltgw04.schlund.de>
References: <1436521427-10568-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1984575203.163267.1436813665815.JavaMail.open-xchange@oxbsltgw06.schlund.de>
 <55A4131C.7040700@linaro.org>
 <139301016.164015.1436818270753.JavaMail.open-xchange@oxbsltgw04.schlund.de>
Message-ID: <55A43022.5040000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/07/15 21:11, Stefan Wahren wrote:
> Hi Srinivas,
>
>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> hat am 13. Juli 2015 um
>> 21:35 geschrieben:
>>
>> On 13/07/15 19:54, Stefan Wahren wrote:
>>> Hi Srinivas,
>>>
>>>> [...]
>>>>
>>>> Providers APIs:
>>>> nvmem_register/unregister();
>>>
>>> How do i get the cell info from the devicetree into the nvmem_config?
>>>
>> Not sure what is the real use-case here, But this is how it is supposed
>> to work.
>>
>> cellinfo in nvmem_config is used to pass cell information in non-dt
>> style to the core. The core would parse it and convert into nvmem-cells.
>> Am not sure why would you want to do other way round. Could you explain
>> the real use case here?
>>
>
> my question comes from porting mxs_ocotp to NVMEM framework.
>
> Here is the devicetree part:
>
> ocotp: ocotp at 8002c000 {
> 	compatible = "fsl,imx28-ocotp", "fsl,ocotp";
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	reg = <0x8002c000 0x2000>;
> 	clocks = <&clks 25>;
> 	read-only;
> 				
> 	/* Data cells */
> 	ocotp_customer: costumer at 20 {
> 		reg = <0x20 0x10>;
> 	};
>
> 	ocotp_rom0: rom0 at 1a0 {
> 		reg = <0x1a0 0x4>;
> 	};
> };
>
> After calling nvmem_register() in the provider driver [1] no data cell is
> registered. So
> i looked at the core code and i thought that retrieving the cell info and put it
> into the nvmem_config
> is job of the provider driver.
>
> Did i missed something?
Ok,
There are 2 possible ways to specify nvmem cells
1> via the DT cell entries.
2> via provider driver directly using cell_info struct.

In the ocotp case its done via dt, so you dont need pass the cell info 
in nvmem_config.

You should also note that cell structure in DT is only created when an 
attempt to access is made as the provider lookup is straight forward in 
this case. In non-DT case the cell structure is created immediately and 
added to the global cell list.


--srini
>
> [1] -
> https://github.com/lategoodbye/fsl_ocotp/commit/7c98e19755b69f761885b0e1ceb2c258a7c47ade
>
>>
>>
>>>
>> ...
>>
>>>> userspace interface: binary file in /sys/bus/nvmem/devices/*/nvmem
>>>>
>>>> ex:
>>>> hexdump /sys/bus/nvmem/devices/qfprom0/nvmem
>>>>
>>>> 0000000 0000 0000 0000 0000 0000 0000 0000 0000
>>>> *
>>>> 00000a0 db10 2240 0000 e000 0c00 0c00 0000 0c00
>>>> 0000000 0000 0000 0000 0000 0000 0000 0000 0000
>>>> ...
>>>> *
>>>> 0001000
>>>
>>> Since we're entering userspace the behavior should be clear.
>>>
>>> How do we treat register gaps? Fill them with zero?
>> nvmem file would read full nvmem size which is passed to it as regmap.
>> So It would dump whatever the provider returns.
>
> Sure, but wouldn't it be nice if different provider behave the same?
>
>>
>>
>> --srini
>>>
>>> Best regards
>>> Stefan
>>>
