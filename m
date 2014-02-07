From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 7 Feb 2014 12:57:21 +0100
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <20140207094656.GY26684@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypo6-0007FF-Lb@rmk-PC.arm.linux.org.uk>
 <CAKMK7uFYhz8Pmv5E7aKY7yzZGDe_m8a0382Njv7tZRoBSfmRpw@mail.gmail.com>
 <20140207094656.GY26684@n2100.arm.linux.org.uk>
Message-ID: <20140207125721.2d925387@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Feb 2014 09:46:56 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Fri, Feb 07, 2014 at 10:04:30AM +0100, Daniel Vetter wrote:
> > I've chatted a bit with Hans Verkuil about this topic at fosdem and
> > apparently both v4l and alsa have something like this already in their
> > helper libraries. Adding more people as fyi in case they want to
> > switch to the new driver core stuff from Russell.  
> 
> It's not ALSA, but ASoC which has this.  Mark is already aware of this
> and will be looking at it from an ASoC perspective.

Russell,

I started to use your code (which works fine, thanks), and it avoids a
lot of problems, especially, about probe_defer in a DT context.

I was wondering if your componentised mechanism could be extended to the
devices defined by DT.

In the DT, when a device_node is a phandle, this means it is referenced
by some other device(s), and these device(s) will not start until the
phandle device is registered.

Then, the idea is to do a component_add() for such phandle devices in
device_add() (device_register).

Pratically,

- the component_add() call in device_register would not include any
  bind/unbind callback function, so, this should be tested in
  component_bind/unbind(),

- component_add would not be called if the device being added already
  called component_add in its probe function. A simple flag in the
  struct device_node should solve this problem.

What do you think about this?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
