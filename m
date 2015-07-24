From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 24 Jul 2015 11:54:18 +0800
Subject: [PATCH 3/5] ARM: MCPM: make internal helpers private to the core
 code
In-Reply-To: <1430496392-15956-4-git-send-email-nicolas.pitre@linaro.org>
References: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
 <1430496392-15956-4-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <CAGb2v65D7vtuV4kfg0HoM_pp4=UmY29AzpOP=E5WWGM5fPO9XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, May 2, 2015 at 12:06 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> This concerns the following helpers:
>
>         __mcpm_cpu_going_down()
>         __mcpm_cpu_down()
>         __mcpm_outbound_enter_critical()
>         __mcpm_outbound_leave_critical()
>         __mcpm_cluster_state()
>
> They are and should only be used by the core code now.  Therefore their
> declarations are removed from mcpm.h and their definitions are made
> static, hence the need to move them before their users which accounts
> for the bulk of this patch.

I'm looking for some advice. On the Allwinner A80, at least on mainline,
there is no external PMU or embedded controller in charge of power
controls. What this means is that I'm doing power sequencing in the
kernel as part of the MCPM calls, specifically powering down cores and
clusters in the .wait_for_powerdown callback. (I don't think it's
reasonable or even possible to power down stuff in .*_powerdown_prepare)

Previously I was using __mcpm_cluster_state() to check if the last core
in a cluster was to be powered off, and thus the whole cluster could be
turned off as well. I could also check if the individual power gates or
resets are asserted, but if a core was already scheduled to be brought
up, and MCPM common framework didn't call .cluster_powerup, there might
be a problem.

Any suggestions? Maybe export __mcpm_cluster_state() so platform code
can know what's going to happen?

Thanks


Regards
ChenYu

> This left the mcpm_sync_struct definition at an odd location, therefore
> it is moved as well with some comment clarifications.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
