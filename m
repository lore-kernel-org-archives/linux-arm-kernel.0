From: collinsd@codeaurora.org (David Collins)
Date: Mon, 28 Mar 2011 08:34:40 -0700
Subject: [PATCH 0/2] regulator: Fix regulator_enable deadlock and add uA_load
	propagation
Message-ID: <1301326482-6547-1-git-send-email-collinsd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the uA_load propagation change takes out a lock on a regulator and
then the regulators that it supplies, it will cause deadlock with the current
regulator_enable implementation.  regulator_disable can also deadlock with
regulator_enable, but it requires two threads and precise timing to observe.
Therefore, regulator_enable must be fixed before current propagation can be
used.

David Collins (2):
  regulator: Remove possible deadlock from regulator_enable
  regulator: Propagate uA_load requirements up supply chain

 drivers/regulator/core.c         |  147 +++++++++++++++++++++++++++++++-------
 include/linux/regulator/driver.h |    5 ++
 2 files changed, 125 insertions(+), 27 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
