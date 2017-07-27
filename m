From: borneo.antonio@gmail.com (Antonio Borneo)
Date: Fri, 28 Jul 2017 01:26:09 +0200
Subject: [PATCH v2 0/3] ASoC: fix unbalanced of_node_get()/of_node_put()
In-Reply-To: <20170725214952.6491-1-borneo.antonio@gmail.com>
References: <20170725214952.6491-1-borneo.antonio@gmail.com>
Message-ID: <20170727232612.23543-1-antonio.borneo@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antonio Borneo <borneo.antonio@gmail.com>

On Hikey target board, enabling CONFIG_OF_DYNAMIC triggers several
errors at kernel boot, like
OF: ERROR: Bad of_node_put() on /soc/i2s at f7118000/ports/port at 0
OF: ERROR: Bad of_node_put() on /soc/i2s at f7118000/ports/port at 0/endpoint
each followed by stack dump.

Fixed by:
- removing of_node_put() in the body of of_for_each_phandle(){},
  since already provided at each iteration. Add it in case the
  loop is break out;
- adding of_node_get() before calling of_graph_get_port_parent().

Tested with kernel v4.13-rc2 with hikey_defconfig taken from
https://git.linaro.org/people/john.stultz/android-dev.git
branch dev/hikey-mainline-WIP

v1 -> v2:
- modify subject "s/fix balance of/fix unbalanced/";
- split the patch per each individual issue. It also simplify the
  backport;
- add ref to the commit being fixed;
- drop one fix not needed.

Antonio Borneo (3):
  ASoC: fix use of of_node_put() in of_for_each_phandle() loops
  ASoC: soc-core: fix unbalanced of_node_get()/of_node_put()
  ASoC: simple-card-utils: fix unbalanced of_node_get()/of_node_put()

 sound/soc/generic/audio-graph-card.c  | 9 ++++-----
 sound/soc/generic/simple-card-utils.c | 5 +++++
 sound/soc/soc-core.c                  | 5 +++++
 3 files changed, 14 insertions(+), 5 deletions(-)

-- 
1.9.1
