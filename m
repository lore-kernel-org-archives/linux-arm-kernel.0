From: leedom@chelsio.com (Casey Leedom)
Date: Thu, 22 Mar 2018 19:44:51 +0000
Subject: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <52cbc9d7-5a6b-5c8b-b930-058f5be62079@opengridcomputing.com>
References: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
 <201803221430.P43GJl9U%fengguang.wu@intel.com>
 <3664b253c730dbf83f4528acaedb3a88@codeaurora.org>
 <3e9c006e4541acbce11743dbda553e84@codeaurora.org>
 <03d201d3c1eb$b71fb460$255f1d20$@opengridcomputing.com>
 <83484a3f-d3f7-d763-e4f8-e4fec3bb8cc2@codeaurora.org>,
 <52cbc9d7-5a6b-5c8b-b930-058f5be62079@opengridcomputing.com>
Message-ID: <BY2PR1201MB098352CB012D8AE8084882F3C8A90@BY2PR1201MB0983.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

| From: Steve Wise <swise@opengridcomputing.com>
| Sent: Thursday, March 22, 2018 9:28 AM
|
| | From: Sinan Kaya <okaya@codeaurora.org>
| | Date: Thursday, March 22, 2018 7:52 AM
| |
| | Isn't this a PowerPC problem? Why penalize other architectures?
| 
| I worry it breaks PPC.

And all other architectures.  Aparraently there isn't a formal API
description for writel_relaxed() and Co., nor __raw_writel(), etc.  What I
think we need is a formal semantic definition of exactly what these APIs is
supposed to do and then we can make sure that they all do that.  Till we
have a consistent definition/implementation, trying to use these APIs in
multi-platform code will be a problem.

For instance, and this is merely an example not a prescription of what I'm
talking about:

    writel():
      -- Ensures correct byte ordering.
      -- Ensures no compiler reordering.
      -- Ensures instruction level synchronization with respect
      --   to previous and succeeding reads and writes.

    writel_relaxed():
      -- Ensures correct byte ordering.
      -- Ensures no compiler reordering.
      -- Ensures instruction level synchronization with respect
      --   to previous writes.

    __raw_writel():
      -- Ensures correct byte ordering.
      -- Ensures no compiler reordering.
 
| I appreciate you doing this.

As do I!  I'm just worried that because the API semantic definitions don't
seem to be formalized for writel_relaxed() and Co., we're in danger of
getting wildly different results on one platform or another based on
differring implementation semantics.

Casey
