From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Sep 2013 20:05:46 +0100
Subject: device tree binding documentation outdated
In-Reply-To: <CAHCPf3sC7bY=p4vpBQFpRUmyPspT_PVjx0rH9cm1ov=SqkO+Vg@mail.gmail.com>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <20130926205906.GT12758@n2100.arm.linux.org.uk>
 <CAOMZO5Dj7o3qBH2hzPFWjepgpt5XR5qKmQorKS6jH_7=gnY5cg@mail.gmail.com>
 <20130927121357.GY12758@n2100.arm.linux.org.uk>
 <20130927132601.GL25146@S2101-09.ap.freescale.net>
 <20130927151900.GA12758@n2100.arm.linux.org.uk>
 <CAHCPf3t8=mJn-RCz3C1cY6zqsH9ds8UANKpKx9ZpwPM6WjJt3g@mail.gmail.com>
 <20130927174916.GD12758@n2100.arm.linux.org.uk>
 <CAHCPf3sC7bY=p4vpBQFpRUmyPspT_PVjx0rH9cm1ov=SqkO+Vg@mail.gmail.com>
Message-ID: <20130927190546.GG12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've got good news... finally!

On Fri, Sep 27, 2013 at 01:33:35PM -0500, Matt Sealey wrote:
> On Fri, Sep 27, 2013 at 12:49 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Okay, but from what I'm working from (which works) the order is:
> >
> > - Set IOMUXC GPR1 bit 21.
> 
> Just to clarify: set or clear? It should be clear if the PHY provides
> the clock to the MAC, and set if the MAC provides the clock to the
> PHY. There can be only one, Highlander!

Well, the patch tells me:

+       /* Set GPR1, bit 21 to 1 */
+       mxc_iomux_set_gpr_register(1, 21, 1, 1);

> > - Set ipg/ahb ethernet clock to 50MHz
> 
> Hmm.. this might be a touch low, but it's not the issue here. The way
> I recall this working, the IP has a clock (IPG, AHB as above) and
> there is a MAC clock too which you're generating from DIV_SELECT in
> the ENET_PLL. They don't have to be the same..

Actually, this is the issue.  I now have doubts that the patches which
Rabeeh gave us early-developers correspond with the kernel binary he
rushed to us on Wednesday (he wasn't expecting them to be delivered soo
quickly.)

Rabeeh says in the wiki that his patches should be applied on top of
3.0.35 BSP 4.1.0, and the patches contain this:

+       /* Set enet clock to 50MHz RMII */
+       enet = clk_get_sys("enet.0", NULL);
+       if (IS_ERR(enet))
+               pr_err("Unable to get enet.0 clock\n");
+       else {
+               clk_prepare(enet);
+               clk_set_rate(enet, 50000000);
+               clk_enable(enet);
+       }

As was pointed out earlier, there is no device specific clock named
"enet.0" in BSP 4.1.0, but there is in BSP 4.0.0.  However, Rabeeh's
kernel doesn't complain with "Unable to get enet.0 clock", so I just
assumed that there's something that was missed from the diff which
allows that to work.

The real answer is: don't believe what you see in the patch!  This
will fail on BSP 4.1.0.  Removing my hack to do this in my kernel...
gets the ethernet working at both gigabit and 100mbit speeds!

Now, I'm not going to say that anything with regard to that GPR bit
is correct - but what I have now is something which does indeed work.
I did hang a scope on that signal (my scope probes have small tips
which can get on the solder pads up to the AR8035) and it didn't
show signs of any contention.

At this point, now that I have it working, I'm happy, and I think I'm
going to find some beer to satisfy that "pintctrl-names" mistake :)
