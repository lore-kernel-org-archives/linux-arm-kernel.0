From: apinski@cavium.com (Andrew Pinski)
Date: Tue, 10 Jan 2017 17:27:47 -0800
Subject: [PATCH] patch in prfm for copy_template if requested
Message-ID: <1484098068-30433-1-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


As mentioned in http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/404146.html
copy_template was left alone at the time which mentions:
"since the template really deals with 64 bytes per iteration,
which would need changing".  The problem is that there is not enough
registers available to do 128 bytes at a time.  There is only enough
registers to do 96 bytes at a time.  If we did not have to save
dst or keep x5 free (that is used by the exception case) or keep
around the count; then we would have enough caller saved registers
free to copy 128 bytes at a time.  For user space, we will be using
the SIMD registers which allows for not using any callee saved
registers and get better performance.

So basically this is my old patch which just patches in the prfm
to copy_template updated for the new name of the define and for
the nop not needed to be there any more.

Andrew Pinski (1):
  arm64: lib: patch in prfm for copy_template if requested

 arch/arm64/lib/copy_template.S | 9 ++++++++-
 arch/arm64/lib/memcpy.S        | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.7.4
