From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 30 Jun 2014 11:03:10 -0700
Subject: [PATCH 2/2] arm: Add back maximum bank limit
In-Reply-To: <20140630104350.600EDC40F52@trevor.secretlab.ca>
References: <1404068784-27604-1-git-send-email-lauraa@codeaurora.org>	<1404068784-27604-2-git-send-email-lauraa@codeaurora.org>
 <20140630104350.600EDC40F52@trevor.secretlab.ca>
Message-ID: <53B1A65E.6050806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/30/2014 3:43 AM, Grant Likely wrote:
> 
> Instead of splitting early_init_dt_scan(), the call to
> early_init_dt_scan() could probably be moved after the
> of_flat_dt_match_machine() call. It's at least worth a try. Looking at
> the code I don't see anything obvious that requires the
> early_init_dt_scan() code to run first.
>

of_flat_dt_match_machine -> of_flat_dt_match which uses
initial_boot_params which isn't set until early_init_dt_scan. I had the
same thought about just rearranging but we still need something to be
set before doing the scan, hence the split.
 
> Once you've got the mdesc pointer, you've could set the limit before
> doing the full scan. Or, better yet because this is a fix for broken
> data, you could call a dt_fixup hook on the mdesc. Then exynos is the
> only platform that needs special treatment. The best thing for exynos to
> do is fix the buggy data by clearing the bogus entries. Then there's no
> need to reintroduce early_init_dt_add_memory_arch() for ARM.
> 

The fixup hook does sound better. The flow would become

setup_machine_fdt
	- early_init_dt_verify
	- of_flat_dt_match_machine
	- mdesc->dt_fixup
	- early_init_dt_scan_all

I notice that powerpc already has a DT fixup infrastructure but I don't see
any such thing for ARM. How much of that do you think could and should be
leveraged for ARM?

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
