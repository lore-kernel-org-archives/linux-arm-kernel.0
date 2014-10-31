From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 31 Oct 2014 14:46:58 +0100
Subject: [PATCHv2 2/3] ARM: mvebu: disable I/O coherency on non-SMP
 situations on Armada 370/XP
In-Reply-To: <1414423955-5933-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414423955-5933-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414423955-5933-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <545392D2.8050202@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

I agree that providing a kernel working reliably is important.

On 27/10/2014 16:32, Thomas Petazzoni wrote:
> Enabling the hardware I/O coherency on Armada 370 and Armada XP
> requires a certain number of conditions:
> 
>  - On Armada 370, the cache policy must be set to write-allocate.
>  - On Armada XP, the cache policy must be set to write-allocate, the
>    pages must be mapped with the shareable attribute, and the SMP bit
>    must be set
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


Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
