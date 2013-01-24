From: saeed.bishara@gmail.com (saeed bishara)
Date: Thu, 24 Jan 2013 23:05:12 +0200
Subject: [PATCH v2 13/16] drivers/bus: add ARM CCI support
In-Reply-To: <1359008879-9015-14-git-send-email-nicolas.pitre@linaro.org>
References: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
 <1359008879-9015-14-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <CAMAG_ecxWK-NqxwFys0tpxXssub+55-gAExuqyGM_EchOQPAVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 8:27 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> +static int cci_driver_probe(struct platform_device *pdev)
> +{
> +       struct resource *res;
> +       int ret = 0;
> +
> +       info = kzalloc(sizeof(*info), GFP_KERNEL);
devm_kzalloc and managed resources allocation can save you few code lines.
> +       if (!info) {
> +               dev_err(&pdev->dev, "unable to allocate mem\n");
> +               return -ENOMEM;
> +       }
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res) {
> +               dev_err(&pdev->dev, "No memory resource\n");
> +               ret = -EINVAL;
> +               goto mem_free;
> +       }
> +
> +       if (!request_mem_region(res->start, resource_size(res),
> +                               dev_name(&pdev->dev))) {
> +               dev_err(&pdev->dev, "address 0x%x in use\n", (u32) res->start);
I suggest that you use %pR or %pr (more info at Documentation/prink-formats.txt
also, request_mem_region can fail due to other reasons
> +               ret = -EBUSY;
> +               goto mem_free;
