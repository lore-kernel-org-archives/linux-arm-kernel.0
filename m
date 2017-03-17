From: amodra@gmail.com (Alan Modra)
Date: Fri, 17 Mar 2017 19:47:33 +1030
Subject: [PATCH] [EXPERIMENTAL, v2] enable thin archives and
 --gc-sections on ARM
In-Reply-To: <20170315165109.3451216-1-arnd@arndb.de>
References: <20170315165109.3451216-1-arnd@arndb.de>
Message-ID: <20170317091733.GT4983@bubble.grove.modra.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 05:50:00PM +0100, Arnd Bergmann wrote:
> I'm still build testing with an experimental change to enable
> thin architeves and --gc-sections on ARM, which should bring
> multiple benefits
> 
> - improve build times
> - allow 'allyesconfig' to succeed without exceeding the
>   section size when linking drivers/built-in.o
> - reduce the kernel image size
> 
> However, I have now run into a build error binutils commit
> f02cb05 ("Always descend into output section statements in
> lang_do_assignments") in binutils-2.28 and later:
> 
>    no __ex_table in  file: vmlinux
> 
> Any idea what's going wrong here?

I presume you checked that section really had disappeared?

>  	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
>  		__start___ex_table = .;
>  #ifdef CONFIG_MMU
> -		*(__ex_table)
> +		KEEP(*(__ex_table))
>  #endif
>  		__stop___ex_table = .;
>  	}

I think that if CONFIG_MMU is not defined, then ld will remove the
empty section.

-- 
Alan Modra
Australia Development Lab, IBM
