From: jlinton@redhat.com (Jeremy Linton)
Date: Mon, 23 Nov 2015 08:31:31 -0600
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <20151123121514.GB32300@e104818-lin.cambridge.arm.com>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej> <564CB1DA.4090304@arm.com>
 <20151118180434.GB13355@leverpostej> <564CD206.9040402@arm.com>
 <20151119112923.GA24570@leverpostej> <20151120195243.GC14942@leverpostej>
 <20151123121514.GB32300@e104818-lin.cambridge.arm.com>
Message-ID: <56532343.8030908@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2015 06:15 AM, Catalin Marinas wrote:

> That's a complete fix indeed but it would require some more testing and
> I don't think it's feasible for 4.4-rc. In the meantime, I propose that
> we revert the contiguous PTE patches and push them again once we fix the
> TLB conflict problems.


The problem as you say exists with the block mappings as well, and the 
explicit TLB flush there is apparently sufficient to keep this problem 
from occurring. The 1 line explicit flush is sufficient to keep it from 
happening in the late mapping case as well, and actually fixes a problem 
that was in the kernel from before these patches (the complete lack of 
flush in paths calling create_mapping_late()). So, I fail to see how 
reverting the patch fixes anything, it only returns to the previously 
(now known) to be bad code path.

BTW: The M400, has other issues that keep it from booting with ACPI 
firmware (the 4.3 EOI changes irritate a 'bug' in the MADT table).
