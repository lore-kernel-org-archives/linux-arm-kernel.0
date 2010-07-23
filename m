From: jason.mcmullan@netronome.com (Jason McMullan)
Date: Fri, 23 Jul 2010 15:59:29 -0400
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <61396.213.84.91.226.1279910330.squirrel@protonic.xs4all.nl>
References: <201007211029.29529.david.jander@protonic.nl>
	<201007221531.58744.david.jander@protonic.nl>
	<20100722142043.GK4737@rakim.wolfsonmicro.main>
	<201007231218.07379.david.jander@protonic.nl>
	<20100723141712.GC12300@rakim.wolfsonmicro.main>
	<61396.213.84.91.226.1279910330.squirrel@protonic.xs4all.nl>
Message-ID: <AANLkTikpD9MTdJ0K3F43QS5eH450rw=eGE+5agubBNVi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 23, 2010 at 2:38 PM, <david@protonic.nl> wrote:
>
> This has been an interesting discussion, but I don't want to upset any
> more people here. I just want to ask one more question, being new to
> ARM-linux: What setup should I chose for our products then? What would be
> more in tune with the most desireable long-term goal of ARM-linux booting?
>
> 1. u-boot doing all pad/IO setup and loading linux.
> 2. u-boot just loading linux and doing only the minimum IO-setup necessary
> for that job, and write a linux BSP that does ALL IO-init
> 3. Don't use u-boot at all, and investigate Magnus's Kexec technique?
> 4. Something else?
>
>
Option (1) is the best bet for a *production* device (your scenario).

For me (as a SoC company BSP engineer, trying to make a zillion
disparate customers all happy) I use option (4):

  a) A minimial (<16k) boot block, that reads a config out of flash, and
runs...
  b) A small DDR (and other devices) init routine (<32k) out of flash, and
then...
  c) Linux

(a) Doesn't set up *anything* other than the serial UART. It is primarily
    for reading the config, and performing the load order from flash as
    requested by the config.
(b) Contains all the 'real' chip/pad/board initialization, that would be
    per-production board specific.
(c) Doesn't need to set up pads/pins, assumes (b) took care of it.

So, this is kinda like option (1), except that we use our own minimal loader
and board setup instead of U-Boot.  The source code for (a) and (b) are
provided
as examples to our customers.

-- 
Jason S. McMullan
Netronome Systems, Inc.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100723/d8f81dc7/attachment-0001.html>
