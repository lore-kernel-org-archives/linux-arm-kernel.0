From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Wed, 29 Nov 2017 14:08:20 +0800
Subject: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to and
 from devices
In-Reply-To: <20171006133203.22803-6-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-6-jean-philippe.brucker@arm.com>
Message-ID: <9c364147-12c4-5a8a-9cd9-0642a6b92555@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
> +int iommu_process_bind_device(struct device *dev, struct task_struct *task,
> +			      int *pasid, int flags)
> +{
[..]
> +			err = iommu_process_attach_locked(context, dev);
> +			if (err)
> +				iommu_process_put_locked(process);
one ref for a context is enough right? so also need call iommu_process_put_locked()
if attach ok, or will be leak if user call bind twice for the same device and task.
