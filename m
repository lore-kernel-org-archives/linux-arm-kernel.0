From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 4 Oct 2017 15:02:59 +0100
Subject: defconfig'ed v4.13 does not boot on ThunderX
In-Reply-To: <20171004134414.GF23092@leverpostej>
References: <135495b6-e13e-5c90-6130-addb60d0fa5c@riken.jp>
 <dfecaf11-d133-91c2-c630-0b08356cebd9@arm.com>
 <20171004134414.GF23092@leverpostej>
Message-ID: <db08ee33-5e54-5c9a-d265-14155b72b5ad@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/17 14:44, Mark Rutland wrote:
> On Wed, Oct 04, 2017 at 02:38:58PM +0100, Robin Murphy wrote:
>> On 04/10/17 08:25, Itaru Kitayama wrote:
>>> Hi,
>>>
>>> defconfig'ed kernel v4.13 does not boot on ThunderX, leaving only
>>> messages below:
>>>
>>> EFI stub: Booting Linux Kernel...
>>> EFI stub: Using DTB from configuration table
>>> EFI stub: Exiting boot services and installing virtual address map...
>>>
>>> Our HW is by GIGABYTE, the model is R150 T62 rev 100:
>>>
>>> http://b2b.gigabyte.com/ARM-Server/R150-T62-rev-100#ov
>>>
>>> The BIOS we're on is T43. Has anyone testing upstream kernels seen a
>>> similar issue like this?
>>
>> FWIW defconfig does *not* enable most of the ThunderX drivers (most
>> importantly, PCI and networking will be missing).
> 
> .... it's a bit worrying if earlycon doesn't work without those, though.
> It shouldn't be dependendent on either. :/

Well, my earlycon was fine too, but that was an a different board with
different firmware, so who knows...

>> I've just built the v4.13 tag with the appropriate drivers added and
>> booted it on a different ThunderX box - the net core throws some
>> warnings from __dev_xdp_attached() but it gets to userspace OK for me.
> 
> Given these seem to exist out in the field, we should probably enable
> those drivers in defconfig.

True, I think the below ought to suffice - arm-soc take defconfig
patches now, right?

Robin.

----->8-----
From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] arm64: Add ThunderX drivers to defconfig

ThunderX needs its PCI host drivers to do anything useful, and it's
probably helpful to have networking by default too.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34480e9af2e7..1c8e0d77deee 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -76,6 +76,8 @@ CONFIG_PCIE_RCAR=y
 CONFIG_PCIE_ROCKCHIP=m
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
+CONFIG_PCI_HOST_THUNDER_PEM=y
+CONFIG_PCI_HOST_THUNDER_ECAM=y
 CONFIG_ARM64_VA_BITS_48=y
 CONFIG_SCHED_MC=y
 CONFIG_NUMA=y
@@ -188,6 +190,7 @@ CONFIG_VIRTIO_NET=y
 CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
 CONFIG_MACB=y
+CONFIG_THUNDER_NIC_PF=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
 CONFIG_E1000E=y
-- 
2.13.4.dirty
