From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 4 Jun 2012 18:46:25 +0800
Subject: [PATCH v2] i2c: imx: convert to use managed functions
In-Reply-To: <CAM=Q2ctTNs0hq9tO5NW0QGsGaOVMNobRSBg_TmCjbaV+hNaoAw@mail.gmail.com>
References: <1338776481-23710-1-git-send-email-richard.zhao@freescale.com>
 <CAM=Q2ctTNs0hq9tO5NW0QGsGaOVMNobRSBg_TmCjbaV+hNaoAw@mail.gmail.com>
Message-ID: <20120604104624.GD2857@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shubhrajyoti,

On Mon, Jun 04, 2012 at 10:29:11AM +0530, Shubhrajyoti Datta wrote:
> Hi  Richard,
> 
> On Mon, Jun 4, 2012 at 7:51 AM, Richard Zhao <richard.zhao@freescale.com> wrote:
> > From: Richard Zhao <richard.zhao@linaro.org>
> nit: A small description would have helped.
The title has told what it did, but I'd like to add more description.
> Otherwise Looks good to me.
> Reviewed-by: Shubhrajyoti D <Shubhrajyoti@ti.com>
Thanks.
> >
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >
> > Changes since v1:
> > ?- rebase to 3.5rc1
> > ?- remove unused imx_i2c_struct.irq.
> >
> > ?drivers/i2c/busses/i2c-imx.c | ? 67 ++++++++++-------------------------------
> > ?1 files changed, 17 insertions(+), 50 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> > index 8d6b504..7f4da2d 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -118,10 +118,8 @@ static u16 __initdata i2c_clk_div[50][2] = {
> >
> > ?struct imx_i2c_struct {
> > ? ? ? ?struct i2c_adapter ? ? ?adapter;
> > - ? ? ? struct resource ? ? ? ? *res;
> > ? ? ? ?struct clk ? ? ? ? ? ? ?*clk;
> > ? ? ? ?void __iomem ? ? ? ? ? ?*base;
> > - ? ? ? int ? ? ? ? ? ? ? ? ? ? irq;
> > ? ? ? ?wait_queue_head_t ? ? ? queue;
> > ? ? ? ?unsigned long ? ? ? ? ? i2csr;
> > ? ? ? ?unsigned int ? ? ? ? ? ?disable_delay;
> > @@ -473,7 +471,6 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
> > ? ? ? ?struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
> > ? ? ? ?struct pinctrl *pinctrl;
> > ? ? ? ?void __iomem *base;
> > - ? ? ? resource_size_t res_size;
> > ? ? ? ?int irq, bitrate;
> > ? ? ? ?int ret;
> >
> > @@ -490,25 +487,16 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
> > ? ? ? ? ? ? ? ?return -ENOENT;
> > ? ? ? ?}
> >
> > - ? ? ? res_size = resource_size(res);
> > -
> > - ? ? ? if (!request_mem_region(res->start, res_size, DRIVER_NAME)) {
> > - ? ? ? ? ? ? ? dev_err(&pdev->dev, "request_mem_region failed\n");
> > + ? ? ? base = devm_request_and_ioremap(&pdev->dev, res);
> > + ? ? ? if (!base)
> > ? ? ? ? ? ? ? ?return -EBUSY;
> > - ? ? ? }
> > -
> > - ? ? ? base = ioremap(res->start, res_size);
> > - ? ? ? if (!base) {
> > - ? ? ? ? ? ? ? dev_err(&pdev->dev, "ioremap failed\n");
> > - ? ? ? ? ? ? ? ret = -EIO;
> > - ? ? ? ? ? ? ? goto fail1;
> > - ? ? ? }
> >
> > - ? ? ? i2c_imx = kzalloc(sizeof(struct imx_i2c_struct), GFP_KERNEL);
> > + ? ? ? i2c_imx = devm_kzalloc(&pdev->dev, sizeof(struct imx_i2c_struct),
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? GFP_KERNEL);
> > ? ? ? ?if (!i2c_imx) {
> > ? ? ? ? ? ? ? ?dev_err(&pdev->dev, "can't allocate interface\n");
> > ? ? ? ? ? ? ? ?ret = -ENOMEM;
> > - ? ? ? ? ? ? ? goto fail2;
> > + ? ? ? ? ? ? ? return ret;
> nit : why not return ENOMEM directly, the copy to ret is redundant.
> feel free to ignore if you  feel so.
Nice catch. :)

Thanks
Richard
