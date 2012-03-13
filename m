From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Mon, 12 Mar 2012 22:13:41 -0400
Subject: ARM926EJS boot failure on v3.3, __iounmap
In-Reply-To: <20120313020734.GE5050@titan.lakedaemon.net>
References: <CAKON4OzL9HtF+3bxzC9zexd7QgAFd5R7Wr=QTShYR+Kk1b4L+g@mail.gmail.com>
 <CAKON4OyURmGP79oJaCkAw1dx3orynZDZSqZOC_t=PTKwHWaRJQ@mail.gmail.com>
 <20120313020734.GE5050@titan.lakedaemon.net>
Message-ID: <CAKON4OzvF-MgEV2AabZ3gWeC+-7T8GpGMMTLpSba6_OERCAyvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 10:07 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Mon, Mar 12, 2012 at 07:31:58PM -0400, jonsmirl at gmail.com wrote:
>> The answer to this is that as of v3.3 you can't have overlapping IO
>> regions. The code I was porting has a large define covering peripheral
>> space and then many smaller ones inside the region, one for each
>> device. I needed to delete the defines for those inner devices.
>
> I got bit by this last week with the dreamplug (kirkwood), I worked
> around it by disabling CONFIG_ARM_PATCH_PHYS_VIRT. ?Could you elaborate
> on your solution so I can work towards a real fix on
> plat-orion/mach-kirkwood?

Somewhere you are allocating an array of map_desc. These regions can't
overlap anymore.

static struct map_desc lpc313x_io_desc[] __initdata = {
	{
		.virtual	= io_p2v(IO_INTC_PHYS),
		.pfn		= __phys_to_pfn(IO_INTC_PHYS),
		.length		= IO_INTC_SIZE,
		.type		= MT_DEVICE
	},
	{
		.virtual	= io_p2v(IO_APB01_PHYS),
		.pfn		= __phys_to_pfn(IO_APB01_PHYS),
		.length		= IO_APB01_SIZE,
		.type		= MT_DEVICE
	},
....



>
> Thanks,
>
> Jason.



-- 
Jon Smirl
jonsmirl at gmail.com
