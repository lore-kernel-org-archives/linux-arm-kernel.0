From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 13 Apr 2018 11:59:29 +0100
Subject: [PATCH 03/37] iommu/sva: Manage process address spaces
In-Reply-To: <04d4d161-ed72-f6b6-9b94-1d60bd79ef94@codeaurora.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
 <04d4d161-ed72-f6b6-9b94-1d60bd79ef94@codeaurora.org>
Message-ID: <f2ea5af2-dfd6-7463-0eaa-ee9ede87eac1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/18 19:53, Sinan Kaya wrote:
> On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
>> +static void io_mm_detach_all_locked(struct iommu_bond *bond)
>> +{
>> +	while (!io_mm_detach_locked(bond));
>> +}
>> +
> 
> I don't remember if I mentioned this before or not but I think this loop
> needs a little bit relaxation with yield and maybe an informational message
> with might help if wait exceeds some time.

Right, at the very least we should have a cpu_relax here. I think this
bit is going away, though, because I want to lift the possibility of
calling bind() for the same dev/mm pair multiple times. It's not useful
in my opinion because that call could only be issued by a given driver.

Thanks,
Jean
