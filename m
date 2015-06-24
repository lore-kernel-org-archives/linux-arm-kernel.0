From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 24 Jun 2015 19:50:51 +0100
Subject: [PATCH v6 0/9] Add simple NVMEM Framework via regmap.
In-Reply-To: <1641569650.41238.1435168054323.JavaMail.open-xchange@oxbsltgw35.schlund.de>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <235181230.251177.1435088854197.JavaMail.open-xchange@oxbsltgw00.schlund.de>
 <558A7C92.2040102@linaro.org> <558AA2E2.1010606@i2se.com>
 <558AAA8D.8030209@linaro.org>
 <1641569650.41238.1435168054323.JavaMail.open-xchange@oxbsltgw35.schlund.de>
Message-ID: <558AFC0B.1050400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/06/15 18:47, Stefan Wahren wrote:
> Hi Srinivas,
>
>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> hat am 24. Juni 2015 um
>> 15:03 geschrieben:
>>
>>
>>
>>
>> On 24/06/15 13:30, Stefan Wahren wrote:
>>>>> If the question is just about hexdump, then hexdump itself can read
>>>>> file from given offset and size.
>>> yes, this is my question at first. Let me show the difference between
>>> the current implementation and my expectations as a user.
>>>
>>> $ hexdump /sys/class/nvmem/mxs-ocotp/nvmem
>>>
>>> Current implementation: dump the complete register range defined in DT
>>>
>> Its dumping the range which is specified in the provider regmap. If the
>> requirement is to dump only particular range, this has to be made
>> explicit while creating regmap, which is to specify the base address to
>> start from "First data register" and max_register to be "Last data
>> register "- "First data register"
>
> i know about max_register, but i can't find the base address in regmap_config.
>
Base is not in the regmap config, its the value which you pass to the

For example, if I had to do similar change to qfprom driver It would 
look like:


 ><-----------------------cut---------------------------------><
diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 7f7a82f..26ced95 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -52,9 +52,9 @@ static int qfprom_probe(struct platform_device *pdev)
         if (IS_ERR(base))
                 return PTR_ERR(base);

-       qfprom_regmap_config.max_register = resource_size(res) - 1;
+       qfprom_regmap_config.max_register = my_data_size;

-       regmap = devm_regmap_init_mmio(dev, base, &qfprom_regmap_config);
+       regmap = devm_regmap_init_mmio(dev, base + data_offset, 
&qfprom_regmap_config);
         if (IS_ERR(regmap)) {
                 dev_err(dev, "regmap init failed\n");
                 return PTR_ERR(regmap);
 ><-----------------------cut---------------------------------><


--srini


> Do you mean struct regmap_access_table *rd_table ?
>
>>
>>> User expectation: dump only the data from OCOTP block
>>>
>>> Let me explain it for i.MX28 OCOTP
>>>
>>> 0x8002c000 // Start of OCOTP register block (defined in DT)
>>>
>>> 0x8002c020 // First data register
>>>
>>> 0x8002c290 // Last data register
>>>
>>> 0x8002dfff // End of OCOTP register block (defined in DT)
>>>
>>> My knowledge about regmap is limited, but how can i achieve that hexdump
>>> give me only the data registers? From my understanding this should be
>>> handled in regmap and not in the read function.
>>
>> Setup the base and regmap_config correctly in the provider driver before
>> calling regmap_init_mmio().
>>
>> Let me know if you need more details.
>
> Yes, please.
>
> Stefan
>
>>
>> --srini
>>
>>>
>>> Are my expectations about the raw access wrong?
>>>
>>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
