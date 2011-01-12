From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jan 2011 23:52:23 +0000
Subject: [PATCH] ARM: use memblock memory regions for "System RAM" I/O
	resources
In-Reply-To: <1294874560-16542-1-git-send-email-dima@android.com>
References: <AANLkTin6oZKrq-z6yEQqGhAcknfDkW0PEaYMfGS7gJq8@mail.gmail.com>
	<1294874560-16542-1-git-send-email-dima@android.com>
Message-ID: <20110112235223.GM11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 03:22:40PM -0800, Dima Zavin wrote:
> @@ -518,8 +518,9 @@ setup_ramdisk(int doload, int prompt, int image_start, unsigned int rd_sz)
>  }
>  
>  static void __init
> -request_standard_resources(struct meminfo *mi, struct machine_desc *mdesc)
> +request_standard_resources(struct machine_desc *mdesc)

Almost there.  This line can now be combined with the preceding line
without wrapping over the 80 column limit.

>  {
> +	struct memblock_type *mem = &memblock.memory;
>  	struct resource *res;
>  	int i;
>  
> @@ -528,14 +529,11 @@ request_standard_resources(struct meminfo *mi, struct machine_desc *mdesc)
>  	kernel_data.start   = virt_to_phys(_sdata);
>  	kernel_data.end     = virt_to_phys(_end - 1);
>  
> -	for (i = 0; i < mi->nr_banks; i++) {
> -		if (mi->bank[i].size == 0)
> -			continue;
> -
> +	for (i = 0; i < mem->cnt; i++) {

Hmm, probably shouldn't rely on that - we should be using the accessors
which memblock people have provided for us.

	for_each_memblock(memory, mem) {

>  		res = alloc_bootmem_low(sizeof(*res));
>  		res->name  = "System RAM";
> -		res->start = mi->bank[i].start;
> -		res->end   = mi->bank[i].start + mi->bank[i].size - 1;
> +		res->start = mem->regions[i].base;
> +		res->end   = mem->regions[i].base + mem->regions[i].size - 1;

		res->start = __pfn_to_phys(memblock_region_memory_base_pfn(mem));
		res->end   = __pfn_to_phys(memblock_region_memory_end_pfn(mem)) - 1;

And I'd say ignore the 80-column limit on that because of the excessively
long memblock function names.
