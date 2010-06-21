From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 21 Jun 2010 16:23:22 +0800
Subject: [PATCH 1/2] [ARM] Introduce 'struct machine_class' for SoC level
	abstraction
In-Reply-To: <201006211527.49786.jeremy.kerr@canonical.com>
References: <1277042450-30382-1-git-send-email-eric.miao@canonical.com>
	<201006211527.49786.jeremy.kerr@canonical.com>
Message-ID: <AANLkTilUddhIW0C5LN4b7igh6vEDvelhnT8a3or677Zk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 3:27 PM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
> Hi Eric,
>
>> For machine class (mostly equivalent to SoC) level abstraction.
>
> Could you detail your intended usage of machine_class and how this will fit in
> with the mdesc? Will the mdesc fields override the machine_class fields, or is
> this intended to be a replacement?
>

Good question, I've missed that part in the commit message. So my idea
is to have machine_class fields to replace machine_desc completely in
the end, but the situation is we need a smooth transition:

1. so for newly added machines with machine_class pointer, the fields in
machine_class will dominate (ignoring the fields in machine_desc)

2. for legacy machine_desc (apparently without machine_class pointer),
the fields within will be used, and these machines are not affected

So my intention of machine_class is really a class of machines, instead of
the class concept in C++. There might be useful situations for derivative,
E.g. some PXA machines have their specific map_io, mainstone:

static struct map_desc mainstone_io_desc[] __initdata = {
  	{	/* CPLD */
		.virtual	=  MST_FPGA_VIRT,
		.pfn		= __phys_to_pfn(MST_FPGA_PHYS),
		.length		= 0x00100000,
		.type		= MT_DEVICE
	}
};

static void __init mainstone_map_io(void)
{
	pxa_map_io();
	iotable_init(mainstone_io_desc, ARRAY_SIZE(mainstone_io_desc));
}

So that from derivative POV, it can be expressed as:

	if (mdesc->class && mdesc->class->map_io)
		mdesc->class->map_io();
	if (mdesc->map_io())
		mdesc->map_io();

But this seems to make things a bit over complicated, so for such cases
I'd prefer:

1. have a separate machine_class for mainstone
2. or move the board specific map_io() separatedly
