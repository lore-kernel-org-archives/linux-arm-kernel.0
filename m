From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Thu, 22 Oct 2015 11:38:36 -0700
Subject: [PATCHv2 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx Zynq 7000
In-Reply-To: <alpine.DEB.2.02.1510221247360.23148@linuxheads99>
References: <1445035350-3569-1-git-send-email-moritz.fischer@ettus.com>
 <1445035350-3569-4-git-send-email-moritz.fischer@ettus.com>
 <alpine.DEB.2.02.1510221247360.23148@linuxheads99>
Message-ID: <CAAtXAHfaMRniqwuiniL5WQz+39WJh+L09-5uTHKiewtRH2pjkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

On Thu, Oct 22, 2015 at 10:56 AM, atull <atull@opensource.altera.com> wrote:
> On Fri, 16 Oct 2015, Moritz Fischer wrote:
>
> Hi Moritz,
>
> I just noticed a problem regarding private data.  Fortunately
> it is easy to fix.  See below...
>
>> +static int zynq_fpga_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct zynq_fpga_priv *priv;
>> +     struct resource *res;
>> +     int err;
>> +
>> +     priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +     if (!priv)
>> +             return -ENOMEM;
>> +
>> +     platform_set_drvdata(pdev, priv);
>
> fpga-mgr.c uses drvdata for its struct fpga_manager, so this will
> get overwritten.  So remove this platform_set_drvdata().  priv
> is saved in struct fpga_manager during fpga_mgr_register().

Ouch, I missed that.
>
> ...
>
>> +static int zynq_fpga_remove(struct platform_device *pdev)
>> +{
>
> Here you can get a pointer to priv from the fpga_manager struct:
>         struct fpga_manager *mgr = platform_get_drvdata(pdev);
>         struct zynq_fpga_priv *priv = mgr->priv;

Thanks, will submit a follow up patch.

>> +     struct zynq_fpga_priv *priv;
>> +
>> +     fpga_mgr_unregister(&pdev->dev);
>> +
>> +     priv = platform_get_drvdata(pdev);
>> +
>> +     clk_disable_unprepare(priv->clk);
>> +
>> +     return 0;
>> +}>
> Alan
>

Cheers,

Moritz
