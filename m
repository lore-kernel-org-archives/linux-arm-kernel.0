From: vgoyal@redhat.com (Vivek Goyal)
Date: Thu, 25 Sep 2014 14:28:10 -0400
Subject: [PATCH 6/7] arm64/kexec: Add core kexec support
In-Reply-To: <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
Message-ID: <20140925182810.GB6303@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 12:23:27AM +0000, Geoff Levand wrote:
[..]
> +void machine_kexec(struct kimage *image)
> +{
> +	phys_addr_t reboot_code_buffer_phys;
> +	void *reboot_code_buffer;
> +
> +	BUG_ON(num_online_cpus() > 1);
> +
> +	kexec_kimage_head = image->head;
> +
> +	reboot_code_buffer_phys = page_to_phys(image->control_code_page);
> +	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
> +
> +	/*
> +	 * Copy relocate_new_kernel to the reboot_code_buffer for use
> +	 * after the kernel is shut down.
> +	 */
> +
> +	memcpy(reboot_code_buffer, relocate_new_kernel,
> +		relocate_new_kernel_size);
> +
> +	/* Flush the reboot_code_buffer in preparation for its execution. */
> +
> +	__flush_dcache_area(reboot_code_buffer, relocate_new_kernel_size);
> +
> +	/* Flush the kimage list. */
> +
> +	kexec_list_walk(NULL, image->head, kexec_list_flush_cb);
> +
> +	pr_info("Bye!\n");
> +
> +	/* Disable all DAIF exceptions. */
> +	
> +	asm volatile ("msr daifset, #0xf" : : : "memory");
> +
> +	soft_restart(reboot_code_buffer_phys);

So what is soft_restart() functionality in arm64?

Looks like it switches to identity mapped page tables and that seems
to be the reason that you are not preparing identity mapped page
tables in kexec code. I am wondering I how do you make sure that once
kexec is swapping pages (putting new kernel's pages to its destination)
at that time these identity page will not be overwritten?

I am assuming that you are jumping to purgatory with paging enabled
and whole of the memory identity mapped.

I am also curious to know what are different entry points arm64
kernel image supports and which one are you using by default.

Thanks
Vivek
