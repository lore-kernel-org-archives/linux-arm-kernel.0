From: olivier.moysan@st.com (Olivier Moysan)
Date: Thu, 14 Dec 2017 17:53:56 +0100
Subject: [RFC PATCH 0/2] select master clock in wm8994 driver based on DT
 clocks configuration
Message-ID: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This RFC follows a previous RFC related to master clock issues with Wolfson wm8994 codec:
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-March/118834.html

This RFC provides a new proposal regarding master clock selection in wm8994 driver.
Below is a reminder of the problem:

Use case:
CPU DAI and codec are managed through audio graph card.
Wolson codec wm8994 is set as slave of CPU DAI and CPU DAI feeds codec with master clock.
Master clock is derived from mclk-fs property and provided to CPU DAI and codec through snd_soc_dai_set_sysclk API. 

Analysis:
The audio graph card sets clock id to 0, while wm8994 codec driver expects a clock id in the range [1..4]. (MCLK1, MCLK2 ..)

Proposal:
Wolfson wm8994 codec bindings exposes MCLK1 and MCLK1 clocks.
It seems that these clocks are not supported in wm8994 driver, yet.
First patch adds support of these clocks.

Second patch sets master clock according to clocks provided in DT.
The patch assumes that MCLK1 and MCLK2 are linked to aif1 and aif2 interfaces respectively.
If MCLKx is defined, is it used as source clock for aifx interface.
Otherwise clock id parameter is used as usual. 
By default clock rate is requested from clock framework. 
This is not convenient, when mclk clock frequency is computed for mclk-fs ratio,
as codec set_sysclk() is called before cpu set_sysclk() callback.
In this case frequency provided by set_sysclk() must be used.
So, if MCLKx rate is 0, frequency parameter provided by wm8994_set_dai_sysclk() is used.

I have a limited view of potential side effects here, so any comments are welcome.
If some adaptations are required to make this change more generic, please let me know.

Regards
Olivier

Olivier Moysan (2):
  ASoC: add support of mclk clock providers in wm8894 driver
  ASoC: select sysclk clock from mlck clock provider in wm8994 driver

 drivers/mfd/wm8994-core.c        |  9 +++++++++
 include/linux/mfd/wm8994/pdata.h |  6 ++++++
 sound/soc/codecs/wm8994.c        | 20 +++++++++++++++++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

-- 
1.9.1
