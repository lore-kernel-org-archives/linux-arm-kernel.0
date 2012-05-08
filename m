From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 8 May 2012 14:35:41 -0700
Subject: [PATCH 0/5] more clk-next fixes
In-Reply-To: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
References: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
Message-ID: <CAJOA=zOeV9+1-oAwL-xYtwcz2SvhF_DuM=XENASywtpkzf0ttg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120506-22:08, Mike Turquette wrote:
> Hi all,
>
> These five patches are hopefully the final set of core framework changes
> for 3.5.  There is the obligatory MAINTAINERS file change, three new
> fixes and the fixed-factor clock patch.  That last patch is being
> reposted since three bugs were found in it (one on the list, two in my
> testing).
>
> If no one complains about these then I'll commit them to clk-next and
> (finally) send my pull request to Arnd.
>

Arnd,

Please pull the following changes since commit
66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:
  git://git.linaro.org/people/mturquette/linux.git clk-next

Mark Brown (2):
      clk: Remove comment for end of CONFIG_COMMON_CLK section
      clk: Constify parent name arrays

Mike Turquette (10):
      clk: core: correct clk_set_rate kerneldoc
      clk: core: remove dead code paths
      clk: core: clk_calc_new_rates handles NULL parents
      clk: core: enforce clk_ops consistency
      clk: core: copy parent_names & return error codes
      clk: basic: improve parent_names & return errors
      MAINTAINERS: add entry for common clk framework
      clk: prevent spurious parent rate propagation
      clk: remove COMMON_CLK_DISABLE_UNUSED
      clk: mux: assign init data

Rajendra Nayak (2):
      clk: Make clk_get_rate() return 0 on error
      clk: constify parent name arrays in macros

Rob Herring (2):
      clk: select CLKDEV_LOOKUP for COMMON_CLK
      clk: remove trailing whitespace from clk.h

Saravana Kannan (1):
      clk: Use a separate struct for holding init data.

Sascha Hauer (1):
      clk: add a fixed factor clock

Shawn Guo (7):
      clk: use kzalloc in clk_register_mux
      clk: remove unnecessary EXPORT_SYMBOL_GPL
      clk: add "const" for clk_ops of basic clks
      clk: declare clk_ops of basic clks in clk-provider.h
      clk: always pass parent_rate into .round_rate
      clk: pass parent_rate into .set_rate
      clk: propagate round_rate for CLK_SET_RATE_PARENT case

Viresh Kumar (5):
      clk: Fix typo in comment
      clk: clk-gate: Create clk_gate_endisable()
      clk: clk-private: Add DEFINE_CLK macro
      clk: Don't set clk->new_rate twice
      clk: clk_set_rate() must fail if CLK_SET_RATE_GATE is set and
clk is enabled

 MAINTAINERS                    |   10 ++
 drivers/clk/Kconfig            |   12 +--
 drivers/clk/Makefile           |    2 +-
 drivers/clk/clk-divider.c      |   68 +++++-----
 drivers/clk/clk-fixed-factor.c |   95 ++++++++++++++
 drivers/clk/clk-fixed-rate.c   |   49 ++++----
 drivers/clk/clk-gate.c         |  104 ++++++++--------
 drivers/clk/clk-mux.c          |   27 +++--
 drivers/clk/clk.c              |  270 +++++++++++++++++++++++++--------------
 include/linux/clk-private.h    |   99 +++++++--------
 include/linux/clk-provider.h   |  118 ++++++++++++------
 include/linux/clk.h            |    6 +-
 12 files changed, 537 insertions(+), 323 deletions(-)
 create mode 100644 drivers/clk/clk-fixed-factor.c

> Note that the Orion patches aren't here, but I figure that Andrew L.
> probably wants to check those against the final clk-next before I pull
> them.
>
> Regards,
> Mike
>
> Mike Turquette (4):
>   MAINTAINERS: add entry for common clk framework
>   clk: prevent spurious parent rate propagation
>   clk: remove COMMON_CLK_DISABLE_UNUSED
>   clk: mux: assign init data
>
> Sascha Hauer (1):
>   clk: add a fixed factor clock
>
>  MAINTAINERS                    |   10 ++++
>  drivers/clk/Kconfig            |   11 -----
>  drivers/clk/Makefile           |    2 +-
>  drivers/clk/clk-fixed-factor.c |   95 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/clk-mux.c          |    1 +
>  drivers/clk/clk.c              |    9 +++-
>  include/linux/clk-private.h    |   20 ++++++++
>  include/linux/clk-provider.h   |   23 ++++++++++
>  8 files changed, 156 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/clk/clk-fixed-factor.c
>
> --
> 1.7.5.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
