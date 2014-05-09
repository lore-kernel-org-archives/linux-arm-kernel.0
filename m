From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 May 2014 16:06:16 +0100
Subject: [PATH V3] arm64: mm: Create gigabyte kernel logical mappings
 where possible
In-Reply-To: <1399381347-28676-1-git-send-email-steve.capper@linaro.org>
References: <1399381347-28676-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140509150616.GJ7950@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 06, 2014 at 02:02:27PM +0100, Steve Capper wrote:
> We have the capability to map 1GB level 1 blocks when using a 4K
> granule.
> 
> This patch adjusts the create_mapping logic s.t. when mapping physical
> memory on boot, we attempt to use a 1GB block if both the VA and PA
> start and end are 1GB aligned. This both reduces the levels of lookup
> required to resolve a kernel logical address, as well as reduces TLB
> pressure on cores that support 1GB TLB entries.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
> Changed in V3: added awareness of 1GB blocks to kern_addr_valid.
> This was tested via gdb:
> gdb ./vmlinux /proc/kcore
> disassemble kern_addr_valid
> 
> The output looked valid.
> In V2 of the patch, I got an oops.
> 
> I've defined constants with pgdval_t type. Ideally, I would like to
> define pudval_t types, but due to the way folding works this does not
> exist for <4 levels. I'm not sure if it would be better to define
> pudval_t for <4 levels or leave this as is?

I would leave it as is for now, PUD_TABLE_BIT is already defined as
pgdval_t. I'll have a look Jungseok and maybe we can clean them up
there.

Patch applied. Thanks.

-- 
Catalin
