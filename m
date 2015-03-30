From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 30 Mar 2015 09:48:47 -0600
Subject: [PATCH 4/5] coresight-stm: adding driver for CoreSight STM
 component
In-Reply-To: <87bnjad1jb.fsf@ashishki-desk.ger.corp.intel.com>
References: <1425078294-13059-1-git-send-email-mathieu.poirier@linaro.org>
 <1425078294-13059-5-git-send-email-mathieu.poirier@linaro.org>
 <87bnjad1jb.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkzK_LX4OQJOUtcr0EksRUKPueNOXrw2C+qTJWov0sQPFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 March 2015 at 08:04, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> +static int stm_send(void *addr, const void *data, u32 size)
>> +{
>> +     u32 len = size;
>> +
>> +     if (((unsigned long)data & 0x1) && (size >= 1)) {
>> +             writeb_relaxed(*(u8 *)data, addr);
>> +             data++;
>> +             size--;
>> +     }
>> +     if (((unsigned long)data & 0x2) && (size >= 2)) {
>> +             writew_relaxed(*(u16 *)data, addr);
>> +             data += 2;
>> +             size -= 2;
>> +     }
>> +
>> +     /* now we are 32bit aligned */
>> +     while (size >= 4) {
>> +             writel_relaxed(*(u32 *)data, addr);
>> +             data += 4;
>> +             size -= 4;
>> +     }
>> +
>> +     if (size >= 2) {
>> +             writew_relaxed(*(u16 *)data, addr);
>> +             data += 2;
>> +             size -= 2;
>> +     }
>> +     if (size >= 1) {
>> +             writeb_relaxed(*(u8 *)data, addr);
>> +             data++;
>> +             size--;
>> +     }
>> +
>> +     return len;
>> +}
>> +
>> +static int stm_trace_data(unsigned long ch_addr, u32 options,
>> +                       const void *data, u32 size)
>> +{
>> +     void *addr;
>> +
>> +     options &= ~STM_OPTION_TIMESTAMPED;
>> +     addr = (void *)(ch_addr | stm_channel_off(STM_PKT_TYPE_DATA, options));
>> +
>> +     return stm_send(addr, data, size);
>> +}
>> +
>> +static inline int stm_trace_hw(u32 options, u32 channel, u8 entity_id,
>> +                            const void *data, u32 size)
>> +{
>> +     int len = 0;
>> +     unsigned long ch_addr;
>> +     struct stm_drvdata *drvdata = stmdrvdata;
>> +
>> +
>> +     /* get the channel address */
>> +     ch_addr = (unsigned long)stm_channel_addr(drvdata, channel);
>> +
>> +     if (drvdata->write_64bit)
>> +             len = stm_trace_data_64bit(ch_addr, options, data, size);
>> +     else
>> +             /* send the payload data */
>> +             len = stm_trace_data(ch_addr, options, data, size);
>> +
>> +     return len;
>> +}
>
> As it looks from the above snippet, you're using a stream of DATA
> packets for user's payload. I also noticed that you use an ioctl to
> trigger timestamps.

Right, the ioctl() conveys user space intentions on that channel.
Options are kept and applied on every packet for as long as the
channel is open.

>
> Now, in the STP protocol there are, for example, marked data packets
> that can be used to mark beginning of a higher-level message,
> timestamped data packets that can be used to mean the same thing and
> FLAG packets to mark message boundaries.

Same on my side, I simply haven't included them yet.  I'll do so in my
next iteration.

>
> In my Intel TH code, I'm using D*TS packet for the beginning of a
> message (or "frame") and FLAG packet for the the end of a message.
>
> So my question is, is there any specific STP framing pattern that you
> use with Coresight STM or should we perhaps figure out a generic framing
> pattern and make it part of the stm class as well?

Now specific pattern... Sending a packet consists of MARK, DATA, FLAG.

>
> For example, we can replace stm's .write callback with something like
>
>     int (*packet)(struct stm_data *data,
>                   unsigned int type,    /* data, flag, trig etc */
>                   unsigned int options, /* timestamped, marked */
>                   u64 payload);
>
> and let the stm core do the "framing", which, then, will be common and
> consistent across different architectures/stm implementations.

I think the framing should be left to individual drivers.  It's only a
matter of time before we get a weird device that doesn't play well
with others, forcing to carry the ugliness in the STM core rather than
the driver.

And isn't carrying "options" redundant?  Using "container_of" on the
"data" field one can get back to the driver specific structure, which
is definitely a better place to keep that information.  I think the
general structure looks good right now, we simply need to find a way
to get rid of the ioctls.

Regarding the same "options", how did you plan on getting those from user space?

>
>> +static long stm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>> +{
>> +     u32 options;
>> +     struct stm_node *node = file->private_data;
>> +
>> +     switch (cmd) {
>> +     case STM_IOCTL_SET_OPTIONS:
>> +             if (copy_from_user(&options, (void __user *)arg, sizeof(u32)))
>> +                     return -EFAULT;
>> +
>> +             options &= (STM_OPTION_TIMESTAMPED | STM_OPTION_GUARANTEED);
>> +             node->options = options;
>> +             break;
>> +     case STM_IOCTL_GET_OPTIONS:
>> +             options = node->options;
>> +             if (copy_to_user((void __user *)arg, &options, sizeof(options)))
>> +                     return -EFAULT;
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     };
>> +
>> +     return 0;
>> +}
>
> That way, we also won't need private ioctl()s, or at least, not for this
> reason.
>
> How do you feel about this?
>
> Regards,
> --
> Alex
