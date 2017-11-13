From: bharatku@xilinx.com (Bharat Kumar Gogada)
Date: Mon, 13 Nov 2017 11:06:51 +0000
Subject: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
In-Reply-To: <16b6ba80-b15b-b278-0d06-350ae0201e82@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
 <BLUPR0201MB150538FDD455F6042803B54FA5560@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <16b6ba80-b15b-b278-0d06-350ae0201e82@arm.com>
Message-ID: <SN1PR0201MB1518765CCEDD9B75119D6C63A52B0@SN1PR0201MB1518.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>        
> In this case even though hardware supports PASID, BIND flow fails.

It should fail, since we're reserving PASID 0 for non-PASID transactions with S1DSS=0b10. In addition, the SMMUv3 specification does not allow using PASID with a single entry. See the description of S1CDMax in 5.2 Stream Table Entry:

"when this field is 0, the substreams of the STE are disabled and one CD is available. (The minimum useful number of substreams is 2.) Any transaction with a SubstreamID will be terminated with an abort and a C_BAD_SUBSTREAMID event recorded."

> Any reason why pasid allocation moved to idr allocations rather than 
> bitmap allocations as in v1 patches ?

Yes, idr provides a convenient way to quickly retrieve the context associated with a PASID, when handling a fault. v1 had the allocation in a bitmap and storing in a rb-tree. By using an idr we combine both and rely on a well-tested infrastructure.

Note that in the future we might need to go back to handcrafting the PASID allocation, but it will probably still be based on idr.

Thanks for the clarification, Jean. 
