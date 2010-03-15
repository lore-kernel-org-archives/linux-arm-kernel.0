From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Mar 2010 10:55:25 +0000
Subject: QUERY: How to handle SOC Configuration (Peripheral
	Multiplexing) in linux
In-Reply-To: <1b68c6791003150334i5f603a48xd363a64e08bf2113@mail.gmail.com>
References: <4B9DB823.1040809@st.com>
	<20100315062041.GD31126@trinity.fluff.org>
	<4B9DD3A3.7050106@st.com> <4B9DF2FF.3000706@st.com>
	<4B9DF966.6050504@st.com>
	<1b68c6791003150237k3d1508d3meb8370509dcfc9a8@mail.gmail.com>
	<4B9E0A65.2090103@st.com>
	<1b68c6791003150334i5f603a48xd363a64e08bf2113@mail.gmail.com>
Message-ID: <20100315105525.GB700@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 07:34:57PM +0900, jassi brar wrote:
> On Mon, Mar 15, 2010 at 7:22 PM, Shiraz HASHIM <shiraz.hashim@st.com> wrote:
> >> usually device makers(that release product versions with same SoC but
> >> different devices)
> >> want a single kernel image that detects the machine type and
> >> accordingly populate the
> >> device support. Managing separate images for similar devices is
> >> considered inefficient.
> >
> > Actually you have pointed to right thing and this is really important.
> > Some architectures (I think ppc) have device tree option to pass the
> > hardware configuration to the kernel from bootloader.
> > I dont know such option exists for arm. Lets hear others' opinions.
> I don't think you can't do without device-trees.

When there are problems in boot loaders, people _always_ want to work
around them in the kernel, because they do not want to fix the boot
loader and risk bricking their board.

We've seen this with the passing of machine IDs, we've seen it with
passing ATAG lists to the kernel - where boot loaders can't even get
the termination of the ATAG list (zero size tag with a NULL id) right.

Since boot loaders can't get this kind of simple stuff right, I'm
absolutely horrified by the idea of passing a much larger structure
from the boot loader to the kernel - the chances of that being correct
are infinitessimally small.

However, there is some work in progress for ARM device tree support,
but it's very slow going and doesn't seem to attract very much support
from within the ARM community.

What we have instead is a system of machine types, which allows the
kernel to select the correct board support file.  The board support
file declares platform devices and other data relevant to the board,
and is responsible for various initialization tasks.  Have a look at
PXA to see how this is done.

For the most part, it works very well, and cuts down on the boot loader
dependencies to _just_ ensuring that it passes a correct machine ID
number, an ATAG list describing the memory layout and kernel command
line.

Until ARM DT support has matured, I suggest following this long
established and well proven approach.
