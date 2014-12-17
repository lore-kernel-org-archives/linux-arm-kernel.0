From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 17 Dec 2014 19:15:49 +0100
Subject: [PATCH 2/2] i2c: i2c-mv64xxx: rework offload support to fix
 several problems
In-Reply-To: <1418315626-9552-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1418315626-9552-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1418315626-9552-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141217181549.GB3981@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 05:33:46PM +0100, Thomas Petazzoni wrote:
> Originally, the I2C controller supported by the i2c-mv64xxx driver
> requires a lot of software support: an interrupt is generated at each
> step of an I2C transaction (after the start bit, after sending the
> address, etc.) and the driver is in charge of re-programming the I2C
> controller to do the next step of the I2C transaction. This explains
> the fairly complex state machine that the driver has.
> 
> On Marvell Armada XP and later processors (Armada 375, 38x, etc.), the
> I2C controller was extended with a part called the "I2C Bridge", which
> allows to offload the I2C transaction completely to the
> hardware. Initial support for this mechanism was added in commit
> 930ab3d403a ("i2c: mv64xxx: Add I2C Transaction Generator support").
> 
> However, the implementation done in this commit has two related
> issues, which this commit fixes by completely changing how the offload
> implementation is done:
> 
>  * SMBus read transfers, where there is one write to select the
>    register immediately followed in the same transaction by one read,
>    were making the processor hang. This was easier visible on the
>    Marvell Armada XP WRT1900AC platform using a driver for an I2C LED
>    controller, or on other Armada XP platforms by using a simple
>    'i2cget' command to read an I2C EEPROM.
> 
>  * The implementation was based on the fact that the offload engine
>    was re-programmed to transfer each message of an I2C xfer: this
>    meant that each message sent with the offload engine was starting
>    with a normal I2C start sequence. However, the I2C subsystem
>    assumes that all messages belonging to the same xfer will use the
>    so-called "repeated start" so that the entire I2C xfer is seen as
>    one transfer by the I2C devices and cannot be interrupt by other
>    I2C masters on the same bus.
> 
> In fact, the "I2C Bridge" allows to offload three types of xfer:
> 
>  - xfer of one write message
>  - xfer of one read message
>  - xfer of one write message followed by one read message
> 
> For all other situations, we have to fallback to not using the "I2C
> Bridge" in order to get proper I2C semantics.
> 
> Therefore, this commit reworks the offload implementation to put it
> not at the message level, but at the xfer level: in the
> mv64xxx_i2c_xfer() function, we decide if the transaction can be
> offloaded (in which case it is handled by the
> mv64xxx_i2c_offload_xfer() function), or otherwise it is handled by
> the slow path (implemented in the existing mv64xxx_i2c_execute_msg()).
> 
> This allows to simplify the state machine, which no longer needs to
> have any state related to the offload implementation: the offload
> implementation is now completely separated from the slow path (with
> the exception of the interrupt handler, of course).
> 
> In summary:
> 
>  - mv64xxx_i2c_can_offload() will analyze an I2C xfer and decided of
>    the "I2C Bridge" can be used to offload it or not.
> 
>  - mv64xxx_i2c_offload_xfer() will actually program the "I2C Bridge"
>    to offload one xfer (of either one or two messages), and block
>    using mv64xxx_i2c_wait_for_completion() until the xfer completes.
> 
>  - The interrupt handler mv64xxx_i2c_intr() is modified to push the
>    offload related code to a separate function,
>    mv64xxx_i2c_intr_offload(). It will take care of reading the
>    received data if needed.
> 
> This commit was tested on:
> 
>  - Armada XP OpenBlocks AX3-4 (EEPROM on I2C and RTC on I2C)
>  - Armada XP WRT1900AC (LED controller on I2C)
>  - Armada XP GP (EEPROM on I2C)
> 
> Fixes: 930ab3d403ae ("i2c: mv64xxx: Add I2C Transaction Generator support")
> Cc: <stable@vger.kernel.org> # v3.12+
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to for-current, thanks. But please fix checkpatch warnings next
time!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141217/5b7fe446/attachment.sig>
