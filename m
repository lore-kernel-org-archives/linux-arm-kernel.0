From: dkeitel@codeaurora.org (David Keitel)
Date: Fri, 17 Apr 2015 11:39:56 -0700
Subject: [PATCH 2/2] arm64: add KASan support
In-Reply-To: <552EA835.5070704@samsung.com>
References: <1427208544-8232-1-git-send-email-a.ryabinin@samsung.com>
 <1427208544-8232-3-git-send-email-a.ryabinin@samsung.com>
 <20150401122843.GA28616@e104818-lin.cambridge.arm.com>
 <551E993E.5060801@samsung.com> <552DCED9.40207@codeaurora.org>
 <552EA835.5070704@samsung.com>
Message-ID: <5531537C.1000107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2015 11:04 AM, Andrey Ryabinin wrote:
> I've pushed the most fresh thing that I have in git:
> 	git://github.com/aryabinin/linux.git kasan/arm64v1
> 
> It's the same patches with two simple but important fixes on top of it.

Thanks, the two commits do fix compilation issues that I've had worked around to get to my mapping question.

I've addressed the mapping problem using __create_page_tables in arch/arm64/head.S as an example.

The next roadblock I hit was running into kasan_report_error calls in cgroups_early_init. After a short investigation it does seem to be a false positive due the the kasan_zero_page size and tracking bytes being reused for different memory regions.

I worked around that by enabling kasan error reporting only after the kasan_init is run. This let me get to the shell with some real KAsan reports along the way. There were some other fixes and hacks to get there. I'll backtrack to evaluate which ones warrant an RFC.

 - David

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
