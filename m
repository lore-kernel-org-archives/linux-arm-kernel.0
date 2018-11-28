From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Wed, 28 Nov 2018 11:29:28 -0700
Subject: [PATCH 0/1] drm/msm/a6xx: Add interconnect support
Message-ID: <20181128182929.19925-1-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I heard at LPC that there was some confusion that the OPP bindings [1]
were needed to land interconnect support. They aren't.

There is a two step process for the SDM845 GPU. First we need a vote (any vote)
because the default bus settings are way too bad for any reasonable
performance.

The next step after that would be to scale the bus request based on the
frequency in order to save power. For that we *do* need a solution but that
can be calmly discussed separately.

This patch accommodates the first step. It cranks the bus to max for GPU
activity and turns it off when the GPU goes to sleep. Hopefully this can
alleviate the confusion and help interconnect land that much quicker.
After that, we can calmly re-introduce the OPP discussion.

This patch depends on interconnect support [2].

[1] https://patchwork.kernel.org/patch/10577303/
[2] https://patchwork.kernel.org/patch/10701287/

Jordan Crouse (1):
  drm/msm/a6xx: Add support for an interconnect path

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
 3 files changed, 32 insertions(+)

-- 
2.18.0
