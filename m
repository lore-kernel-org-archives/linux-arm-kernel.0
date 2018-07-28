From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sat, 28 Jul 2018 18:39:43 +0530
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <VI1PR04MB4222B4877B341C0FA07A6A8D802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-4-o.rempel@pengutronix.de>
 <CABb+yY0kVFvQRBrU4j9t=_JcSUkcXMMSK5u=XSufM6XcmKiv-g@mail.gmail.com>
 <AM0PR04MB42116C756EC78AD12EB254D6802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0yn9os6nqH8eUfAr3Q3ev4=TfpTp=5ZDBR7FN67eb-wg@mail.gmail.com>
 <VI1PR04MB4222672B8F7B6AF2B11A4442802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY1EkHk85H72xYoYA3JbQL03+-o3UcRVdA_Zub-Q+D=OHw@mail.gmail.com>
 <VI1PR04MB422216469EE5F3ED8E53A4F1802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY0SfdFr8TMOMosTVb5+LFWqB8nQkKj3ze8usi-s7Cko4g@mail.gmail.com>
 <VI1PR04MB4222B4877B341C0FA07A6A8D802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
Message-ID: <CABb+yY1MSSQKZ6BOQXC-x=qy4VZ5HqDBjmh_BJTXSkAm3+P8mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 2:12 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:


>> >> >>
>> >> >> MU has 4 pairs of TX_Reg + TX_IRQ, and 4 pairs of RX_Reg + RX_IRQ.
>> >> >> (MU also has 4 "doorbell" type channels that it calls GP, but
>> >> >> those are not managed here, so lets not worry atm).
>> >> >>
>> >> >> By definition, a mailbox channel is simply a signal, optionally
>> >> >> with data attached. So, MU has 4 TX and 4 RX channels.
>> >> >>
>> >> >> The MU driver should populate 8 unidirectional (4 Tx and 4 RX)
>> >> >> channels and set each tx/rx operation to trigger the corresponding
>> >> >> interrupt. This is not my whim, this is how the controller is!
>> >> >>
>> >> >
>> >> > This looks like reasonable to me, theoretically.
>> >> > Just not sure whether it's necessary to support it because we
>> >> > probably will never use like that in reality, then it might become
>> >> > meaningless complicity introduced and error prone.
>> >> >
>> >> It _is_ necessary to write controller driver independent of client drivers.
>> >>
>> >
>> > Yes, that's true. What if we think we're writing driver against HW
>> > capabilities which support 4 pair of channel links(tx/rx)?
>> > It looks like independent of client drivers and may make life easily.
>> > Does it make sense?
>> >
>> No, that would be emulation.
>> Why doesn't a usb device controller (udc) driver emulate FSG/HID etc, by
>> "thinking" it has a hardware backed storage/keyboard? It doesn't because
>> that is the job of upper protocol layer.
>>
>
> Sorry I'm not quite familiar with USB device.
>
Which subsystem are you familiar with? Every stack is designed like
that -- controller drivers reflect the physical hardware, any
emulation/protocol is implemented in the user layer.


> Another reason is I doubt that we may never use per register mode in a different register pair
> in the future.
>
You may never use, but if the driver reflects the controller as
precisely as it is, linux could support any usecase that some
baremetal code could support on your platform.
For example, you could support "normal" and "scu" mode over the 3-cell
mechanism I suggested. But your original proposal/assumption of
"scu-mode", failed immediately, hence Oleksij had to imlpement the
"normal" mode.


