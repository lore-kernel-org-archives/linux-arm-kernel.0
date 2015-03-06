From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 6 Mar 2015 10:51:16 +0800
Subject: parent/child hierarchy for regulator
In-Reply-To: <20150305122234.GL21293@sirena.org.uk>
References: <20150305103534.GA19600@shlinux2>
 <20150305122234.GL21293@sirena.org.uk>
Message-ID: <20150306025115.GB12879@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 12:22:34PM +0000, Mark Brown wrote:
> On Thu, Mar 05, 2015 at 06:35:36PM +0800, Peter Chen wrote:
> 
> > Any good ways at code/dts to show parent/child hierarchy for regulator?
> 
> There's plenty of examples in mainline...
> 

thanks, I am back to study again.

> > The related regulators at my platforms like below:
> > PMIC (SWB 5v) --> Switch Chip (GPIO Regulator) --> USB VBUS
> 
> > PMIC has one 5V regulator (eg, swbst at pfuse), and it is the input
> > for USB power switch chip, and there are two gpios at this switch
> > chip to control if 5V is output or not, we register these two gpios as 
> > fixed regulators, currently, if regulator swbst is disabled, the
> > gpio regulator has no way to know, and cause the vbus voltage is wrong.
> 
> Can you please clarify why you're registering two fixed voltage
> regulators for the switch chip and how you're doing that?

Two fixed regulators for two USB vbus, there are no relationships beween
them, but both of them needs PMIC 5V (swbst at pfuse) to be enabled.

> The picture
> above looks like you should just have a single regulator there and
> nothing should care if the either regulator is enabled when querying the
> parent for its voltage.

I need to care about its parent's status, currently, the usb code does
not consider parent regulator, so after below patch, the voltage of
vbus is incorrect, due to parent regulator is disabled after boots up,
there is no user for this parent regulator.

commit a6dcf9782f99a0d844b4d06f65cc990468424068
Author: Sean Cross <xobs@kosagi.com>
Date:   Mon May 26 16:45:40 2014 +0800

    regulator: pfuze100: Support SWB enable/disable
        
        The SWB regulators have the ability to be turned on and off.
	Add enable/disable support for these regulators.

-- 

Best Regards,
Peter Chen
