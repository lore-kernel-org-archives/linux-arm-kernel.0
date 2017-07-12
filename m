From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Wed, 12 Jul 2017 17:39:59 -0500
Subject: [PATCHv4 3/3] i2c: altera: Add Altera I2C Controller driver
In-Reply-To: <CAHp75Vdr6tomrzKMtJ2LQ+k-jU274VMEfHN-MTzvO-PYN_8DHw@mail.gmail.com>
References: <1497904618-27010-1-git-send-email-thor.thayer@linux.intel.com>
 <1497904618-27010-4-git-send-email-thor.thayer@linux.intel.com>
 <CAHp75VcpdeGW0KXSqZwyMDkGbjT+6Ky5nBXTs7d-dN0gpYHV_w@mail.gmail.com>
 <f049d174-5a64-2a20-5f47-1638963ea475@linux.intel.com>
 <CAHp75Vdr6tomrzKMtJ2LQ+k-jU274VMEfHN-MTzvO-PYN_8DHw@mail.gmail.com>
Message-ID: <41d47a3c-cff6-a24c-da96-3e7901e9334d@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 07/08/2017 04:41 PM, Andy Shevchenko wrote:
> On Sat, Jul 8, 2017 at 12:08 AM, Thor Thayer
> <thor.thayer@linux.intel.com> wrote:
>> On 07/07/2017 11:25 AM, Andy Shevchenko wrote:
>>> On Mon, Jun 19, 2017 at 11:36 PM,  <thor.thayer@linux.intel.com> wrote:
> 
>>>> +       while (bytes_to_transfer-- > 0) {
>>>> +               *idev->buf++ = readl(idev->base + ALTR_I2C_RX_DATA);
>>>> +               if (idev->msg_len == 1)
>>>> +                       altr_i2c_stop(idev);
>>>> +               else
>>>> +                       writel(0, idev->base + ALTR_I2C_TFR_CMD);
>>>> +
>>>> +               idev->msg_len--;
>>>> +       }
>>>
>>>
>>> Move out invariant from the loop (and I see a bug, you might go over
>>> boundaries).
>>>
>>>          while (bytes_to_transfer-- > 0) {
>>>                  *idev->buf++ = readl(idev->base + ALTR_I2C_RX_DATA);
>>>                  if (idev->msg_len-- == 1)
>>>                      break;
>>>                  writel(0, idev->base + ALTR_I2C_TFR_CMD);
>>>          }
>>>
>>>          altr_i2c_stop(idev);
>>>
>> I see your point on the boundary.
> 
> Actually I didn't notice min() call above. So, you may ignore that part.
> 
>> However your change is slightly different
>> from what I'm trying to do.
> 
> I don't see how it differs to what you wrote.

The stop condition is sent after every FIFO read but I only want the 
stop condition when the entire message has been sent (at msg_len == 1) 
which will be the last byte.

> 
>> I think you assumed the alt_i2c_stop() call can cause a stop condition. This
>> soft IP can't send just a start or a stop condition by itself - both of
>> these conditions need to be paired with a byte.
> 
> OK.
> 
>> The other subtle side effect is the start condition + byte write is the
>> first write which is why the last write is skipped.
> 
>> I need to send a byte with a stop condition on the last expected byte
>> (idev->msg_len == 1) while this change would send it after the FIFO is empty
>> or after (msg_len == 1).
> 
> Consider the corner case when msg_len _is_ 1 at the beginning.
> Then continue with 2. I really didn't see the difference in two
> snippets. Perhaps you have a bug there.

I see your point about a bug. I'm sending an extra byte. I'll fix it in 
the next revision. Thanks.

