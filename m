From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Nov 2014 11:10:07 +0100
Subject: [PATCHv3 2/5] ARM: mvebu: disable I/O coherency on non-SMP
 situations on Armada 370/375/38x/XP
In-Reply-To: <1415871540-20302-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1415871540-20302-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1415871540-20302-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5650402.1KVMxKcjQn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014 10:38:57 Thomas Petazzoni wrote:
> Enabling the hardware I/O coherency on Armada 370, Armada 375, Armada
> 38x and Armada XP requires a certain number of conditions:
> 
>  - On Armada 370, the cache policy must be set to write-allocate.
> 
>  - On Armada 375, 38x and XP, the cache policy must be set to
>    write-allocate, the pages must be mapped with the shareable
>    attribute, and the SMP bit must be set
> 
> Currently, on Armada XP, when CONFIG_SMP is enabled, those conditions
> are met. However, when Armada XP is used in a !CONFIG_SMP kernel, none
> of these conditions are met. With Armada 370, the situation is worse:
> since the processor is single core, regardless of whether CONFIG_SMP
> or !CONFIG_SMP is used, the cache policy will be set to write-back by
> the kernel and not write-allocate.
> 
> Since solving this problem turns out to be quite complicated, and we
> don't want to let users with a mainline kernel known to have
> infrequent but existing data corruptions, this commit proposes to
> simply disable hardware I/O coherency in situations where it is known
> not to work.
> 
> And basically, the is_smp() function of the kernel tells us whether it
> is OK to enable hardware I/O coherency or not, so this commit slightly
> refactors the coherency_type() function to return
> COHERENCY_FABRIC_TYPE_NONE when is_smp() is false, or the appropriate
> type of the coherency fabric in the other case.
> 
> Thanks to this, the I/O coherency fabric will no longer be used at all
> in !CONFIG_SMP configurations. It will continue to be used in
> CONFIG_SMP configurations on Armada XP, Armada 375 and Armada 38x
> (which are multiple cores processors), but will no longer be used on
> Armada 370 (which is a single core processor).
> 
> In the process, it simplifies the implementation of the
> coherency_type() function, and adds a missing call to of_node_put().
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Fixes: e60304f8cb7bb545e79fe62d9b9762460c254ec2 ("arm: mvebu: Add hardware I/O Coherency support")
> Cc: <stable@vger.kernel.org> # v3.8+
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 

Seems fine to me. I was hoping to solve this with the introduction
of the CONFIG_ARCH_MULTIPLATFORM_STRICT or CONFIG_BROKEN_MULTIPLATFORM
setting that would allow us to have a compile-time setting to make it
work on UP (while possibly breaking or slowing down other machines
in a multiplatform kernel), but Russell didn't like the idea.

	Arnd
