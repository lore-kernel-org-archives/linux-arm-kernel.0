From: rogerq@ti.com (Roger Quadros)
Date: Thu, 10 Oct 2013 17:35:19 +0300
Subject: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
In-Reply-To: <CACRpkdZx5+OCcQytkpjd7_nz4hw6VXoXOS0LByKgJ8_cQjbA4g@mail.gmail.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054221.8941.87801.stgit@localhost> <5256AA7F.8030005@ti.com>
 <CACRpkdZx5+OCcQytkpjd7_nz4hw6VXoXOS0LByKgJ8_cQjbA4g@mail.gmail.com>
Message-ID: <5256BB27.6010107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2013 05:04 PM, Linus Walleij wrote:
> On Thu, Oct 10, 2013 at 3:24 PM, Roger Quadros <rogerq@ti.com> wrote:
> 
>> I think pcs_irq_set_wake() is where need to control system wakeup behaviour for the irq.
>> This is where we should be able to change WAKEUP_EN bit of the pad
>> to enable/disable system wakeup for that pad and also call _reconfigure_io_chain().
> 
> As an innocent bystander who has no clue what the _reconfigure_io_chain()
> is about can you tell me what this is all about?

The OMAP SoC has a mechanism to monitor and wakeup from a low power state by creating
an IO ring of all the pads. But there is one bit in one of the control registers that
needs to be toggled each time the pad configuration is changed to re-arm the IO ring.
This is exactly what _reconfigure_io_chain() does.
> 
> Is this another one of the OMAP forked paths where you must call back into
> the machine with a special callback from each and every driver?

_reconfigure_io_chain() is not available for public use and is not called by any driver yet.
However, it somehow needs to be called from this pinctrl-single driver each time the
wakeup configuration for any pad is changed.

cheers,
-roger
