From: brendanhiggins@google.com (Brendan Higgins)
Date: Thu, 12 Jul 2018 02:33:16 -0700
Subject: [PATCH] i2c: aspeed: Improve driver to support multi-master use
 cases stably
In-Reply-To: <e51471e6-0f8a-bffc-34c8-1e74239fdbcf@linux.intel.com>
References: <20180626165812.4141-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g45z--ucXf-So517tgrayZT6x2TGvaUvaDF7zeRNn7CPXw@mail.gmail.com>
 <e51471e6-0f8a-bffc-34c8-1e74239fdbcf@linux.intel.com>
Message-ID: <CAFd5g47j_h4ZrT8Eg1FZ8sAj5ekCUH20jUVub75ozdkg8_YW7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 10:55 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
<snip>
> >> +/* Timeout for bus busy checking */
> >> +#define BUS_BUSY_CHECK_TIMEOUT                         250000 /* 250ms */
> >> +#define BUS_BUSY_CHECK_INTERVAL                                10000  /* 10ms */
> >
> > Could you add a comment on where you got these values from?
> >
>
> These are coming from ASPEED SDK code. Actually, they use 100ms for
> timeout and 10ms for interval but I increased the timeout value to
> 250ms so that it covers a various range of bus speed. I think, it
> should be computed at run time based on the current bus speed, or
> we could add these as device tree settings. How do you think about it?
>

This should definitely be a device tree setting. If one of the busses is being
used as a regular I2C bus, it could hold the bus for an unlimited amount of
time before sending a STOP. As for a default, 100ms is probably fine given
that, a) the limit will only apply to multi-master mode, and b) multi-master
mode will probably almost always be used with IPMB, or MCTP (MCTP actually
recommends a 100ms timeout for this purpose, see
https://www.dmtf.org/sites/default/files/standards/documents/DSP0237_1.1.0.pdf,
symbol PT2a). That being said, if you actually want to implement IPMB, or MCTP
arbitration logic, it is much more complicated.

>  >
<snip>
> >>   #if IS_ENABLED(CONFIG_I2C_SLAVE)
> >> -       if (aspeed_i2c_slave_irq(bus)) {
> >> -               dev_dbg(bus->dev, "irq handled by slave.\n");
> >> -               return IRQ_HANDLED;
> >> +       if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
> >> +               if (!aspeed_i2c_master_irq(bus))
> >
> > Why do you check the slave if master fails (or vice versa)? I
> > understand that there are some status bits that have not been handled,
> > but it doesn't seem reasonable to assume that there is state that the
> > other should do something with; the only way this would happen is if
> > the state that you think you are in does not match the status bits you
> > have been given, but if this is the case, you are already hosed; I
> > don't think trying the other handler is likely to make things better,
> > unless there is something that I am missing.
> >
>
> In most of cases, interrupt bits are set one by one but there are also a
> lot of other cases that ASPEED I2C H/W sends multiple interrupt bits
> with combining master and slave events using a single interrupt call. It
> happens much in multi-master environment than single-master. For
> example, when master is waiting for a NORMAL_STOP interrupt in its
> MASTER_STOP state, SLAVE_MATCH and RX_DONE interrupts could come along
> with the NORMAL_STOP in case of an another master immediately sends data
> just after acquiring the bus - it happens a lot in BMC-ME connection
> practically. In this case, the NORMAL_STOP interrupt should be handled
> by master_irq and the SLAVE_MATCH and RX_DONE interrupts should be
> handled by slave_irq so it's the reason why this code is added.

That sucks. Well, it sounds like there are only a handful of cases in which
this can happen. Maybe enumerate these cases and error out or at least warn if
it is not one of them?

>
<snip>
> >> +       for (;;) {
> >> +               if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
> >> +                     (ASPEED_I2CD_BUS_BUSY_STS |
> >> +                      ASPEED_I2CD_XFER_MODE_STS_MASK)))
> >
> > Is using the Transfer Mode State Machine bits necessary? The
> > documentation marks it as "for debugging purpose only," so relying on
> > it makes me nervous.
> >
>
> As you said, the documentation marks it as "for debugging purpose only."
> but ASPEED also uses this way in their SDK code because it's the best
> way for checking bus busy status which can cover both single and
> multi-master use cases.
>

Well, it would also be really nice to have access to this bit if someone wants
to implement MCTP. Could we maybe check with Aspeed what them meant by "for
debugging purposes only" and document it here? It makes me nervous to rely on
debugging functionality for normal usage.

> >> +                       return 0;
> >> +               if (ktime_compare(ktime_get(), timeout) > 0)
> >> +                       break;
> >> +               usleep_range((BUS_BUSY_CHECK_INTERVAL >> 2) + 1,
> >
> > Where did you get this minimum value?
> >
>
> No source for the minimum value. ASPEED uses mdelay(10) in their SDK
> but I changed that code using usleep_range and the range value was set
> with considering time stretching of usleep_range.
> regmap_read_poll_timeout was a reference for this code.

What protocol are you trying to implement on top of this? You mentioned BMC-ME
above; that's IPMB, right? For most use cases, this should work, but if you
need arbitration, you will need to do quite a bit more work.

>
> Thanks,
>
> Jae
<snip>

Cheers
