From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 12 Jul 2013 10:59:03 +0200
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <51DE58DF.5010304@keymile.com>
References: <51DD88A4.1030506@keymile.com> <20130710185706.72b124a4@skate>
 <51DD9A8C.10608@keymile.com> <51DE58DF.5010304@keymile.com>
Message-ID: <20130712105903.6336e912@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Valentin Longchamp,

On Thu, 11 Jul 2013 09:03:59 +0200, Valentin Longchamp wrote:

> On the board you are currently using for your tests, it is the case (the whole
> map is not used ... things are scattered over the 256 MB, with one 128MB BAR).
> If you want to get rid of this problem, we have another board that does not
> require these (256 MB .. and I have one of them on my desk that you can use for
> your tests).
> 
> On the kirkwood variant we use, there is only _one_ real PCIe controller. In
> order to map 256MB for the MEM space of this controller without having further
> memory map conflicts, what was done was to not enable the CPU windows for the
> usual 2nd PCIe controller and set a wider CPU window for the MEM space of the
> only PCIe controller.

Such tricks are no longer needed with the new PCIe driver. Instead of
assigning address ranges per PCIe controller, the new PCIe driver
(together with the mvebu-mbus driver) allows to specify one global
range of addresses for PCIe mem, and the PCIe driver will automatically
figure out which devices are available on which PCIe bus, how much PCIe
mem then need, and create the MBus windows accordingly.

However of course, as I pointed out in an earlier e-mail, this global
range must be suitably sized to allow the mapping of all PCIe devices.
By default, we've made it 128 MB large, but in this case, it looks like
you would need 256 MB.

But there's no need to disable the second PCIe controller anymore. If
there's nothing connected to it, not PCIe window will be created for it.

> > - we need a virtual PCIe device to connect to the internal switch, which 
> > must be mapped at 0xf4000000 (normally used for the NAND which must then 
> > move to 0xff000000)
> > 
> 
> I think you can forget this for the time being. This is called (also in
> Marvell's doc) a virtual PCIe controller, but apart that it is then memory
> mapped, this has nothing to do with PCIe (although I don't know what is done
> internally in the SoC). It is a problem because the physical address chosen for
> this CPU window conflicts with the one that is used for the NAND controller in
> the current kirkwood Linux memory map. But this is another topic and it should
> not play any role in this PCIe topic.

I'm not sure to follow this story of a virtual PCIe controller sitting
at 0xf4000000. Can you give a few more details?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
