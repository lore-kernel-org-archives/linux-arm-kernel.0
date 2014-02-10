From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 10 Feb 2014 15:35:51 +0100
Subject: [PATCH v3 1/2] drivers/base: permit base components to omit the
 bind/unbind ops
In-Reply-To: <20140210131233.GT26684@n2100.arm.linux.org.uk>
References: <cover.1391792986.git.moinejf@free.fr>
 <9b3c3c2c982f31b026fd1516a2b608026d55b1e9.1391792986.git.moinejf@free.fr>
 <20140210125307.GG20143@ulmo.nvidia.com>
 <20140210131233.GT26684@n2100.arm.linux.org.uk>
Message-ID: <20140210153551.1309f017@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Feb 2014 13:12:33 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> I've NAK'd these patches already - I believe they're based on a
> mis-understanding of how this should be used.  I believe Jean-Francois
> has only looked at the core, rather than looking at the imx-drm example
> it was posted with in an attempt to understand it.
> 
> Omitting the component bind operations is absurd because it makes the
> component code completely pointless, since there is then no way to
> control the sequencing of driver initialisation - something which is
> one of the primary reasons for this code existing in the first place.

I perfectly looked at your example and I use it now in my system.

You did not see what could be done with your component code. For
example, since november, I have not yet the clock probe_defer in the
mainline (http://www.spinics.net/lists/arm-kernel/msg306072.html), so,
there are 3 solutions:

- hope the patch will be some day in the mainline and, today, reboot
  when the system does not start correctly,

- insert a delay in the tda998x and kirkwood probe sequences (delay
  long enough to be sure the si5351 is started, or loop),

- use your component work.

In the last case, it is easy:

- the si5351 driver calls component_add (with empty ops: it has no
  interest in the bind/unbind functions) when it is fully started (i.e.
  registered - that was the subject of my patch),

- in the DRM driver, look for the si5351 as a clock in the DT (drm ->
  encoder -> clock), and add it to the awaited components (CRTCs,
  encoders..),

- in the audio subsystem, look for the si5351 as an external clock in
  the DT (simple-card -> CPU DAI -> clock) and add it to the awaited
  components (CPU and CODEC DAIs - yes, the S/PDIF CODEC should also be
  a component with no bin/unbind ops).

Then, when the si5351 is registered, both master components video and
audio can safely run.


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
