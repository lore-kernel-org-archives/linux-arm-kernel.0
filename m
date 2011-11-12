From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 12 Nov 2011 12:00:20 +0100
Subject: [PATCH] ARM: SAMSUNG: Save/restore GPIO drive strength across
 suspend/resume
In-Reply-To: <1321074108-10025-1-git-send-email-inderpal.singh@linaro.org>
References: <1321074108-10025-1-git-send-email-inderpal.singh@linaro.org>
Message-ID: <CACRpkdbC=w5vRvgLVpAcmcampt-baTydpLHBexak4RzxUcO32Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2011 at 6:01 AM, Inderpal Singh
<inderpal.singh@linaro.org> wrote:

> GPIO driver strength settings are not preserved across suspend/resume
> for s5pc100, s5pv210 and Exynos platforms which has been the cause of
> mmc/sd card read/write failures after resume. Fix this by saving and
> restoring the GPIO driver strength register settings across suspend/resume.
>
> Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>

On a related theme: I am thinking about how to support preserving
drive strength (etc) across suspend/resume and deepsleep in the
pincontrol subsystem.

Currently I am playing with the idea to let pin groups have states,
as the different configurations seem to be 90% or so about very
specific sleep modes, so say:

pinconf_set_group_state("mmcgroup", PINCONF_STATE_ACTIVE);
pinconf_set_group_state("mmcgroup", PINCONF_STATE_SUSPENDED);
pinconf_set_group_state("mmcgroup", PINCONF_STATE_SLEEP);

This would then instruct each pin controller driver to configure
each pin apropriately for the given state, and that cross-references
to a table keeping track of the preset per-pin for each state.

My intuitive idea is that letting the core keep track of the state of
every pin and letting pin groups harness the settings for a group
of pins is the proper approach to the problem.

Do you think something like this will work for the S5P:s?

Yours,
Linus Walleij
