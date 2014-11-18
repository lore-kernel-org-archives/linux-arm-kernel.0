From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 18 Nov 2014 11:41:03 +0000
Subject: [PATCHv5 4/7] arm64: Move some head.text functions to executable
 section
In-Reply-To: <1416272105-14787-5-git-send-email-lauraa@codeaurora.org>
References: <1416272105-14787-1-git-send-email-lauraa@codeaurora.org>
 <1416272105-14787-5-git-send-email-lauraa@codeaurora.org>
Message-ID: <20141118114103.GB14323@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Tue, Nov 18, 2014 at 12:55:02AM +0000, Laura Abbott wrote:
> The head.text section is intended to be run at early bootup
> before any of the regular kernel mappings have been setup.
> Parts of head.text may be freed back into the buddy allocator
> due to TEXT_OFFSET so for security requirements this memory
> must not be executable. The suspend/resume/hotplug code path
> requires some of these head.S functions to run however which
> means they need to be executable. Support these conflicting
> requirements by moving the few head.text functions that need
> to be executable to the text section which has the appropriate
> page table permissions.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
> v5: Went back to the v3 version which moved everything around instead
> of adding annotations. Dropped the code duplication for head.text.
> ---
>  arch/arm64/kernel/head.S        | 406 +++++++++++++++++++++-------------------
>  arch/arm64/kernel/vmlinux.lds.S |   1 +
>  2 files changed, 210 insertions(+), 197 deletions(-)

[...]

> +/*
> + * end 'true' head section, begin head section that can be read only
> + */
> +       .section ".latehead.text","ax"

Is there any reason we can't place the remainder into .text directly?

Everything after the section change is used repeatedly for hotplug and
idle, so the "latehead" distinction is a little misleading.

Given adrp and b/bl, we can jump at least +/-128MB without problems, so
we should be ok even if this code gets emitted late in the kernel image.

Other than that, this looks fine to me.

Thanks,
Mark.
