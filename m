From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Mon, 23 Nov 2015 14:02:33 -0800
Subject: [PATCH v2] fpga: zynq-fpga: Enable pm_runtime (suspend, resume)
In-Reply-To: <564ECAE7.9060900@topic.nl>
References: <1447970832-774-1-git-send-email-moritz.fischer@ettus.com>
 <564ECAE7.9060900@topic.nl>
Message-ID: <CAAtXAHddHYwk711JV79XrVkam_3qEUsMSQnNhj8-iVP4YvjqWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

thanks for your feedback. I put what I think you suggested inline below.

On Thu, Nov 19, 2015 at 11:25 PM, Mike Looijmans
<mike.looijmans@topic.nl> wrote:
> On 19-11-15 23:07, Moritz Fischer wrote:

>> @@ -457,19 +457,26 @@ static int zynq_fpga_probe(struct platform_device
>> *pdev)
>>                 return err;
>>         }
>>
>> +       pm_runtime_get_noresume(&pdev->dev);
>> +       pm_runtime_set_active(&pdev->dev);
>> +       pm_runtime_enable(&pdev->dev);
>> +
>>         /* unlock the device */
>>         zynq_fpga_write(priv, UNLOCK_OFFSET, UNLOCK_MASK);
>>
>> -       clk_disable(priv->clk);
>>
>>         err = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
>>                                 &zynq_fpga_ops, priv);
>>         if (err) {
>>                 dev_err(dev, "unable to register FPGA manager");
>> -               clk_unprepare(priv->clk);
>> +               clk_disable_unprepare(priv->clk);
- clk_disable_unprepare(priv->clk);
>> +               pm_runtime_put_noidle(&pdev->dev);
>> +               pm_runtime_disable(&pdev->dev);
>>                 return err;
>>         }
>>
>> +       pm_runtime_put(&pdev->dev);
>> +
>>         return 0;
>>   }
>>
>> @@ -483,11 +490,45 @@ static int zynq_fpga_remove(struct platform_device
>> *pdev)
>>
>>         fpga_mgr_unregister(&pdev->dev);
>>
>> -       clk_unprepare(priv->clk);
>> +       pm_runtime_get_sync(&pdev->dev);
>> +       clk_disable_unprepare(priv->clk);
- clk_disable_unprepare(priv->clk);

>> +       pm_runtime_put_noidle(&pdev->dev);
>> +       pm_runtime_disable(&pdev->dev);
>>
>>         return 0;
>>   }
>>
>> +static int __maybe_unused zynq_fpga_runtime_suspend(struct device *dev)
>> +{
>> +       struct zynq_fpga_priv *priv;
>> +       struct fpga_manager *mgr;
>> +
>> +       mgr = dev_get_drvdata(dev);
>> +       priv = mgr->priv;
>> +
>> +       clk_disable(priv->clk);

- clk_disable(priv->clk)
+ clk_disable_unprepare(priv->clk)
>
>
> From what I understand, this call is done in a sleepable context, so you can
> use clk_disable_unprepare here (and its counterpart in resume). And remove
> the prepare at probe time and unprepare at removal.
>
> Not all clocks can implement atomic enable/disable, for example I2C and SPI
> controlled clocks only implement the prepare/unprepare routines.
>
> I guess the "clk" here will always be a SOC provided one, so it won't make
> any difference for the Zynq, but someone is likely to some day copy/paste
> this driver and use it for some externally connected FPGA instead.

To clarify. Is the above / below what you suggested?

>> +static int __maybe_unused zynq_fpga_runtime_resume(struct device *dev)
>> +{
>> +       struct zynq_fpga_priv *priv;
>> +       struct fpga_manager *mgr;
>> +
>> +       mgr = dev_get_drvdata(dev);
>> +       priv = mgr->priv;
>> +
>> +       clk_enable(priv->clk);

- clk_enable(priv->clk)
+ clk_prepare_enable(priv->clk)
>> +
>> +       return 0;
>> +}
>> +

Cheers,

Moritz
