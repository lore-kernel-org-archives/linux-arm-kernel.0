From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  9 Jun 2011 18:21:50 +0100
Subject: [RFC PATCH 0/2] ARM: Add a generic macro for declaring proc_info
	structs
Message-ID: <1307640112-5360-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on recent problems with variable-size Thumb instructions
inside tables, this patch adds an experimental macro for declaring
proc_info structs, as an example of the kind of build-time robustness
we could implement for these and similar structures.

As such, it's an illustration of something we _could_ do, rather
than something we necessarily should do.

I'd be interested in people's views on this.


Potential advantages include:

 * automatic build-time checking that struct proc_info is reasonably
in sync with the assembler definitions;

 * automatic checking that proc_info structure declarations are
complete and correctly structured, with no mis-sized or misaligned
elements (particularly important for Thumb-2 kernels);

 * better readability of the declarations (depending on people's
personal taste, of course);

 * reduction of some boilerplate code (perhaps up to 700 lines net
if we were to convert all arch/arm/mm/proc-*.S to use the macro.


The same general technique could be potentially expanded to cover
any struct defined in assembler.

However, this may be taking a sledgehammer to crack a nut,
and it will cause some churn, though it could leave is with a
cleaner situation afterwards.


Much lighter-weight, less invasive build-time checks could
still deliver significant benefits.


Dave Martin (2):
  ARM: Add a generic macro for declaring proc_info structs
  ARM: proc-v7: Use the new proc_info declaration macro

 arch/arm/mm/proc-macros.S |  141 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-v7.S     |   93 ++++++++++++-----------------
 2 files changed, 179 insertions(+), 55 deletions(-)

-- 
1.7.4.1
