From: olof@lixom.net (Olof Johansson)
Date: Sun, 6 Jul 2014 17:51:45 -0700
Subject: [PATCH] ARM: integrator: fix OF-related regression
In-Reply-To: <CACRpkdbr05q4iNG00eX1e1ZWKHEmGZ5exGHR9WRPuyFzrs6Tkg@mail.gmail.com>
References: <1403611687-23512-1-git-send-email-linus.walleij@linaro.org>
 <CAL_Jsq+Us51c-6+kP5Y+aML-HPV-=9SooPepD6u13xyrvDfcKw@mail.gmail.com>
 <CACRpkdZr6T65zOmxy9mQdeapMfu=nwfcXRtufb5DU5NO+vwU7A@mail.gmail.com>
 <20140626193938.GA16226@debian>
 <CACRpkdbr05q4iNG00eX1e1ZWKHEmGZ5exGHR9WRPuyFzrs6Tkg@mail.gmail.com>
Message-ID: <20140707005145.GH8469@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 06:52:58PM +0200, Linus Walleij wrote:
> On Thu, Jun 26, 2014 at 9:39 PM, Rabin Vincent <rabin@rab.in> wrote:
> 
> > earlyprintk doesn't work on Integrator hardware?
> 
> It does, but loading the kernel is done over serial line 115200 bps
> so iterative tests take "some time" :-)
> 
> > It does on QEMU's
> > integratorcp so it's trivial to debug there.
> 
> Yeah I should be using QEMU for things like this ... poke self.
> 
> > The problem is that integrator_init_sysfs() adds a device attribute
> > called "fpga" to the soc0 bus, and the soc0 bus device is also used as
> > the root of the device tree, and the device tree has a node called "fpga".
> (...)
> > 07e461cd7e73a84f0e3757932b93cc80976fd749 removed the .0 from the fpga node's
> > directory, leading to that node (and its subnodes) failing to register due to a
> > filename conflict with the fpga attribute's file:
> 
> Aha! Thanks for root-causing this Rabin. Awesome.
> 
> > After Linus' patch, the root is no longer soc0 so the fpga node's directory
> > becomes /devices/fpga while the attribute file remains at /devices/soc0/fpga.
> 
> It appears the patch is doing the right thing, though I had very vague
> ideas as to why.

Ok, sounds like this is good to go. I'll apply it to the fixes branch, we can
fairly easily take it out right now if it needs to bake more so please speak up
quickly if that is the case.


-Olof
