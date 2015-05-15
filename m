From: tom_usenet@optusnet.com.au (Tom Evans)
Date: Fri, 15 May 2015 10:09:52 +1000
Subject: [PATCH v2 5/5] can: flexcan: Add support for non RX-FIFO mode
In-Reply-To: <5554C244.80809@pengutronix.de>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-6-git-send-email-bhupesh.sharma@freescale.com>
 <5554C244.80809@pengutronix.de>
Message-ID: <55553950.3050709@optusnet.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/15 01:41, Marc Kleine-Budde wrote:
> On 05/14/2015 01:33 PM, Bhupesh Sharma wrote:
>> This patch adds support for non RX-FIFO (legacy) mode in
>> the flexcan driver.
>>
>> On certain SoCs, the RX-FIFO support might be broken, as
>> a result we need to fall-back on the legacy (non RX-FIFO)
>> mode to receive CAN frames.
>>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
>> Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
>
> The non FIFO mode doesn't guarantee the order of the incoming frames,
> not does not even try to...this is not acceptable. I'm currently working
> on a patch by David Jander that brings in non FIFO mode, but tries to
> keep the order of the frames.
>
> Marc

In case it is of any help as a reference, here's a thread on the problems of 
receiving messages in order on another non-FIFO chip. This applies to the 
normal Microchip CAN controllers, in this case the very-hard-to-program 
on-the-end-of-an-SPI-bus MCP2515:

http://www.microchip.com/forums/tm.aspx?m=620741

It has two receive buffers, and a "rollover" setting. This does not make the 
registers operate as a FIFO and it needs a state machine to keep track of 
which buffer holds which sequence message.

Tom
