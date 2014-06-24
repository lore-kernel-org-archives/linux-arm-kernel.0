From: dianders@google.com (Doug Anderson)
Date: Tue, 24 Jun 2014 09:12:40 -0700
Subject: [PATCH 1/3] ARM: MCPM: provide infrastructure to allow for MCPM
 loopback
In-Reply-To: <1403583071-5650-2-git-send-email-nicolas.pitre@linaro.org>
References: <1403583071-5650-1-git-send-email-nicolas.pitre@linaro.org>
 <1403583071-5650-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <CAD=FV=X0mP_Vq9SSAugJfFRqchu_dkSFcL5aBAhAC073LPy6oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

On Mon, Jun 23, 2014 at 9:11 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> The kernel already has the responsibility to handle resources such as the
> CCI when hotplugging CPUs, during the booting of secondary CPUs, and when
> resuming from suspend/idle.  It would be more coherent and less confusing
> if the CCI for the boot CPU (or cluster)  was also initialized by the kernel rather than expecting the

nit: wrap long line?

> firmware/bootloader to do it and only in that case. After all, the kernel
> has all the necessary code already and the bootloader shouldn't have to
> care at all.
>
> The CCI may be turned on only when the cache is off. Leveraging the CPU
> suspend code to loop back through the low-level MCPM entry point is all
> that is needed to properly turn on the CCI from the kernel by using the
> same code as for secondary boot.
>
> Let's provide a generic MCPM loopback function that can be invoked by
> backend initialization code to set things (CCI or similar) on the boot
> CPU just as it is done for the other CPUs.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/common/mcpm_entry.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/include/asm/mcpm.h  | 16 ++++++++++++++
>  2 files changed, 68 insertions(+)

Thank you very much for posting!  With your series I'm able to boot
all 8 cores on exynos5420-peach-pit and exynos5800-peach-pi sitting on
my desk.

Tested-by: Doug Anderson <dianders@chromium.org>


I will note that git yelled about whitespace damage on theis patch:

# pwclient git-am 4406301
Applying patch #4406301 using 'git am'
Description: [1/3] ARM: MCPM: provide infrastructure to allow for MCPM loopback
Applying: ARM: MCPM: provide infrastructure to allow for MCPM loopback
/b/tip/src/third_party/kernel/3.8/.git/rebase-apply/patch:51: trailing
whitespace.

/b/tip/src/third_party/kernel/3.8/.git/rebase-apply/patch:95: trailing
whitespace.
 * to the MCPM low-level entry code before returning to the caller.
warning: 2 lines add whitespace errors.
