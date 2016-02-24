From: wpdster@gmail.com (Patrick Doyle)
Date: Wed, 24 Feb 2016 17:06:03 -0500
Subject: USB_GADGETFS in kernel vs module
Message-ID: <CAF_dkJBmwCjjneqiynEiRyC5UuOzkS=2H=uyawxc4V2whySneA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yes, I know it's archaic, and possibly even obsolete, but I have code
that uses it.

I have a _defconfig file that sets CONFIG_USB_GADGETFS to "y".

If I do the following:

$ cp path/to/my/defconfig .config
$ yes "" | make -k ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- oldconfig

I get a .config file with CONFIG_USB_GADGETFS set to "m".
(This is what buildroot does, which is where I found this.)

Is there any way I can hand-tweak my _defconfig file so that
CONFIG_USB_GADGETFS remains "y"?

If you want to play along at home (with the linux-at91 kernel, if that
makes a difference, which I doubt), you can do the following to see
the problem:

$ echo CONFIG_MODULES=y > .config
$ echo CONFIG_USB_GADGET=y >> .config
$ echo CONFIG_USB_GADGETFS=y >> .config
$ yes "" | make -k ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- oldconfig
...
$ grep CONFIG_USB_GADGET .config
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
# CONFIG_USB_GADGET_XILINX is not set
CONFIG_USB_GADGETFS=m


After some amount of experimentation and bisection, I have learned
that CONFIG_USB_GADGETFS defaults to "m" when CONFIG_MODULES=y,
despite the fact that I set it to "y" in my config file fragment.

Why is that?  Any clues?

Thanks.

--wpd
