From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 31 Jan 2011 17:27:20 -0500 (EST)
Subject: [PATCH v2 4/6] arm/dt: probe for platforms via the device tree
In-Reply-To: <20110131210410.15105.63595.stgit@localhost6.localdomain6>
References: <20110131203626.15105.64302.stgit@localhost6.localdomain6>
	<20110131210410.15105.63595.stgit@localhost6.localdomain6>
Message-ID: <alpine.LFD.2.00.1101311709280.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 31 Jan 2011, Grant Likely wrote:

> If a dtb is passed to the kernel then the kernel needs to iterate
> through compiled-in mdescs looking for one that matches and move the
> dtb data to a safe location before it gets accidentally overwritten by
> the kernel.
> 
> This patch creates a new function, setup_machine_fdt() which is
> analogous to the setup_machine_atags() created in the previous patch.
> It does all the early setup needed to use a device tree machine
> description.  It also creates arm_unflatten_device_tree() which copies
> the dtb into an allocated buffer and unflattens it into the live-tree
> representation.
> 
> v2: Changed to save the dtb by copying into an allocated buffer.
>     - Since the dtb will very likely be passed in the first 16k of ram
>       where the interrupt vectors live, memblock_reserve() is
>       insufficient to protect the dtb data.

This is wrong.  The vector page can be allocated anywhere.  It is 
currently allocated with memblock_alloc(), so if you memblock_reserve() 
the dtb soon enough then it should be safe and the vector page or 
whatever will be allocated somewhere else.

What was the actual problem?


Nicolas
