From: riku.voipio@linaro.org (Riku Voipio)
Date: Fri, 27 May 2016 13:42:27 +0300
Subject: [PATCH] arm64: defconfig: add options for virtualization and
 containers
Message-ID: <1464345747-11729-1-git-send-email-riku.voipio@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable options commonly needed by popular virtualization
and container applications. Use modules when possible to
avoid too much overhead for users not interested.

- add namespace and cgroup options needed
- add seccomp - optional, but enhances Qemu etc
- bridge, nat, veth, macvtap and multicast for routing
  guests and containers
- btfrs and overlayfs modules for container COW backends
- while near it, make fuse a module instead of built-in.

Generated with make saveconfig and dropping unrelated spurious
change hunks while commiting. bloat-o-meter old-vmlinux vmlinux:

add/remove: 899/388 grow/shrink: 744/216 up/down: 183556/-94881 (88675)
...
Total: Before=10515333, After=10604008, chg 0.000000%

Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 arch/arm64/configs/defconfig | 53 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fd2d74d..7db8010 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -15,10 +15,14 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_MEMCG=y
 CONFIG_MEMCG_SWAP=y
+CONFIG_BLK_CGROUP=y
+CONFIG_CGROUP_PIDS=y
 CONFIG_CGROUP_HUGETLB=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_NET_NS is not set
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_PERF=y
+CONFIG_USER_NS=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
@@ -69,6 +73,7 @@ CONFIG_PREEMPT=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
+CONFIG_SECCOMP=y
 CONFIG_XEN=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
@@ -81,10 +86,37 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IPV6 is not set
+CONFIG_IPV6=m
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_EVENTS=y
+CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
+CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_NAT=m
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_NF_CONNTRACK_IPV6=m
+CONFIG_IP6_NF_IPTABLES=m
+CONFIG_IP6_NF_FILTER=m
+CONFIG_IP6_NF_TARGET_REJECT=m
+CONFIG_IP6_NF_MANGLE=m
+CONFIG_IP6_NF_NAT=m
+CONFIG_IP6_NF_TARGET_MASQUERADE=m
+CONFIG_BRIDGE=m
+CONFIG_BRIDGE_VLAN_FILTERING=y
+CONFIG_VLAN_8021Q=m
+CONFIG_VLAN_8021Q_GVRP=y
+CONFIG_VLAN_8021Q_MVRP=y
 CONFIG_BPF_JIT=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
@@ -100,6 +132,7 @@ CONFIG_MTD=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
@@ -116,7 +149,10 @@ CONFIG_SATA_SIL24=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_PATA_OF_PLATFORM=y
 CONFIG_NETDEVICES=y
+CONFIG_MACVLAN=m
+CONFIG_MACVTAP=m
 CONFIG_TUN=y
+CONFIG_VETH=m
 CONFIG_VIRTIO_NET=y
 CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
@@ -144,6 +180,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_AMBAKMI=y
+CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
@@ -304,12 +341,16 @@ CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_ACPI=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_BTRFS_FS=m
+CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_FANOTIFY=y
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
 CONFIG_QUOTA=y
 CONFIG_AUTOFS4_FS=y
-CONFIG_FUSE_FS=y
-CONFIG_CUSE=y
+CONFIG_FUSE_FS=m
+CONFIG_CUSE=m
+CONFIG_OVERLAY_FS=m
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
-- 
2.1.4
