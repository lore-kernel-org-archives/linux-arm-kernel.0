From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 4 Mar 2015 09:22:37 +0100
Subject: Bug in i2c-core?
In-Reply-To: <3574616.qzNqihiGp7@avalon>
References: <54F0507F.6030804@armadeus.com> <20150227165944.GA6679@dtor-ws>
 <3574616.qzNqihiGp7@avalon>
Message-ID: <20150304082237.GA2955@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > I am writing an I2C touchscreen driver for an i.MX6 based board. I
> > > compiled it as a module and when I unload it, I get the following warning:
> > > 
> > > # modprobe sx8654
> > > [   46.261494] input: SX8654 I2C Touchscreen as
> > > /devices/soc0/soc/2100000.aips-bus/21a0000.i2c/i2c-0/0-0048/input/input1
> > > # rmmod sx8654
> > > [   76.435223] ------------[ cut here ]------------
> > > [   76.439909] WARNING: CPU: 0 PID: 134 at fs/proc/generic.c:552
> > > remove_proc_entry+0x148/0x164()
> > > [   76.448582] remove_proc_entry: removing non-empty directory
> > > 'irq/208', leaking at least 'sx8654'
> > 
> > ...
> > 
> > > When I revert commit e4df3a0 (i2c: core: Dispose OF IRQ mapping at
> > > client removal time) I don't get the warning.
> > > 
> > > Is this a bug in the i2c-core or am I doing something wrong in my driver?
> > 
> > Yes, this commit breaks all drivers using devm* for IRQ management on
> > OF-based systemsi because devm* cleanup happens in device code, after
> > bus's remove() method returns. I'd recommend reverting and finding a
> > better way (making cleanup a custom devm action as well?).
> 
> Ouch, my bad.
> 
> Wolfram, any opinion ? The original patch fixes a real bug, so we shouldn't 
> just revert it.

Looking at it some more: What bug does it fix? Anything you experienced?

I wonder if we really need e4df3a0 because I can't see where
platform_get_irq, the major user of of_irq_get, disposes the mapping.
irq_create_of_mapping() will return an already assigned mapping if
called twice. I don't know yet, though, if mappings are static or if a
mapping can be routed to another irq controller over some time because
theoretically they can be dynamically added/removed.

Adding Rob to CC as he wrote of_irq_get and put it into
platform_get_irq. Rob, we use of_irq_get() in the I2C core and the
question is now if we need to dispose the mapping and if so what would
be a good place for it so managed devices will not have their mappings
removed before the managed irq is removed.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150304/dd0ff6fd/attachment-0001.sig>
