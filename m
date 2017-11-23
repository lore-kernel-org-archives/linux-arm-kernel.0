From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Nov 2017 18:21:32 +0000
Subject: Query : Regarding overwriting of DTB loading region while
 clearing BSS section
In-Reply-To: <7c215883-8ae2-67ef-4c6b-a043ef2740bc@codeaurora.org>
References: <a61a6216-cd8d-f172-df41-404a4888eb38@codeaurora.org>
 <20171123141048.hocde5isp6wj7qes@lakrids.cambridge.arm.com>
 <7c215883-8ae2-67ef-4c6b-a043ef2740bc@codeaurora.org>
Message-ID: <20171123182132.mhk5dxnj4n47igo5@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 10:26:07PM +0530, Kohli, Gaurav wrote:
> Hi Mark,
> 
> Thanks for the reply,
> 
> Actually, We solved our issue by removing unwanted code from kernel,

I would very strongly recommend that you update your bootladoer/firmware
to respect image_size, since any numbero f things may increase the size
of the kernel in future.

i.e. trimmign the kernel down is a workaround, but not a fix.

> But my request can't we put some check itself in head.s during clear
> of BSS region to check whether dtb is intact or not.  Because
> ultimately it will fail in start kernel.
> At that point(start_kernel),? we can not directly say what is the root cause
> for this overriding.

Perhaps we could add a check in setup_arch(). If the DTB pointer
overlaps any part of the kerenl (BSS included), the bootloader is
clearly broken.

Even then, it's going to be a slient panic(), since we won't be able to
parse anything out of the DTB...

Thanks,
Mark.
