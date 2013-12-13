From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Dec 2013 16:49:58 +0000
Subject: [PATCH 4/5] arm64: Add missing AT() macros to vmlinux.lds.S
In-Reply-To: <51cf7ba0aab8ae3677673cab65ec560d78a645ce.1386879684.git.geoff@infradead.org>
References: <cover.1386879684.git.geoff@infradead.org>
 <51cf7ba0aab8ae3677673cab65ec560d78a645ce.1386879684.git.geoff@infradead.org>
Message-ID: <20131213164958.GO19177@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 08:39:46PM +0000, Geoff Levand wrote:
> Add missing AT() macros to vmlinux.lds to generate the sections
> properly.  Some elf file tools expect correct paddr values in
> vmlinux.
> 
> Fixes bad paddr values written to vmlinux like these:
> 
>   Program Header:
>     LOAD off 0x0000000000010000 vaddr 0xffffffc000080000 paddr 0xffffffc000080000 align 2**16
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 6563b64..065fe40d 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -48,11 +48,11 @@ SECTIONS
>  
>  	. = PAGE_OFFSET + TEXT_OFFSET;
>  
> -	.head.text : {
> +	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {

Since LOAD_OFFSET is PAGE_OFFSET, does this assume that physical memory
starts at 0x0?

Will
