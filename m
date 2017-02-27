From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Feb 2017 08:48:09 +0000
Subject: [PATCH RFC] arm64/mm: handle memmap kernel option
In-Reply-To: <ab8d4b0a-dfe5-629f-5ead-3c7e907509fa@huawei.com>
References: <1488005245-54811-1-git-send-email-xieyisheng1@huawei.com>
 <CAKv+Gu9j_4kSVAPrddsdcDiW+MWMTweHPe9bthf4=n4jLt2NZw@mail.gmail.com>
 <ab8d4b0a-dfe5-629f-5ead-3c7e907509fa@huawei.com>
Message-ID: <20170227084808.GA31271@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 27, 2017 at 11:48:50AM +0800, Yisheng Xie wrote:
> On 2017/2/26 18:46, Ard Biesheuvel wrote:
> > On 25 February 2017 at 06:47, Yisheng Xie <xieyisheng1@huawei.com> wrote:

> >> To make user reserve memory for some specific use more convenient,
> >> this patch implement the following memmap variants:
> >>  - memmap=nn[KMG]$ss[KMG]: mark specified memory as reserved;
> >>  - memmap=nn[KMG]@ss[KMG]: force usage of a specific region of memory;

> > Could you explain which problem you are solving here? ACPI implies
> > UEFI on arm64, and so these reservations could be made by a boot
> > component instead, if it requires a fixed memory reservation. If this
> > is a reservation for, e.g., OP-TEE, we should not rely on the command
> > line to communicate this information.
> > 
> We just want to reserve some memory for a driver and I just not so familiar
> with how to reserve memory with UEFI. So doubt about whether it is suitable
> to reserve memory with cmdline like "memmap=xxx", which had appeared in x86
> for a long time.

Could you please explain for what purpose this is necessary?

Does the driver need a specific region of memory? Or just some contiguous
region? Or something else?

For the former, this is not an appropriate solution; firmware must absolutely
mark the memory as reserved for a particular purpose.

If you just need contiguous physical memory, I believe it would be better to
use CMA, and request CMA reserve a larger area if necessary.

Thanks,
Mark.
