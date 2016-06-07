From: panand@redhat.com (Pratyush Anand)
Date: Tue, 7 Jun 2016 07:35:50 +0530
Subject: [PATCH kexec-tools v2 04/32] kdump: fix kdump mapping
In-Reply-To: <E1b9xrj-0003rn-3S@e0050434b2927.dyn.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
 <E1b9xrj-0003rn-3S@e0050434b2927.dyn.armlinux.org.uk>
Message-ID: <20160607020550.GA9722@dhcppc6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016:05:59:03 PM, Russell King wrote:
> When kdump tries to map the program header, it fails to take account
> of ehdr->e_phoff being an offset from the start of the ELF "file",
> which causes:
> 
> Cannot mmap /dev/mem offset: 64 size: 392: Invalid argument
> 
> Ensure that we take account of the start address when mapping this.
> 
> This fix has been extracted from a larger patch by Vitaly Andrianov
> adding support for Keystone 2.
> 
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>
Reviewed-by: Pratyush Anand <panand@redhat.com>
> ---
>  kdump/kdump.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kdump/kdump.c b/kdump/kdump.c
> index 1f5b984..34d2149 100644
> --- a/kdump/kdump.c
> +++ b/kdump/kdump.c
> @@ -284,7 +284,8 @@ int main(int argc, char **argv)
>  	}
>  	
>  	/* Get the program header */
> -	phdr = map_addr(fd, sizeof(*phdr)*(ehdr->e_phnum), ehdr->e_phoff);
> +	phdr = map_addr(fd, sizeof(*phdr)*(ehdr->e_phnum), 
> +			start_addr + ehdr->e_phoff);
>  
>  	/* Collect up the notes */
>  	note_bytes = 0;
> -- 
> 1.9.1
