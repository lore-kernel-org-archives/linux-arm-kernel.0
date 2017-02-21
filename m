From: p.figiel@camlintechnologies.com (Piotr Figiel)
Date: Tue, 21 Feb 2017 09:48:54 +0100
Subject: imx: Race when disabling RX in IMX.6 UART in half duplex
In-Reply-To: <20170221081821.7n2345o4zacnfcvl@tarshish>
References: <c07c95e2-3463-222b-c78a-b5716b4c5a14@camlintechnologies.com>
 <20170220192001.eqomprbgrqkefkas@tarshish>
 <e95b9a6f-9d61-3759-3eae-48e2900ca9b4@camlintechnologies.com>
 <20170221081821.7n2345o4zacnfcvl@tarshish>
Message-ID: <6151d423-da84-d497-d82a-7347357790a0@camlintechnologies.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,


On 21.02.2017 09:18, Baruch Siach wrote:
> Hi Piotr,
>
> On Tue, Feb 21, 2017 at 09:00:39AM +0100, Piotr Figiel wrote:
>> On 20.02.2017 20:20, Baruch Siach wrote:
>>> On Mon, Feb 20, 2017 at 02:54:02PM +0100, Piotr Figiel wrote:
>>>>    I'm looking to find a correct way to disable RX in the I.MX6 UART during
>>>> TX-ing. I stumbled on the issue described below when working on
>>>> ~SER_RS485_RX_DURING_TX on custom 3.10 tree (branched from Freescale's/NXP's
>>>> BSP release) independently to what is now in the main line imx.c, but I see
>>>> now that the implementation in mainline also seem to have the same problem
>>>> I'm trying to solve now. I would like to request for comments to
>>>> confirm/deny whether the issue I raise here is valid and how to best
>>>> approach this.
>>>>
>>>>    I'm mostly concerned about the fact that the URXD register must not be
>>>> accessed (as documented in IMX.6 RM) when RX is disabled (RXEN=0). The issue
>>>> is that in the following sequence happening during imx_start_tx with
>>>> ~SER_RS485_RX_DURING_TX set:
>>>>
>>>> 1. Acquire spinlock, disable local interrupts (from serial_core.c),
>>>> 2. Disable RX receiver (RXEN=0 in UCR2),
>>>> 3. Release spinlock, reenable interrupts.
>>>>
>>>> The RX fifo may become not empty between #1 and #2. This will raise
>>>> interrupt which will be handled after re-enabling interrupts (after #3). ISR
>>>> in this case will check the status bit of the interrupt and fetch RX FIFO
>>>> contents, which I understand is forbidden by the documentation and may raise
>>>> error on the bus [1]. In addition disabling RX IRQ in this procedure, e.g.
>>>> after #1 doesn't seem to be enough, as the IRQ still may trigger after #1
>>>> and will need to be serviced.
>>> As I understand it, SER_RS485_RX_DURING_TX is for half-duplex RS-485 where
>>> only one device is allowed to transmit at any given time. Higher level code
>>> determines when any given device on the bus is allowed to transmit. If Rx FIFO
>>> becomes non-empty during Tx enable, you have a contention problem to solve.
>> That's correct, although I don't want bugs from the user-space or
>> misbehaving devices on RS-485 to cause errors on the AXI/AHB bus resulting
>> with possible crash/exception on the CPU core. The reason I write about this
>> is that the RM explicitly forbids accessing those registers in such case.
> The trivial solution might be to return early from imx_rxint() when RXEN=0.
> Would that be sufficient?

I'm not sure if it's best idea, I don't know if the UART will keep 
triggering the interrupt if the source won't be cleared (FIFO drained), 
but if it does we'll be irq flooded, if it doesn't there will be old 
contents in the RX fifo no-one will touch until some other interrupt 
(other than TX fifo empty, as at that time RXEN would still be 0) comes. 
RX fifo could be alternatively cleaned somewhere else, this is actually 
question I raise in my initial e-mail.

Best regards, Piotr.
