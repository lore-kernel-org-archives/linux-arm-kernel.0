From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Feb 2014 10:15:30 -0500
Subject: Stuck getting DTS working for a new kirkwood board
In-Reply-To: <5307029C.20006@sigpipe.me>
References: <5306721B.7020403@sigpipe.me>
 <20140221013407.GX7862@titan.lakedaemon.net>
 <5307029C.20006@sigpipe.me>
Message-ID: <20140221151530.GZ7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 08:39:08AM +0100, Dashie wrote:
> On 02/21/2014 02:34 AM, Jason Cooper wrote:
> > On Thu, Feb 20, 2014 at 10:22:35PM +0100, Dashie wrote:
> >> I've done some tests using mainlineLinux and arcNumber and i remember to
> >> got some things working (PCI-e, Intel eth) but only two drives and no
> >> fan/sensor using arcNumber for "00000b1e    HP t5325 Thin Client       
> >>                         2846".
> >>
> > Let's focus on converting this board file to devicetree.  which means
> > you'll be setting mainlineLinux to true and arcNumber to 0xffffffff.
> > (means booting via devicetree).
> >
> Actually i've unset mainlineLinux and arcNumber, so the DTB is used.
> In fact the t5325 device is the only one which the pci-e works, but it
> use old -setup.c files and then i'm lost with that.
> 
> >
> >> I've since started to use a DTS, copied the guruplug-server-plus (IIRC)
> >> and done some changes, actually i can get working :
> >>     - temp sensor
> >>     - fan control (off, middle, full)
> >>     - integrated marvell eth
> >>     - the four disks are detected and seems working
> > That's a good start.
> >
> >> But can't get the PCI-e working (and then the intel ethernet), also
> >> sensor path seems to change every reboot (i need to do more tests).
> >> Also i've SATA power reg enabled in the DTS but it doesn't seems to have
> >> any (to be confirmed, the original firmware seems to have the ability to
> >> shutdown unaccessed drives) and i will remove them, anyway i don't know
> >> the GPIO, if any.
> >>
> >> I still miss some GPIOS for : Led (r/g) power, func led, the four sata
> >> leds, maybe some triggers for hdds, and the power and func buttons.
> >> (already tried gpio export and out direction and "1" in value, but
> >> nothing blink)
> >> Reset button sends things in /dev/input/input0 so it seems to works.
> >>
> >> The current DTS is joined to this mail, i've actually the NAS with me
> >> and can test things. I can provide too : original dmesg (from original
> >> firmware), current dmesg using DTS, lspci -vvv (from kernel with arcNumber).
> >>
> >> I'm currently using a stock 3.12.9 debian kernel and doesn't have
> >> anymore access to the original firmware.
> >>
> > It would be helpful if you could build a kernel from the git repos.
> > Have you done that before?
> >
> I've built a kernel from the 3.12.9 debian sources but can't get it to
> boot, i got nothing after "Uncompressing Linux... done, booting the
> kernel.".

Check that you have 'earlyprintk' in your commandline, and that you set

Kernel hacking
  -> Kernel low-level debugging functions
  -> Kernel low-level debugging port (Kernel low-level debugging via 8250 UART)
  -> (0xf1012000) Physical base address of debug UART
  -> (0xfde12000) Virtual base address of debug UART
  -> (2) Register offset shift for the 8250 debug UART
  -> Early printk

Also make sure you have set 'console=ttyS0,115200n8' on the commandline
as well.

> I've used the debian's kernel config file, but i can try the
> kirkwood_defconfig make target and checking everything is activated (DTB
> append, SATA PMP, etc.)
> Which git repos i could try to build then ?

We'll have you work with two repos.  Linus' mainline repo:

$ cd
$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
$ cd linux
$ git config --add user.name "first and last"
$ git config --add user.email "dashie at sigpipe.me"

And we'll add our repo as another remote:

$ git remote add mvebu git://git.infradead.org/linux-mvebu.git
$ git remote update --prune mvebu

First you should try v3.14-rc1

$ git checkout -b t5325 v3.14-rc1

Now, add your dts file and commit the result.  Build, boot, report back.

I wold also do kirkwood_defconfig with the above that I mentioned.

hth,

Jason.
