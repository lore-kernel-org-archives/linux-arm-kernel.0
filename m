From: ray-lk@madrabbit.org (Ray Lee)
Date: Mon, 20 Jun 2011 10:10:04 -0700
Subject: [PATCH 00/10] Enhance /dev/mem to allow read/write of arbitrary
	physical addresses
In-Reply-To: <4DFE7FF9.9070406@gmail.com>
References: <201106171038.25988.ptesarik@suse.cz>
	<20110617093032.GA19235@elte.hu> <4DFE7FF9.9070406@gmail.com>
Message-ID: <BANLkTi=kP0LQ4Hx_uA8viA59aDnb1KePyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 19, 2011 at 4:02 PM, Ryan Mallon <rmallon@gmail.com> wrote:
> On 17/06/11 19:30, Ingo Molnar wrote:
>> ?- there's some really horrible out-of-tree drivers that do mmap()s
>> ? ?via /dev/mem, those should be fixed if they want to move beyond
>> ? ?4G: their char device should be mmap()able.
>
> There are drivers where this makes sense. For example an FPGA device with a
> proprietary register layout on the memory bus can be done this way. The FPGA
> can simply be mapped in user-space via /dev/mem and handled there. If the
> device requires no access other than memory bus reads and writes then
> writing a custom char device driver just to get an mmap function seems a bit
> overkill.

While VFIO is still out-of-tree, it handles this use-case, as well as
interrupts and transparent DMA remapping via the IOMMU. I'm using it
on a current project and it works as advertised. UIO is in-tree and
also handles this (as I understand it), but without DMA or interrupt
support.

   https://github.com/pugs/vfio-linux-2.6/blob/vfio/Documentation/vfio.txt

It's perhaps arguable whether any human with taste should ship a
driver based on UIO/VFIO, but for code that exists solely to exercise
and test a hardware design, it works great.

~r.
