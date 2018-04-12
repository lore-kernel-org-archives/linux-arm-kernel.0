From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 12 Apr 2018 18:20:16 -0400
Subject: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
In-Reply-To: <20180412215149.GA27802@saruman>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <20180412215149.GA27802@saruman>
Message-ID: <a50e4919-24d8-de37-c696-ec964988ca8b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2018 5:51 PM, James Hogan wrote:
> But why don't we always use wmb() in the writeX() case? Might not the
> cached write to DMA buffer be reordered with the uncached write to MMIO
> register from the coherent DMA point of view? I'm waiting on feedback
> from MIPS hardware folk on this topic.

Are you asking about this?

 #if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANCEMENT)
 #define war_io_reorder_wmb()		wmb()
 #else
-#define war_io_reorder_wmb()		do { } while (0)
+#define war_io_reorder_wmb()		barrier()
 #endif

There is a write barrier in writeX() but seem to be different from platform
to platform. 

I'm not familiar with the MIPS architecture. We can always use a wmb() but it
could hurt performance where it is not needed. 

This is the kind of input we need from the MIPS folks if compiler barrier is
enough or we need a wmb() for all cases.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
