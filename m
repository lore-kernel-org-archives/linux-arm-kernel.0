From: bharatku@xilinx.com (Bharat Kumar Gogada)
Date: Wed, 8 Nov 2017 17:50:40 +0000
Subject: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
In-Reply-To: <20171006133203.22803-2-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
Message-ID: <BLUPR0201MB150538FDD455F6042803B54FA5560@BLUPR0201MB1505.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

+static struct iommu_process *
+iommu_process_alloc(struct iommu_domain *domain, struct task_struct 
+*task) {
+	int err;
+	int pasid;
+	struct iommu_process *process;
+
+	if (WARN_ON(!domain->ops->process_alloc || !domain->ops->process_free))
+		return ERR_PTR(-ENODEV);
+
+	process = domain->ops->process_alloc(task);
+	if (IS_ERR(process))
+		return process;
+	if (!process)
+		return ERR_PTR(-ENOMEM);
+
+	process->pid		= get_task_pid(task, PIDTYPE_PID);
+	process->release	= domain->ops->process_free;
+	INIT_LIST_HEAD(&process->domains);
+	kref_init(&process->kref);
+
+	if (!process->pid) {
+		err = -EINVAL;
+		goto err_free_process;
+	}
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&iommu_process_lock);
+	pasid = idr_alloc_cyclic(&iommu_process_idr, process, domain->min_pasid,
+				 domain->max_pasid + 1, GFP_ATOMIC);
If EP supports only one pasid; domain->min_pasid=1 and domain->max_pasid=0.
When idr_alloc_cyclic is called it invokes idr_get_free_cmn function where we have following condition. (Based on kernel 4.14-rc6)
	if (!radix_tree_tagged(root, IDR_FREE)) 
                start = max(start, maxindex + 1);
              if (start > max) 
		return ERR_PTR(-ENOSPC);
Here max is being assigned zero by the time this function is invoked, this value is based on domain->max_pasid.
This condition fails and ENOSPC is returned.
	
In this case even though hardware supports PASID, BIND flow fails.
Any reason why pasid allocation moved to idr allocations rather than bitmap allocations as in v1 patches ?

+	process->pasid = pasid;

Regards,
Bharat
