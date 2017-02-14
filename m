From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Feb 2017 18:13:16 +0000
Subject: Question about PTE_CONT in linux_4.10
In-Reply-To: <B99C36949BCC8541A564076B659DD9706714ED6D@nkgeml514-mbx.china.huawei.com>
References: <B99C36949BCC8541A564076B659DD9706714ED6D@nkgeml514-mbx.china.huawei.com>
Message-ID: <20170214181315.GM23718@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 08:04:03AM +0000, Wangxuefeng (E) wrote:
> Hi Jeremy,
> 
> I has a question about change access permission(X-executable) in
> linux_4.10 when continuous bit enable.
> In linux_4.10, the memories allocated by kmalloc are always set
> PTE_PXN and PTE_CONT. When I need change the access permission
> of the kmalloc area to make it has executable permission(clear
> PXN), what interface can I use?

Why do you wish to make a portion of this executable?

There is no interface for changing the linear map (i.e. the kmalloc
area) in this way because it cannot be implemented safely without
tremendous expense.

> The set_memory_x only change the PTE_PXN, but it doesn't change
> continuous bit. If only a 4K page change the permission, TLB
> conflict will happen.

As Ard said, set_memory_x() should return -EINVAL if it's used for
anything without a vm_area, so it should reject attempts to change the
linear map.

Is that not working correctly, or has thatcode been modified?

> Is there any other interface can change the permission?

It is unsafe to change the permissions of the linear map since this may
require splitting and/or merging of block entries (or regions where the
contiguous bit is set). This requires a Break-Before-Make approach,
which we cannot use while data mapped by those tables are in active use.

We take great pains at boot time [1] to avoid this, and we can't do
similarly at run time as it would involve parking all secondary CPUs in
idmap'd code.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401434.html