> 
>> Your version is cleaner so I'll just add the alt_i2c_stop(idev) call inside
>> the (msg_len == 1) condition and before the break.
> 
>>>> +static int altr_i2c_fill_tx_fifo(struct altr_i2c_dev *idev)
>>>> +{
>>>> +       size_t tx_fifo_avail = idev->fifo_size - readl(idev->base +
>>>> +
>>>> ALTR_I2C_TC_FIFO_LVL);
>>>> +       int bytes_to_transfer = min(tx_fifo_avail, idev->msg_len);
>>>> +       int ret = idev->msg_len - bytes_to_transfer;
>>>> +
>>>> +       while (bytes_to_transfer-- > 0) {
>>>> +               if (idev->msg_len == 1)
>>>> +                       writel(ALTR_I2C_TFR_CMD_STO | *idev->buf++,
>>>> +                              idev->base + ALTR_I2C_TFR_CMD);
>>>> +               else
>>>> +                       writel(*idev->buf++, idev->base +
>>>> ALTR_I2C_TFR_CMD);
>>>> +               idev->msg_len--;
>>>> +       }
>>>
>>>
>>> Ditto.
>>>
>> See above but I will move the msg_len-- inside the condition check like you
>> had.
> 
> Ditto.

I'll check this one as well.

> 
>>>> +static int altr_i2c_wait_for_core_idle(struct altr_i2c_dev *idev)
>>>> +{
>>>> +       unsigned long timeout = jiffies +
>>>> msecs_to_jiffies(ALTR_I2C_TIMEOUT);
>>>> +
>>>> +       do {
>>>> +               if (time_after(jiffies, timeout)) {
>>>> +                       dev_err(idev->dev, "Core Idle timeout\n");
>>>> +                       return -ETIMEDOUT;
>>>> +               }
>>>> +       } while (readl(idev->base + ALTR_I2C_STATUS) &
>>>> ALTR_I2C_STAT_CORE);
>>>> +
>>>> +       return 0;
>>>> +}
> 
>>> readl_poll_timeout[_atomic]() please.
> 
> You ignored some of my comments including this one. Why? Can you go
> again through my rreview and answer the rest?

I wasn't aware of this function but it simplifies the code. I'll add it. 
Thanks.

I addressed most of your comments. In some cases, I grouped the comments 
together - for instance in the msg[], the comments addressed the same 
function.

> 
>>>> +       if (of_property_read_u32(np, "fifo-size", &idev->fifo_size))
>>>> +               idev->fifo_size = ALTR_I2C_DFLT_FIFO_SZ;
> 
>>> Shouldn't be possible to auto detect?
>>>
>> I agree. That would have been SO much better but the hardware designers
>> released this without capturing the size in a register - they come from a
>> bare-metal project perspective.  Since the FIFO size is configurable in the
>> FPGA from 4 to 256 levels deep, I need to capture this with the device tree.
> 
> You may do it manually, right? There are examples for similar cases
> like writing the offset into FIFO until it returns the written value
> and FIFO maximum possible size is not achieved.
> 
While I agree that some FIFOs could be discovered that way, data pushed 
into this FIFO will be transmitted which isn't good.

Reading from the device tree is quite clean.  Additionally, there is a 
precedence for the "fifo-size" being read from the device tree in 
i2c-at91.c.

I have an addition question about a comment that isn't in this reply so 
I'm copying it here to keep the thread clean.

<snip> Copying my previous reply

 >>> +static u32 altr_i2c_func(struct i2c_adapter *adap)
 >>> +{
 >>> +       return I2C_FUNC_I2C;
 >>> +}
 >>
 >> Useless. Use value in place.
 >
 >Got it. Thanks!

After looking at this, I'm not clear what you mean. The 
i2c_algorithm.functionality parameter requires a function pointer which 
is why the altr_i2c_func() is assigned to that parameter as shown below. 
Am I missing something?

+
+static const struct i2c_algorithm altr_i2c_algo = {
+	.master_xfer = altr_i2c_xfer,
+	.functionality = altr_i2c_func,
+};

</snip>

Thanks again for reviewing and for the helpful comments.

Thor
