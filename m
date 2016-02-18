From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 18 Feb 2016 15:13:55 +0000
Subject: Query on using nvmem consumer API
In-Reply-To: <20160218120100.GA11366@Sanchayan-Arch.toradex.int>
References: <20160218120100.GA11366@Sanchayan-Arch.toradex.int>
Message-ID: <56C5DFB3.1020903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/02/16 12:01, maitysanchayan at gmail.com wrote:
> Hello Srinivas,
>
> I have a device tree node as follows
>
>                          ocotp: ocotp at 400a5000 {
>                                  compatible = "fsl,vf610-ocotp";
>                                  #address-cells = <1>;
>                                  #size-cells = <1>;
>                                  reg = <0x400a5000 0xCF0>;
>                                  clocks = <&clks VF610_CLK_OCOTP>;
>
>                                  ocotp_cfg: cfg at 410 {
>                                          reg = <0x410 0x20>;
>                                  };
>                          };
>
> and a nvmem data consumer node as follows
>
>          soc-bus {
>                  compatible = "fsl,vf610-soc-bus";
>                  nvmem = <&ocotp>;
>                  nvmem-names = "ocotp";
>                  nvmem-cell = <&ocotp_cfg>;
>                  nvmem-cell-names = "soc_id";
>                  status = "okay";
>          };
>
> I believe my device tree node entries are incorrect. I did like to
> use the devm_nvmem_device/cell_get functions and then read using
> cell or device consumer API's. I am looking at the NVMEM bindings
> but it is not clear to me as to what the correct DT entries and
> the corresponding arguments to devm_nvmem_device/cell_get should
> be?
>
> Can you help me out with as to what the correct entries and calls
> should be?

Sure,

Firstly you should grab a nvmem cell and then use it as part of 
nvmem_read/write.

In your case you would do this in soc-bus device.

struct nvmem_cell *soc_id = devm_nvmem_cell_get(dev, "soc_id");
data = nvmem_cell_read(soc_id, &len);

There is some documentation at Documentation/nvmem/nvmem.txt
Let me know if you find any issues with the doc.


thanks,
srini


>
> I currently have
> devm_nvmem_device_get(dev, "ocotp");
> devm_nvmem_cell_get(dev, "soc_id");
>
> where dev would be the soc-bus device.
>
> Thanks & Regards,
> Sanchayan.
>
