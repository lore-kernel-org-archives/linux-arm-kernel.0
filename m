From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 6 Feb 2012 23:47:14 +0100
Subject: [PATCH v5] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
In-Reply-To: <CAGsJ_4yHn1M3s6CPezaW_jwOcsX6NuaZRHcNWX0qnSfhx30AHQ@mail.gmail.com>
References: <1327846668-3053-1-git-send-email-21cnbao@gmail.com>
 <20120205223757.GA10680@nekote.pengutronix.de>
 <CAGsJ_4yHn1M3s6CPezaW_jwOcsX6NuaZRHcNWX0qnSfhx30AHQ@mail.gmail.com>
Message-ID: <20120206224714.GB25703@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Thanks for your contribution! Is there a free datasheet for this controller
> > available?
> 
> sorry. not available to public yet.

:( Can you cite what "SIRFSOC_I2C_NACK" does?
> 
> >> +struct sirfsoc_i2c {
> >> + ? ? void __iomem *base;
> >> + ? ? struct clk *clk;
> >> + ? ? unsigned long speed; ? ?/* I2C SCL frequency */
> >> + ? ? int irq;
> >
> > Do you really need those two?
> 
> irq can be deleted. speed is not really needed if you don't like.

It is not about "like". It is not needed, or?

> >> +static void i2c_sirfsoc_queue_cmd(struct sirfsoc_i2c *siic)
> >> +{
> >> + ? ? u32 regval;
> >> + ? ? int i = 0;
> >> +
> >> + ? ? if (siic->msg_read) {
> >> + ? ? ? ? ? ? while (((siic->finished_len + i) < siic->msg_len)
> >> + ? ? ? ? ? ? ? ? ? ? && (siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)) {
> >
> > Either use a different indentation for the above line or add a newline below.
> > It is hard to see where the while() ends and the code block starts.
> 
> i just want to make sure what you want is:
> 
>              while (((siic->finished_len + i) < siic->msg_len)
>                      &&(siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)
>                      ) {
> ?
> or something else?

I thought of (which is simpler IMO):

>              while (((siic->finished_len + i) < siic->msg_len)
>                      &&(siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)) {
>
>  ? ? ? ? ? ? ? ? ? ? regval = SIRFSOC_I2C_READ | SIRFSOC_I2C_CMD_RP(0);


The other solution would be (not sure if it fits the line length):

> >> + ? ? ? ? ? ? while (((siic->finished_len + i) < siic->msg_len)
> >> + ? 	? ? ? ? ? ? ? ? ? && (siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)) {
> >> + ? ? ? ? ? ? ? ? ? ? regval = SIRFSOC_I2C_READ | SIRFSOC_I2C_CMD_RP(0);

The idea is to make it easier (visually) what is the while-condition and where
is the code of the while-block. I thought that was difficult in original version.

> >> +static int i2c_sirfsoc_xfer_msg(struct sirfsoc_i2c *siic, struct i2c_msg *msg)
> >> +{
> >> + ? ? u32 regval = readl(siic->base + SIRFSOC_I2C_CTRL);
> >> + ? ? int timeout = (msg->len + 1) * 50;
> >
> > That looks broken. What is 50 here?
> 
> just multiple of xfer bytes for defining a timeout. i might have a comment here.

That probably won't help. I'd think you want a *_to_jiffies() here to define a
proper timeout value in usecs/msecs?

> >> + ? ? siic->irq = platform_get_irq(pdev, 0);
> >> + ? ? if (siic->irq < 0) {
> >> + ? ? ? ? ? ? err = -EINVAL;
> >> + ? ? ? ? ? ? goto out;
> >> + ? ? }
> >
> > return the error code here?
> 
> out lable will free resources and return error code.

Sorry, I meant the error code you received which is in siic->irq.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120206/8b523255/attachment.sig>
