From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 19 Oct 2017 16:45:11 +0100
Subject: [PATCH 0/2] arm/arm64: kvm: Fix issue with branch profiling
Message-ID: <1508427913-34619-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When enabling branch profiling, a lockup occurs at boot time, after
displaying: "kvm [1]: Hyp mode initialized successfully"

The issue is caused by the Hyp code getting instrumented and trying to
access unmapped code or data, which happens when trying to initialize EL2.

So it also seems like KVM is misleadingly announcing it was initialized and
yet gets stuck during initialization.

* First patch deals with printing the initialization message once KVM has
  fully initialized Hyp mode
* Second patch actually disables branch profiling instrumentation in Hyp
  code

Cheers,

Julien Thierry (2):
  arm/arm64: kvm: Move initialization completion message
  arm/arm64: kvm: Disable branch profiling in HYP code

 arch/arm/kvm/hyp/Makefile   |  2 +-
 arch/arm64/kvm/hyp/Makefile |  2 +-
 virt/kvm/arm/arm.c          | 31 ++++++++++++++-----------------
 3 files changed, 16 insertions(+), 19 deletions(-)

--
1.9.1
