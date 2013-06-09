From: zhangfei.gao@linaro.org (zhangfei)
Date: Mon, 10 Jun 2013 00:03:25 +0800
Subject: [PATCH 2/2] i2c: designware: Add i2c-designware-hs
In-Reply-To: <20130609095026.GF4312@tarshish>
References: <1370745402-11844-1-git-send-email-zhangfei.gao@linaro.org>
 <1370745402-11844-3-git-send-email-zhangfei.gao@linaro.org>
 <20130609032300.GB4312@tarshish>
 <CAMj5BkhPp_-b19WFM-XitJ5-qDd9-dETp7UdNRLkRbdcq_h-Vg@mail.gmail.com>
 <20130609095026.GF4312@tarshish>
Message-ID: <51B4A74D.3040908@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>> What in case private register have to be accessed?
>
> Good question. I don't know what is the common convention in this case. Do you
> have such a need here?

Originally, there is private register for tuning timing of clk and data.
Suppose there may some issue of catching data in clk trigger stage.
However, in the test, still not need to set timing yet.

>
>> struct dw_i2c_data {
>>          u32 accessor_flags;
>>          unsigned int tx_fifo_depth;
>>          unsigned int rx_fifo_depth;
>> };
>>
>> static struct dw_i2c_data hisilicon_data = {
>>          .accessor_flags = ACCESS_32BIT,
>
> This should be detected automatically in i2c_dw_init(). When ACCESS_16BIT is
> not set, access is 32bit wide. Doesn't it work for you?

Cool, this works, then the first patch can be ignored at all.
My bad, not check when no value of DW_IC_COMP_TYPE.

>
>>          .tx_fifo_depth = 16,
>>          .rx_fifo_depth = 16,
>
> These should be encoded in new device-tree properties named "tx-fifo-size",
> and "rx-fifo-size". For example, see
> Documentation/devicetree/bindings/powerpc/4xx/emac.txt.

OK, will add these two property to
Documentation/devicetree/bindings/i2c/i2c-designware.txt

Besides, would you mind change
subsys_initcall(dw_i2c_init_driver);
to
module_platform_driver(dw_i2c_driver);
Otherwise default pinctrl can not be auto-set, since subsys_initcall is 
too early.

Thanks
