From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jan 2011 15:51:47 +0100
Subject: [PATCH V2] ST SPEAr: PCIE gadget suppport
In-Reply-To: <4D2AEB84.6060804@st.com>
References: <137dfad4a093ea0ac80396f5eb7fbf0c382be698.1294314772.git.viresh.kumar@st.com>
	<201101072332.16985.arnd@arndb.de> <4D2AEB84.6060804@st.com>
Message-ID: <201101181551.47675.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 January 2011, pratyush wrote:

> >> +/*wait till link is up*/
> >> +# cat sys/devices/platform/pcie-gadget-spear.0/link
> >> +wait till it returns UP.
> > 
> > A blocking sysfs read is not a nice interface. This is probably where
> > the sysfs abstraction for your hardware stops making sense.
> > 
> 
> This call is not blocking. User will have to recheck link status till he
> finds it UP. He may put some delay between two successive read. I will
> modify documentation to be more explicit.

Ok, that is better, although with this interface you could argue that having
a blocking interface (not a sysfs file) would be useful to have.

> > The user interface for the interrupts looks to me like it should really
> > be based around a character device and either read/write/poll or
> > ioctl and poll. Using an eventfd might be cool here, because  then you
> > can combine this with other devices by passing the event file to
> > an interface that operates on eventfd. This would e.g. make it possible
> > to combine a UIO device generating interrupts with a PCIe gadget
> > sending the interrupts somewhere else, without leaving kernel
> > space.
> > 
> 
> I do not have much idea about eventfd mechanism. But if we decide to
> split it in two layers (generic pcie gadget and HW specific) then I
> might try to do it in this way.
 
ok.

	Arnd
