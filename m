From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Fri, 28 Sep 2012 15:10:59 +0530
Subject: [PATCH v2 1/2] usb: phy: add a new driver for usb3 phy
In-Reply-To: <20120927141837.GA26268@n2100.arm.linux.org.uk>
References: <1348754648-8315-1-git-send-email-kishon@ti.com>
 <1348754648-8315-2-git-send-email-kishon@ti.com>
 <20120927141837.GA26268@n2100.arm.linux.org.uk>
Message-ID: <CAAe_U6J_AGArYEj1-sUmEeVkMmbkhp=WZxOuN-y-L6E5SDJM=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 27, 2012 at 7:48 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 27, 2012 at 07:34:07PM +0530, Kishon Vijay Abraham I wrote:
>> +static int omap5_usb_phy_power(struct omap_usb *phy, bool on)
>> +{
>> +     u32 val;
>> +     unsigned long rate;
>> +     struct clk *sys_clk;
>> +
>> +     sys_clk = clk_get(NULL, "sys_clkin");
>> +     if (IS_ERR(sys_clk)) {
>> +             pr_err("%s: unable to get sys_clkin\n", __func__);
>> +             return -EINVAL;
>> +     }
>> +
>> +     rate = clk_get_rate(sys_clk);
>> +     rate = rate/1000000;
>> +     clk_put(sys_clk);
>
> Actually, you're supposed to hold on to the struct clk all the time your
> driver is making use of that - you're not supposed to drop it.
>
> That has several advantages: if clk_get() fails, then you're failing
> earlier on (when the driver is being probed) and when some event occurs.

Ok. Will post a patch fixing it.

Thanks
Kishon
