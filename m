From: joelf@ti.com (Joel Fernandes)
Date: Mon, 28 Apr 2014 11:11:18 -0500
Subject: [patch V2 5/6] edma: Make reading the position of active channels
 work
In-Reply-To: <20140428104643.215725974@linutronix.de>
References: <20140428104416.464002156@linutronix.de>
 <20140428104643.215725974@linutronix.de>
Message-ID: <535E7DA6.7010506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 05:49 AM, Thomas Gleixner wrote:
> As Joel pointed out, edma_read_position() uses memcpy_fromio() to read
> the parameter ram. That's not synchronized with the internal update as
> it does a byte by byte copy. We need to do a 32bit read to get a
> consistent value.
> 
> Further reading destination and source is pointless. In DEV_TO_MEM
> transfers we are only interested in the destination, in MEM_TO_DEV we
> care about the source. In MEM_TO_MEM it really does not matter which
> one you read.
> 
> Simple solution: Remove the pointers, select dest/source via a bool
> and return the read value.
> 
> Remove the export of this function while at it. The only potential
> user is the dmaengine and that's always builtin.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Thanks, this looks good.

Acked-by: Joel Fernandes <joelf@ti.com>


Regards,
-Joel
