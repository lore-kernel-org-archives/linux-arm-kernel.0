From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 21 Oct 2017 11:47:53 -0400
Subject: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to and
 from devices
In-Reply-To: <20171006133203.22803-6-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-6-jean-philippe.brucker@arm.com>
Message-ID: <683a518d-0e22-c855-2416-2e097ec3291d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just some improvement suggestions.

On 10/6/2017 9:31 AM, Jean-Philippe Brucker wrote:
> +	spin_lock(&iommu_process_lock);
> +	idr_for_each_entry(&iommu_process_idr, process, i) {
> +		if (process->pid != pid)
> +			continue;
if you see this construct a lot, this could be a for_each_iommu_process.

> +
> +		if (!iommu_process_get_locked(process)) {
> +			/* Process is defunct, create a new one */
> +			process = NULL;
> +			break;
> +		}
> +
> +		/* Great, is it also bound to this domain? */
> +		list_for_each_entry(cur_context, &process->domains,
> +				    process_head) {
> +			if (cur_context->domain != domain)
> +				continue;
if you see this construct a lot, this could be a for_each_iommu_process_domain.

> +
> +			context = cur_context;
> +			*pasid = process->pasid;
> +
> +			/* Splendid, tell the driver and increase the ref */
> +			err = iommu_process_attach_locked(context, dev);
> +			if (err)
> +				iommu_process_put_locked(process);
> +
> +			break;
> +		}
> +		break;
> +	}
> +	spin_unlock(&iommu_process_lock);
> +	put_pid(pid);
> +
> +	if (context)
> +		return err;

I think you should make the section above a independent function and return here when the
context is found.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
