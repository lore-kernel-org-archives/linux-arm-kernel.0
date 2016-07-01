From: riku.voipio@linaro.org (Riku Voipio)
Date: Fri, 1 Jul 2016 16:17:00 +0300
Subject: [PATCH v2] arm64: defconfig: add options for virtualization and
 containers
In-Reply-To: <20160627111113.GF26498@cbox>
References: <1465979279-23449-1-git-send-email-riku.voipio@linaro.org>
 <20160627111113.GF26498@cbox>
Message-ID: <CAAqcGHmMtSpaB37HYFwpVg51R+DGdDc2T1fogBSxdW7W0A95EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 June 2016 at 14:11, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Wed, Jun 15, 2016 at 11:27:59AM +0300, Riku Voipio wrote:
>> Enable options commonly needed by popular virtualization
>> and container applications. Use modules when possible to
>> avoid too much overhead for users not interested.
>>
>> - add namespace and cgroup options needed
>> - add seccomp - optional, but enhances Qemu etc
>> - bridge, nat, veth, macvtap and multicast for routing
>>   guests and containers
>> - btfrs and overlayfs modules for container COW backends
>> - while near it, make fuse a module instead of built-in.
>>
>> Generated with make saveconfig and dropping unrelated spurious
>> change hunks while commiting. bloat-o-meter old-vmlinux vmlinux:
>>
>> add/remove: 905/390 grow/shrink: 767/229 up/down: 183513/-94861 (88652)
>> ....
>> Total: Before=10515408, After=10604060, chg +0.84%
>>
>> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
>
> I'm unclear what the conclusion on the v1 regarding using modules in
> defconfig was exactly, but I'm happy to see a defconfig that makes it
> easier to test virtualization.

I think it was generally agreed that adding modules to defconfig is ok. However
this patch seems to be a bit stuck in limbo. Anyone going to pick it up?

Riku

> Thanks,
> -Christoffer
>
>> ---
>> v2: Adapt to v4.7-rc3 where CONFIG_DEVPTS_MULTIPLE_INSTANCES is gone
>> ---
>>  arch/arm64/configs/defconfig | 52 +++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 46 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index fd2d74d..2d9f845 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -15,10 +15,14 @@ CONFIG_IKCONFIG_PROC=y
>>  CONFIG_LOG_BUF_SHIFT=14
>>  CONFIG_MEMCG=y
>>  CONFIG_MEMCG_SWAP=y
>> +CONFIG_BLK_CGROUP=y
>> +CONFIG_CGROUP_PIDS=y
>>  CONFIG_CGROUP_HUGETLB=y
>> -# CONFIG_UTS_NS is not set
>> -# CONFIG_IPC_NS is not set
>> -# CONFIG_NET_NS is not set
>> +CONFIG_CPUSETS=y
>> +CONFIG_CGROUP_DEVICE=y
>> +CONFIG_CGROUP_CPUACCT=y
>> +CONFIG_CGROUP_PERF=y
>> +CONFIG_USER_NS=y
>>  CONFIG_SCHED_AUTOGROUP=y
>>  CONFIG_BLK_DEV_INITRD=y
>>  CONFIG_KALLSYMS_ALL=y
>> @@ -69,6 +73,7 @@ CONFIG_PREEMPT=y
>>  CONFIG_KSM=y
>>  CONFIG_TRANSPARENT_HUGEPAGE=y
>>  CONFIG_CMA=y
>> +CONFIG_SECCOMP=y
>>  CONFIG_XEN=y
>>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>>  CONFIG_COMPAT=y
>> @@ -81,10 +86,37 @@ CONFIG_NET=y
>>  CONFIG_PACKET=y
>>  CONFIG_UNIX=y
>>  CONFIG_INET=y
>> +CONFIG_IP_MULTICAST=y
>>  CONFIG_IP_PNP=y
>>  CONFIG_IP_PNP_DHCP=y
>>  CONFIG_IP_PNP_BOOTP=y
>> -# CONFIG_IPV6 is not set
>> +CONFIG_IPV6=m
>> +CONFIG_NETFILTER=y
>> +CONFIG_NF_CONNTRACK=m
>> +CONFIG_NF_CONNTRACK_EVENTS=y
>> +CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
>> +CONFIG_NETFILTER_XT_TARGET_LOG=m
>> +CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
>> +CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
>> +CONFIG_NF_CONNTRACK_IPV4=m
>> +CONFIG_IP_NF_IPTABLES=m
>> +CONFIG_IP_NF_FILTER=m
>> +CONFIG_IP_NF_TARGET_REJECT=m
>> +CONFIG_IP_NF_NAT=m
>> +CONFIG_IP_NF_TARGET_MASQUERADE=m
>> +CONFIG_IP_NF_MANGLE=m
>> +CONFIG_NF_CONNTRACK_IPV6=m
>> +CONFIG_IP6_NF_IPTABLES=m
>> +CONFIG_IP6_NF_FILTER=m
>> +CONFIG_IP6_NF_TARGET_REJECT=m
>> +CONFIG_IP6_NF_MANGLE=m
>> +CONFIG_IP6_NF_NAT=m
>> +CONFIG_IP6_NF_TARGET_MASQUERADE=m
>> +CONFIG_BRIDGE=m
>> +CONFIG_BRIDGE_VLAN_FILTERING=y
>> +CONFIG_VLAN_8021Q=m
>> +CONFIG_VLAN_8021Q_GVRP=y
>> +CONFIG_VLAN_8021Q_MVRP=y
>>  CONFIG_BPF_JIT=y
>>  CONFIG_CFG80211=m
>>  CONFIG_MAC80211=m
>> @@ -100,6 +132,7 @@ CONFIG_MTD=y
>>  CONFIG_MTD_M25P80=y
>>  CONFIG_MTD_SPI_NOR=y
>>  CONFIG_BLK_DEV_LOOP=y
>> +CONFIG_BLK_DEV_NBD=m
>>  CONFIG_VIRTIO_BLK=y
>>  # CONFIG_SCSI_PROC_FS is not set
>>  CONFIG_BLK_DEV_SD=y
>> @@ -116,7 +149,10 @@ CONFIG_SATA_SIL24=y
>>  CONFIG_PATA_PLATFORM=y
>>  CONFIG_PATA_OF_PLATFORM=y
>>  CONFIG_NETDEVICES=y
>> +CONFIG_MACVLAN=m
>> +CONFIG_MACVTAP=m
>>  CONFIG_TUN=y
>> +CONFIG_VETH=m
>>  CONFIG_VIRTIO_NET=y
>>  CONFIG_AMD_XGBE=y
>>  CONFIG_NET_XGENE=y
>> @@ -304,12 +340,16 @@ CONFIG_ARM_SCPI_PROTOCOL=y
>>  CONFIG_ACPI=y
>>  CONFIG_EXT2_FS=y
>>  CONFIG_EXT3_FS=y
>> +CONFIG_EXT4_FS_POSIX_ACL=y
>> +CONFIG_BTRFS_FS=m
>> +CONFIG_BTRFS_FS_POSIX_ACL=y
>>  CONFIG_FANOTIFY=y
>>  CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
>>  CONFIG_QUOTA=y
>>  CONFIG_AUTOFS4_FS=y
>> -CONFIG_FUSE_FS=y
>> -CONFIG_CUSE=y
>> +CONFIG_FUSE_FS=m
>> +CONFIG_CUSE=m
>> +CONFIG_OVERLAY_FS=m
>>  CONFIG_VFAT_FS=y
>>  CONFIG_TMPFS=y
>>  CONFIG_HUGETLBFS=y
>> --
>> 2.1.4
>>
