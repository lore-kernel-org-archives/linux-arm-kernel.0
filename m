From: robherring2@gmail.com (Rob Herring)
Date: Thu, 08 Mar 2012 16:22:44 -0600
Subject: [PATCH 06/14] ARM: kirkwood: convert uart0 to devicetree.
In-Reply-To: <20120308215048.GN5050@titan.lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <201203072113.04369.arnd@arndb.de>
 <20120308162530.GI5050@titan.lakedaemon.net>
 <201203081701.01663.arnd@arndb.de> <alpine.LFD.2.02.1203082026470.2742@ionos>
 <20120308194725.GM5050@titan.lakedaemon.net>
 <20120308213244.GD16533@ponder.secretlab.ca>
 <20120308215048.GN5050@titan.lakedaemon.net>
Message-ID: <4F593134.5000603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2012 03:50 PM, Jason wrote:
> On Thu, Mar 08, 2012 at 02:32:44PM -0700, Grant Likely wrote:
>> On Thu, Mar 08, 2012 at 02:47:25PM -0500, Jason wrote:
>>> On Thu, Mar 08, 2012 at 08:27:11PM +0100, Thomas Gleixner wrote:
>>>> On Thu, 8 Mar 2012, Arnd Bergmann wrote:
>>>>
>>>>> On Thursday 08 March 2012, Jason wrote:
>>>>>>
>>>>>> On Wed, Mar 07, 2012 at 09:13:04PM +0000, Arnd Bergmann wrote:
>>>>>>> Finally, something could be wrong with the interrupt controller.
>>>>>>> AFAICT, you register it through the device tree now, but it's also
>>>>>>> getting initialized through kirkwood_init_irq, so the numbers
>>>>>>> would all be wrong.
>>>>>>
>>>>>> Yes, I'm working through this now.  mv_cesa silently fails to come up
>>>>>> if it can't find the interrupt controller via fdt.  So, it needs to get
>>>>>> done.
>>>>>>
>>>>>> Right now, I'm looking at how mach-versatile does it (vic_init()) since
>>>>>> it's also an ARM926ej-s...
>>>>>>
>>>>>
>>>>> Ok, sounds good. It's not important whether it's an ARM9 or not btw.
>>>>> You should look at both anything that defines an "interrupt-controller"
>>>>> property as an example including Documentation/devicetree/bindings/arm/vic.txt
>>>>> and Documentation/devicetree/bindings/arm/gic.txt.
>>>>>
>>>>> (taking Thomas Gleixner on Cc)
>>>>>
>>>>> Since the orion irq chip is based on irqchip_generic, it would be
>>>>> perfect to have a generic irqchip binding to go along with
>>>>> kernel/irq/generic-chip.c. Not sure if anyone has thought about this
>>>>> before, but it looks like we can completely avoid using
>>>>> arch/arm/plat-orion/irq.c and arch/arm/mach-kirkwood/irq.c if we
>>>>> do that.

A generic irqchip binding is not the right approach. The binding should
still be specific to the controller as the generic irqchip code doesn't
handle everything like dispatching interrupts or know how many blocks of
32 interrupts your controller has.

>>>> Right. That should be trivial to implement.

Yes, since someone else already has (me).

>>>
>>> ok, I'm on it.  kernel/irq/of_generic_irq.c sound good?
>>
>> Rob Herring has done some work in this area.  Please coordinate with him.
> 
> Rob,
> 
> I'm attempting to convert mach-kirkwood boards over to devicetree,
> starting with the dreamplug.
> 
> You can find my stable patches here:
> 
> git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt_stable
> 
> and the stuff I'm still trying to figure out:
> 
> git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt_staging
> 
> My next task looks like converting the irq code, since mv_cesa fails
> silently without the interrupt-controller specified in the dtb.
> 
> The code I'm replacing can be found here:
> 
> arch/arm/mach-kirkwood/irq.c
> arch/arm/plat-orion/irq.c
> 
> This is the first time I've attempted something like this, so any
> pointers would be much appreciated.  Also, if there is anything I would
> need to deconflict with, please let me know.
> 

Look at my branch here:

git://sources.calxeda.com/kernel/linux.git irqdomain-for-grant

Your .init_irq function should call of_irq_init which will then call an
init function for each controller. Then you need to call
irq_setup_generic_chip_domain to setup the generic irqchip instances.

You also should convert to enabling CONFIG_MULTI_IRQ_HANDLER or I think
a linear domain won't work for you and that's what the generic irqchip
code will use. Also you should enable SPARSE_IRQ, but that is somewhat
independent.

In the DT case, you want to not have any compile time dependencies on
Linux irq numbers. If you're keeping non-DT compatibility, that will
complicate your conversion.

Rob
