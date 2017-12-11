From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 11 Dec 2017 12:00:22 +0000
Subject: [PATCH 04/12] arm64: Initialise high_memory global variable
 earlier
In-Reply-To: <20171204141313.31604-5-steve.capper@arm.com>
References: <20171204141313.31604-1-steve.capper@arm.com>
 <20171204141313.31604-5-steve.capper@arm.com>
Message-ID: <20171211120022.ujdc37dp3iawzrem@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 02:13:05PM +0000, Steve Capper wrote:
> The high_memory global variable is used by
> cma_declare_contiguous(.) before it is defined.
> 
> We don't notice this as we compute __pa(high_memory - 1), and it looks
> like we're processing a VA from the direct linear map.
> 
> This problem becomes apparent when we flip the kernel virtual address
> space and the linear map is moved to the bottom of the kernel VA space.
> 
> This patch moves the initialisation of high_memory before it used.
> 
> Signed-off-by: Steve Capper <steve.capper@arm.com>

It looks like we've had this bug since 3.18 (f7426b983a6a, "mm: cma:
adjust address limit to avoid hitting low/high memory boundary"). It may
be worth adding a cc stable on this patch.

-- 
Catalin
