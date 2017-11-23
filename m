From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Nov 2017 14:10:49 +0000
Subject: Query : Regarding overwriting of DTB loading region while
 clearing BSS section
In-Reply-To: <a61a6216-cd8d-f172-df41-404a4888eb38@codeaurora.org>
References: <a61a6216-cd8d-f172-df41-404a4888eb38@codeaurora.org>
Message-ID: <20171123141048.hocde5isp6wj7qes@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 06:44:59PM +0530, Kohli, Gaurav wrote:
> Hi ,

Hi,

> While enabling KASLR, I have faced one booting stuck issue due to dtb
> corruption. I have checked
> 
> more and in our case, bss stop region has itself crossed the dtb region and So
> while clearing

It sounds like your bootloader has placed the DTB too close to the
kernel, and the DTB overlaps with the (non-allocated) kernel data (e.g.
BSS).

You can avoid this by reading the image_size field from the kernel Image
header, and placing the DTB at least this many bytes away from the start
of the Image. That way, it is guaranteed that it will not clash with the
BSS section (or any other regions excluded from the Image binary).

Note that this is from the start of the Image. For example, if the
kernel was loaded at 0x80000, and image_size was 0x800000, the first
address that is safe to use would be 0x880000.

See Documentation/arm64/booting.txt for more details.

If you are using a kernel older than v3.17, there is no way to reliably
determine how much space needs to be reserved.

Thanks,
Mark.
