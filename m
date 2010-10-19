From: simon@sequanux.org (Simon Guinot)
Date: Tue, 19 Oct 2010 11:46:36 +0000
Subject: [PATCH 1/2] hwmon: add generic GPIO fan driver
In-Reply-To: <20101018205034.GA10473@ericsson.com>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com>
	<20101018203610.GD29120@kw.sim.vm.gnt>
	<20101018205034.GA10473@ericsson.com>
Message-ID: <20101019114636.GF29120@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Mon, Oct 18, 2010 at 01:50:34PM -0700, Guenter Roeck wrote:
> On Mon, Oct 18, 2010 at 04:36:10PM -0400, Simon Guinot wrote:
> [ ... ]
> 
> > > I don't really understand the value of supporting pwm attributes,
> > > since you have to convert those to rpm anyway. Why not just stick
> > > with fan1_input and fan1_target ? This would simplify the code a lot.
> > 
> > I don't know very well the hwmon API. I have simply been fooled by the
> > sysfs-interface document which claim that fan[1-*]_target only make
> > sense for a closed-loop fan. Moreover, I was expecting gpio-fan to be
> > compliant with the fancontrol shell script...
> > 
> > But anyway, you are right. I just don't want the pwm interface.
> > 
> If the fancontrol script doesn't support fanX_target, and a given fan 
> doesn't support pwm, it might make sense to update it. 
> 
> Jean, any comments ?
> 
> > > > +
> > > > +err_free_gpio:
> > > > +       for (i = i - 1; i >= 0; i--)
> > > > +               gpio_free(ctrl[i]);
> > > > +
> > > This misses the most recently allocated gpio pin if gpio_direction_output() failed.
> > 
> > The gpio is freed above while handling the gpio_direction_output() error.
> > 
> I missed that. Thatks for the clarification.
> 
> > > > +
> > > > +       dev_info(&pdev->dev, "GPIO fan initialized\n");
> > > > +
> > > Might be a good idea to add a notion of which fan was initialized.
> > > After all, there could be more than one.
> > 
> > dev_info() don't do it for me ? anyway, I will check this too.
> > 
> It probably does. Wonder what it actually shows. Can you check ?

If CONFIG_PRINTK is enabled, dev_info() end up in a dev_printk() call
with the level argument set to KERN_INFO.
The message format is:
${driver_name} ${device_name}: ${message}

Note that the device id number is part of the device name. So, if two
gpio-fan devices are initialized, you will see:

gpio-fan gpio-fan.0: GPIO fan initialized
gpio-fan gpio-fan.1: GPIO fan initialized

For a single fan device, you will see:

gpio-fan gpio-fan: GPIO fan initialized

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101019/00391386/attachment-0001.sig>
