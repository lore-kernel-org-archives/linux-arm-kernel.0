From: eric.auger@redhat.com (Auger Eric)
Date: Tue, 10 Jan 2017 22:21:28 +0100
Subject: [PATCH v7 08/19] iommu: Implement reserved_regions iommu-group
 sysfs file
In-Reply-To: <20170110171444.GU17255@8bytes.org>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
 <1483969570-3154-9-git-send-email-eric.auger@redhat.com>
 <9ee5aa6b-6e63-c153-0727-729e0e9592c6@redhat.com>
 <20170110171444.GU17255@8bytes.org>
Message-ID: <1d2137bf-8d0d-d786-6cd6-9090fb76f05c@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,
On 10/01/2017 18:14, Joerg Roedel wrote:
> On Tue, Jan 10, 2017 at 05:20:34PM +0100, Auger Eric wrote:
>> The /sys/kernel/iommu_groups/n directory seems to be removed before this
>> gets called and this may produce a WARNING when devices get removed from
>> the group. I intend to remove the call since I have the feeling
>> everything gets cleaned up properly.
> 
> A feeling is not enough, please check that in the code.

So my understanding is on group's kobject_release we have:
kobject_release
|_ kobject_cleanup
	|_ kobject_del
		|_ sysfs_remove_dir
			|_ kernfs_remove
				|_ _kernfs_remove
	../..
	|_ ktype release (iommu_group_release)

_kernfs_remove() calls kernfs_put() on all descendant nodes, leading to
the whole directory cleanup.

In iommu_group_release I called sysfs_remove_file on the
reserved_regions attribute file. My understanding is its job is
identifical as what was done previously and the node was already
destroyed hence the warning.

sysfs_remove_file
|_ sysfs_remove_file_ns
	|_ kernfs_remove_by_name_ns
		|_kernfs_remove

So my understanding is it is safe to remove it.

Thanks

Eric
> 
> 
> 	Joerg
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
