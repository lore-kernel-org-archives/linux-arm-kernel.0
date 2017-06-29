From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 29 Jun 2017 17:56:20 +0200
Subject: [PATCH v5] drm/sun4i: hdmi: Implement I2C adapter for A10s DDC bus
In-Reply-To: <CANwerB0aTAbEoK3zrjZ0802+QEBiZ8tuuPovLsV+KWYtNzd3ig@mail.gmail.com>
References: <20170627143652.13075-1-net147@gmail.com>
 <20170628092024.ejxy6itqj3hx6yew@flea>
 <CANwerB0aTAbEoK3zrjZ0802+QEBiZ8tuuPovLsV+KWYtNzd3ig@mail.gmail.com>
Message-ID: <20170629155620.4keqi4cumbtvv63u@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 08:39:33PM +1000, Jonathan Liu wrote:
> >> +     u32 int_status;
> >> +     u32 fifo_status;
> >> +     /* Read needs empty flag unset, write needs full flag unset */
> >> +     u32 flag = read ? SUN4I_HDMI_DDC_FIFO_STATUS_EMPTY :
> >> +                       SUN4I_HDMI_DDC_FIFO_STATUS_FULL;
> >> +     int ret;
> >> +
> >> +     /* Wait until error or FIFO ready */
> >> +     ret = readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG,
> >> +                              int_status,
> >> +                              is_err_status(int_status) ||
> >> +                              is_fifo_flag_unset(hdmi, &fifo_status, flag),
> >> +                              min(len, SUN4I_HDMI_DDC_FIFO_SIZE) * byte_time,
> >> +                              100000);
> >> +
> >> +     if (is_err_status(int_status))
> >> +             return -EIO;
> >> +     if (ret)
> >> +             return -ETIMEDOUT;
> >
> > Why not just have
> > ret = readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_FIFO_STATUS_REG, reg,
> >                          !(reg & flag), 100, 100000);
> >
> > if (ret < 0)
> >         if (is_err_status())
> >                 return -EIO;
> >         return ret;
> >
> >
> 
> If I check error status after readl_poll_timeout and there is an error
> (e.g. the I2C address does not have a corresponding device connected
> or nothing connected to HDMI port) it will keep checking the fifo
> status even though error bit is set in the int status and then timeout
> after 100 ms. If it checks the int status register at the same time,
> it will error after 100 nanoseconds. I don't want to introduce
> unnecessary delays considering part of the reason for adding this
> driver to make it more usable for non-standard use cases.

Well, polling for 100ms doesn't seem great either. What was the
rationale behind that timeout?

And we can also reverse the check and look at the INT_STATUS
register. The errors will be there, and we can program the threshold
we want in both directions and use the
DDC_FIFO_Request_Interrupt_Status bit.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170629/6b2dc932/attachment.sig>
