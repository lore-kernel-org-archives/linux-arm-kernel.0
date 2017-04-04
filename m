From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue, 4 Apr 2017 12:32:24 -0500
Subject: [PATCH v4 19/23] drivers/fsi: Add GPIO based FSI master
In-Reply-To: <1490907014.3177.207.camel@kernel.crashing.org>
References: <20170329174340.89109-1-cbostic@linux.vnet.ibm.com>
 <20170329174340.89109-20-cbostic@linux.vnet.ibm.com>
 <CACPK8XfOSYPidHF6=psC4mP-tkRyWTu0psdcK6EwA2E6FF53Uw@mail.gmail.com>
 <0e1bcf3a-e8d7-9f50-bdf7-2a1e7466665b@linux.vnet.ibm.com>
 <1490907014.3177.207.camel@kernel.crashing.org>
Message-ID: <93b21624-11fc-b71b-aa78-6cb4371c87ae@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/30/17 3:50 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2017-03-30 at 13:15 -0500, Christopher Bostic wrote:
>>>> +static void serial_in(struct fsi_master_gpio *master, struct fsi_gpio_msg *msg,
>>>> +                       uint8_t num_bits)
>>>> +{
>>>> +       uint8_t bit, in_bit;
>>>> +
>>>> +       set_sda_input(master);
>>>> +
>>>> +       for (bit = 0; bit < num_bits; bit++) {
>>>> +               clock_toggle(master, 1);
>>>> +               in_bit = sda_in(master);
>>>> +               msg->msg <<= 1;
>>>> +               msg->msg |= ~in_bit & 0x1;      /* Data is negative active */
>>>> +       }
>>>> +       msg->bits += num_bi	ts;
>>>> +}
>>>> +
>>>> +static void serial_out(struct fsi_master_gpio *master,
>>>> +                       const struct fsi_gpio_msg *cmd)
>>>> +{
>>>> +       uint8_t bit;
>>>> +       uint64_t msg = ~cmd->msg;       /* Data is negative active */
>>>> +       uint64_t sda_mask = 0x1ULL << (cmd->bits - 1);
>>>> +       uint64_t last_bit = ~0;
>>>> +       int next_bit;
>>>> +
>>>> +       if (!cmd->bits) {
>>>> +               dev_warn(master->dev, "trying to output 0 bits\n");
>>>> +               return;
>>>> +       }
>>>> +       set_sda_output(master, 0);
>>>> +
>>>> +       /* Send the start bit */
>>>> +       sda_out(master, 0);
>>>> +       clock_toggle(master, 1);
>>>> +
>>>> +       /* Send the message */
>>>> +       for (bit = 0; bit < cmd->bits; bit++) {
>>>> +               next_bit = (msg & sda_mask) >> (cmd->bits - 1);
>>>> +               if (last_bit ^ next_bit) {
>>>> +                       sda_out(master, next_bit);
>>>> +                       last_bit = next_bit;
>>>> +               }
>>>> +               clock_toggle(master, 1);
>>>> +               msg <<= 1;
>>>> +       }
>>>> +}
> As I mentioned privately, I don't think this is right, unless your
> clock signal is inverted or my protocol spec is wrong...
>
> Your clock toggle is written so you call it right after the rising
> edge. It does delay, 0, delay, 1.
>
> But according to the FSI timing diagram I have, you need to establish
> the data around the falling edge, it gets sampled by the slave on the
> rising edge. So as it is, your code risks violating the slave hold
> time.
>
> On input, you need to sample on the falling edge, right before it. You
> are sampling after the rising edge, so you aren't leaving enough time
> for the slave to establish the data.
>
> You could probably just flip clock_toggle() around. Make it: 0, delay,
> 1, delay.
>
> That way you can do for sends: sda_out + toggle, and for receive
> toggle + sda_in. That will make you establish your output data and
> sample right before the falling edge, which should be ok provided the
> diagram I have is right.

Hi Ben,

Agreed that there is room for improvement.   I intend to look further 
into your suggestions from here and our private conversation on the 
matter and make changes as appropriate.  I have an open issue to track 
this.  As it exists in this patch reads/writes from master to slave 
fundamentally work.   Given the pervasiveness and time to fully evaluate 
and test any protocol updates I intend address this in the near future 
with a separate follow on patch.

Thanks,
Chris
>
> Cheers,
> Ben.
>
