From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 7 Jan 2011 08:57:06 -0700
Subject: [PATCH 3/6] i2c/pxa2xx: Add PCI support for PXA I2C controller
In-Reply-To: <20110106115026.GA18081@www.tglx.de>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de>
	<1294246263-31960-4-git-send-email-bigeasy@linutronix.de>
	<20110105230342.GO8638@n2100.arm.linux.org.uk>
	<20110105230834.GA26399@suse.de> <20110106105051.GA12146@www.tglx.de>
	<20110106111231.GD31708@n2100.arm.linux.org.uk>
	<20110106115026.GA18081@www.tglx.de>
Message-ID: <AANLkTikSrGaZoigQS4pU8bnHx4-PpmSRW-qTOo+joi=U@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 6, 2011 at 4:50 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Russell King - ARM Linux | 2011-01-06 11:12:31 [+0000]:
>
>>Please see my email where I described the lifetime rules. ?Let's say
>>your module is removed. ?In doing so, you call platform_device_unregister()
>>followed by kfree(). ?After this, your module is removed from the system
>>and the memory backing the module code is unmapped.
>>
>>If something holds a reference to the platform device, then that's just
>>waiting for an OOPS to happen. ?When those references are finally given
>>up, your release function will be called - but the code has been unmapped.
>
> I got that. That is why I'm going go to use allready provided functions
> (platform_device_register_resndata() in this case) so I'm no longer
> allocating any memory. So I'm only holding a struct which is pointing to
> the platform_device. Everything else is unmapped by the driver core.
>
> So I just have just to of_device_node_put() myself. Hmmm.
>
> Grant, who is calling of_device_node_put() on nodes assigned in
> of_register_spi_devices() & of_i2c_register_devices()? I can't find any
> reference. The spi part is not putting the node or removing the irq
> mapping in error case so I guess there must be some magic triggered
> somewhere.

No, it is just a deficiency on the spi and i2c dt support at the
moment.  It needs to be added.  However, since the flattree is
currently entirely static (nodes don't get freed) the mismatched
reference counting isn't immediately an issue.  However, it will
become a problem when add-in boards (like xilinx fpgas) start using
the dt to describe internal devices.

> Also adap->dev.of_node and master->dev.of_node has to be
> non-null for the device assignment to work. Who is putting these nodes
> back? I see drivers (i2c-cpm & i2c-mpc) taking refs but I fail to find a
> place where it is put back.

Same issue.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
