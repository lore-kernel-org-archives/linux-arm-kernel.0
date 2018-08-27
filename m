From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Mon, 27 Aug 2018 09:11:03 -0600
Subject: [PATCH 0/9] Add interconnect support + bindings for A630 GPU
Message-ID: <20180827151112.25211-1-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is a first stab at trying to add interconnect support
for the Adreno 630 GPU in the sdm845 SOC. The most interesting thing
for discussion is the OPP binding for specifying bandwidth - once that
is worked out the actual code to implement it is pretty straight forward
thanks to the hard work from Georgi and the PM lists.

The first 5 patches are are just a sync / reminder of the still pending
DT bindings and entries for the GPU itself - the interconnect folks can
refer to them as a reference to see what the GPU nodes will look like
but I suspect they are of more interest for the GPU.

Patch 6 adds a proposed binding to specify the interconnect avg/peak
BW for a given operating point. On devices that can do aggressive
frequency scaling like the GPU we want to be able to set a peak
bandwidth along with the frequency so that we can make sure that
the bus can handle a faster GPU frequency if we scale up but also
to reduce power consumption on the bus when we scale down.

The proposed binding uses the form:

opp-interconnect-bw-<name> = <avg peak>

Where 'name' is the corresponding interconnect-name of the interested
path and 'avg' and 'peak' are the average and peak bandwidth values
in HZ to program for the operating point. The path name is used to
identify path specific settings for devices that may have multiple
active interconnect paths.

The next patch adds a generic OPP API to read the interconnect values
given a operating point and a name.

The 8th patch adds code support for an interconnect path to the for
the a6xx GPU reading the bandwidth for the operating point from the
OPP API.

And the final patch adds the actual interconnect details the
device tree specifying both the interconnect details as well as
the bandwidth requirements for each of the operating points on the
a630 GPU.

Jordan Crouse (9):
  drm/msm/a6xx: rnndb updates for a6xx
  drm/msm/a6xx: Fix PDC register overlap
  drm/msm/a6xx: Rename gmu phandle to qcom,gmu
  dt-bindings: Document qcom,adreno-gmu
  arm64: dts: sdm845: Add gpu and gmu device nodes
  PM / OPP: dt-bindings: Add opp-interconnect-bw
  OPP: Add dev_pm_opp_get_interconnect_bw()
  drm/msm/a6xx: Add support for an interconnect path
  arm64: dts: Add interconnect for the GPU on SDM845

 .../devicetree/bindings/display/msm/gmu.txt   |  54 ++
 .../devicetree/bindings/display/msm/gpu.txt   |  10 +-
 Documentation/devicetree/bindings/opp/opp.txt |  36 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 131 ++++
 drivers/gpu/drm/msm/adreno/a6xx.xml.h         | 642 +++++++++++-------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         | 114 ++--
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h         |   6 -
 drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h     |  26 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |   7 +
 drivers/gpu/drm/msm/msm_gpu.h                 |   3 +
 drivers/opp/of.c                              |  36 +
 include/linux/pm_opp.h                        |   7 +
 13 files changed, 775 insertions(+), 299 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt

-- 
2.18.0
