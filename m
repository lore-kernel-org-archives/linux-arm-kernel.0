From: net147@gmail.com (Jonathan Liu)
Date: Fri, 30 Jun 2017 19:58:55 +1000
Subject: [PATCH v5] drm/sun4i: hdmi: Implement I2C adapter for A10s DDC bus
In-Reply-To: <20170630093422.om7b75q5wyuby6r7@flea>
References: <20170627143652.13075-1-net147@gmail.com>
 <20170628092024.ejxy6itqj3hx6yew@flea>
 <CANwerB0aTAbEoK3zrjZ0802+QEBiZ8tuuPovLsV+KWYtNzd3ig@mail.gmail.com>
 <20170629155620.4keqi4cumbtvv63u@flea>
 <CANwerB3bKWYhTsD7Jh1r6r-+AP_96y5rOtU6mCwpY1_jFZC8yg@mail.gmail.com>
 <20170630093422.om7b75q5wyuby6r7@flea>
Message-ID: <CANwerB2X1Z-B2-rFeizh7ijQ-QX6K8o7CKaht+KWdQ6qnkDYvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 30 June 2017 at 19:34, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Fri, Jun 30, 2017 at 08:22:13AM +1000, Jonathan Liu wrote:
>> Hi Maxime,
>>
>> On 30 June 2017 at 01:56, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Wed, Jun 28, 2017 at 08:39:33PM +1000, Jonathan Liu wrote:
>> >> >> +     u32 int_status;
>> >> >> +     u32 fifo_status;
>> >> >> +     /* Read needs empty flag unset, write needs full flag unset */
>> >> >> +     u32 flag = read ? SUN4I_HDMI_DDC_FIFO_STATUS_EMPTY :
>> >> >> +                       SUN4I_HDMI_DDC_FIFO_STATUS_FULL;
>> >> >> +     int ret;
>> >> >> +
>> >> >> +     /* Wait until error or FIFO ready */
>> >> >> +     ret = readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG,
>> >> >> +                              int_status,
>> >> >> +                              is_err_status(int_status) ||
>> >> >> +                              is_fifo_flag_unset(hdmi, &fifo_status, flag),
>> >> >> +                              min(len, SUN4I_HDMI_DDC_FIFO_SIZE) * byte_time,
>> >> >> +                              100000);
>> >> >> +
>> >> >> +     if (is_err_status(int_status))
>> >> >> +             return -EIO;
>> >> >> +     if (ret)
>> >> >> +             return -ETIMEDOUT;
>> >> >
>> >> > Why not just have
>> >> > ret = readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_FIFO_STATUS_REG, reg,
>> >> >                          !(reg & flag), 100, 100000);
>> >> >
>> >> > if (ret < 0)
>> >> >         if (is_err_status())
>> >> >                 return -EIO;
>> >> >         return ret;
>> >> >
>> >> >
>> >>
>> >> If I check error status after readl_poll_timeout and there is an error
>> >> (e.g. the I2C address does not have a corresponding device connected
>> >> or nothing connected to HDMI port) it will keep checking the fifo
>> >> status even though error bit is set in the int status and then timeout
>> >> after 100 ms. If it checks the int status register at the same time,
>> >> it will error after 100 nanoseconds. I don't want to introduce
>> >> unnecessary delays considering part of the reason for adding this
>> >> driver to make it more usable for non-standard use cases.
>> >
>> > Well, polling for 100ms doesn't seem great either. What was the
>> > rationale behind that timeout?
>> >
>>
>> When an error occurs one of the error bits will be set in the
>> INT_STATUS register so this is detected very quickly if I check the
>> INT_STATUS and FIFO_STATUS at the same time. The 100 ms timeout is in
>> case the I2C slave does clock stretching in which case the transfer
>> may take longer than the predicted time.
>
> 100ms isn't stretching anymore, it's worse than that.
>

What would you suggest?

>> > And we can also reverse the check and look at the INT_STATUS
>> > register. The errors will be there, and we can program the threshold
>> > we want in both directions and use the
>> > DDC_FIFO_Request_Interrupt_Status bit.
>> >
>>
>> I did try that when I was doing the v3 patch but I couldn't get it to
>> work as mentioned previously in the v3 patch discussion. I programmed
>> the FIFO_RX_TRIGGER_THRES and FIFO_TX_TRIGGER_THRES in DDC_FIFO_Ctrl
>> register at the same time as setting FIFO_Address_Clear but the
>> request interrupt status bit did not get updated to the appropriate
>> state that is consistent with the FIFO level and the thresholds. I did
>> try this several times for subsequent patch versions without success.
>
> What values did you set it to?
>

FIFO_RX_TRIGGER_THRES: 0
FIFO_TX_TRIGGER_THRES: 15

> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

Regards,
Jonathan
