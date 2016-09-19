From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 19 Sep 2016 18:31:50 +0300
Subject: next-20160914 build: 2 failures 3 warnings (next-20160914)
In-Reply-To: <1474883226.Je8NqnULCh@wuerfel>
References: <E1bk5OS-0000Vu-1C@optimist> <2300987.vYzazfRX5F@wuerfel>
 <20160919105429.GK10189@sirena.org.uk> <1474883226.Je8NqnULCh@wuerfel>
Message-ID: <b651f279-75c0-17b6-4940-938e0d29207d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2016 02:30 PM, Arnd Bergmann wrote:
> On Monday, September 19, 2016 11:54:29 AM CEST Mark Brown wrote:
>> On Mon, Sep 19, 2016 at 12:31:04PM +0200, Arnd Bergmann wrote:
>>
>>> My guess is that this is indeed the correct fix, but I don't understand
>>> at all what the function does, and Marcin Niestroj said the same thing,
>>> he just copied the code from a driver that is always built-in.
>>
>> Yes, most of the code is copied from regmap-irq.  Setting the parent is
>> needed for edge triggered interrupts that don't latch state when
>> disabled but isn't needed in the general case.
> 
> I found this in the tps65217 data sheet:
> 
>  9.3.7 Interrupt Pin (nINT)
>  The interrupt pin is used to signal any event or fault
>  condition to the host processor. Whenever a fault or event
>  occurs in the IC the corresponding interrupt bit is set in
>  the INT register, and the open-drain output is pulled low.
>  The nINT pin is released (returns to Hi-Z state) and fault
>  bits are cleared when the INT register is read by the
>  host. However, if a failure persists, the corresponding
>  INT bit remains set and the nINT pin is pulled low again
>  after a maximum of 32 ?s.
> 
>  Interrupt events include pushbutton pressed/released, USB
>  and AC voltage status change.
>  The MASK bits in the INT register are used to mask events
>  from generating interrupts. The MASK settings affect the
>  nINT pin only and have no impact on protection and
>  monitor circuits themselves. Note that persisting event
>  conditions such as ISINK enabled shutdown can cause the
>  nINT pin to be pulled low for an extended period of
>  time which can keep the host in a loop trying to resolve
>  the interrupt. If this behavior is not desired, set the
>  corresponding mask bit after receiving the interrupt and
>  keep polling the INT register to see when the event
>  condition has disappeared. Then unmask the interrupt bit
>  again.
> 
> Does this tell us if it's needed or not?
> 


The irq_set_parent() is required for proper supporting of lazy irq disabling
for threaded nested irqs and allow them to be re-triggered in the following case:

driverX:
 disable(nested_irq);
...
 parent irq triggered
   |- handle_nested_irq()
	|- mark nested_irq with IRQS_PENDING

...
driverX:
 enable(nested_irq);
   |- if IRQS_PENDING -> resend parent_irq [*], because nested threaded irq can't
      be resend by itself 

[*] if parent_irq is not set the IRQS_PENDING status will be ignored and irq might be lost.

Also, it was "mandatory" to be done before commit 75a06189fc5 
"genirq: Prevent resend to interrupts marked IRQ_NESTED_THREAD"
which made setting of parent_irq optional.

So, if is it required or not depends not only on HW, but, rather, on MFD drivers implementation
(Interrupt controller and MFD cell drivers).

-- 
regards,
-grygorii
