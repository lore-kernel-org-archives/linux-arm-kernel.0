From: gkohli@codeaurora.org (Kohli, Gaurav)
Date: Thu, 23 Nov 2017 22:26:07 +0530
Subject: Query : Regarding overwriting of DTB loading region while
 clearing BSS section
In-Reply-To: <20171123141048.hocde5isp6wj7qes@lakrids.cambridge.arm.com>
References: <a61a6216-cd8d-f172-df41-404a4888eb38@codeaurora.org>
 <20171123141048.hocde5isp6wj7qes@lakrids.cambridge.arm.com>
Message-ID: <7c215883-8ae2-67ef-4c6b-a043ef2740bc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for the reply,

Actually, We solved our issue by removing unwanted code from kernel, But 
my request can't we put some check itself
in head.s during clear of BSS region to check whether dtb is intact or 
not. Because ultimately it will fail in start kernel.

At that point(start_kernel),? we can not directly say what is the root 
cause for this overriding.

Regards
Gaurav




On 11/23/2017 7:40 PM, Mark Rutland wrote:
> On Thu, Nov 23, 2017 at 06:44:59PM +0530, Kohli, Gaurav wrote:
>> Hi ,
> Hi,
>
>> While enabling KASLR, I have faced one booting stuck issue due to dtb
>> corruption. I have checked
>>
>> more and in our case, bss stop region has itself crossed the dtb region and So
>> while clearing
> It sounds like your bootloader has placed the DTB too close to the
> kernel, and the DTB overlaps with the (non-allocated) kernel data (e.g.
> BSS).
>
> You can avoid this by reading the image_size field from the kernel Image
> header, and placing the DTB at least this many bytes away from the start
> of the Image. That way, it is guaranteed that it will not clash with the
> BSS section (or any other regions excluded from the Image binary).
>
> Note that this is from the start of the Image. For example, if the
> kernel was loaded at 0x80000, and image_size was 0x800000, the first
> address that is safe to use would be 0x880000.
>
> See Documentation/arm64/booting.txt for more details.
>
> If you are using a kernel older than v3.17, there is no way to reliably
> determine how much space needs to be reserved.
>
> Thanks,
> Mark.

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
