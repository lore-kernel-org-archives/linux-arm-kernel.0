From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Apr 2012 16:43:39 -0600
Subject: [PATCH] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <CACRpkdZYccTvHEMa=4=-uoLZYQxEPS+932UPA7MGc+-94eLc6w@mail.gmail.com>
References: <a1b7f612544a09989cec80a0318f35b6e48eb1d3.1333453148.git.viresh.kumar@st.com>
 <201204031347.35256.arnd@arndb.de>
 <CACRpkdZYccTvHEMa=4=-uoLZYQxEPS+932UPA7MGc+-94eLc6w@mail.gmail.com>
Message-ID: <4F7B7D1B.7030507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2012 03:24 PM, Linus Walleij wrote:
> On Tue, Apr 3, 2012 at 3:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> The initialization order dependencies can now be handled using
>> the deferred probe mechanism, by returning -EPROBE_DEFER from
>> the probe() function of any driver that is loaded before its
>> pins are available.
> 
> So how do I as a driver writer do that?
> 
> Example: drivers/tty/serial/sirfsoc_uart.c:
> 
> #include <linux/pinctrl/consumer.h>
> 
> probe() {
>        if (sirfport->hw_flow_ctrl) {
>                 sirfport->p = pinctrl_get_select_default(&pdev->dev);
>                 ret = IS_ERR(sirfport->p);
>                 if (ret)
>                         goto pin_err;
>         }
> 
> pin_err:
>     (...)
>    return ret;
> 
> So basically the pinctrl subsystem needs to return -EPROBE_DEFER
> to the driver in this case, so it can escalate that further.

Yes, I believe so.

There should be a couple of comments in pinctrl now (well, perhaps some
of them aren't there yet until my DT patches are applied!) that indicate
where -EPROBE_DEFER should be returned.
