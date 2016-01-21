From: shijie.huang@arm.com (Huang Shijie)
Date: Thu, 21 Jan 2016 10:04:11 +0800
Subject: [PATCH] iommu/arm-smmu: add a shortcut when the @dev_node is NULL
In-Reply-To: <569F9DCA.3030808@arm.com>
References: <1452564905-2662-1-git-send-email-shijie.huang@arm.com>
 <20160120120225.GD18805@8bytes.org>
 <20160120133401.GA3487@localhost.localdomain>
 <569F9DCA.3030808@arm.com>
Message-ID: <20160121020409.GA7792@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 02:46:34PM +0000, Robin Murphy wrote:
> On 20/01/16 13:34, Huang Shijie wrote:
> >On Wed, Jan 20, 2016 at 01:02:25PM +0100, Joerg Roedel wrote:
> >>On Tue, Jan 12, 2016 at 10:15:05AM +0800, Huang Shijie wrote:
> >>>This patch adds a shortcut for the code when the @device_node is NULL.
> >>>In my juno-r1 board, the boot time can be faster by 0.004014s.
> >>
> >>How have you made sure this number is reliable and not just noise in the
> >>boot process?
> >In the boot process, there are 5 or more modules whose @dev_node are
> >NULL. Without the patch, the kernel will waste some cycles to do the
> >meaningless calculations for all these modules.
>
> With a quick counting hack, booting 4.4 on my r1 indeed shows 5 calls where
> dev_node is null. Plus 68 calls in which we waste cycles doing meaningless
> calculations when dev_node is non-null. The fundamental issue at hand is

The 68 calls are just compare instructions, such as "b.eq".
But if the code runs to the followng branch when the @dev_node is NULL, the
instructions executed will more the 68 calls (even including
some read memory instructions when try to grab the locks).

> that the "platform bus" is a rubbish abstraction.
This is just a small trivial patch, please ignore it if we think it is
no use. :)

thanks
Huang Shijie
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