> For example:
> AP:
> node {
>         ...
>         // cell 0 meaning: 0: tx 1: rx  cell1 meaning: channel id
>         Mboxes = <&mbox 0 1 &mbox 1 2>
>         Mbox-names = "tx", "rx";
>>
>
> M4:
> node {
>         ...
>         Mboxes = <&mbox 0 2 &mbox 1 1>
>         Mbox-names = "tx", "rx";
>>
> This make things complicated and error prone as I said before.
>
I don't see how.


> But that's just my understanding and may overlook something, if you still think
> we should do exactly as above, I will not against it because it does work for M4 case.
>
Cool, done.


> Then the left question is how we handle SCU case?
>
Please point me to the code that you worry might not work.


>
> I'm a bit confusing....
> The section 3.6 you pointed is the MHU register description. It does not conflict
> with what I see from ARM doc center that each physical channel is unidirectional.
>
> See below:
> Chan 1:
> 0x000 SCP_INTR_L_STAT
> 0x008 SCP_INTR_L_SET
> 0x010 SCP _INTR_L_CLEAR
>
> Chan 2:
> 0x020 SCP_INTR_H_STAT
> 0x028 SCP_INTR_H_SET
> 0x030 SCP _INTR_H_CLEAR
>
> Chan 3:
> 0x100 CPU_INTR_L_STAT
> 0x108 CPU_INTR_L_SET
> 0x110 CPU_INTR_L_CLEAR
>
> Chan 4:
> 0x120 CPU_INTR_H_STAT
> 0x128 CPU_INTR_H_SET
> 0x130 CPU_INTR_H_CLEAR
>
> Chan 5:
> 0x200 SCP_INTR_S_STAT
> 0x208 SCP_INTR_S_SET
> 0x210 SCP _INTR_S_CLEAR
>
> Chan 6:
> 0x300 CPU_INTR_S_STAT
> 0x308 CPU_INTR_S_SET
> 0x310 CPU_INTR_S_CLEAR
>
> And the driver compose them into 3 channel links (lp, hp and sec).
> Am I wrong?
>
The RX and TX are not independent of each other, their priorities are
tied together in hardware. So it makes more sense (as compared to
declaring them independent) to club them together as one channel.
Whatever example you take - MHU or TI - you won't find a driver that
implements a virtual mode like "scu-mode".


>> >
>> > Sorry for may not clear, "Passing short message' usecase is to tell
>> > how the HW is working on one channel mode sending up to 4 words in one
>> > time As specified in reference manual.
>> >
>> > SCU does work that way, the only difference is it's using polling mode
>> > rather than interrupt driven.  The point is the data size may be
>> > different for each msg, so we can't simply know which data register
>> > interrupt should be enable from static data defined in device tree.
>> >
>> And you think passing variable data through registers is a better idea than
>> passing packets via shared-memory?
>>
>
> You got me. :-)
> I've no idea about which one is better.
>
Passing data directly via controller makes sense only when your
protocol defines fixed length packets that fit into registers (usually
FIFOs) or there is no shared memory between the processors.
Otherwise, you write a data packet at some located in shmem, and
provide its start and size along with the code of expected operation
on it, over the mailbox. Please refer to "Passing frame information"
para of page-2743 of your manual.
That is another reason the SCU implementation is broken - it has
variable length packets and yet use registers to pass them around.


> The problem is SCU firmware is already
> there passing packets through data registers, we have no way to change it.
>
OK. But what is SCU exactly? Part of ATF? Do you get some binary from
third party? If the last, you shouldn't be paying hsit for such a
design.


>>
>> The hardware has 8 unidirectional channels. But your protocol (SCU
>> implementation) assumes there is one _virtual_ channel that has 4 registers
>> and 1/0 irq --- which is not true. Instead of fixing the assumption in your
>> protocol or emulating the virtual channel in the protocol level (user of a MU),
>> you want to add code in the controller driver that ignores interrupts and club
>> the 4 independent channels together.
>>
>
> This stucks me. This is how the hardware is designed  and suggested to use
> in hardware reference manual. And now you're telling me this is wrong and
> we should not use the design in reference manual...
>
What you call "suggested to use in hardware reference manual" is just
1/5 examples of usecase.
And SCU is not even doing that correctly (it uses variable length
packet, unlike the fixed 4-words suggestion).

A manual can suggest multiple ways of implementing a usecase. It is
our job to chose the best one.
