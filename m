From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 21 Apr 2017 09:47:50 -0400
Subject: [PATCH V2] scsi: mpt3sas: remove redundant wmb
In-Reply-To: <CAK=zhgpmcmq-CnWuU9=WRJpAaEduw63LSPLE9yZzF_sUHkM4AA@mail.gmail.com>
References: <1491591978-17880-1-git-send-email-okaya@codeaurora.org>
 <yq1y3uvq0c1.fsf@oracle.com>
 <CAK=zhgpmcmq-CnWuU9=WRJpAaEduw63LSPLE9yZzF_sUHkM4AA@mail.gmail.com>
Message-ID: <63726ec2-56dc-4fe2-f7ea-e177832d6114@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/21/2017 3:56 AM, Sreekanth Reddy wrote:
> [Sreekanth] Whether same thing applicable for SPARC & POWER
> architectures. If yes then we are fine with this patch changes.

This behavior is common for all architectures according to this document.

Who would be the best person to comment on SPARC and POWER architectures
in specific? James and I exchanged some comments on the first version. 

James? can you comment on POWER behavior.

https://www.kernel.org/doc/Documentation/memory-barriers.txt

Inside of the Linux kernel, I/O should be done through the appropriate accessor
routines - such as inb() or writel() - which know how to make such accesses
appropriately sequential.  

"Whilst this, for the most part, renders the explicit
use of memory barriers unnecessary", 

there are a couple of situations where they might be needed:

 (1) On some systems, I/O stores are not strongly ordered across all CPUs, and
     so for _all_ general drivers locks should be used and mmiowb() must be
     issued prior to unlocking the critical section.

 (2) If the accessor functions are used to refer to an I/O memory window with
     relaxed memory access properties, then _mandatory_ memory barriers are
     required to enforce ordering.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
